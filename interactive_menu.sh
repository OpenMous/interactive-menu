#!/bin/bash
# Bash script/module for a universal interactive menu for bash scripting | AntonioOA1206 & OpenMosto
##
# This script will create an interactive menu were you can choose between options with W S keys in the terminal.
# You will only have to change the options in the options array with the all options you want your menu to have.
# The last option is build to always be the "Quit" option
##
# Options array, change it with the options you want using the same structure
declare -a options=("1. First option" "2. Second option" "3. Third option" "4. Quit") 
##
# Funtions
function cursor-fix( # Funtion to avoid not showing your cursor when you stop the program with CTRL + C
	
	echo ""
	echo "(Press ENTER to quit)"
	tput cnorm
	exit 0
)
##
function prompt_template ( # Sets the structure for highlighting the options.
	echo -e "\e[${1}m${@:2}\e[0m"
)
##
function print_menu ( # Prints every iteration of the menu with te selected option highlighted
	color_increment=1
	for i in "${!options[@]}"; do
		option="${options[$i]}"
		((color_increment++))
		if  [ $i = $(($menu_position-1)) ]; then
			prompt_template $1 = = = = = = = =
			prompt_template ${!color_increment} $option
			prompt_template $1 = = = = = = = =
		else
			prompt_template ${!color_increment} $option
		fi
	done
)
##
menu_position=1
interactive_menu() {
	while true; do
		tput civis # Hides the terminal cursor
		##
		while true; do
			# Array that saves the menu arguments, resets every time you move trough the menu. This arguments represent each a color.
			declare -a arguments=(30) # Argument 30 = equals chain (======)
			for ((i=1; i<${#options[@]}; i++)); do
				arguments+=(33) # Argument 33 = Menu option
			done
			arguments+=(31) # Argument 31 = "Quit" option (red)
			arguments[$menu_position]=44 # Argument 44 = Highlighted option
			##
			print_menu "${arguments[@]}"
			trap cursor-fix SIGINT
			read -s -n 1 key # Read the keyboard imput (WS)
			##
			if [ -z $key ]; then # Enter
				break
			elif [ $key = "w" ]; then # W
				if [ $menu_position -eq 1 ]; then
					menu_position=1
				else
					menu_position=$(($menu_position-1))
				fi
			elif [ $key = "s" ]; then # S
				if [ $menu_position -eq ${#options[@]} ]; then
					menu_position=${#options[@]}
				else
					menu_position=$((menu_position+1))
				fi
			else
				menu_position=$menu_position
			fi
			clear
		done
		tput cnorm
		if [ $menu_position -eq ${#options[@]} ]; then # Quit option
			exit 0 # This will shutdown the script, change it to "break" if you only want to quit the menu
        else
            menu_option=$menu_position # This will set the option you chosen. Its value is the position of the option in order.
            break
        fi
		##
	done
}
