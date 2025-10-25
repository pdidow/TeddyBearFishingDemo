@echo off
setlocal enabledelayedexpansion

:: === CONFIGURATION ===
set REPO_PATH=C:\Users\peter\Downloads\TeddyBearFishingDemo
set REMOTE_URL=https://github.com/pdidow/TeddyBearFishingDemo.git
set BRANCH_NAME=main

echo =======================================================
echo Resetting and uploading %REPO_PATH% to GitHub with LFS
echo =======================================================
echo.

cd /d "%REPO_PATH%" || (echo Folder not found! && exit /b)

:: 1. Remove old Git data
echo Removing old .git folder...
rmdir /s /q .git 2>nul
del .gitattributes 2>nul

:: 2. Initialize repo
echo Initializing new Git repository...
git init
git lfs install

:: 3. Track ALL game-related binary files BEFORE adding them
echo Setting up comprehensive LFS tracking rules...

:: Image files
git lfs track "*.png"
git lfs track "*.jpg"
git lfs track "*.jpeg"
git lfs track "*.tga"
git lfs track "*.bmp"
git lfs track "*.psd"
git lfs track "*.dds"

:: Audio files
git lfs track "*.wav"
git lfs track "*.mp3"
git lfs track "*.ogg"
git lfs track "*.wma"

:: XNA/MonoGame specific
git lfs track "*.xnb"
git lfs track "*.mgcb"

:: Executables and libraries
git lfs track "*.exe"
git lfs track "*.dll"
git lfs track "*.pdb"

:: 3D assets
git lfs track "*.fbx"
git lfs track "*.obj"
git lfs track "*.blend"
git lfs track "*.3ds"
git lfs track "*.dae"

:: Fonts
git lfs track "*.ttf"
git lfs track "*.otf"

:: Video files
git lfs track "*.mp4"
git lfs track "*.avi"
git lfs track "*.wmv"

:: Archive files
git lfs track "*.zip"
git lfs track "*.rar"
git lfs track "*.7z"

:: 4. Find and track any remaining large files
echo Searching for any remaining large files (>50MB)...
git lfs track "*.pak"
git lfs track "*.dat"

:: 5. Verify LFS is tracking files
echo.
echo Verifying LFS tracking setup...
git lfs track

:: 6. Add .gitattributes first
git add .gitattributes
git commit -m "Add Git LFS tracking rules"

:: 7. Now add all other files
echo Staging all files...
git add .

:: 8. Verify LFS files are staged correctly
echo.
echo Files to be tracked by LFS:
git lfs ls-files

:: 9. Commit everything
git commit -m "Full upload of TeddyBearFishingDemo with Git LFS"

:: 10. Set branch and remote
echo Setting branch and remote...
git branch -M %BRANCH_NAME%
git remote remove origin 2>nul
git remote add origin %REMOTE_URL%

:: 11. Push (force overwrite to make clean)
echo Pushing to GitHub...
git push -u origin %BRANCH_NAME% --force

echo.
echo Done! Repository uploaded with LFS tracking.
echo.
echo To verify after cloning, run:
echo   git lfs pull
echo =======================================================
pause