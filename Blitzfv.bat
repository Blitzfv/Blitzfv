@echo off
chcp 65001 >nul
mode con: cols=120 lines=30
title By Blitzfv

:: Set the console color to black background and bright magenta text
color 0D

cd files

:banner
cls
echo.
echo.                        ███╗   ███╗██╗   ██╗██╗  ████████╗██╗████████╗ ██████╗  ██████╗ ██╗     
echo.                        ████╗ ████║██║   ██║██║  ╚══██╔══╝██║╚══██╔══╝██╔═══██╗██╔═══██╗██║     
echo.                        ██╔████╔██║██║   ██║██║     ██║   ██║   ██║   ██║   ██║██║   ██║██║     
echo.                        ██║╚██╔╝██║██║   ██║██║     ██║   ██║   ██║   ██║   ██║██║   ██║██║     
echo.                        ██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║   ██║   ╚██████╔╝╚██████╔╝███████╗
echo.                        ╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝
echo.
:: Reset color for the choices
color 0D
echo 1] Autoruns
echo 2] cc_20240821_212554
echo 3] CCleaner
echo 4] msert
echo 5] MSI Afterburner
echo 6] MSI_util_v3
echo 7] NVCleanstall_1.16.0
echo 8] nvidiaProfileInspector
echo 9] OOSU10
echo 10] parkcontrolsetup64
echo 11] Prefetch
echo 12] System Explorer
echo 13] SystemPropertiesPerformance.exe
echo 14] TCPOptimizer
echo 15] Temp
echo 16] Temp2
echo 17] Ultimate Windows Tweaker 5.1
echo 18] UnparkCpu
echo 19] WPD
echo 20] DNS Test
echo.
set /p choices="Enter your choices (e.g., 1,3,5): "

:: Process the input
for %%i in (%choices%) do (
    if "%%i"=="20" (
        echo.
        echo Performing DNS Test...
        echo Pinging 1.1.1.1 and 8.8.8.8...

        setlocal enabledelayedexpansion
        set best_dns=""
        set best_ping=9999

        for %%d in (1.1.1.1 8.8.8.8) do (
            echo Pinging %%d...
            for /L %%j in (1,1,5) do (
                for /f "tokens=5" %%a in ('ping -n 1 %%d ^| findstr "Average"') do (
                    set "ping_time=%%a"
                    echo Ping %%d: !ping_time! ms
                    if !ping_time! LSS !best_ping! (
                        set best_ping=!ping_time!
                        set best_dns=%%d
                    )
                )
                timeout /t 1 >nul
            )
            echo.
        )

        echo Applying DNS settings to: %best_dns% with an average ping of %best_ping% ms
        netsh interface ip set dns name="Ethernet" static %best_dns%
        echo DNS settings applied successfully.

        pause
    )
)

:: Clean up
endlocal
pause
