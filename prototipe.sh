#!/bin/bash

function fcolores ( # Función plantilla para colorear el "prompt"
	echo -e "\e[${1}m${@:2}\e[0m"
)

declare -a opcs=("Ver_Usuarios" "Crear_Usuario" "Modificar_Usuario" "Borrar_Usuarios" "Volcar_y_Salir") # Array de opciones

function fmenu (
	# Variable sit temporal que se reinicia cada que te mueves por el menu
	sit_temp=1

	# Para cada opcion nos quedamos con su indice en el array indexado
	for i in "${!opcs[@]}"; do
		# Nos quedamos con la opcion correspondiente (texto)
		e="${opcs[$i]}"
		# Aumentamos la variable temporal porque es necesario para que se muestren los colores correctamente
		((sit_temp++))

		# Si el indice de la opcion es igual a la variable sit -1 significa que estas "seleccionando" esa opcion
		# (Ha resultado curioso que la posicion en el array siempre sea el valor de sit-1 en este caso)
		if  [ $i = $(($sit-1)) ]; then
			fcolores $1 = = = = = = = =
			fcolores ${!sit_temp} $e
			fcolores $1 = = = = = = = =
		##
		# Si no es igual entonces no mostramos los "espacios"
		else
			fcolores ${!sit_temp} $e
		fi
		##

	done
)

sit=1

while true;do
	#Oculta el cursor en la terminal
	tput civis
	##

	#Moverse por el menu
	while true;do
		# Array que guarda los argumentos (colores) y se reinicia cada que te mueves por el menú
		declare -a args=(30)

		# Contador que incluye al array argumentos (default 33) tantos como opciones - 1 haya
		for ((i=1; i<${#opcs[@]}; i++)); do
			args+=(33)
		done
		##

		# Se añade un ultimo que correspondera al color rojo para la ultima opcion que es la de salir
		args+=(31)
		# Dependiendo el valor de $sit (donde estes en el menú) sustituira el 33 correspondiente con un 44
		args[$sit]=44

		# Llama a la funcion del menú con todos los argumentos
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
			if [ $sit -eq ${#opcs[@]} ];then
				sit=${#opcs[@]}
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
