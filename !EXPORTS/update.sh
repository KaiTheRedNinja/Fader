# this assumes that there is a file named Archive.love in !EXPORTS
pwd
rm win32.exe
rm win64.exe
rm -r macOS.app

cp -r Templates/macOS.app macOS.app
cp Archive.love Templates/macOS.app/Contents/Resources/Archive.love
cat Templates/love32.exe Archive.love > win32.exe
cat Templates/love64.exe Archive.love > win64.exe
