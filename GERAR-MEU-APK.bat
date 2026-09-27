@echo off
chcp 65001 >nul
echo.
echo  Curio Quest - generador de su APK
echo  ================================
echo.
echo  Detecta la IP de este PC y crea un APK que se conecta a él por Wi-Fi.
echo  (Si va a conectar el celular mediante cable USB, no necesita esto:
echo   use el CurioQuest-offline-127.0.0.1.apk que ya viene preparado.)
echo.

where python >nul 2>&1
if errorlevel 1 (
  echo  [X] Python no encontrado. Instálelo desde https://python.org y marque
  echo      "Add Python to PATH" durante la instalación.
  echo.
  pause
  exit /b 1
)

where java >nul 2>&1
if errorlevel 1 (
  echo  [X] Java no encontrado. Es necesario para firmar el APK.
  echo      Instale el Temurin JDK: https://adoptium.net
  echo.
  pause
  exit /b 1
)

if not exist "Curio Quest_1.15.00.apk" (
  echo  [X] Falta el archivo "Curio Quest_1.15.00.apk" en esta carpeta.
  echo      Viene incluido en el paquete, dentro de apk\. Cópielo aquí.
  echo.
  pause
  exit /b 1
)

python tools\patch_apk.py
if errorlevel 1 (
  echo.
  echo  [X] Falló. Lea el mensaje anterior.
  pause
  exit /b 1
)

echo.
echo  Listo. Su APK está en la carpeta build\.
echo.
echo  Ahora instálelo en el celular:
echo    adb install -r build\CurioQuest-offline-SEU-IP.apk
echo    adb shell pm clear air.com.A5thplanetgames.pets
echo.
pause
