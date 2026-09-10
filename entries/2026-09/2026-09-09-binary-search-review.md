# Binary Search - Split Array Largest Sum [Hard]

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-09-07-binary-split-array-largest-sum.md) <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-09-09 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](./2026-09-07-binary-split-array-largest-sum.md), we reviewed a solution to [split an input array into k subarrays](https://leetcode.com/problems/split-array-largest-sum/description/) minimizing the largest sum of any subarray.

We used the `binary_search_recursive` [definition](../2026-08/2026-08-19-binary-search-template.md) as below.

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

The final solution was defined by `split_into_subarrays` as listed below.

```python
condition = feasible
split_into_subarrays=lambda nums, m: binary_search_recursive(
     SearchSpace(nums, m), condition, max(nums), sum(nums)
   ) + 1 # Increment by 1 to undo the decrement in recursive definition.
```

The issue is that for the problem above the solution is not clean due to the terminiation condition.

Let's revise the `binary_search_recursive` definition for a cleaner approach.

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

The above definition is much better to understand, remember and recall.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->


Let's revisit the [problem to Split an array](./2026-09-07-binary-split-array-largest-sum.md) minimizing the largest sum as below.

```python
from typing import NamedTuple

class SearchSpace(NamedTuple):
    nums: list[int]
    m: int      # the required number of subarrays

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

condition = feasible
split_into_subarrays=lambda nums, m: binary_search_recursive(
     SearchSpace(nums, m), condition, max(nums), sum(nums)
   )
```

The increment at the end is not needed with the new recursive function.

```python
> nums = [7,2,5,10,8]; k = 2; split_into_subarrays(nums, k)
18
```

The recursive function returns the lowest value satisfying the condition, if one exists. 

If no solution exists, then I guess it will return the last element in the sequence. 

We need to review the earlier examples and modify them with this recursive definition.

## Notes
Another advanced example from [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was reviewed.

---
· Continues from: [Binary Search Ship within D days](./2026-09-05-binary-ship-days.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
