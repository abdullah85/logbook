# Binary Search Ship within D days

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-08-27-binary-template-easy.md) <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-08-31 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

Let's revisit the easy examples in the [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) using the approach provided earlier.

In the [previous entry](2026-08-19-binary-search-template.md) we defined all the easy examples in the [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) with a recursive definition for the template.

Hopefully, it is much easier to understand the solutions provided.

In this entry, we will explore one example in the advanced application section of the [reference article](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) provided earlier.

The problem statement involves [identifying the minimum capacity](https://leetcode.com/problems/capacity-to-ship-packages-within-d-days/description/) for a ship to ensure that it is able to ship all items arriving in a conveyor belt with specified weights in `D` days.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's recall the template defined [earlier](./2026-08-19-binary-search-template.md) first.

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


## Notes

The first example among the  [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) were encoded recursively and with appropriate additional functions.


---
· Continues from: [Binary Search Python](./2026-08-09-binary-search-python.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
