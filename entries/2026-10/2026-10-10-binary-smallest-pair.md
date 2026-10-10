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

Let's proceed with the next example from  [original article](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) which is to find the kth smallest pair distance for a list of numbers.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The [problem](https://leetcode.com/problems/find-k-th-smallest-pair-distance/description/) requires finding the `k-th` smallest absolute pair difference from a list of numbers provided by a `num` array. The difference from the previous entry for finding the 

## Notes

The kth smallest absolute pair in a list of numbers provided in the   [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was discussed in this entry.

---
· Continues from:

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
