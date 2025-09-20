@echo off

set PATH=C:\Program Files\7zip;%PATH%
rmdir /s /q release.zip
rmdir /s /q release
mkdir release
copy LICENSE release\
copy haxelib.json release\
copy README.md release\
copy extraParams.hxml release\
mkdir release\mini
xcopy mini\*.hx release\mini\ /Y
7za a -tzip release.zip release
rmdir /s /q release
haxelib submit release.zip
pause