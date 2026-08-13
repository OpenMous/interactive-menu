# Interactive Menu Module

This project is a module for implementing interactive menus in terminal tools and shell programs.

## How it works

You register the options you want to display in your menu in an array used by the `interactive_menu` function. When you use it in your program, it automatically generates an interactive terminal menu that you can navigate using your keyboard.

Once an option is selected, the menu disappears and the chosen option is stored in a variable, allowing you to use it in the rest of your program.

## Purpose

This project was created to make it easy to add `interactive_menu` functionality to scripts developed by **AntonioOA1206** and **OpenMous** without having to reimplement the same code repeatedly (or remember how it works every time it needs to be adapted).
