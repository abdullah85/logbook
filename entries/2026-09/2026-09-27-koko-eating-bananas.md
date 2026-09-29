
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

The problem is that Koko has `N` piles of bananas, the `i`-th pile has `piles[i]` bananas. She has `H` hours and she has to choose `K` which is the number of bananas that she eats per hour. The problem is for her to find the minimum `K` , as she likes to eat bananas slowly while also being able to finish all bananas from all the piles within `H` hours, before the guards come back.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The problem is resolved by using the binary search template with the following condition:
```python
> from collections import namedtuple
> SearchSpace = namedtuple("SearchSpace", ["piles", "H"])
> condition = lambda search_space, speed : sum((pile - 1) // speed + 1 for pile in search_space.piles) <= search_space.H
```

The condition is quite interesting in the way it verifies the speed provided.

The objective is to verify that Koko can finish eating all bananas within `H` hours.

The expression `(pile-1) // speed + 1` is the number of hours to finish a `pile` of bananas and it is quite elegant in the way it does the calculation by assuming that the last hour will finish at least one banana and `//` for the remaining.

```python
> koko_eating_bananas = lambda piles, H: binary_search_recursive(
     SearchSpace(piles, H), condition, 1, max(piles)
  )
```

The above definition is the require function for calculating the required speed.

```python
> piles = [3,6,7,11]; H=8; koko_eating_bananas(piles, H)
4

> piles = [30,11,23,4,20]; H=5; koko_eating_bananas(piles, H)
30

> piles = [30,11,23,4,20]; H=6; koko_eating_bananas(piles, H)
23
```

The above solution reduces to applying the binary search template in an elegant way.

## Notes

The Koko Eating Bananas problem provided in the [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was discussed and resolved in this entry.

---
· Continues from: [Binary Search - Revisit Easy Examples](/entries/2026-09/2026-09-23-binary-search-revisit-easy-examples.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
