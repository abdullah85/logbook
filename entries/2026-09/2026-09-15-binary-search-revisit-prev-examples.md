# Binary Search - Revisit Previous Examples 

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](/entries/2026-09/2026-09-12-binary-search-revisit.md) <!-- · [Next](/entries/2026-09/2026-09-23-binary-search-revisit-easy-examples.md) -->

Date: 2026-09-15 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](/entries/2026-09/2026-09-12-binary-search-revisit.md), we presented the definition below.

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

The above returns the smallest element satisfying the condition if one exists.

If no element in the search space satisfies the condition, the initial `right` index is returned.

The above definition seems much better to understand, remember and recall.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

Let's revisit the various examples presented thus far using the above definition starting with the latest first.

### Split An Array

The only change required for [the problem to Split an array](./2026-09-07-binary-split-array-largest-sum.md) is the definition below.

```python
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

### Ship Within D Days Problem

This problem is similar to the one above and modifications required are minimal as well.

```python
condition = feasible
ship_d_days=lambda weights,days: binary_search_recursive(
      SearchSpace(weights, days), condition, max(weights), sum(weights)
    )
```

Running through the examples, the results are verified as below.

```python
> weights = [1,2,3,1,1]; days = 4; ship_d_days(weights, days)
3

> weights = [3,2,2,4,1,4]; days = 3; ship_d_days(weights, days)
6

> weights = [1,2,3,4,5,6,7,8,9,10]; days = 5; ship_d_days(weights, days)
15
```

In both problems above, the result is the smallest value satisfying the condition.

### Conclusion

The recursive function returns the lowest value satisfying the condition, if one exists. 

If no solution exists, it returns the initial value of `right` used in the invocation.

Thus, we have reviewed the previous examples with the simpler recursive definition.

## Notes

Simpler recursive definition for various examples in [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) were reviewed.

---
· Continues from: [Binary Search Revisited](/entries/2026-09/2026-09-12-binary-search-revisit.md)

· Continued in: [Binary Search Revisit Easy Examples](/entries/2026-09/2026-09-23-binary-search-revisit-easy-examples.md)

Tags: #binary-search #algorithms #python #programming #generic
