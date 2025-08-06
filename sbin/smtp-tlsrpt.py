#!/usr/bin/python3

import argparse

parser = argparse.ArgumentParser()
parser.add_argument("filename", nargs="?", default="-")
args = parser.parse_args()

import email
file = open(args.filename)
message = email.message_from_file(file)

def parse_dmarc(content_zip) :
    import zipfile
    zf = zipfile.ZipFile(content_zip, "r")

    import xml.etree.ElementTree as ET
    reports = []
    for name in zf.namelist() :
        reports.append(ET.fromstring(zf.read(name).decode("utf-8")))
    assert(len(reports) == 1)

    records = reports[0].findall("record")
    assert(len(records) == 1)
    rows = records[0].findall("row")
    assert(len(rows) == 1)
    policy_evaluated = rows[0].findall("policy_evaluated")
    assert(len(policy_evaluated) == 1)
    dkim = policy_evaluated[0].findall("dkim")
    assert(len(dkim) == 1)
    spf = policy_evaluated[0].findall("spf")
    assert(len(spf) == 1)
    print(dkim[0].text)
    print(spf[0].text)

import io
if message.get_content_type() == "application/zip" :
    parse_dmarc(io.BytesIO(message.get_payload(decode=True)))
    exit(0)

payloads = []
#payloads = [ message ]
if message.is_multipart() :
    payloads = message.get_payload()

content_gzip = []
for payload in payloads :
    if not payload.get_content_type().endswith("gzip") : continue
    content_gzip.append(payload)
assert(len(content_gzip) == 1)

def parse_smtp(content_gzip) :
    import gzip
    content = gzip.decompress(content_gzip.get_payload(decode=True)).decode("utf-8")

    import json
    report = json.loads(content)
    for policy in report['policies'] :
        print(policy['summary'])
        assert(policy['summary']['total-failure-session-count'] == 0)

parse_smtp(content_gzip[0])

