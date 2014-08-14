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
tail_len([_|T], Other) -> tail_len(T, Other + 1). % 要は、Otherっていう変数に数値を束縛して、この関数を通ってる時だけ生かそう、みたいな感じ。奇数偶数とかやったら生存時間がわかると思う。



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




