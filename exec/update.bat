@ECHO OFF

:master

	:confirm
		CHOICE /C YN "Would you like to update RPS?"
		IF "%ERRORLEVEL%" == "1" CALL:process
		IF "%ERRORLEVEL%" == "2" CALL:exiting
	GOTO:EOF

	:process
		START cmd.exe /K gem update PlayRockPaperScissorsGame
		IF %ERRORLEVEL% EQU 9009 (
			ECHO error - cmd.exe file not found in your PATH
		)
	GOTO:EOF

	:exiting
		EXIT
	GOTO:EOF
GOTO:EOF

CALL:master
