# Binary Search - Make m  Bouquets

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](/entries/2026-09/2026-09-27-koko-eating-bananas.md) <!-- · [Next](link to the follow-up entry, once created) -->

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


## Notes

The Make M Bouquets problem provided in the   [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was discussed in this entry.

---
· Continues from: [Binary Search - Revisit Easy Examples](/entries/2026-09/2026-09-23-binary-search-revisit-easy-examples.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
