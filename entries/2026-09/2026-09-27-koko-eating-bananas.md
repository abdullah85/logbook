
# Binary Search - Koko Eating Bananas

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](/entries/2026-09/2026-09-23-binary-search-revisit-easy-examples.md) <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-09-27 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](/entries/2026-09/2026-09-23-binary-search-revisit-easy-examples.md), we presented the easy examples implemented with the definition below.

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

Let's proceed with other examples from the [original article](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) now.

Let's look at the Koko Eating Bananas problem which is a medium problem on Leet Code.

The summary of the problem is that Koko has `N` piles of bananas, the `i`-th pile has `piles[i]` bananas. She has `H` hours and she has to choose `K` which is the number of bananas that she eats per hour. The problem is for her to find the minimum `K` framed as here liking to eat bananas slowly such that she is able to finish all bananas from all the piles within `H` hours, before the guards come back.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The problem is resolved by using the binary search template with the following condition:
```python
from collections import namedtuple

SearchSpace = namedtuple("SearchSpace", ["piles", "H"])

condition = lambda search_space, speed : sum((pile - 1) // speed + 1 for pile in search_space.piles) <= search_space.H
```

This is a really interesting problem and condition and we need to explore it further.

## Notes

The Koko Eating Bananas problem provided in the   [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was discussed in this entry.

---
· Continues from: [Binary Search - Revisit Easy Examples](/entries/2026-09/2026-09-23-binary-search-revisit-easy-examples.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
