#!/usr/bin/python3

# ruff: noqa: S101

import argparse
import email
import gzip
import io
import json
import logging
import re
import sys
import zipfile

import defusedxml.ElementTree as ET

logging.basicConfig(
    format='%(levelname).1s [%(filename)s:%(lineno)d:%(funcName)s] %(message)s',
    datefmt='%Y-%m-%dT%H:%M:%S', # %(asctime)s.%(msecs)03d
    level=logging.INFO,
    stream=sys.stdout,
)
logger = logging.getLogger(__name__)

parser = argparse.ArgumentParser()
parser.add_argument('files', nargs='+', default='-')
args = parser.parse_args()

def parse_dmarc(content: str) -> None :
    records = ET.fromstring(content).findall('record')
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
            logger.info('dmarc: %s, spf/dkim = %s/%s ', ip, spf[0].text, dkim[0].text)

def parse_smtp(content: str) -> None :
    report = json.loads(content)
    assert len(report['policies']) >= 0
    for policy in report['policies'] :
        if policy['summary']['total-failure-session-count'] == 0 :
            #logger.info('smtp: OK')
            continue
        logger.error('smtp: %s', policy['summary'])

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

    logger.warning(headers)
    print(content)

for file_name in args.files :
    #logger.info('file: %s', file_name)
    with open(file_name) as file :
        message = email.message_from_file(file)
    #logger.info('from: %s', message['From'])

    if not re.search('^postmaster@', message['To']) : continue

    payloads = [ message ]
    if message.is_multipart() :
        payloads = message.get_payload()

    for payload in payloads :
        content_type = payload.get_content_type()
        headers = {
            'from' : message['From'],
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
        logger.warning(headers)
