#!/bin/bash
# Docker Healthcheck

# Check the HTTP endpoint is listening
if ! curl -s "http://127.0.0.1:8080/" ; then
    exit 1
fi

# function check_cert_dates() {
#     cert="$(openssl s_client -showcerts -connect $1 < /dev/null)"
    
#     end_epoch=$(date +%s --date="$(echo $cert | openssl x509 -noout -enddate | cut -d'=' -f2)")
#     start_epoch=$(date +%s --date="$(echo $cert | openssl x509 -noout -startdate | cut -d'=' -f2)")
    
#     if [ $end_epoch -lt $(date +%s) ] ; then
#         exit 1
#     fi
    
#     if [ $start_epoch -gt $(date +%s) ] ; then
#         exit 1
#     fi
    
#     exit 0
# }

# Check SSL certificate expiry.
# check_cert_dates "127.0.0.1:8443"

exit 0
