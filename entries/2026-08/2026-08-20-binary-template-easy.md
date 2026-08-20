# Binary Search Template

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-08-19-binary-search-template.md) <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-08-20 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

Let's revisit the easy examples in the [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) using the approach provided earlier.


Let's recall the template provided in the [Previous](./2026-08-19-binary-search-template.md) entry first.

```python
def binary_search_recursive(search_space, condition, left, right) -> int:
    # Termination condition
    if left == right:
      if condition(search_space, left):
          return (left - 1)
      return left

    # Compute the middle element index
    mid = left + (right - left) // 2

    # Reduce the search space recursively
    if condition(search_space, mid):
        return binary_search_recursive(search_space, condition, left, mid)
    else:
        return binary_search_recursive(search_space, condition, (mid+1), right)
```

Let's define the easy examples defined in the [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) provided earlier.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

### First Bad Version 

Recall the First Bad version definition described in the [previous entry](./2026-08-19-binary-search-template.md) here.

```python
FIRST_BAD_VERSION = 195

def isBadVersion(n):
  if n >= FIRST_BAD_VERSION:
    return True
  return False

condition = lambda search_space, value: isBadVersion(value)
last_good_version = lambda start, end: binary_search_recursive(None, condition, start, end)
first_bad_version = lambda start, end: -1 if (lg := last_good_version(start, end)) == end else lg + 1
```

The above ensures that if all versions in the provided range are good then `-1` is returned.

```python
> first_bad_version(1, 1500)
195
> first_bad_version(1, 95)
-1
> import math
> FIRST_BAD_VERSION = math.inf
> first_bad_version(1, 10_15)
-1
```

I have just summarized the definitions above and refer the [previous entry](./2026-08-19-binary-search-template.md) for further details.

### Integer Square Root

For this problem, define the following functions as below.

```python
condition = lambda target, value: value * value > target
int_square_root = lambda target: binary_search_recursive(target, condition, 1, target)
```
The above definition is quite succinct and easy to recall while being flexible as well.

Note that `search_space` is actually `target` and our recursive definition allows this.

```python
> int_square_root(9)
3
> int_square_root(15)
3
> int_square_root(16)
4
```

The above examples illustrate the actual invocation of the defined program.

### Search Insert Position

In this problem, we are given an array without any duplicates.

The objective is to find the index of the array if it exists, otherwise return the index it would be inserted at to keep the array sorted.

The `search_space` here bundles two pieces of information, `nums` and `target`, so rather than indexing into an anonymous tuple with `search_space[0]` / `search_space[1]`, a `NamedTuple` gives us named attribute access instead.

```python
from typing import NamedTuple

class SearchSpace(NamedTuple):
    nums: list[int]
    target: int

condition = lambda search_space, idx: search_space.nums[idx] >= search_space.target
search_insert_position = lambda nums, target: binary_search_recursive(
    SearchSpace(nums, target), condition, 0, len(nums) - 1
) + 1
```

Unlike `first_bad_version`, no `-1` sentinel is needed here — even the "insert at the end" case falls out of `lg + 1` naturally, since `len(nums)` is itself a valid answer.

```python
> search_insert_position([1, 3, 5, 6], 5)
2
> search_insert_position([1, 3, 5, 6], 2)
1
> search_insert_position([1, 3, 5, 6], 7)
4
> search_insert_position([1, 3, 5, 6], 0)
0
```

The above examples confirm that the target's own index is returned when present, matching the expected behaviour of the problem.

## Notes

Easy examples provided in the [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) were encoded recursively and with appropriate additional functions.
---
· Continues from: [Binary Search Python](./2026-08-09-binary-search-python.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
