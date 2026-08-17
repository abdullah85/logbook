# Binary Search Template

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-08-09-binary-search-python.md) · <!-- [Next](link to the follow-up entry, once created) -->

Date: 2026-08-17 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

To solve problems with binary search, this [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) looks quite useful.

Let's review the template provided in the article as shown below.

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

Let's make it more re-usable by using recursion and functions appropriately.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

To ensure better resuability, define a new function `binary_search_recursive` as below.

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

The above requires defining the `search_space` and `condition(search_space, value)` functions.

The idea behind the above approach is to consider the problem as a sequence as below.
```
+++++++++++++**************
+++++++++++
********
```

The `*` denotes items that satisfy the `condition` while `+` denotes the elements that do not satisfy a condition.

The `search_space` represents a structure  (usually an array) with a monotonic underlying structure as above.

The function `binary_search_recursive` returns the last element that does **not** satisfy the condition.
 
Let's assume that the elements are `0-indexed` and thus `-1` is returned when all elements satisfy the condition.

Let's review some concrete examples as provided in the [reference article](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) mentioned earlier.

### First Bad Version 

Let's review the Python code below that encodes the required API below.

```python
FIRST_BAD_VERSION = 195

def isBadVersion(n):
  if n>= FIRST_BAD_VERSION:
    return True
  return False
```

Now, we can reuse the template we defined earlier by defining `last_good_version` as below.

```python

```


## Notes

A generic template for binary search was created with recursion, functions that ensures better reusability.

---
· Continues from: [Binary Search Python](./2026-08-09-binary-search-python.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
