**Evidencia Implementación de Análisis Léxico (Autómata y Expresión Regular)**

<div style="align: center; text-align: center; margin: 0;">

| All possible combinations of | Rules |
| ----- | :---: |
| ab1 | must have ab1 or 1ba |
|  | and must end with ba |

Fig.1 \- El lenguaje y el conjunto de reglas que lo conforman

</div>

## **Descripción del lenguaje**

Se tiene un lenguaje con alfabeto:  
∑ \= {a, b, 1}

Y un conjunto de reglas, tal que cualquier combinación válida siempre termine con ‘*ba*’ y contenga al menos una concurrencia de ‘*ab1*’ o ‘*1ba*’.

## **Modelado del lenguaje**

A continuación el *NFA* que representa las reglas del lenguaje mencionado, fue hecho con *plantUML*. Previo a conseguir un DFA, he decidido modelar un NFA puesto que es más sencillo de plasmar. A continuación, el código de PlantUML.

<details>
  <summary>Desplegar código</summary>

```PlantUML
@startuml
[*] --> q0
left to right direction 
scale 2048 width

skinparam nodesep 80
skinparam ranksep 90

note "NFA: Al menos una ocurrencia de 'ab1' o '1ba' y siempre fin en 'ab'" as nota


' Lee cualquier pregijo  
q0 --> q0 : a, b, 1

' Intento de detectar "ab1"
q0 --> q1 : a  
q1 --> q2 : b  
q2 --> q5 : 1

' Intento de detectar "1ba"
q0 --> q3 : 1  
q3 --> q4 : b  
q4 --> q5 : a

' Encontró alguno  
q5 --> q5 : a, b, 1

q5 --> q6 : b
q6 --> q6 : a

q6 --> [*]

<style>
stateDiagram {
  arrow {
    LineThickness 0.85
  }
}
</style>
@enduml
```

</details>

![NFA](https://github.com/GutierrezLuisEduardo/ImplementacionAnalisisLexico/blob/main/Images/NFA.png)

<sub>Fig.2 NFA que representa al menos una ocurrencias de ‘ab1’ o ‘1ba’ y terminación de ‘ba’ de una cadena</sub>



## **Implementación de una expresión regular equivalente**

La expresión estuvo pensada para detectar saltos de línea y evaluar la línea completa (por ello los anchors de ***'^'*** y ***'$'*** para inicio y final de línea, respectivamente). Después el grupo de comprobación de *positive-lookahead* que asegura la presencia de 0 o más caracteres previo al grupo de captura que impone la restricción de lenguaje de una mínima ocurrencia de '*ab1*' o '*1ba*'.

Los caracteres previos y posteriores al grupo de captura sólo pueden adquirir valores constituidos dentro del alfabeto del lenguaje (denotado como ‘\[*abc*\]’) y hacer esto entre una cantidad de cero e ilimitada de veces (‘*\**’).

Por último sólo se añade de manera explícita ‘*ba*’, para cumplir con la restricción de validez en que toda cadena válida debe terminar con ‘*ba*’. 

Conformada la expresión regular, se incluyó dentro de un código (*regex.py*) que contiene una función que analiza una cadena dada y la valida respecto al patrón (que comprende las reglas del lenguaje), determinando así la correspondencia entre dada cadena y el lenguaje.

Estas pruebas de validez están incluidas dentro del archivo *tests.py*, mismo que debe de ejecutarse para visualizar los resultados de implementación.

## **Resultados de implementación**

El arreglo con las cadenas de prueba contiene 20 cadenas, las 13 primeras son erróneas (era lo planeado) y las últimas 7 son válidas.

A continuación el resultado de la ejecución del código:

![Resultado de ejecucuón del código](https://github.com/GutierrezLuisEduardo/ImplementacionAnalisisLexico/blob/main/Images/Resultados.png)

## **Análisis de complejidad**
