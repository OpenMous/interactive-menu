#!/bin/bash

function fcolores (
	echo -e "\e[${1}m${@:2}\e[0m"
)

col_def=33

declare -a opcs=("Ver_Usuarios" "Crear_Usuario" "Modificar_Usuario" "Borrar_Usuarios" "Volcar_y_Salir")

echo "-----------------"
echo Hay ${#opcs[@]} opciones
echo "-----------------"

function fmenu (
	pos=0
	for e in ${opcs[@]};do
		if [ $pos -eq 0 ];then
			if [ $sit -eq 1 ];then
				fcolores $1 = = = = = = = =
				fcolores $2 $e
				fcolores $1 = = = = = = = =
			else
				fcolores $2 $e
			fi
		elif [ $pos -eq 1 ];then
			if [ $sit -eq 2 ];then
				fcolores $1 = = = = = = = =
				fcolores $3 $e
				fcolores $1 = = = = = = = =
			else
				fcolores $3 $e
			fi
		elif [ $pos -eq 2 ];then
			if [ $sit -eq 3 ];then
				fcolores $1 = = = = = = = =
				fcolores $4 $e
				fcolores $1 = = = = = = = =
			else
				fcolores $4 $e
			fi
		elif [ $pos -eq 3 ];then
			if [ $sit -eq 4 ];then
				fcolores $1 = = = = = = = =
				fcolores $5 $e
				fcolores $1 = = = = = = = =
			else
				fcolores $5 $e
			fi
		else
			if [ $sit -eq 5 ];then
				fcolores $1 = = = = = = = =
				fcolores $6 $e
				fcolores $1 = = = = = = = =
			else
				fcolores $6 $e
			fi
		fi
		pos=$(($pos+1))
	done
)
##

sit=1

while true;do
	#Oculta el cursor en la terminal
	tput civis
	##

	#Moverse por el menu
	while true;do
		declare -a args=(30)

		for ((i=1; i<${#opcs[@]}; i++)); do
			args+=(33)
		done

		args+=(31)
		args[$sit]=44

		fmenu "${args[@]}"

		#Lee sin mostrar lo que se escribe y solo una tecla
		read -s -n 1 tecla
		#Si le das a enter elige esa opcion
		if [ -z $tecla ];then
			break
		##
		#Si pulsas w subes en el menu poniendo como limite la primera opcion
		elif [ $tecla = "w" ];then
			if [ $sit -eq 1 ];then
				sit=1
			else
				sit=$(($sit-1))
			fi
		##
		#Si pulsas s bajas en el menu poniendo como limite la ultima opcion
		elif [ $tecla = "s" ];then
			if [ $sit -eq 5 ];then
				sit=5
			else
				sit=$((sit+1))
			fi
		##
		#Si pulsas cualquier otra tecla pues no hace nada
		else
			sit=$sit
		fi
		##
		clear
	done
	##

	#Muestra de nuevo el cursor en la terminal
	tput cnorm
	##
    	#La opcion 5 es salir
	if [ $sit -eq 5 ];then
		break
	##
	#Si no pues te pregunta si quieres hacer algo mas o no
	else
		read -p "¿Deseas algo mas (S/n)? " emp
		if [ -z $emp ] || [ $emp = "s" ] || [ $emp = "S" ];then
			clear
		else
			break
		fi
	fi
	##
done
