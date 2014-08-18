-module(hhfuns).
-compile(export_all).

one() -> 1.
two() -> 2.

add(X, Y) -> X() + Y().

% リストを受け取って、Headすべてに1足したものを返す
increment([]) -> [];
increment([Head | Tail]) -> [Head + 1 | increment(Tail)].

% リストを受け取って、Headすべてから1引いたものを返す
decrement([]) -> [];
decrement([Head | Tail]) -> [Head - 1 | decrement(Tail)].


% オレオレmap関数の実装。関数とリストを受け取り、[Headに対して関数を実行、Tailが空になるまで続けたものをリストとして返す。
map(_, []) -> [];
map(F, [Head | Tail]) -> [F(Head) | map(F, Tail)].

incr(X) -> X + 1.
decr(X) -> X - 1.

% めんどくさいよね、というわけでここから匿名関数
% 定義できるのは関数内のみ、だったのが、17系からはいけるようになったとのこと。
% fun V FFF {; V FFF} end. ??? 書き方よくわかってない。
% ここに書いてあるが見方がよくわかんない。 http://www.erlang.org/eeps/eep-0037.html

% 含んだ関数
obtainFunc() -> 
	map(fun(X) -> X + 1 end, [1,2,3]).


defFunc() ->
	% 無名関数の定義
	PrepareAlerm = fun (Room) -> 
		io:format("alerm is set ~s.~n", [Room]),% 返り値でないけど右辺なので,が要る
		fun () -> 
			io:format("hahaha with ~s! call Someone!~n", [Room]),
			1001 
		end%匿名関数の定義そのものなのでなにも要らない

	end,%ここまでが匿名関数の定義で、さらに継続されるので,が要る

	AlermReady = PrepareAlerm("Roomeeerrr"),% 一つ目の匿名関数の実行、ここで内部の関数がさらに定義、束縛される。
	AlermReady().% 返される関数の実行。


% 理解するために書き直してみる。
defFunc2() ->
	Func1 = fun () -> 
		fun () -> 
			20000 end
	end,
	Func1Item = Func1(),
	Func1Item().
% なるほど。


% スコープの話。
base(A) ->
	B = A + 1,
	F = fun () -> A * B end,
	F().


% スコープ内で定義されたものに触るとおこ
% base(A) -> 
% 	B = A + 1,
% 	F = fun
% 		() ->
% 			C = A * B end,
% 	F().
% 	C.


a() -> Secret = "pony", fun() -> Secret end.

b(F) -> "a/0's password is "++F().


testFunc() ->
	Result1 = math:pow(5,2),

	POf2 = fun
		(X) ->
			Result1,
			math:pow(Result1, X) 
	end,

	% powで得た5 * 5を、mapでさらにn乗する。25*1, 25*25, 25*25*25,,,
	Result2 = map(POf2, [1,2,3,4]),
	Result2.


filter(Pred, List) -> lists:reverse(filter(Pred, List, [])).

filter(_, [], Last) -> Last;
filter(Pred, [H|T], Current) -> 
	case Pred(H) of
		true -> filter(Pred, T, [H|Current]);
		false -> filter(Pred, T, Current)%Currentだけを返すことで除外を発生させる
	end.

