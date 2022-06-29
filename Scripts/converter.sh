#!/bin/bash
### Converts an integer number from number base to another using a REST API call
# Supported number bases are 2,8,10,16 
# $1 The base from where to convert E.g Base 2,8,10,16
# $2 The base the script converts to E.g Base 2,8,10,16
# $3 The number to convert E.g any number
# How to use  converter.sh 10 2 5  > 101
#             converter.sh 2 10 1111 > 15
#             converter.sh 8 16  1016 > 20E



### Parses the arguements piped to the script
function parse_args
{
    if [ $# -lt 3 ]; then
        echo 'Invalid arguements'
        exit 1
    fi  
    from=`echo $1 | tr -d '-'`
    to=`echo $2 | tr -d '-'`
    number=`echo $3 | tr -d '-'`
}

### Constructs the URL
function build_url
{
    api_url="https://networkcalc.com/api/binary"
    api_url="${api_url}/${number}?from=${from}&to=${to}"
}

parse_args $@
build_url
json_response=`curl --silent "$api_url"` 
# Response returned by the API
# {
#   "status": "HTTPS response code",
#   "original": "{number}",
#   "converted": "Converted number or null",
#   "from": "{from}",
#   "to": "{to}"
# }
converted=`echo $json_response | jq -r '.converted'`
echo $converted