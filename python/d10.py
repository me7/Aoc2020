# from https://old.reddit.com/r/adventofcode/comments/ka8z8x/2020_day_10_solutions/gf980np/
#!/usr/bin/env python3

from os import path
from functools import lru_cache

lines = [0] + sorted(map(int,open("inputs/10.txt").readlines()))
diffs = {1:0,3:1}
for i in range(1,len(lines)):
    diffs[lines[i]-lines[i-1]]+=1
print('part 1:', diffs[1]*diffs[3])

@lru_cache(maxsize=None) 
def howmany(i):
    return (1 if i == len(lines)-1
              else sum(howmany(j) for j,x in enumerate(lines[i+1:i+4],start=i+1) if x<=lines[i]+3))
print('part 2:',howmany(0))