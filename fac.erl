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
tail_len(N) -> tail_len(N, 0).

tail_len([], Rest) -> Rest;
tail_len([_|T], Last) -> tail_len(T, Last + 1).
