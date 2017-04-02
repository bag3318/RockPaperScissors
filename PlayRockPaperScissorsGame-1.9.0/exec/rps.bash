#!/bin/bash

master() {

	normal=$(tput sgr0);      # Select normal mode
	bold=`tput bold`;         # Select bold mode
	nonbold=`tput sgr0` 	  # Select non-bold mode
	underline=`tput smul`;    # Select underline mode
	nonunderline=`tput rmul`; # Select non-underline mode

	echo "${bold}Would you like to install the RPS gem and what is needed for it?${nonbold}";
	processes() {
		process() {
			sudo xcode-select --install;
		}
		process1() {
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
			\curl -sSL https://get.rvm.io | bash -s stable --ruby;
			osascript -e "
			tell application \"Terminal\"
			do script \"gem install PlayRockPaperScissorsGame; $1\"
			end tell";	
			echo 'Finished!';
		}
	}
	processes;
	confirmations() {
		confirm() {
			echo "${bold}Press Y to install, or press N to cancel${nonbold}";
			while read -r -n 1 -s answer; do
				if [[ $answer = [YyNn] ]]; then 
				    [[ $answer = [Yy] ]] && retval=0; 
				    [[ $answer = [Nn] ]] && retval=1; 
				    break; 
				fi; 
			done;
			return $retval;
		} 
		confirm1() {
			echo "${bold}PLEASE WAIT UNTIL XCODE COMMAND LINE TOOLS ARE DONE INSTALLING!";
			echo "If you get an error that says you already installed it, then please continue.";
			echo "Press C to continue...${nonbold}"
			while read -r -n 1 -s answer; do
				if [[ $answer = [Cc] ]]; then 
				    [[ $answer = [Cc] ]] && retval=0; 
				    break; 
				fi; 
			done;
			return $retval;
		} 
	}
	confirmations;
	initFunctions() {
		init() {
			if confirm; then
				process;
			else
				exit;
			fi;
		}
		init;
		init1() {
			if confirm1; then
				process1;
			else
				exit;
			fi;
		}
		init1
	}
	initFunctions;
}
master;
