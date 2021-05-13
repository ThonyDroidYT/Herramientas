#!/bin/bash
# uncomment and fix with appropriate values if you are behind a proxy
#export https_proxy='http://localhost:3128'
sl=en
tl=$(basename $0)
if [[ "${tl}" != "es" ]]; then
  sl=es
fi
base_url="https://translate.googleapis.com/translate_a/single?client=gtx&sl=${sl}&tl=${tl}&dt=t&q="
ua='Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36'
qry=$( echo $@ | sed -E 's/\s{1,}/\+/g' )
full_url=${base_url}${qry}
response=$(curl -sA "${ua}" "${full_url}")
echo ""
#print only first translation from JSON
echo ${response} | sed 's/","/\n/g' | sed -E 's/\[|\]|"//g' | head -1
