# Binary Search Template

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-08-09-binary-search-python.md) · [Next](./2026-08-09-binary-search-python.md) -->

Date: 2026-08-19 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

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
  if n >= FIRST_BAD_VERSION:
    return True
  return False
```

Now, we can reuse the template we defined earlier by defining `last_good_version` as below.

```python
condition = lambda search_space, value: isBadVersion(value)
last_good_version = lambda start, end: binary_search_recursive(None, condition, start, end)
```

The `search_space` is represented by `None` and the condition function needs only the `value` as input.

The function produces the required results as shown below.

```python
> last_good_version(1, 1500)
194
> last_good_version(1, 95)
95
> import math
> FIRST_GOOD_VERSION = math.inf
> last_good_version(1, 1500)
1500
```

The edge cases are handled appropriately especially when there is no bad version.

Now, let's define the `first_bad_version` appropriately as below.

```python
first_bad_version = lambda start, end: -1 if (lg := last_good_version(start, end)) == end else lg + 1
```

The above ensures that if all versions in the provided range are good then `-1` is returned.

```python
> first_bad_version(1, 1500)
195
> first_bad_version(1, 95)
-1
> import math
> FIRST_BAD_VERSION = math.inf
> first_bad_version(1, 10_15)
-1
```

The above illustrates that the behaviour of `first_bad_version` works as expected.

## Notes

A generic template for binary search was created with recursion, functions that ensures better reusability.

One example has been presented in this entry.
---
· Continues from: [Binary Search Python](./2026-08-09-binary-search-python.md)

· Continued in: [Binary Template Easy](./2026-08-20-binary-template-easy.md)

Tags: #binary-search #algorithms #python #programming #generic
