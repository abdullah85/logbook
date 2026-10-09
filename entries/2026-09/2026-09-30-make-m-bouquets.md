# Binary Search - Make m  Bouquets

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](/entries/2026-09/2026-09-27-koko-eating-bananas.md) · [Next](/entries/2026-10/2026-10-05-binary-mul-tab.md)

Date: 2026-09-30 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](/entries/2026-09/2026-09-27-koko-eating-bananas.md), we minimized the speed of eating bananas while ensuring all bananas are eaten.

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

Let's proceed with the next example from  [original article](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) which is to minimize the number of days to make m bouquets.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The [problem](https://leetcode.com/problems/minimum-number-of-days-to-make-m-bouquets/description/) requires making `m` bouquets where each bouquet needs `k` adjacent flowers where a flower at index `i` blooms after `bloomDay[i]` days and can be used in exactly one bouquet after that.

To understand the adjacency requirement, the following example is helpful:

```
Input: bloomDay = [7,7,7,7,12,7,7], m = 2, k = 3
Output: 12
Explanation: We need 2 bouquets each should have 3 flowers.
Here is the garden after the 7 and 12 days:
After day 7: [x, x, x, x, _, x, x]
We can make one bouquet of the first three flowers that bloomed. We cannot make another bouquet from the last three flowers that bloomed because they are not adjacent.
After day 12: [x, x, x, x, x, x, x]
It is obvious that we can make two bouquets in different ways.

```

The objective is to minimize the number of days to wait to make `m` bouquets.

If it  is not possible to make `m` bouquets then `-1` must be returned and the `SearchSpace` is identified as below:
```python
from collections import namedtuple
SearchSpace = namedtuple("SearchSpace", ["bloomDay", "m", "k"])
```

To check possibility, `m * k <= len(bloomDay)` is necessary and sufficient.

Thus, the condition and the actual function can be implemented as below:
```python
from itertools import groupby

condition = lambda search_space, num_days_passed: \
    sum(
        len(list(group)) // search_space.k
        for bloomed, group in groupby(
            search_space.bloomDay, key=lambda day: day <= num_days_passed
        )
        if bloomed
    ) >= search_space.m
```

The above `groupby` is convenient for defining our condition.

```python
make_m_bouquets = lambda bloomDay, m, k: binary_search_recursive(
    SearchSpace(bloomDay, m, k), condition, min(bloomDay), max(bloomDay)
) if m * k <= len(bloomDay) else -1
```
Let's now verify that it works as expected on sample values.
```python
> make_m_bouquets([1,10,3,10,2], 3, 1)
3

> make_m_bouquets([1,10,3,10,2], 3, 2)
-1

> make_m_bouquets([7,7,7,7,12,7,7], 2, 3)
12
```

Thus, the problem of making `m` bouquets was solved with the help of the template.

## Notes

The Make M Bouquets problem provided in the   [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was discussed in this entry.

---
· Continues from:

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
