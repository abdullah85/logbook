# Binary Search - Revisit Easy Examples 

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](/entries/2026-09/2026-09-15-binary-search-revisit-prev-examples.md) <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-09-23 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](/entries/2026-09/2026-09-15-binary-search-revisit-prev-examples.md), we presented the definition below.

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

The above returns the smallest element satisfying the condition if one exists.

If no element in the search space satisfies the condition, the initial `right` index is returned.

The above definition seems much better to understand, remember and recall.

We also covered two examples and we now revisit the Easy examples.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->


### Conclusion


## Notes

Simpler recursive definition for various examples in [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) were reviewed.

---
· Continues from: [Binary Search Revisited](/entries/2026-09/2026-09-12-binary-search-revisit.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
