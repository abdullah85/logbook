# Binary Search - Kth-Smallest Pair Distance

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](/entries/2026-10/2026-10-05-binary-mul-tab.md) <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-10-10 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](/entries/2026-10/2026-10-05-binary-mul-tab.md), we identified the kth smallest number contained in a multiplication table given the values `m` and `n` for the rows, columns respectively of the table.

Recall the recursive definition for our binary search template below.

```python
def binary_search_recursive(search_space, condition, left, right) -> int:
    # Termination condition
    if left >= right:
      return left

    # Compute the middle element index
    mid = left + (right - left) // 2

    # Reduce the search space recursively
    if condition(search_space, mid):
        return binary_search_recursive(
          search_space, condition, left, mid
        )
    else:
        return binary_search_recursive(
          search_space, condition, (mid+1), right
        )
```

Let's proceed with the next example from the [original article](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) which is to find the kth smallest pair distance for a list of numbers.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The [problem](https://leetcode.com/problems/find-k-th-smallest-pair-distance/description/) requires finding the `k-th` smallest absolute pair difference from a list of numbers provided by a `nums` array. The difference from the previous entry for finding the `kth` smallest number in the multiplication table is obvious as this requires identifying the `kth` smallest pair. A few aspects need to be observed to solve this problem.

The required auxiliary data structures and the `enough` function are of the form:
```python
from collections import namedtuple
SearchSpace = namedtuple("SearchSpace", ["nums", "k"])
enough = lambda search_space, distance: \
```
The `enough` function takes the `search_space`, `distance` as input and is expected to return `True` if there are at least `k` pairs whose difference is less than or equal to `distance` and this makes the problem slightly more involved than the previous one.

Also, let's assume that the `nums` array is sorted before invoking the `enough` function.

Reviewing the article, we find the function defined as below:
```python
def enough(distance) -> bool:  # two pointers
    count, i, j = 0, 0, 0
    while i < n or j < n:
        while j < n and nums[j] - nums[i] <= distance:  # move fast pointer
            j += 1
        count += j - i - 1  # count pairs
        i += 1  # move slow pointer
    return count >= k
```
The above is correct: when `j == i` the difference is `0`, so `j` always advances past `i` and `j - i - 1` never goes negative. Since `nums` is sorted, `j` never needs to move back as `i` advances, so counting takes `O(n)`. The `or j < n` check is redundant but harmless. Note that it reads `nums`, `n` and `k` from the enclosing scope rather than taking a `search_space` argument, so it needs adapting to fit our template.

## Notes

The kth smallest absolute pair distance in a list of numbers provided in the [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was discussed in this entry.

---
· Continues from:

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
