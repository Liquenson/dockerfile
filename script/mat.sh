#!/bin/bash

mostrar_menu() {
    echo "===================="
    echo "   Calculadora    "
    echo "===================="
    echo "1. Sumar"
    echo "2. Restar"
    echo "3. Multiplicar"
    echo "4. Dividir"
    echo "5. Salir"
    echo "===================="
}

calcular() {
    case $1 in
        1) resultado=$(echo "$2 + $3" | bc);;
        2) resultado=$(echo "$2 - $3" | bc);;
        3) resultado=$(echo "$2 * $3" | bc);;
        4) 
            if [ "$3" -eq 0 ]; then
                echo "No se puede dividir por 0"
                return
            else
                resultado=$(echo "scale=2; $2 / $3" | bc)
            fi
            ;;
        *) echo "Opción no válida";;
    esac
    echo "El resultado es: $resultado"
}

while true; do
    mostrar_menu
    read -p "Seleccione una opción: " opcion

    if [ "$opcion" -eq 5 ]; then
        echo "Saliendo..."
        break
    fi

    read -p "Ingrese el primer número: " num1
    read -p "Ingrese el segundo número: " num2

    calcular $opcion $num1 $num2
    #test
done
