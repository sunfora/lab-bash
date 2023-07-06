#!/usr/bin/bash
identifier='[[:alnum:]][[:alnum:]_.-]+'
egrep -orhI "$identifier@$identifier[.]$identifier" /etc/ | tee emails.lst
