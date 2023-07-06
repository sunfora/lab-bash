#!/usr/bin/bash
source "concatenative.sh"

word="[a-Z]([[:alnum:]]*([_\-][[:alnum:]])*)+"

def select-words << '|'
  egrep -o $word
|
  
def with-size [ size ] << '|'
  egrep "^(.$size)$"
|

def remove-spaces << '|' 
  sed 's/[[:space:]]*//'
|

def freq << '|'
  sort 
  uniq -ic
|

def sort-by-freq << '|'
  freq
  sort -nr
  remove-spaces
  cut -d ' ' -f 2-     
|

def task << '|'
  select-words
  with-size '{4,}'
  sort-by-freq 
  head -3 
|

man bash | task
