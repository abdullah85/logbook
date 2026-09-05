# Binary Search - Ship within D days

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-08-27-binary-template-easy.md) <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-08-31 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](2026-08-19-binary-search-template.md) we defined all the easy examples in the [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) with a recursive definition for the template.

In this entry, we will explore one example in the advanced application section of the [reference article](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) provided earlier.

The problem involves [identifying the minimum capacity](https://leetcode.com/problems/capacity-to-ship-packages-within-d-days/description/) for a ship to ship items arriving with specified weights in `D` days.

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

To define the search space use `NamedTuple` 

```python
from typing import NamedTuple

class SearchSpace(NamedTuple):
    waeights: list[int]
    D: int      # D is the target number of days across all capacities

```

The key idea is to reformulate the problem as the capacity is a monotonic measure.

That is, if a ship with capacity `c` can ship within `D` days then any ship with greater capacity can do so as well.

Another observation is to greedily pack an item on the ship if the capacity of the ship allows it.

Let's review the solution provided in the reference earlier.

```python
def feasible(search_space, capacity):
    days = 1
    total = 0
    for weight in search_space.weights:
        if total + weight <= capacity:
            total += weight
        else:
            total = weight
            days += 1
            if days > search_space.D:
                return False
    return True
```

This definition is compatible with our `condition` function and we can complete the remaining definitions as below.

```python
condition = feasible
ship_d_days=lambda weights,days: binary_search_recursive(SearchSpace(weights, days), condition, max(weights), sum(weights)) + 
```
The result of `binary_search_recursive` will provide the largest value that does not satisfy the condition.

That is, the result of the recursive call returns the largest capacity of a ship that **cannot** ship within `D` days.

Hence, we need to increment by 1 to obtain the lowest capacity that is able to ship within `D` days.

```python
> weights = [1,2,3,4,5,6,7,8,9,10]; days = 5; ship_d_days(weights, days)
15

> weights = [3,2,2,4,1,4]; days = 3; ship_d_days(weights, days)
6

> weights = [1,2,3,1,1]; days = 4; ship_d_days(weights, days)
3
```

The running time is in order of `O(n * log(n))` where `n` is the number of weights.


## Notes

The first example among the advanced exampled in [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) were reviewed.

---
· Continues from: [Binary Search Python](./2026-08-09-binary-search-python.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
