 #!/bin/bash
cd /var/log
rm -rf certbot-certificates.log
touch certbot-certificates.log

log_file="/var/log/certbot-certificates.log"

# اجرای دستور certbot certificates و ذخیره خروجی در یک متغیر
output=$(certbot certificates)

# ذخیره خروجی در فایل لاگ
echo "$output" >> "$log_file"

# نمایش پیام موفقیت آمیز در اجرای اسکریپت
echo "Certificate information has been logged successfully."

