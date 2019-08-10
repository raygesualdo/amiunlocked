#! /bin/sh

set -e

greenColor="\033[0;32m"
cyanColor="\033[0;36m"
resetColor="\033[0m"

#######################
# USER INPUT REQUIRED #
#######################
secretKey=""
writeKey=""

if [[ -z "$secretKey" ]]; then
  echo "A secret key is required to create a bucket. Plese fill in the 'secretKey' variable in setupDb.sh and try again."
  exit 1
fi

if [[ -z "$writeKey" ]]; then
  echo "A write key is required to create a bucket. Plese fill in the 'writeKey' variable in setupDb.sh and try again."
  exit 1
fi

if [[ -z `which curl` ]]; then
  echo "curl is required for this script to run. Install curl and try again."
  exit 1
fi

curlResponse=`curl --silent --fail -d "secret_key=$secretKey" -d "write_key=$writeKey" https://kvdb.io`
urlPrefix="https://kvdb.io/"

echo "Your database bucket has been created."
echo ""
echo "URL: $greenColor$urlPrefix$curlResponse$resetColor"
echo "Secret Key: $greenColor$secretKey$resetColor"
echo "Write Key: $greenColor$writeKey$resetColor"
echo "$cyanColor"
echo "STORE THESE VALUES IN A SAFE PLACE! THEY CANNOT BE RECOVERED IF LOST!$resetColor"
echo ""
