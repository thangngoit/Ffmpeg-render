@ECHO OFF
@TITLE Add image

@SET vExt=mp4
@SET aExt=mp3
@SET bg=background.jpg
@SET bitRate=128
@SET frequency=44100

@MD combine
@CLS

@IF NOT EXIST "%bg%" (
    @REM Do another thing
    @TITLE Add image: ERROR
    @ECHO Not exist image "%bg%"
    @PAUSE
    @EXIT
)

@FOR %%i IN ("*.%aExt%") DO (SET fname=%%i) & CALL :encode
@TITLE Add image
@ECHO All done
@PAUSE
GOTO :eof

:encode
@TITLE Add image: "%fname%"
@FFMPEG -i "%fname%" -ss 0:00:00.317 -c copy "combine\cut_%fname%"
@FFMPEG -i "combine\cut_%fname%" -af "pan=stereo|c0<0*c0+c1|c1<0*c0+c1,aeval=-val(0)|val(1)"  -vcodec copy "combine\lach_%fname%"
@DEL /q /f "combine\cut_%fname%"
@FFMPEG -loop 1 -i "%bg%" -i "combine\lach_%fname%" -c:v libx264 -c:a copy -shortest "combine\%fname%.%vExt%"
@DEL /q /f "combine\lach_%fname%"

GOTO :eof