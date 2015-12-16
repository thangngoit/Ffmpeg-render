@ECHO off
@FOR /f "tokens=*" %%a IN ('ffprobe -show_format -i %1 ^| find "duration"') DO  SET _duration=%%a
@SET _duration=%_duration:~9%
@FOR /f "delims=. tokens=1*" %%b IN ('ECHO %_duration%') DO SET /a "_durS=%%b"
@FOR /f "delims=. tokens=2*" %%c IN ('ECHO %_duration%') DO SET "_durMS=%%c"
@REM following line is seconds to cut
@SET /a "_durS-=1"
@SET "_newduration=%_durS%.%_durMS%"
@SET "_output=%~n1"
@FFMPEG -ss 0 -i %1 -t %_newduration% -c copy "fixed\%_output%.mp4"