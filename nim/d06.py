import argparse
import os.path

import pytest
from typing import Generator
import contextlib
import time

@contextlib.contextmanager
def timing(name: str = '') -> Generator[None, None, None]:
    before = time.time()
    try:
        yield
    finally:
        after = time.time()
        t = (after - before) * 1000
        unit = 'ms'
        if t < 100:
            t *= 1000
            unit = 'μs'
        if name:
            name = f' ({name})'
        print(f'> {int(t)} {unit}{name}')

INPUT_TXT = os.path.join(os.path.dirname(__file__), 'input.txt')


def compute(s: str) -> int:
    counts = 0
    for group in s.split('\n\n'):
        lines = group.splitlines()
        all_counted = set(lines[0])
        for other in lines[1:]:
            all_counted &= set(other)
        counts += len(all_counted)
    return counts


INPUT_S = '''\
abc
a
b
c
ab
ac
a
a
a
a
b
'''


@pytest.mark.parametrize(
    ('input_s', 'expected'),
    (
        (INPUT_S, 6),
    ),
)
def test(input_s: str, expected: int) -> None:
    assert compute(input_s) == expected


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument('data_file', nargs='?', default=INPUT_TXT)
    args = parser.parse_args()

    with open(args.data_file) as f, timing():
        print(compute(f.read()))

    return 0


if __name__ == '__main__':
    exit(main())