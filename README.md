**Evidencia Implementación de Análisis Léxico (Autómata y Expresión Regular)**

| Alfabeto | Reglas |
| ----- | :---: |
| ab1 | al menos una ocurrencia de 'ab1' or '1ba' |
|  | terminación 'ba' |

<sub>Fig.1 El lenguaje y el conjunto de reglas que lo conforman</sub>

## **Descripción del lenguaje**

Se tiene un lenguaje con alfabeto:  
∑ \= {a, b, 1}

Y un conjunto de reglas, tal que cualquier combinación válida siempre termine con ‘*ba*’ y contenga al menos una concurrencia de ‘*ab1*’ o ‘*1ba*’.

## **Modelado del lenguaje**
Previo a conseguir un _DFA_, se modeló un _NFA_ por la facilidad que confiere al momento de plasmar estados y transiciones entre estos.
Esto implicó, en la primera versión de NFA, crear dos autómatas (uno para la ocurrencia de 'ab1'|'1ba' y otro para la terminación 'ba') mismos que terminaron uniéndose en uno solo.

![Dos NFA que terminaron uniéndose](https://github.com/GutierrezLuisEduardo/ImplementacionAnalisisLexico/blob/main/Images/NFA%20-%20Diagram.png)

Este proceso puede interpretarse como concatenar los lenguajes representados por cada NFA , pues primero corre un NFA y luego el otro esta operación entre lenguajes es necesaria para cumplir con el sufijo 'ba'. (Sudkamp, 2006)

A continuación un _NFA_ que corresponde a las reglas del lenguaje, hecho con _plantUML_.

<details>
  <summary>Desplegar código de PlantUML</summary>

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

<sub style="align: center; text-align: center">Fig.2 NFA que representa al menos una ocurrencia de ‘ab1’ o ‘1ba’ y terminación de ‘ba’ de una cadena</sub>

Con el _NFA_ terminado, procedió derivar las transiciones y nuevos estados que constituyen al DFA equivalente. Para ello se utilizó la técnica de _construcción por subconjuntos_.

Bajo este método, se interpreta como un nuevo estado en el DFA a cada conjunto de conexiones suscitadas entre los estados del NFA a través de los símbolos del alfabeto. Esto abarca todas las posibilidades de interconexión y garantizar que se cumplan ambas reglas de manera determinista.

En la práctica, esto implicó identificar al estado inicial (el primero del NFA), seguido de esto, plasmar la relación del NFA en su tabla de transiciones, llevar a cabo un producto cruz entre sus estados sobre los distintos caracteres del alfabeto, y finalmente deliberar cuáles serían los estados de aceptación (se definió como estado de aceptación a todo estado que incluyera al estado final del NFA).

Con la definición de todo estado de aceptación, se mantiene la propiedad finita.

| Estado | a | b | 1 |
| :---: | ----- | ----- | ----- |
| **q0** | {q0, q1} | {q0} | {q0, q3} |
| **q1** |  | {q2} |  |
| **q2** |  |  | {q5} |
| **q3** |  | {q4} |  |
| **q4** | {q5} |  |  |
| **q5** | {q5} | {q5,q6} | {q5} |
| **q6** | {q6} |  |  |

<sub>Fig.3 Tabla de transiciones del NFA</sub>

| Símbolo | Estados | a | b | 1 |
| :---: | :---: | :---: | :---: | :---: |
| **A** | **q0** | {q0, q1} | {q0} | {q0, q3} |
| **B** | **{q0, q1}** | {q0, q1} | {q0,q2} | {q0, q3} |
| **C** | **{q0,q2}** | {q0, q1} | {q0} | {q0, q3, q5} |
| **D** | **{q0, q3}** | {q0, q1} | {q0, q4} | {q0, q3} |
| **E** | **{q0, q4}** | {q0, q1, q5} | {q0} | {q0, q3} |
| **F** | **{q0, q5}** | {q0, q1, q5} | {q0, q5, q6} | {q0, q3, q5} |
| **G** | **{q0, q6}** | {q0, q1, q6} | {q0} | {q0, q3} |
| **H** | **{q0, q1, q5}** | {q0, q1, q5} | {q0, q2, q5, q6} | {q0, q3, q5} |
| **I** | **{q0, q1, q6}** | {q0, q1, q6} | {q0,q2} | {q0, q3} |
| **J** | **{q0, q3, q5}** | {q0, q1, q5} | {q0, q4, q5, q6} | {q0, q3, q5} |
| **K** | **{q0, q5, q6}** | {q0, q1, q5, q6} | {q0, q2, q5, q6} | {q0, q3, q5} |
| **L** | **{q0, q1, q5, q6}** | {q0, q1, q5, q6} | {q0, q2, q5, q6} | {q0, q3, q5} |
| **M** | **{q0, q2, q5, q6}** | {q0, q1, q5, q6} | {q0, q5, q6} | {q0, q3, q5} |
| **N** | **{q0, q4, q5, q6}** | {q0, q1, q5, q6} | {q0, q5, q6} | {q0, q3, q5} |

<sub>Fig.4 Tabla de transiciones del DFA</sub>

|  | a | b | 1 |
| ----- | :---: | :---: | :---: |
| **A** | B | A | D |
| **B** | B | C | D |
| **C** | B | A | J |
| **D** | B | E | D |
| **E** | H | A | D |
| **F** | H | K | J |
| **G** | I | A | D |
| **H** | H | M | J |
| **I** | I | C | D |
| **J** | H | N | J |
| **K** | L | M | J |
| **L** | L | M | J |
| **M** | L | K | J |
| **N** | L | K | J |

<sub>Fig.5 Tabla de adyacencia del DFA</sub>

A continuación, el diagrama del DFA que corresponde con las reglas del lenguaje y el NFA.

<details>
  <summary>Desplegar código de PlantUML</summary>

```PlantUML
@startuml
left to right direction 
scale 2048 width

skinparam nodesep 80
skinparam ranksep 90

note "DFA: Al menos una ocurrencia de 'ab1' o '1ba' y siempre fin en 'ab'" as nota

[*] -down-> A

' G, I, K, L, M, N
state G <<end>>
note left of G : G
state I <<end>> : estado I
note left of I : I
state K <<end>> : estado K
note left of K : K
state L <<end>> : estado L
note left of L : L
state M <<end>> : estado M
note left of M : M
state N <<end>> : estado N
note left of N : N

A -down[#12FFFF]-> B : a
A -up[#12FFFF]-> A : b
A -down[#12FFFF]-> D : 1

B -up[#FF12FF]-> B : a
B -down[#FF12FF]-> C : b
B -down[#FF12FF]-> D : 1

C -up[#FFFF12]-> B : a
C -up[#FFFF12]-> A : b
C -down[#FFFF12]-> J : 1

D -up[#12FF12]-> B : a
D -down[#12FF12]-> E : b
D -[#12FF12]-> D : 1

E -down[#2412FF]-> H : a
E -up[#2412FF]-> A : b
E -up[#2412FF]-> D : 1

F -down[#12FF24]-> H : a
F -down[#12FF24]-> K : b
F -down[#12FF24]-> J : 1

G -down[#FF1224]-> I : a
G -up[#FF1224]-> A : b
G -down[#FF1224]-> D : 1

H -[#FF468C]-> H : a
H -down[#FF468C]-> M : b
H -down[#FF468C]-> J : 1

I -[#468CFF]-> I : a
I -up[#468CFF]-> C : b
I -up[#468CFF]-> D : 1

J -up[#8CFF46]-> H : a
J -down[#8CFF46]-> N : b
J -[#8CFF46]-> J : 1

K -down[#C86432]-> L : a
K -down[#C86432]-> M : b
K -up[#C86432]-> J : 1

L -[#6432C8]-> L : a
L -left[#6432C8]-> M : b
L -up[#6432C8]-> J : 1

M -up[#32C864]-> L : a
M -up[#32C864]-> K : b
M -up[#32C864]-> J : 1

N -up[#912D64]-> L : a
N -up[#912D64]-> K : b
N -up[#912D64]-> J : 1 

N -down-> [*]

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

![DFA](https://github.com/GutierrezLuisEduardo/ImplementacionAnalisisLexico/blob/main/Images/DFA.png)
<sub style="align: center; text-align: center">Fig.3 Transformado, el NFA de la Fig.2 se representa como el siguiente DFA.</sub>

## **Implementación de una expresión regular equivalente**

Patrón: `^(?=.*(ab1|1ba))[ab1]*ba$`

La expresión estuvo pensada para evaluar la línea completa (por ello los anchors de ***'^'*** y ***'$'*** para inicio y final de línea, respectivamente). Después, el grupo de comprobación de *positive-lookahead* contempla la presencia de 0 o más caracteres previo al grupo de captura, que impone la restricción de lenguaje de una mínima ocurrencia de '*ab1*' o '*1ba*'.

Los caracteres previos y posteriores al grupo de captura sólo pueden ser constituidas por caracteres que pertenezcan al alfabeto del lenguaje (denotado como `[ab1*]`) y hacer esto entre una cantidad de cero e ilimitada de veces (`*`).

Por último, para satisfacer el sufijo 'ba' requerido para toda cadena válida, elemento de ∑* (correspondiente al lenguaje), se denota `ba` al final de la expresión. 

Conformada la expresión regular, se incluyó dentro de un código (*regex.py*) que contiene una función que analiza una cadena dada y la valida respecto al patrón (que comprende las reglas del lenguaje), determinando así la correspondencia entre dada cadena y el lenguaje.

Estas pruebas de validez están incluidas dentro del archivo *tests.py*, mismo que debe de ejecutarse para visualizar los resultados de implementación.

## **Resultados de implementación**

Un arreglo dentro del archivo 'test.py' contiene 20 cadenas de prueba, las 13 primeras fueron pensadas para resultar inválidas ante el patrón y las últimas 7 cadenas pensadas para resultar válidas.

A continuación el resultado de la ejecución del código:

![Resultado de ejecucuón del código](https://github.com/GutierrezLuisEduardo/ImplementacionAnalisisLexico/blob/main/Images/Resultados.png)

## **Análisis de complejidad**

La complejidad implícita puede describirse como lineal `O(n)` para toda cadena `ω` procesada por lo que Sudkamp (2006) introduce como una "máquina de estado finito", p.147 (si se quiere ver así al DFA modelado, también pudiérase interpretar de esta manera a la expresión regular planteada).

Esto se debe a que la iteración sobre cada uno de los caracteres que conforman a la cadena, derivará en un cambio de estado por cada carácter, y este cambio de estado se atiene directamente a la función transición `δ=Q×Σ→Q`, que desembarca en uno de los estados definidos para el DFA. 

## **Referencias**
Sudkamp, T. A. (2006). Languages and Machines: An Introduction to the Theory of Computer Science. Addison-Wesley Longman.

