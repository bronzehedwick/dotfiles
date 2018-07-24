#!/usr/bin/env python2

from subprocess import check_output

def macosgetpass():
    return check_output("security find-generic-password -w -s fastmail_offlineimap", shell=True).strip("\n")
