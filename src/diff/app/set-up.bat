@echo off

echo cd /diff/src
cd ..\src

echo deleting /_app 
rmdir /s /q _app
echo /_app has been deleted!

echo deleting /templates
rmdir /s /q templates 
echo /templates has been deleted!

echo deleting favicon.png
del favicon.png
echo favicon.png has been deleted!

echo back to /app
cd ..\app

echo starting run build scripts
npm run format & npm run build & move templates ..\src\templates & cd ..\src\templates & move _app ..\  & cd ..\..\app & copy static\favicon.png ..\src\ 
