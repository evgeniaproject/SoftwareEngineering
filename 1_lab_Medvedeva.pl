person(wolf).
person(nif).
person(naf).
person(nuf).

theme(fauna).
theme(sport).
theme(cosmos).
theme(flora).

solve(Seats, Collects) :-

    member(WolfPos, [0,1,2,3]),
    member(NifPos,  [0,1,2,3]),
    member(NafPos,  [0,1,2,3]),
    member(NufPos,  [0,1,2,3]),
    WolfPos \== NifPos, WolfPos \== NafPos, WolfPos \== NufPos,
    NifPos  \== NafPos, NifPos  \== NufPos,
    NafPos  \== NufPos,
    WolfPos is (NafPos - 1) mod 4,     % Волк слева от Нафа
    NufPos  is (NafPos + 2) mod 4,     % Наф напротив Нуфа

    Seats = [sits(wolf,WolfPos), sits(nif,NifPos), sits(naf,NafPos), sits(nuf,NufPos)],    % рассадка как список структур

    CosmosPos is (NifPos - 1) mod 4,       % позиция собирающего марки с космосом
    member(sits(CosmosPerson, CosmosPos), Seats),

    theme(NifT), NifT \== fauna,
    theme(NafT), NafT \== fauna,
    theme(NufT), NufT \== fauna,
    NifT \== NafT, NifT \== NufT, NafT \== NufT,
    NufT \== sport,

    Collects = [collects(wolf,fauna), collects(nif,NifT), collects(naf,NafT), collects(nuf,NufT)],
    member(collects(CosmosPerson, cosmos), Collects).

main :-
    solve(_, Collects),
    !,         % берём первое найденное решение
    member(collects(wolf,WolfT), Collects), format('Волк - ~w~n', [WolfT]),      % ~w - write,  ~n - newline
    member(collects(nif,NifT),  Collects), format('Ниф  - ~w~n', [NifT]),
    member(collects(naf,NafT),  Collects), format('Наф  - ~w~n', [NafT]),
    member(collects(nuf,NufT),  Collects), format('Нуф  - ~w~n', [NufT]),
    halt.

:- initialization(main).