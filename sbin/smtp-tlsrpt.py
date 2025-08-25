#!/usr/bin/python3

# ruff: noqa: S101

import argparse
import email
import gzip
import io
import json
import logging
import os
import pathlib
import re
import sys
import zipfile

from defusedxml import ElementTree

logging.basicConfig(
    #format='%(levelname).1s [%(filename)s:%(lineno)d:%(funcName)s] %(message)s',
    format='%(levelname)s [%(filename)s:%(lineno)d:%(funcName)s] %(message)s',
    datefmt='%Y-%m-%dT%H:%M:%S', # %(asctime)s.%(msecs)03d
    level=logging.INFO,
    stream=sys.stdout,
)
logger = logging.getLogger(__name__)

# logging show-once header
class LFilter(logging.Filter) :
    def __init__(self) -> None :
        super().__init__()
        self.header = None
    def filter(self, record: logging.LogRecord) -> None :
        if self.header :
            print(self.header)
            self.header = None

        sgr = []
        if record.levelno >= logging.ERROR :
            sgr = [ '1', '31' ] # bold red
        elif record.levelno >= logging.WARNING :
            sgr = [ '31' ] # red
        elif record.levelno >= logging.INFO :
            sgr = [ '32' ] # green

        record.levelname = record.levelname[:1]
        if len(sgr) > 0 :
            record.levelname = f'\033[{";".join(sgr)}m{record.levelname}\033[0m'

        return True

lfilter = LFilter()
logger.addFilter(lfilter)

parser = argparse.ArgumentParser()
parser.add_argument('files', nargs='+', default='-')
args = parser.parse_args()

def parse_dmarc(content: str) -> None :
    records = ElementTree.fromstring(content).findall('record')
    assert(len(records) >= 1)
    for record in records :
        rows = record.findall('row')
        assert(len(rows) >= 1)
        for row in rows :
            ip = row.findall('source_ip')[0].text
            policy_evaluated = row.findall('policy_evaluated')
            assert(len(policy_evaluated) == 1)
            dkim = policy_evaluated[0].findall('dkim')
            assert(len(dkim) == 1)
            spf = policy_evaluated[0].findall('spf')
            assert(len(spf) == 1)
            if spf[0].text == 'pass' and dkim[0].text == 'pass' :
                #logger.info('dmarc: OK')
                continue
            logger.warning('dmarc: %s, spf/dkim = %s/%s ', ip, spf[0].text, dkim[0].text)

def parse_smtp(content: str) -> None :
    report = json.loads(content)
    assert len(report['policies']) >= 0
    for policy in report['policies'] :
        if policy['summary']['total-failure-session-count'] == 0 :
            #logger.info('smtp: OK')
            continue
        logger.warning('smtp: %s', policy['summary'])

def handle_payload(content: str, headers: dict[str, str]) -> None :
    if re.search(r'dmarc', headers['from'], re.IGNORECASE) :
        parse_dmarc(content)
        return

    if headers['file_name'].endswith('.json.gz') :
        parse_smtp(content)
        return

    if headers['file_name'].endswith('.xml.gz') :
        parse_dmarc(content)
        return

    logger.error(headers)
    print(content)

prefix = os.path.commonprefix(args.files)
for file_name in args.files :
    lfilter.header = '\n#### ' + file_name[len(prefix):] + ' |'
    #with pathlib.Path(file_name).open(encoding='utf-8', errors='replace') as file :
    #    try :
    #        message = email.message_from_binary_file(file)
    #    except UnicodeDecodeError :
    #        logger.exception("can't open file")
    #        continue
    with pathlib.Path(file_name).open('rb') as file :
        message = email.message_from_binary_file(file)

    date = email.utils.parsedate_to_datetime(message['Date']).isoformat()
    lfilter.header += ' ' + date
    email_from = email.utils.parseaddr(message['From'])[1]
    lfilter.header += ' ' + email_from
    email_to = email.utils.parseaddr(message['To'])[1]

    # parse SPF/DKIM
    for auth in (message['Authentication-Results'] or '').split(';') :
        if not re.search(r'^\s*(spf|dkim)=', auth, re.IGNORECASE) : continue
        # ignore pass/none entries
        if re.search(r'^\s*(spf|dkim)=pass', auth, re.IGNORECASE) : continue
        if re.search(r'^\s*(spf|dkim)=none', auth, re.IGNORECASE) : continue
        # ignore mailing lists
        if re.search(r'^\s*(spf)=.* smtp\.(helo|mailfrom|pra)=.*@.*$', auth, re.IGNORECASE) : continue
        if re.search(r'^\s*(dkim)=.* header\.\w+=.*@.*$', auth, re.IGNORECASE) : continue
        logger.warning(auth.strip())

    if not re.search(r'^postmaster@', email_to) : continue

    payloads = [ message ]
    if message.is_multipart() :
        payloads = message.get_payload()

    for payload in payloads :
        content_type = payload.get_content_type()
        headers = {
            'from' : email_from,
            'file_name' : payload.get_filename(),
            'content_type' : content_type,
        }

        if content_type == 'application/zip' :
            zf = zipfile.ZipFile(io.BytesIO(payload.get_payload(decode=True)), 'r')
            for name in zf.namelist() :

                handle_payload(zf.read(name).decode('utf-8'), headers )
            continue
        if re.search(r'^application/(tlsrpt\+)?gzip$', content_type) :
            handle_payload(gzip.decompress(payload.get_payload(decode=True)).decode('utf-8'), headers)
            continue

        if re.search(r'^image/', content_type) : continue
        if re.search(r'^message/', content_type) : continue
        if re.search(r'^text/', content_type) : continue
        logger.error(headers)
