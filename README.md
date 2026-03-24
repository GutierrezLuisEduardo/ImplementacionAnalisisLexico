**Evidencia Implementación de Análisis Léxico (Autómata y Expresión Regular)**

| All possible combinations of | Rules |
| ----- | :---: |
| ab1 | must have ab1 or 1ba |
|  | and must end with ba |

Fig.1 \- El lenguaje y el conjunto de reglas que lo conforman

## **Descripción del lenguaje**

Se tiene un lenguaje con alfabeto:  
∑ \= {a, b, 1}

Y un conjunto de reglas, tal que cualquier combinación válida siempre termine con ‘*ba*’ y contenga al menos una concurrencia de ‘*ab1*’ o ‘*1ba*’.

## **Modelado del lenguaje**

A continuación los *NFA* que representan las reglas del lenguaje mencionado, fueron hechos con *plantUML*, (he decidido modelar de esta manera por la facilidad que permiten estos autómatas) utilizando el siguiente código: 
```PlantUML
@startuml

StateAB11BA \--\> q0
StateAB11BA : Debe contener al menos una ocurrencia de 'ab1' o '1ba'

' Lee cualquier pregijo  
q0 \--\> q0 : a  
q0 \--\> q0 : b  
q0 \--\> q0 : 1

' Intento de detectar "ab1"
q0 \--\> q1 : a  
q1 \--\> q2 : b  
q2 \--\> qf : 1

' Intento de detectar "1ba"
q0 \--\> q3 : 1  
q3 \--\> q4 : b  
q4 \--\> qf : a

' Encontró alguno  
qf \--\> qf : a  
qf \--\> qf : b  
qf \--\> qf : 1

StateBA \--\> q24 
StateBA : Debe terminar siempre con 'ba'

' Cualquier prefijo
q24 \--\> q24 : a  
q24 \--\> q24 : b  
q24 \--\> q24 : 1

' Terminación en 'ba'
q24 \--\> q25 : b  
q25 \--\> q25 : a

@enduml
```

![NFA's]["./Images/NFA - Diagram.png"]  
Fig.2 Dos NFA: aquel que representa ocurrencias de ‘ab1’ y ‘1ba’ (izquierda), y terminación de ‘ba’ (derecha)

## **Implementación de una expresión regular equivalente**

La expresión estuvo pensada para detectar saltos de línea y evaluar la línea completa (por ello los anchors de ***'^'*** y ***'$'*** para inicio y final de línea, respectivamente). Después el grupo de comprobación de *positive-lookahead* que asegura la presencia de 0 o más caracteres previo al grupo de captura que impone la restricción de lenguaje de una mínima ocurrencia de '*ab1*' o '*1ba*'.

Los caracteres previos y posteriores al grupo de captura sólo pueden adquirir valores constituidos dentro del alfabeto del lenguaje (denotado como ‘\[*abc*\]’) y hacer esto entre una cantidad de cero e ilimitada de veces (‘*\**’).

Por último sólo se añade de manera explícita ‘*ba*’, para cumplir con la restricción de validez en que toda cadena válida debe terminar con ‘*ba*’. 

Conformada la expresión regular, se incluyó dentro de un código (*regex.py*) que contiene una función que analiza una cadena dada y la valida respecto al patrón (que comprende las reglas del lenguaje), determinando así la correspondencia entre dada cadena y el lenguaje.

Estas pruebas de validez están incluidas dentro del archivo *tests.py*, mismo que debe de ejecutarse para visualizar los resultados de implementación.

## **Resultados de implementación**

El arreglo con las cadenas de prueba contiene 20 cadenas, las 13 primeras son erróneas y las últimas 7 son válidas.

A continuación el resultado de la ejecución del código:

![Resultado de ejecucuón del código][./Images/Resultados.png]

## **Análisis de complejidad**
