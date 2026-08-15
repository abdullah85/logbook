# Binary Search Recursion Template Examples

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-08-12-binary-recursive-redefined.md)  <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-08-15 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

Recall the [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) which provides examples.

Recall the recursive template from the [previous entry](./2026-08-11-binary-search-recursive.md) below.


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



Let's work through the examples from the original article.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's run through the examples with the recursive template provided earlier.

For each example problem, we must define the `search_space`, `condition` and maybe tweak the termination condition.

### First Bad Version

Define the condition as `is_bad_version(n, i)` and the `search_space` is implicit for a given `n` as an integer.

### Square Root

Define the condition as `condition = lambda n: lambda x: x*x > n` with `n` representing the search space.

### Search Insert Position

Define the condition as `cond = lambda lst: (lambda target: (lambda x : lst[x] > target))` with three variables.

The `search_space` conists of a list of elements and a target as illustrated in the condition function above.

## Notes

A recursive definition for binary search template with examples for the easy cases.

---
· Continues from: [Binary Recursive Search Template Redefined](./2026-08-12-binary-recursive-redefined.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
