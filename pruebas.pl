% Subcadena 'ab1' o '1ba' y terminar en 'ba'

% Debe aceptar

aceptada_1 :- acepta(aaab1ba).
aceptada_2 :- acepta(aaa1ba).
aceptada_3 :- acepta('1ba').
aceptada_4 :- acepta(ab11ba).
aceptada_5 :- acepta('1baab1ba').

% No debe aceptar

rechazada_1 :- \+ acepta(aaabba).
rechazada_2 :- \+ acepta(aaa1b).
rechazada_3 :- \+ acepta('1baaaaa').
rechazada_4 :- \+ acepta(abba).
rechazada_5 :- \+ acepta('1abb1bba').

hacer_pruebas :- 
    write('CADENAS VÁLIDAS'), nl,

    probar(aceptada_1, aaab1ba),
    probar(aceptada_2, aaa1ba),
    probar(aceptada_3,'1ba'),
    probar(aceptada_4, ab11ba),
    probar(aceptada_5,'1baab1ba'),

    nl,
    write('CADENAS INVÁLIDAS'), nl,
    
    probar(rechazada_1, aaabba),
    probar(rechazada_2, aaa1b),
    probar(rechazada_3, '1baaaaa'),
    probar(rechazada_4, abba),
    probar(rechazada_5, '1abb1ba').


probar(Predicado, Cadena) :-
    ( call(Predicado) ->
        write('Se cumple el resultado esperado:'),
        write(Cadena),
        nl;

        write('No se cumple el resultado esperado:'),
        write(Cadena),
        nl
    ).


% DFA

acepta(Cadena) :-
    atom_chars(Cadena, Simbolos),
    estado_inicial(EstadoInicial),
    recorrer(Simbolos, EstadoInicial, EstadoFinal),
    estado_aceptacion(EstadoFinal).

recorrer([], Estado, Estado).

recorrer([Simbolo|Resto], EstadoActual, EstadoFinal) :-
    transicion(EstadoActual, Simbolo, SiguienteEstado),
    recorrer(Resto, SiguienteEstado, EstadoFinal).

estado_inicial(edo_a).
estado_aceptacion(edo_f).
estado_aceptacion(edo_g).

% caracter a

transicion(edo_a, a, edo_b).
transicion(edo_b, a, edo_b).
transicion(edo_c, a, edo_b).
transicion(edo_d, a, edo_b).
transicion(edo_e, a, edo_g).
transicion(edo_f, a, edo_h).
transicion(edo_g, a, edo_h).
transicion(edo_h, a, edo_h).
transicion(edo_i, a, edo_g).
transicion(edo_j, a, edo_h).
transicion(edo_k, a, edo_h).

% caracter b

transicion(edo_a, b, edo_a).
transicion(edo_b, b, edo_d).
transicion(edo_c, b, edo_e).
transicion(edo_d, b, edo_a).
transicion(edo_e, b, edo_a).
transicion(edo_f, b, edo_i).
transicion(edo_g, b, edo_i).
transicion(edo_h, b, edo_i).
transicion(edo_i, b, edo_k).
transicion(edo_j, b, edo_k).
transicion(edo_k, b, edo_k).


% caracter 1

transicion(edo_a, '1', edo_c).
transicion(edo_b, '1', edo_c).
transicion(edo_c, '1', edo_c).
transicion(edo_d, '1', edo_f).
transicion(edo_e, '1', edo_c).
transicion(edo_f, '1', edo_f).
transicion(edo_g, '1', edo_f).
transicion(edo_h, '1', edo_f).
transicion(edo_i, '1', edo_f).
transicion(edo_j, '1', edo_f).
transicion(edo_k, '1', edo_f).

