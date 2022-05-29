@echo off
:start
echo  ----------------------
echo  ! Youtube Downlaoder !
echo  ----------------------

echo.
echo  ----------------------------------------------------
echo  ! [1] : Download Video        ! -o ... URL         !
echo  ! [2] : Download Audio        ! -o -f m4a ... URL  !
echo  ! [3] : Trim and Download     ! -g URL --> ffmpeg  !
echo  ! [4] : Download V.Playlist   !                    !
echo  ! [5] : Downlaod A.Playlist   !                    !
echo  ! [6] : Show all options      ! -F URL, Stream MPV !
echo  ----------------------------------------------------
echo  ! [7] : UPDATE                ! -U                 !
echo  ----------------------------------------------------
echo.
echo   -------------------------
set /p URL=.  Url: 
set /p DTYPE=.  Chose a number: 
echo   -------------------------
echo.
if %DTYPE%==1 goto Video
if %DTYPE%==2 goto Audio
if %DTYPE%==3 goto Trim
if %DTYPE%==4 goto Pl.Video
if %DTYPE%==5 goto Pl.Audio
if %DTYPE%==6 goto All 
if %DTYPE%==7 goto Update 

:All
echo -- Show all options ...
yt-dlp.exe -F %URL%
echo.
set /p F.ID=Chose a number:
echo.
echo [1] : Download
echo [2] : Stream
echo.
set /p DORS=Chose a number:  
if %DORS%==1  goto All.d
if %DORS%==2 goto All.s
	:All.d
	echo -- Download the file ...
	yt-dlp.exe -f %F.ID% -o ./dl/%%(title)s.%%(ext)s %URL%
	echo -- End
	pause
	echo.
	goto start

	:All.s
	echo -- Stream the file ...
	mpv --ytdl-format=%F.ID% %URL%
	set/p DORS2=Download? (Y,N)
	if %DORS2%==y goto All.d
echo -- End
pause
echo.
goto start

:Trim
echo -- Print URL ...
yt-dlp.exe -g %URL%
echo. 
echo   -------------------------
set /p Fg=.  Link: 
set /p TS=.  Start (hh:mm:ss.ms): 
set /p TE=.  End   (hh:mm:ss.ms): 
echo   -------------------------
echo. 
echo -- Download file ...
ffmpeg.exe -ss %TS% -i "%Fg%" -t %TE% -c copy out.mp4
echo -- End
pause
echo.
goto start


:Video
echo -- Download the video ...
yt-dlp.exe -o ./dl/%%(title)s.%%(ext)s %URL%
echo -- End
pause
echo.
goto start

:Audio
echo -- Download the audio file ...
yt-dlp.exe -f m4a -o ./dl/%%(title)s.%%(ext)s %URL%
echo -- End
pause
echo.
goto start

:Pl.Video
echo 1: Start from
echo 2: from X to Y
set /p PLTYPE=Chose a number: 
if %PLTYPE%==1 goto PLS 
if %PLTYPE%==2 goto PLI

    :PLS
    set /p PLS= Playlist Start:
    yt-dlp.exe --playlist-start %PLS% %URL%
    echo -- End
	pause	
    goto start

    :PLI
    set /p PLI= Set X and Y (1-3,5,7): 
    yt-dlp.exe --playlist-items %PLI% %URL%
	echo -- End
	pause
    goto start

:Pl.Audio
echo 1: Start from
echo 2: from X to Y
set /p PLTYPE=Chose a number: 
if %PLTYPE%==1 goto PLS.a if %PLTYPE%==2 goto PLI.a

    :PLS.a
    set /p PLS= Playlist Start:
    yt-dlp.exe -f m4a --playlist-start %PLS% %URL%
	echo -- End
	pause
    goto start

    :PLI.a
    set /p PLI= Set X and Y (1-3,5,7): 
    yt-dlp.exe -f m4a --playlist-items %PLI% %URL%
	echo -- End
	pause
    goto start
:Update
yt-dlp.exe -U
echo ============================================================
echo =                                                           =
echo =  Y88b   d88P  88888888888             888  888  88888b.   =
echo =   Y88b d88P       888                 888  888  888 "88b  = 
echo =    Y88o88P        888                 888  888  888  888  =
echo =     Y888P         888             .d88888  888  888 d88P  =  
echo =      888          888            d88" 888  888  88888P"   =
echo =      888          888            888  888  888  888       =
echo =      888          888      888   Y88b 888  888  888       =
echo =      888          888      888    "Y88888  888  888       =
echo =                                                         
echo =============================================================
