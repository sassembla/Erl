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


% これはどう違うんだろう。違わない、という答えだった。
do(In) ->
	io:format("A~n"),
	In;
do(Out) ->
	io:format("B~n"),
	Out;
do(_) ->
	io:format("C~n"),
	100.


