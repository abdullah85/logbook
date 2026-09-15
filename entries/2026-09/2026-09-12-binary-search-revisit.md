# Binary Search - Revisit Recursive Definition

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](./2026-09-07-binary-split-array-largest-sum.md) · [Next](/entries/2026-09/2026-09-15-binary-search-revisit-prev-examples.md)

Date: 2026-09-12 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

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

The issue is that for the problem above, the solution is not clean due to the terminiation condition.

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
> condition = feasible
> split_into_subarrays=lambda nums, m: binary_search_recursive(
      SearchSpace(nums, m), condition, max(nums), sum(nums)
    )

> nums = [7,2,5,10,8]; k = 2; split_into_subarrays(nums, k)
18
```

Thus, the various examples were resolved using a simple recursive definition.

## Notes

Various examples were presented with a simpler recursive definition for binary search.

---
· Continues from: [Binary Search Ship within D days](./2026-09-05-binary-ship-days.md)

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
