# Binary Search Recursion Template, Redefined

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-08-11-binary-search-recursive.md)  <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-08-12 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

Taking a closer look at the [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) and my presentation of the recursive approach in the 
[previous entry](./2026-08-11-binary-search-recursive.md), I feel it can be improved further with respect to clarity and generic.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's redefine the binary search template with a recursive function below.

```python
def binary_search_recursive(search_space, left, right) -> int:
    def condition(search_space, value) -> bool:
        pass

    if left == right:
       return left

    mid = left + (right - left) // 2

    if condition(search_space, mid):
        return binary_search(search_space, left, mid) 
    else:
        return binary_search(search_space, mid+1, right)
```

This should further clarify the template and make it easier to recall or implement.

## Notes

A recursive definition for a binary search template.

---
· Continues from: [Binary Search Template](./2026-08-10-binary-search-template.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
