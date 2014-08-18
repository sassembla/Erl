-module (fac).


fac(0) -> 1;
fac(N) -> N * fac(N-1).

% 末尾再帰
tail_fac(N) -> tail_fac(N, 1).

tail_fac(0, Rest) -> Rest;
tail_fac(N, Last) when 0 < N -> tail_fac(N - 1, N * Last).



len([]) -> 0;
len([_|T]) -> 1 + len(T).

% 末尾再帰
tail_len(T) -> tail_len(T, 0).

tail_len([], Rest) -> Rest;
tail_len([_|T], Other) -> tail_len(T, Other + 1).
% 要は、Otherっていう変数に数値を束縛して、この関数を通ってる時だけ生かそう、みたいな感じ。奇数偶数とかやったら生存時間がわかると思う。
% 生存時間0だった。すばらしい。変数を生んでるだけだ。


% 節の中で変数がどう保持されてるのかっていうと、パターンマッチで解消してるのか。超かっけえ。
tail_byTwo(N) -> tail_byTwo(N, 0).

tail_byTwo(0, Rest) -> 
	io:fwrite("d. ~w~n", [Rest]),
	Rest;
tail_byTwo(_, Other) ->% 1. _, 0で入ってきて -> 4. 左が0でないからもう一度くる
	io:fwrite("a. ~w~n", [Other]),
	if
		Other div 2 =:= 0 ->% 2. 0だから割り切れて
			io:fwrite("b. ~w~n", [Other]),
			tail_byTwo(Other - 1, Other + 2);% 3. -1, 2になって、

		true ->% 5. こちらへ。中身は -1, 2 -> Otherは2
			io:fwrite("c. ~w~n", [Other]),
			tail_byTwo(Other - 2, Other - 1)% 5. 0, 1
	end.



% 0の時はもう返すものが要らない
duplicate(0, _) -> [];
duplicate(N, Term) when 0 < N ->
	% リストを返したい。中身は、Term * N
	[Term | duplicate(N - 1, Term)].




% 末尾再帰にする。どうやって考えるんかなー。解きたい。
tail_duplicate(N, Term) -> tail_duplicate(N, Term, []).


tail_duplicate(0, _, List) -> List;
tail_duplicate(N, Term, CurrentList) when N > 0 -> tail_duplicate(N - 1, Term, [Term|CurrentList]).

% 継続して追加される要素を変数として保持することで、そいつを受け皿にしてどんどん足せる。
% まずは、「何が継続されるか」を考えるとうまく行きそう。



% 適当に考えてやってみよう、リストの「前方」に、加算された数字が追加されるやつ。回数ぶん。
tail_duplicate_head(N, Term) -> tail_duplicate_head(N, Term, []).


tail_duplicate_head(0, _, Lasts) -> Lasts;
tail_duplicate_head(N, Term, Current) when N > 0 -> tail_duplicate_head(N - 1, Term, [Term + len(Current)] ++ Current).
% なるほどなー、cons | はあくまでも追加する場合で末尾が空なら使える、って感じで、headの判定には使えるけどheadへの追加挿入には使えないんだ。
% 判断時には存在しないからまあ確かにな。


% reverseを実装してみる話
reverse([]) -> [];
reverse([Head|Tail]) -> reverse(Tail) ++ [Head].
% これだと、回数が増えると再帰回数が不味い。

% どうするか？　-> 毎回ヘッドを追加すれば良い。
tail_rev(Source) -> tail_rev(Source, []).

tail_rev([], LastData) -> LastData;
tail_rev([Head|Tail], CurrentData) -> tail_rev(Tail, [Head|CurrentData]).
% あたまいいなーーーーいつでもパターンマッチが使えるんだ。こりゃー強力だわ。フィルタがすごく強くなった感じ。



sublist(L, N) -> sublist(L, N, []).

sublist(_, 0, Last) -> Last;
sublist(0, _, Last) -> Last;
% sublist([Head|Tail], N, Current) when N > 0 -> sublist(Tail, N - 1, [Current|Head]). X これはだめ。
% あーーーそうか、[Current|Head] はCurrentがListだから、リストを含んだリストになっちゃうんだ。これはつらい。

sublist([Head|Tail], N, CurrentList) when N > 0 -> sublist(Tail, N - 1, CurrentList ++ [Head]).
% こんな実装でも可能だったけど、本だと、Listの結合を「入り口の関数」に対して使って、そいつをreverseさせてた。 ++重たいのかな。


sublist2(L, N) -> lists:reverse(sublist2(L, N, [])).

sublist2(_, 0, Last) -> Last;
sublist2(0, _, Last) -> Last;
sublist2([Head|Tail], N, Current) -> sublist2(Tail, N - 1, [Head|Current]).
% ずるい。どっちが重たいんだろう。どのくらい差があるのかっていうと、cons の末尾が増えてくのと、 Current が肥大化してくのの差で、Current追加のほうが圧倒的に重そう。






% 最後に寄り道して型による分岐
typeFunc(Expression) when is_binary(Expression) -> "isBin!";
typeFunc(Expression) when is_list(Expression) -> "isList".
