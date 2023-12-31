#!/bin/bash
 echo=`sh /root/certbot-certificates.sh`
# ﺪﺴﺗﺮﺳی ﺐﻫ ﻻگ Certbot ﻭ ﺬﺧیﺮﻫ ﺥﺭﻮﺟی ﺩﺭ ﻢﺘﻏیﺭ output
output=$(grep -E "Certificate Name|Expiry Date" /var/log/certbot-certificates.log | awk 'BEGIN {OFS=" "} {if ($1 == "Certificate") {cert = $NF} else {print cert, $0}}' | grep "(VALID: 5 days)")


domains=$(echo "$output" | awk '{print $1}')
#expiry_dates=$(echo "$output" | awk '{print $2}')


num_domains=$(echo "$domains" | wc -l)


for ((i=1; i<=$num_domains; i++)); do
  domain=$(echo "$domains" | sed -n "${i}p")
  #expiry_date=$(echo "$expiry_dates" | sed -n "${i}p")


 # expiry_timestamp=$(date -d "$expiry_date" +%s)

  today_timestamp=$(date +%s)

  
  if [[ $(($expiry_timestamp - $today_timestamp)) -le $((2 * 24 * 60 * 60)) ]]; then
    # ﺎﺟﺭﺍی ﺪﺴﺗﻭﺭ ﺖﻣﺩیﺩ گﻭﺎﻫی<200c>ﻥﺎﻤﻫ ﺏﺍ پﻻگیﻥ nginx
    sudo certbot certonly --cert-name "$domain" -d "$domain" --force-renewal --non-interactive --quiet --nginx
  fi
done

echo=`nginx -t && nginx -s reload`
