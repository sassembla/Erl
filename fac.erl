-module (fac).


fac(0) -> 1;
fac(N) -> N * fac(N-1).

len([]) -> 0;
len([_|T]) -> 1 + len(T).

tail_fac(N) -> tail_fac(N, 1).

tail_fac(0, Rest) -> Rest;
tail_fac(N, Last) when 0 < N -> tail_fac(N - 1, N * Last).