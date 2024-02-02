#!/bin/bash

# Función para generar una clave privada aleatoria de 52 caracteres
generate_random_private_key() {
	characters='123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
	length=52
	new_private_key=$(cat /dev/urandom | tr -dc $characters | fold -w $length | head -n 1)
	echo "$new_private_key"
}

# Loop para intentar importar la clave generada
while :
do
	new_private_key=$(generate_random_private_key)
	result=$(./bitcoin-cli -rpcwallet="Argmining10" importprivkey "$new_private_key" "" false 2>&1)
	if [[ $result == *"Invalid private key encoding"* ]]; then
    	echo "Intento fallido con clave: $new_private_key"
	else
    	echo "¡Clave privada válida encontrada!: $new_private_key"
    	echo "$new_private_key" > privkey.txt
    	break
	fi
done
