#!/bin/bash

master() {
	echo "Would you like to install the RPS gem and what is needed for it?";
	process() {
		`sudo xcode-select --install`;
		`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`;
		`\curl -sSL https://get.rvm.io | bash -s stable --ruby`;
		`gem install PlayRockPaperScissorsGame`;
	}
	confirm() {
		echo "Press Y to install, or press N to cancel";
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