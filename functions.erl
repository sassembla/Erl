-module (functions).
-compile(export_all).

head([H|_]) ->
	H.

second([_,X|_]) ->
	X.

same(X, X) ->
	true;
same(_, _) ->
	false.

old_enough(X) when X >= 16, 100 >= X -> true;
old_enough(_) -> false.


heh_fine() ->
	if
		1 =:= 1 ->
			io:format("1~n"),
			works;
		true -> io:format("4~n")
	end,
	if
		1 =:= 2, 1 =:= 1 ->
			io:format("2~n"),
			works;
		true -> io:format("5~n")
	end,
	if
		1 =:= 2, 1 =:= 1 ->
			io:format("3~n"),
			fails;
		true -> io:format("6~n")
	end,
	io:format("7~n").


oh_god(N) -> 
	if
		N =:= 2 ->
			here;
		true -> 
			over

	end.


