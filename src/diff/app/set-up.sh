#!/bin/bash
echo 'cd /diff/src'
cd /Users/roo/Desktop/workspace/vlang/v_bugs/src/diff/src/
echo 'deleting /_app'
pwd
rm -rf _app
echo '/_app has been deleted!'
echo 'deleting /templates'
rm -rf templates
echo '/templates has been deleted!'

echo 'deleting favicon.png'
rm -rf favicon.png
echo 'favicon.png has been deleted!'

echo 'back to /app'
cd /Users/roo/Desktop/workspace/vlang/v_bugs/src/diff/app

echo 'starting run build scripts'
npm run build
echo 'build completed '


echo 'mv /templates to /diff/src'
mv /Users/roo/Desktop/workspace/vlang/v_bugs/src/diff/app/templates /Users/roo/Desktop/workspace/vlang/v_bugs/src/diff/src/
echo 'cd ./templates'
cd /Users/roo/Desktop/workspace/vlang/v_bugs/src/diff/src/templates
echo 'mv /templates/_app to /diff/src'
mv /Users/roo/Desktop/workspace/vlang/v_bugs/src/diff/src/templates/_app /Users/roo/Desktop/workspace/vlang/v_bugs/src/diff/src/ 

cp /Users/roo/Desktop/workspace/vlang/v_bugs/src/diff/app/static/favicon.png /Users/roo/Desktop/workspace/vlang/v_bugs/src/diff/src/

echo 'done~'