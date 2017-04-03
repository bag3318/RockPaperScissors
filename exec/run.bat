@ECHO OFF

:master

	:confirm
		CHOICE /C YN "Would you like to play Rock Paper Scissors?"
		IF "%ERRORLEVEL%"=="1" CALL:process
		IF "%ERRORLEVEL%"=="2" CALL:exiting
	GOTO:EOF
	
	REM start process
	:process
		START cmd.exe /K PlayRockPaperScissorsGame
		IF %ERRORLEVEL% EQU 9009 (
			ECHO error - cmd.exe file not found in your PATH
		)
	GOTO:EOF
	REM end process

	:exiting
		EXIT
	GOTO:EOF

GOTO:EOF

CALL:master