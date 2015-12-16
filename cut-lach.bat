@ECHO OFF
@TITLE Cut&Lach

@SET ext=mp4

@MD cut_lach

@FOR %%i IN ("*.%ext%") DO (SET fname=%%i) & CALL :encode
@TITLE Cut&Lach
@ECHO ..........
@ECHO All done
@PAUSE
@GOTO :eof

:encode
@TITLE Cut&Lach: "%fname%"
@FFMPEG -i "%fname%" -ss 0:00:00.317 -c copy "cut_lach\cut_%fname%"
@FFMPEG -i "cut_lach\cut_%fname%" -af "pan=stereo|c0<0*c0+c1|c1<0*c0+c1,aeval=-val(0)|val(1)"  -vcodec copy "cut_lach\%fname%"
@DEL /q /f "cut_lach\cut_%fname%"

@GOTO :eof