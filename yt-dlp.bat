@echo off
:start
echo                  ----------------------
echo                  ! Youtube Downloader !
echo                  ----------------------
echo.
echo  ------------------------------------------------------
echo  ! [1] : Download Video        ! -o ... URL           !
echo  ! [2] : Download Audio        ! -o -f m4a ... URL    !
echo  ! [3] : Trim and Download     ! -g URL --  ffmpeg    !
echo  ! [4] : Download V.Playlist   !                      !
echo  ! [5] : Downlaod A.Playlist   !                      !
echo  ! [6] : Show all options      ! -F URL, Stream "MPV" !
echo  ! [7] : Custom command        !                      !
echo  ------------------------------------------------------
echo  ! [8] : UPDATE                ! -U                   !
echo  ------------------------------------------------------
echo.
md dl
echo   -------------------------
set /p DTYPE=.  choose a number: 
if %DTYPE%==8 goto Update 
set /p URL=.  Url: 
echo   -------------------------
echo.
if %DTYPE%==1 goto Video
if %DTYPE%==2 goto Audio
if %DTYPE%==3 goto Trim
if %DTYPE%==4 goto Pl.Video
if %DTYPE%==5 goto Pl.Audio
if %DTYPE%==6 goto All 
if %DTYPE%==7 goto Custom

:All
echo -- Show all options ...
yt-dlp.exe -F %URL%
echo.
set /p F.ID=choose a number (A or V or both A+V): 
echo.
echo [1] : Download
echo [2] : Stream
echo [3] : Print URL
echo.
set /p DORS=choose a number:
echo.
if %DORS%==1  goto All.d
if %DORS%==2 goto All.s
if %DORS%==3 goto All.pu
	:All.d
	echo -- Download the file ...
	yt-dlp.exe -f %F.ID% -o ./dl/%%(title)s.%%(ext)s %URL%
	pause
	echo  ________________________ End _________________________
	echo.
	goto start


	:All.s
	echo -- Stream the file ...
	mpv --ytdl-format=%F.ID% %URL%
	set/p DORS2=Download? (Y,N)
	if %DORS2%==y goto All.d
	
	:All.pu
	echo -- Print URL ...
	yt-dlp.exe -g -f %F.ID% %URL%	
	pause
	echo  ________________________ End _________________________
	echo.
	goto start

:Trim
echo -- Print URL ...
yt-dlp.exe -g %URL%
echo. 
echo   -------------------------
echo Paste printed URL
set /p Fg=.  Link: 
echo.
echo use "s" for (00:00) or "e" for (end)
set /p TS=.  Start (hh:mm:ss.ms): 
set /p TE=.  End   (hh:mm:ss.ms): 
echo   -------------------------
echo. 
echo -- Download the file ...
if %TE%==e goto Trim.e
if %TS%==s goto Trim.s

ffmpeg.exe -ss %TS% -i "%Fg%" -t %TE% -c copy dl/out.mp4
pause
echo  ________________________ End _________________________
echo.
goto start

	:Trim.e
	ffmpeg.exe -ss %TS% -i "%Fg%" -c copy dl/out.mp4
	pause
	echo  ________________________ End _________________________
	echo.
	goto start
	
	:Trim.s
	ffmpeg.exe -ss 00:00:00 -i "%Fg%" -t %TE% -c copy dl/out.mp4
	pause
	echo  ________________________ End _________________________
	echo.
	goto start

:Video
echo -- Download the video ...
yt-dlp.exe -o ./dl/%%(title)s.%%(ext)s %URL%
pause
echo  ________________________ End _________________________
echo.
goto start


:Audio
echo -- Download the audio file ...
yt-dlp.exe -f m4a -o ./dl/%%(title)s.%%(ext)s %URL%
pause
echo  ________________________ End _________________________
echo.
goto start

:Pl.Video
echo 1: Start from
echo 2: from X to Y
set /p PLTYPE=choose a number: 
if %PLTYPE%==1 goto PLS 
if %PLTYPE%==2 goto PLI

    :PLS
    set /p PLS= Playlist Start:
    yt-dlp.exe --playlist-start %PLS% %URL%
	pause
	echo  ________________________ End _________________________
	echo.
	goto start

    :PLI
    set /p PLI= Set X and Y (1-3,5,7): 
    yt-dlp.exe --playlist-items %PLI% %URL%
	pause
	echo  ________________________ End _________________________
	echo.
	goto start

:Pl.Audio
echo 1: Start from
echo 2: from X to Y
set /p PLTYPE=choose a number: 
if %PLTYPE%==1 goto PLS.a if %PLTYPE%==2 goto PLI.a

    :PLS.a
    set /p PLS= Playlist Start:
    yt-dlp.exe -f m4a --playlist-start %PLS% %URL%
	pause
	echo  ________________________ End _________________________
	echo.
	goto start

    :PLI.a
    set /p PLI= Set X and Y (1-3,5,7): 
    yt-dlp.exe -f m4a --playlist-items %PLI% %URL%
	pause
	echo  ________________________ End _________________________
	echo.
	goto start
	
:Custom
echo if you need help type --> -h
set /p COMMAND=Commnd --> yt-dlp  
yt-dlp.exe %COMMAND%
pause
echo  ________________________ End _________________________
echo.
goto start

:Update
yt-dlp.exe -U
pause
echo  ________________________ End _________________________
echo.
goto start


echo =============================================================
echo =                                                           =
echo =  Y88b   d88P  88888888888             888  888  88888b.   =
echo =   Y88b d88P       888                 888  888  888 "88b  = 
echo =    Y88o88P        888                 888  888  888  888  =
echo =     Y888P         888             .d88888  888  888 d88P  =  
echo =      888          888            d88" 888  888  88888P"   =
echo =      888          888            888  888  888  888       =
echo =      888          888      888   Y88b 888  888  888       =
echo =      888          888      888    "Y88888  888  888       =
echo =                                                           =
echo =============================================================
