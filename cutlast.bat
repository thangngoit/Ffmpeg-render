@ECHO OFF
@TITLE Cut last

@SET ext=mp4

@MD fixed

@FOR %%i in (*.%ext%) DO (
@TITLE Cut last: "%%i"
@CALL _cutlast.bat "%%i"
)
@TITLE Cut last
@ECHO ..........
@ECHO All done
@PAUSE