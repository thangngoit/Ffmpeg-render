@ECHO OFF
@TITLE Cut

@SET ext=mp4

@MD cut

@FOR %%i IN ("*.%ext%") DO (SET fname=%%i) & CALL :encode
@TITLE Cut
@ECHO ..........
@ECHO All done
@PAUSE
@GOTO :eof

:encode
@TITLE Cut: "%fname%"
@FFMPEG -i "%fname%" -ss 0:00:00.317 -c copy "cut\%fname%"

@GOTO :eof