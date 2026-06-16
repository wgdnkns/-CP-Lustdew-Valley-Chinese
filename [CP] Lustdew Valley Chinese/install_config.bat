@echo off
chcp 65001 >nul
title Lustdew Valley HanHua - Config Menu Install
echo Installing config menu Chinese translation...
powershell.exe -ExecutionPolicy RemoteSigned -File "%~dp0install_config.ps1"
