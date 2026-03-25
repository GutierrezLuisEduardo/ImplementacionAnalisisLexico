from regexp import *

cadenas = [
    # Inválidas (Primeras 13)
    "ab1",
    "1baLuis",
    "ab1Luis",
    "Luisab1",
    "aa1",
    "ba1",
    "aabbb1",
    "ab1bab",
    "baba1baa",
    "1baLuisba",
    "1baLuisba",
    "Luis1ba",
    "Luisab1ba",

    # Válidas (últimas 7)
    "1ba",
    "ab1ba",
    "1baabababbbbabaaabaaba",
    "ab1bbbabbaabaaababababa",
    "aaaaaaaaaaa1ba",
    "bbbbbbbbbbbab1ba",
    "ab1aabbbbab1aabababba"
]

count = 0
for s in cadenas:
    status = validar(s)
    if status == "Válida":
        count += 1
    print(f'La cadena "{s}" es {status} respecto al lenguaje.')

print(count, f" de {len(cadenas)} cadenas han sido válidas respecto\
 al lenguaje")