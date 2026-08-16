# Binary Search Recursion Template with Recursion
<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-08-10-binary-search-template.md) · [Next](./2026-08-15-binary-search-recursive-template-examples.md)

Date: 2026-08-11 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

I had a closer look at the [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) and read through the examples.

I guess my presentation of the recursive approach in the [previous entry](./2026-08-10-binary-search-template.md), can be improved.

Let's try and improve the clarity and make it more generic.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's redefine the binary search template with a recursive function below.

```python
def binary_search_recursive(search_space, left, right) -> int:
    def condition(search_space, value) -> bool:
        pass

    # Termination condition
    if left == right:
      if condition(search_space, left):
          return (left - 1)
      return left

    # Compute the middle element index 
    mid = left + (right - left) // 2

    # Reduce the search space recursively
    if condition(search_space, mid):
        return binary_search(search_space, left, mid) 
    else:
        return binary_search(search_space, (mid+1), right)
```

Now, we have three aspects to consider as mentioned in the comments.
 * The termination condition to indicate the final result
 * The computation of the middle element index
 * The recursive invocation with reduced search space

The above allows for a generic search space instead of just an array.

This should further clarify the template and make it easier to recall or implement.

## Notes

A recursive definition for a binary search template which may require further tweaking.

---
· Continues from: [Binary Search Template](./2026-08-10-binary-search-template.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
