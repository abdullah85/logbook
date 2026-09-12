# Binary Search - Split Array Largest Sum [Hard]

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-09-05-binary-ship-days.md) · [Next](./2026-09-12-binary-search-revisit.md)

Date: 2026-09-07 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](./2026-09-05-binary-ship-days.md), we discussed the problem of finding the minimum capacity required for a ship to ship a list of weighted items within `D` days from the [Binary Search Template](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/), as an application of the template with a slightly modified recursive definition for the template as well as auxillary functions.

Let's explore another example, which is to [split an input array into k subarrays](https://leetcode.com/problems/split-array-largest-sum/description/) minimizing the largest sum of any subarray.

The problem seems very difficult at first glance but is quite similar to the previous one to find the shipping capacity.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's revisit the `binary_search_recursive` [definition](../2026-08/2026-08-19-binary-search-template.md) as below.

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
        return binary_search_recursive(
        search_space, condition, left, mid
        )
    else:
        return binary_search_recursive(
         search_space, condition, (mid+1), right
        )
```

To capture the search space, we use `NamedTuple` again as shown below.
```python
from typing import NamedTuple

class SearchSpace(NamedTuple):
    nums: list[int]
    m: int      # the required number of subarrays
```

The main challenge of this problem is to reformulate it correctly.

Similar to the shipping problem, we need to define the `feasible` condition as below:
```python
def feasible(search_space, threshold):
  total = 0
  count = 1
  for num in search_space.nums:
    total += num
    if total > threshold: # increment the number of subarrays
        total = num
        count += 1
        if count > search_space.m:
            return False
  return True
```

With the `binary_search_recursive` defined earlier, we could have the definitions below.

```python
condition = feasible
split_into_subarrays=lambda nums, m: binary_search_recursive(
     SearchSpace(nums, m), condition, max(nums), sum(nums)
   ) + 1 # Increment by 1 to undo the decrement in recursive definition.
```

However, if we apply the definition to the example problem, we get the required result below.
```python
> nums = [7,2,5,10,8]; k = 2; split_into_subarrays(nums, k)
18
```

Thus, the problem of splitting arrays is quite similar to the previous problem with respect to shipping.

## Notes
Another advanced example from [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was reviewed.

---
· Continues from: [Binary Search Ship within D days](./2026-09-05-binary-ship-days.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
