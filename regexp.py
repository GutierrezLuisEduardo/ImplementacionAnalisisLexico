"""
Author: Luis Eduardo Gutiérrez Chavarría
Date: 23/03/26
Project: Evidencia Implementación de Análisis Léxico (Autómata y
Expresión Regular)
Purpose: Implementar una expresión regular equivalente al autómata.
"""

import re

def validar(cadena:str) -> str:
    """
    ## Valida la cadena contra el patrón regex.

    `cadena`: cadena a validar
    """

    if not cadena: 
        return "Inválida"

    patron = r'^(?=.*(ab1|1ba))[ab1]*ba$'

    if re.match(patron, cadena):
        return "Válida"
    else:
        return "Inválida"