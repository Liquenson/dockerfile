#!/bin/bash

# Archivo donde se guardarán las recetas
FILE="recetas.txt"

# Función para mostrar el menú
mostrar_menu() {
    echo "=== Menú de Recetas Médicas ==="
    echo "1. Agregar receta"
    echo "2. Listar recetas"
    echo "3. Buscar receta"
    echo "4. Salir"
    echo "Seleccione una opción [1-4]: "
}

# Función para agregar una receta
agregar_receta() {
    echo "Ingrese el nombre del paciente: "
    read paciente
    echo "Ingrese el nombre del medicamento: "
    read medicamento
    echo "Ingrese la dosis (ej. 2 veces al día): "
    read dosis
    echo "Ingrese observaciones (opcional): "
    read observaciones
    
    echo "Paciente: $paciente" >> $FILE
    echo "Medicamento: $medicamento" >> $FILE
    echo "Dosis: $dosis" >> $FILE
    echo "Observaciones: $observaciones" >> $FILE
    echo "------------------------------" >> $FILE
    
    echo "Receta añadida exitosamente."
}

# Función para listar todas las recetas
listar_recetas() {
    if [ -s $FILE ]; then
        cat $FILE
    else
        echo "No hay recetas almacenadas."
    fi
}

# Función para buscar una receta por nombre de paciente
buscar_receta() {
    echo "Ingrese el nombre del paciente a buscar: "
    read paciente
    grep -A 4 "Paciente: $paciente" $FILE
    if [ $? -ne 0 ]; then
        echo "No se encontraron recetas para el paciente $paciente."
    fi
}

# Función principal
main() {
    while true; do
        mostrar_menu
        read opcion
        case $opcion in
            1) agregar_receta ;;
            2) listar_recetas ;;
            3) buscar_receta ;;
            4) echo "Saliendo..."; exit 0 ;;
            *) echo "Opción inválida, por favor seleccione nuevamente." ;;
        esac
    done
}

# Ejecutar la función principal.
main
