# Binary Search - Kth-Smallest Multiplication Table

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](/entries/2026-09/2026-09-30-make-m-bouquets.md) <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-10-05 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](/entries/2026-09/2026-09-30-make-m-bouquets.md), we minimized the number of days to make m bouquets with certain constraints on the number of flowers required and the number of days for each to bloom.

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

Let's proceed with the next example from  [original article](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) which is to find the kth smallest number in the multiplication table.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The [problem](https://leetcode.com/problems/kth-smallest-number-in-multiplication-table/description/) requires finding the `k-th` smallest number in a multiplication table, `mat` of size `m * n` where `mat[i][j] = i*j` with indices starting from 1, inclusive of end points. This problem seems quite simple to state but is listed as a hard problem in the Leet Code website probably because the inputs are three numbers. Also, this problem seems a bit unrelated to the framework we have at first glance.

To fit the framework, we can define the `enough` function which would take an appropriate search space definition which includes the number `k`  and given any number in the multiplication table it must return `True` if there are at least k numbers in the multiplication table that are less than the number provided.

Consider the `enough` function defined in the article below:
```python
    def enough(num) -> bool:
        count = 0
        for val in range(1, m + 1):  # count row by row
            add = min(num // val, n)
            if add == 0:  # early exit
                break
            count += add
        return count >= k                
```

It iterates over the number `m` which denotes the number of rows.

Thus, the solution can be obtained as below:

```python
> from collections import namedtuple
> SearchSpace = namedtuple("SearchSpace", ["m", "n", "k"])
> enough = lambda search_space, num : \
       sum(min(num // val, search_space.n)
           for val in range(1, search_space.m + 1)) >= search_space.k
```

With the above defined, we can finally solve the problem with our template
```python
> smallest_k_num = lambda m,n,k : \
    binary_search_recursive(SearchSpace(m,n,k), enough, 1, m*n)
> smallest_k_num(3,3,5)
3

> smallest_k_num(2,3,6)
6
```

This was an interesting application of the binary search template.

## Notes

The kth smallest number in multiplication table problem provided in the   [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was discussed in this entry.

---
· Continues from:

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
