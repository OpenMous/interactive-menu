#!/bin/bash
# Script prototipo para generar menus automaticamente by | AntonioOA1206 & mosto
# Funciones
##
function plantilla_prompt ( # Función plantilla para colorear el "prompt"
	echo -e "\e[${1}m${@:2}\e[0m"
)
##
function print_menu ( # Función que colorea el menú
	posicion_print=1
	for i in "${!opciones[@]}"; do
		opcion="${opciones[$i]}"
		((posicion_print++))
		# Si el indice de la opcion es igual a la variable posicion_menu -1 significa que estas "seleccionando" esa opcion
		if  [ $i = $(($posicion_menu-1)) ]; then
			plantilla_prompt $1 = = = = = = = =
			plantilla_prompt ${!posicion_print} $opcion
			plantilla_prompt $1 = = = = = = = =
		# Si no es igual entonces no mostramos los "espacios"
		else
			plantilla_prompt ${!posicion_print} $opcion
		fi
	done
)
##
posicion_menu=1 # Posición inicial
menu_interactivo() {
	while true; do
		tput civis # Oculta el cursor en la terminal
		##
		while true; do
			# Array que guarda los argumentos (colores) y se reinicia cada que te mueves por el menú
			declare -a argumentos=(30) # Argumento 30 = cadena de iguales (======)
			# Contador que incluye al array argumentos tantos como opciones -1 haya
			for ((i=1; i<${#opciones[@]}; i++)); do
				argumentos+=(33) # Argumento 33 = Opción del menú
			done
			argumentos+=(31) # Argumento 31 = Opción de salir del menú (rojo)
			argumentos[$posicion_menu]=44 # Argumento 44 = Opción seleccionada 
			##
			print_menu "${argumentos[@]}"
			read -s -n 1 tecla # Imput del teclado para mover el menú (WS)
			##
			if [ -z $tecla ]; then # Enter
				break
			##
			elif [ $tecla = "w" ]; then # W
				if [ $posicion_menu -eq 1 ]; then
					posicion_menu=1
				else
					posicion_menu=$(($posicion_menu-1))
				fi
			##
			elif [ $tecla = "s" ]; then # S
				if [ $posicion_menu -eq ${#opciones[@]} ]; then
					posicion_menu=${#opciones[@]}
				else
					posicion_menu=$((posicion_menu+1))
				fi
			##
			else
				posicion_menu=$posicion_menu
			fi
			##
			clear
		done
		tput cnorm
		##
		if [ $posicion_menu -eq ${#opciones[@]} ]; then # Opción para salir
			break
		else
			read -p "¿Deseas algo mas (S/n)? " sn3
			if [ -z $sn3 ] || [ $sn3 = "s" ] || [ $sn3 = "S" ]; then
				clear
			else
				break
			fi
		fi
		##
	done
}
##
# Variables
fichero_opciones="./opciones.txt"
opciones_introducidas=$(cat $fichero_opciones)
# Programa
clear # Clear del terminal
##
echo "Procesando opciones..."
sleep 1
echo "-- Opciones introducidas --"
cat $fichero_opciones
##
echo "==========="
echo "1. Crear menu con estas opciones"
echo "2. Crear menu con nuevas opciones"
echo "3. Salir"
echo "==========="
read -p "¿Que quieres hacer? " pre_menu
##
case $pre_menu in
	1)
	declare -a opciones
	mapfile -t opciones < "$fichero_opciones"
	menu_interactivo
	;;
	2)
	read -p "Nueva opcion (ENTER para salir): " nueva_opcion
	echo "$nueva_opcion" > $fichero_opciones
	while true; do
		read -p "Nueva opcion (ENTER para salir): " nueva_opcion
		if [ "$nueva_opcion" == "" ]; then
			break
		fi
		echo "$nueva_opcion" >> $fichero_opciones
	done
	declare -a opciones
	mapfile -t opciones < "$fichero_opciones"
	menu_interactivo
	;;
	*)
	echo "Saliendo..."
	;;
esac
##