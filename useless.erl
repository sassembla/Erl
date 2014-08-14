-module (useless).

% -export ([add/2, hello/0, greet_and_add_two/1]).

-define (HOUR, 3600). % in seconds


add(A,B) ->
	A + B,
	?HOUR.

hello() ->
	io:format("hello!~n").

greet_and_add_two(X) ->
	hello(),
	add(X, 2).

do(In) ->
	In;
do(Out) ->
	Out;
do(_) ->
	100.
