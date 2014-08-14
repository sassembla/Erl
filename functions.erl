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

