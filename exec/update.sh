#!/bin/sh

master() {
	echo "Would you like to update RPS?";
	process() {
		gem update PlayRockPaperScissorsGame;
		echo "Finished!";
	}
	confirm() {
		echo "Press U to update or press C to cancel";
		while read -r -n 1 -s answer; do
			if [[ $answer = [UuCc] ]]; then
				[[ $answer = [Uu] ]] && retval=0;
				[[ $answer = [Cc] ]] && retval=1;
				break;
			fi;
		done;
		return $retval;
	}
	init() {
		if confirm; then
			process;
		else
			exit;
		fi;
	}
	init;
}
master;