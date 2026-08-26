# Interactive Menu Module

This project is a module for implementing interactive menus in terminal tools and shell programs.

## How it works

This script will display an interactive menu were you can choose between options with W S keys or with the arrow keys in the terminal.

You just have to import the script on your own script or program and use the funtion `interactive-menu` followed by the options you want your menu to have as arguments.

### Example

~~~
source ./interactive_menu
interactive_menu "1. Option" "2. Option" "3. Option" "4. Quit"
~~~

Once an option is selected, the menu disappears and the chosen option is stored in the variable `menu_option`, allowing you to use it in the rest of your program.

The last option is build to always be the "Quit" option, and will end the program instantly unless you use the -b (or --break) option.

### Example 

~~~
source ./interactive_menu
interactive_menu "1. Option" "2. Option" "3. Option" "4. Quit" --break
~~~

## Purpose

This project was created to make it easy to add `interactive_menu` functionality to scripts developed by **AntonioOA1206** and **OpenMous** without having to reimplement the same code repeatedly (or remember how it works every time it needs to be adapted).
