@echo off
setlocal enabledelayedexpansion

REM Set the font color to green
color a

REM Set the size of the Command Prompt window (Width x Height)
mode con: cols=90 lines=30

REM biar code page di cmd berubah menjadi UTF-8, guna menampilkan karakter non-ASCII seperti emoji
chcp 65001 >null

REM Tampilkan ASCII Art
echo.
echo ========================================================
echo "==   ___        _          _____ _____ _____ _____  =="
echo "==  / _ \      | |        /  __ \  _  /  __ \_   _| =="
echo "== / /_\ \_   _| |_ ___   | /  \/ | | | /  \/ | |   =="
echo "== |  _  | | | | __/ _ \  | |   | | | | |     | |   =="
echo "== | | | | |_| | || (_) | | \__/\ \_/ / \__/\_| |_  =="
echo "== \_| |_/\__,_|\__\___/   \____/\___/ \____/\___/  =="
echo ========================================================
echo.

REM Set direktori lokasi skrip .bat ini dijalankan
set "currentDir=%~dp0"

REM Cek apakah file .env ada di C:\coci\
if exist "C:\coci\.env" (
    set "envPath=C:\coci\.env"
    goto run_script
)

REM Jika tidak ada, cek di direktori saat ini (tempat script .bat dijalankan)
if exist "%currentDir%.env" (
    set "envPath=%currentDir%.env"
    goto run_script
)

REM Jika belum ada juga, lanjut buat file .env
echo ⚠️  File .env tidak ditemukan!
echo 🛠️  Membuat file .env baru...
echo.

REM Ambil input dari user
set "separator========================================================="
echo %separator%
echo Silakan isi data berikut untuk konfigurasi awal:

echo %separator%

:getUserInput
set "inputUser="
set /p "inputUser=👤 Masukkan Username Akun PeoplesHR: "
if "%inputUser%"=="" (
    echo ❌ ERROR: Username tidak boleh kosong!
    goto getUserInput
)

echo %separator%

:getPasswordInput
set "inputPass="
set /p "inputPass=🔒 Masukkan Password Akun PeoplesHR: "
if "%inputPass%"=="" (
    echo ❌ ERROR: Password tidak boleh kosong!
    goto getPasswordInput
)

echo %separator%

REM Cek apakah C:\coci\auto_coci.py ada
if exist "C:\coci\auto_coci.py" (
    set "inputScript=C:\coci"
    echo File auto_coci.py ditemukan di C:\coci. Menetapkan SCRIPT_PATH ke C:\coci\auto_coci.py.
    goto mainProgram
) else (
    goto getScriptPath
)

:getScriptPath
set "inputScript="
set /p "inputScript=📁 Masukkan DIREKTORI tempat auto_coci.py (contoh: C:\Users\ASUS-TUF\Desktop\coci): "

REM Trim spasi dari input (optional tapi bagus)
for /f "tokens=* delims= " %%i in ("%inputScript%") do set "inputScript=%%i"

if "%inputScript%"=="" (
    echo ❌ ERROR: SCRIPT_PATH tidak boleh kosong!
    pause
    goto getScriptPath
)

if not exist "%inputScript%\auto_coci.py" (
    echo ❌ ERROR: File auto_coci.py tidak ditemukan di path yang diberikan!
    pause
    goto getScriptPath
)

:mainProgram
REM Menentukan path lengkap untuk auto_coci.py
set "fullScriptPath=%inputScript%\auto_coci.py"

REM Menentukan direktori tempat file .env akan disimpan
if exist "C:\coci\auto_coci.py" (
    set "envPath=C:\coci\.env"
) else (
    set "envPath=%currentDir%.env"
)

REM Tulis ke file .env
(
    echo MY_USERNAME=%inputUser%
    echo MY_PASSWORD=%inputPass%
    echo SCRIPT_PATH=%fullScriptPath%
) > "%envPath%"

echo ✅ File .env berhasil dibuat di: %envPath%

timeout /t 3
echo.

:run_script

REM Load .env and extract SCRIPT_PATH
echo 🔄 Mengambil konfigurasi dari: %envPath%
set "SCRIPT_PATH="

REM Ambil variabel dari file .env
for /f "usebackq delims=" %%i in (`type "%envPath%"`) do (
    for /f "tokens=1,2 delims==" %%a in ("%%i") do (
        if /I "%%a"=="SCRIPT_PATH" set "SCRIPT_PATH=%%b"
    )
)

REM Debug: Print SCRIPT_PATH sebelum melanjutkan
echo 📄 File Python akan dijalankan dari: %SCRIPT_PATH%
echo.
REM Cek apakah SCRIPT_PATH ada di .env dan file-nya valid
if "%SCRIPT_PATH%"=="" (
    echo ❌ ERROR: SCRIPT_PATH tidak ditemukan di .env!
    pause
    exit /b
)

REM Cek apakah SCRIPT_PATH valid dan bisa diakses
if not exist "%SCRIPT_PATH%" (
    echo ❌ ERROR: File tidak ditemukan di path: %SCRIPT_PATH%
    echo Pastikan path yang kamu masukkan di .env valid dan file .py-nya ada.
    pause
    exit /b
)

python "%SCRIPT_PATH%"

echo ✅ Proses selesai.

REM Menutup CMD
exit
