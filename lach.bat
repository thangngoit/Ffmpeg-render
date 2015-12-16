@ECHO OFF
@TITLE Lach

@SET ext=mp4

@MD lach

@FOR %%i IN ("*.%ext%") DO (SET fname=%%i) & CALL :encode
@TITLE Lach
@ECHO ..........
@ECHO All done
@PAUSE
GOTO :eof

:encode
@TITLE Lach: "%fname%"
@FFMPEG -i "%fname%" -af "pan=stereo|c0<0*c0+c1|c1<0*c0+c1,aeval=-val(0)|val(1)"  -vcodec copy "lach\%fname%"

GOTO :eof