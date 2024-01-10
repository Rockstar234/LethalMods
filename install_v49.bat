@shift /0
@shift /0
@echo off
set local enableextensions


Color 0E

set scriptpath=%~dp0
echo %scriptpath%
chcp 437 > nul

::Idea took from https://github.com/SlejmUr/Manifest_Tool_TB.
::Credits 
::https://github.com/SlejmUr
::JVAV

::requirements check
:7zipcheck
MODE 62,50
if exist "Resources\7z.exe" (
goto cmdCheck
) else (
mkdir Resources
goto no7zip
)
goto 7zipcheck

:no7zip
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo ###########################  Downloading 7-Zip... #############################
echo -------------------------------------------------------------------------------
curl.exe -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/7z.exe" --ssl-no-revoke --output 7z.exe
move 7z.exe Resources
goto 7zipcheck

:cmdCheck
if exist "Resources\cmdmenusel.exe" (
goto foldercheck
) else (
goto GetCmd
)
goto cmdCheck

:GetCmd
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo ########################### Downloading cmdmenusel... #########################
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/cmdmenusel.exe" --ssl-no-revoke --output cmdmenusel.exe
move cmdmenusel.exe Resources
goto cmdCheck

::requirements check end

::check for updates
:foldercheck
Title Checking updates...1
if exist "%userprofile%\.lethalmods\temp" (
goto getVer
) else (
    goto foldercreate
)

:foldercreate
Title Creating folder...
mkdir "%userprofile%\.lethalmods"
mkdir "%userprofile%\.lethalmods\temp"
goto foldercheck

:getVer
Title Checking updates...2
cls 
MODE 79,20
echo -------------------------------------------------------------------------------
echo ######################## Trying to verify version... ##########################
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/LethalMods/version.verify" --ssl-no-revoke --output version.verify
move version.verify %userprofile%\.lethalmods
goto versioncheck 

:versioncheck
Title Checking updates...3
::BYAxDQAAAIIaeTisZn52lgo= v45.2
::BcAxDQAAAMIwUzwzhv7mCw== v49
findstr /m "BcAxDQAAAMIwUzwzhv7mCw==" %userprofile%\.lethalmods\version.verify >Nul
if %errorlevel%==0 (
goto noupdatesfound
)

if %errorlevel%==1 (
goto updatesfound
)

:updatesfound
Title Checking updates...4
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo  Your dowloader is outdated and it downloads wrong LC modpack. Please update.
echo                             Redirecting you...
echo              Don't forget to delete outdated downloader folder.
echo -------------------------------------------------------------------------------
timeout 5 >nul
start "" https://github.com/Rockstar234/LethalMods/releases
exit 

:noupdatesfound
Title Verify complete
cls
echo -------------------------------------------------------------------------------
echo ###################### Your downloader is up to date. #########################
echo -------------------------------------------------------------------------------
timeout 2 >nul
goto changedir
::check for updates end

::main part
:mainmenu
Title Mods Downloader
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo Welcome to Game Downloader menu. Current version is v49.
echo THIS IS BETA. ISSUES MAY APPEAR.
echo Current dir: %launcherpath%
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Install Mods" "  Change Directory" "  Discord Server" "  Launch game (select dir)" "  Open temp folder" "  Exit"
if %ERRORLEVEL% == 1 goto installgame
if %ERRORLEVEL% == 2 goto changedir
if %ERRORLEVEL% == 3 goto discordserver
if %ERRORLEVEL% == 4 goto launchgame
if %ERRORLEVEL% == 5 goto tempfolder
if %ERRORLEVEL% == 6 goto closescript
:tempfolder
cls
start %SystemRoot%\explorer.exe "%userprofile%\.lethalmods\temp"
goto mainmenu

:launchgame
Title Launching Lethal Company.exe
cls
echo Please, wait. Do not close game's CMD window.
start "" "%launcherpath%\Lethal Company\Lethal Company.exe"
timeout 3 >nul
echo Game launched. GOODBYE!!!
timeout 2 >nul
exit

:changedir
Title ??????? ????? ?????
MODE 79,13
start "" https://i.imgur.com/LieI1Bs.png
set "psCommand="(new-object -COM 'Shell.Application')^.BrowseForFolder(0,'Please select a Lethal Company folder.',0,0).self.path""

for /f "usebackq delims=" %%A in (`powershell %psCommand%`) do set "launcherpath=%%A"
goto mainmenu

:installgame
Title Installing mods...
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                        Trying to install your mods...
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/LethalMods/v49/work.7z.001" --ssl-no-revoke --output work.7z.001
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/LethalMods/v49/work.7z.002" --ssl-no-revoke --output work.7z.002
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/LethalMods/v49/work.7z.003" --ssl-no-revoke --output work.7z.003
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/LethalMods/v49/work.7z.004" --ssl-no-revoke --output work.7z.004
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/LethalMods/v49/work.7z.005" --ssl-no-revoke --output work.7z.005
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/LethalMods/v49/work.7z.006" --ssl-no-revoke --output work.7z.006
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/LethalMods/v49/work.7z.007" --ssl-no-revoke --output work.7z.007
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/LethalMods/v49/work.7z.008" --ssl-no-revoke --output work.7z.008
for %%I in ("work.7z.001") do (
    "Resources\7z.exe" x -y -o"Resources\work" "%%I" -aoa && del %%I
    )
move /y work.7z.001 %userprofile%\.lethalmods\temp
move /y work.7z.002 %userprofile%\.lethalmods\temp
move /y work.7z.003 %userprofile%\.lethalmods\temp
move /y work.7z.004 %userprofile%\.lethalmods\temp
move /y work.7z.005 %userprofile%\.lethalmods\temp
move /y work.7z.006 %userprofile%\.lethalmods\temp
move /y work.7z.007 %userprofile%\.lethalmods\temp
move /y work.7z.008 %userprofile%\.lethalmods\temp
robocopy Resources\work "%launcherpath%\Lethal Company" /E /MOVE
if exist "%launcherpath%\Lethal Company\BepInEx\plugins\BetterStamina.dll" (
    goto downloadcomplete
) else (
    goto somethingwentwrong
)

:discordserver
Title Discord Server
cls MODE 79,20
echo -------------------------------------------------------------------------------
echo               You're being redirected to our discord server.
echo                     You will be redirected in 5 seconds.
echo -------------------------------------------------------------------------------
timeout 5 >nul
start "" https://discord.gg/5GVb9UwsY7
Resources\cmdMenuSel f870 "  <- Back to Main Menu"
if %ERRORLEVEL% == 1 goto mainmenu

:closescript
Title GOODBYE!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ################################# GOODBYE! #####################################
echo --------------------------------------------------------------------------------
timeout 2 >nul
exit
::main part end

:downloadcomplete
Title Update Complete
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ########################### Download Complete! #################################
echo --------------------------------------------------------------------------------
timeout 2 >nul
goto mainmenu

:somethingwentwrong
Title Something went wrong!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ##### Woops! Something went wrong and gives an error. Please report back. #####
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                               Continue" "                            Report an issue"
if %ERRORLEVEL% == 1 goto mainmenu
if %ERRORLEVEL% == 2 goto reportissue

:reportissue
start "" https://github.com/Rockstar234/LethalMods/issues
goto mainmenu
