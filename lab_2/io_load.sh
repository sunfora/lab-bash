#!/usr/bin/bash
seq 4 | xargs -P4 -I {} dd if=/dev/sda of=/dev/null status=none
