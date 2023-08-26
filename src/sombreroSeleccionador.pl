%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 1 - Sombrero Seleccionador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(parte1).



test(encadenadosPorCasas, nondet):-
    encadenadosPorCasas([harry, harry]).

:- end_tests(parte1).

% caracteristicas de los magos

caracterizadoPor(harry, [corajudo, amistoso, orgulloso, inteligente]).
caracterizadoPor(draco, [inteligente, orgulloso]).
caracterizadoPor(hermione, [inteligente, orgulloso, responsable]).

% status de sangre

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

% qué casa odiaría quedar 

odiariaSerMandadoA(harry, slytherin).
odiariaSerMandadoA(draco, hufflepuff).


apropiadoPara([coraje], gryffindor).
apropiadoPara([orgulloso, inteligente], slytherin).
apropiadoPara([inteligente, responsable], ravenclaw).
apropiadoPara([amistoso], hufflepuff).

% Casas
casa(Casa):-
    apropiadoPara(_, Casa).

% Magos 
mago(Mago):-
    sangre(Mago, _).

% 1)

permiteEntrarA(slytherin, Mago):-
    mago(Mago), % ligar Mago
    not(sangre(Mago, impura)).
permiteEntrarA(Casa, Mago):-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.

% 2)

tieneCaracterApropiadoPara(Mago, Casa):-
    caracterizadoPor(Mago, ListaCaracteristicasDelMago),
    apropiadoPara(ListaCaracteristicasApropiadas, Casa),
    incluyeA(ListaCaracteristicasDelMago, ListaCaracteristicasApropiadas).
% Si Lista1 inlcuye todos los elementos de Lista2.
incluyeA(Lista1, Lista2):-
    forall(
        member(Elemento, Lista2), % todos los elementos de la Lista2
        member(Elemento, Lista1) % estan incluidas en Lista1
    ).

% 3)

casaPosible(Mago, Casa):-
    tieneCaracterApropiadoPara(Mago, Casa),
    permiteEntrarA(Casa, Mago),
    not(odiariaSerMandadoA(Mago, Casa)).
casaPosible(hermione, gryffindor).

% 4) 

cadenaDeAmistades(ListaDeMagos):-
    forall(
        member(Mago, ListaDeMagos),
        esAmistoso(Mago)
    ), % todos son amistosos.
    encadenadosPorCasas(ListaDeMagos).

esAmistoso(Mago):-
    caracterizadoPor(Mago, ListaCaracteristicasDelMago),
    member(amistoso, ListaCaracteristicasDelMago).

encadenadosPorCasas([Mago1, Mago2]):-
    casaPosible(Mago1, CasaComun),
    casaPosible(Mago2, CasaComun).
encadenadosPorCasas([Mago1, Mago2 | ListaMagos]):-
    ListaMagos \= [],
    encadenadosPorCasas([Mago1, Mago2]),
    encadenadosPorCasas([Mago2 | ListaMagos]). % checkear lo mismo con los siguientes

