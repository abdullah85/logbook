 # Binary Search Template

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-08-09-binary-search-python.md) · [Next](./2026-08-11-binary-search-recursive.md)

Date: 2026-08-10 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

While searching for a solution for a problem that might involve binary search, I came across a [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) which looks quite interesting and I want to understand it better.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The first code snippet presented a concise but generic approach to binary search below.

```python
def binary_search(array) -> int:
    def condition(value) -> bool:
        pass

    left, right = min(search_space), max(search_space) # could be [0, n], [1, n] etc. Depends on problem
    while left < right:
        mid = left + (right - left) // 2
        if condition(mid):
            right = mid
        else:
            left = mid + 1
    return left
```

The above allows variations for `condition` function, a precise definition of `left`, `right` and `mid` variables.

The above can be used as a template and is quite concise while capturing many problem statements.

## Notes

A generic template for binary search was presented and needs to be explored further.

---
· Continues from: [Binary Search Python](./2026-08-09-binary-search-python.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
