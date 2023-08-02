#!/bin/bash
echo 'cd /diff/src'
cd ./../src
echo 'deleting /_app'

rm -rf _app
echo '/_app has been deleted!'
echo 'deleting /templates'
rm -rf templates
echo '/templates has been deleted!'

echo 'deleting favicon.png'
rm -rf favicon.png
echo 'favicon.png has been deleted!'

echo 'back to /app'
cd ./../app

echo 'starting run build scripts'
npm run format
npm run build
echo 'build completed '


echo 'mv /templates to /diff/src'
mv ./templates ./../src/

# echo 'cd ./templates'
# cd ./../src/templates

# echo 'mv /templates/_app to /diff/src'
# mv ./_app ./../
# cd ../../app && cp ./static/favicon.png ./../src/

echo 'done~'