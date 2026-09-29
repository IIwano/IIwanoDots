#!/bin/bash
if [ -z "$1" ]; then
  echo -e "\0prompt\x1fBuscar en Brave"
else
  query=$(echo "$1" | sed 's/ /+/g')
  brave "https://search.brave.com/search?q=$query" &
fi
