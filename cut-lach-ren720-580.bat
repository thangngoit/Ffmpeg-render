@ECHO OFF
@TITLE Render

@SET ext=mp4
@SET bg=bg720.jpg
@SET resH=720
@SET scaleH=580
@SET /a resW=%resH%*16/9
@SET /a scaleW=(%resW%*%scaleH%)/%resH%
@SET /a overlayX=(%resW%-%scaleW%)/2
@SET /a overlayY=(%resH%-%scaleH%)/2

@MD render
@CLS

@IF NOT EXIST "%bg%" (
    @REM Do another thing
    @TITLE Render: ERROR
    @ECHO Not exist image "%bg%"
    @PAUSE
    @EXIT
)

@FOR %%i IN ("*.%ext%") DO (SET fname=%%i) & CALL :encode
@TITLE Render
@ECHO ..........
@ECHO All done
@PAUSE
@GOTO :eof

:encode
@TITLE Render: "%fname%"
@FFMPEG -i "%fname%" -ss 0:00:00.317 -c copy "render\cut_%fname%"
@FFMPEG -loop 1 -i "%bg%" -i "render\cut_%fname%" -filter_complex "[0:v]scale=%resW%:0[bg];[1:v]scale=%scaleW%:%scaleH%[fl];[bg][fl]overlay=%overlayX%:%overlayY%:shortest=1,format=yuv420p[v];[1:a]pan=stereo|c0<0*c0+c1|c1<0*c0+c1,aeval=-val(0)|val(1) [a]" -map "[v]" -map "[a]" -movflags +faststart "render\%fname%"
@DEL /q /f "render\cut_%fname%"

@GOTO :eof