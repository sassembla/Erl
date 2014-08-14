-module (cases).


insert(X, []) ->
	[X];
insert(X, Set) ->
	case lists:member(X, Set) of
		true -> Set;
		false -> [X|Set]
	end.


beach (Temp) ->
	case Temp of
		{cel, N} when N >= 20, N =< 40 -> 'good';
		{kel, K} when K >= 20, K =< 40 -> 'good2';
		{far, F} when F >= 20, F =< 40 -> 'good3';
		_ -> 'die'
	end.

