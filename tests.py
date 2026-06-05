"""
Author: Luis Eduardo Gutiérrez Chavarría
Date: 04/06/26
Project: Evidencia Implementación de Análisis Léxico (Expresión Regular)
Purpose: Implementar una expresión regular equivalente al autómata.
"""

import re

def validar(cadena:str) -> bool:
    "Valida la cadena contra el patrón regex."

    if cadena: 
        patron = r'^(?=.*(ab1|1ba))[ab1]*ba$'

        if re.match(patron, cadena):
            return True

    return False


cadenas = [
    # Sólo opera con caracteres permitidos
    "1baxyzba",
    # Inválidas
    "aaabba",
    "aaa1b",
    "1baaaaa",
    "abba",
    "1abb1bba",
    # Válidas
    "aaab1ba",
    "aaa1ba",
    "1ba",
    "ab11ba",
    "1baab1ba"
]

for s in cadenas:
    resultado = validar(s)

    if resultado == False:
        validez = "Inválida"
    else:
        validez = "Válida"

    print(f"'{s}' es {validez} respecto al lenguaje\n")
