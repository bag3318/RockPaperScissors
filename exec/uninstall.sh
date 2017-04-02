#!/bin/sh

master() {
	echo "Would you like to Uninstall the RPS gem, Ruby Gems, Ruby, and xcode command line tools?";
	process() {
		`sudo rm -rf /Library/Developer/CommandLineTools`;
		`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"`;
		`rvm implode`;
		`gem uninstall PlayRockPaperScissorsGame`;
	}
	confirm() {
		echo "Press Y to uninstall, or press N to cancel";
		while read -r -n 1 -s answer; do
			if [[ $answer = [YyNn] ]]; then 
			    [[ $answer = [Yy] ]] && retval=0; 
			    [[ $answer = [Nn] ]] && retval=1; 
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