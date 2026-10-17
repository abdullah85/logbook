# Binary Search - Kth-Smallest Pair Distance

<!-- — describing the event, concepts learnt or progress made. -->

[Previous](/entries/2026-10/2026-10-05-binary-mul-tab.md) <!-- · [Next](link to the follow-up entry, once created) -->

Date: 2026-10-10 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context

<!-- What problem existed, or what I set out to do. 1–3 sentences. -->

In the [previous entry](/entries/2026-10/2026-10-05-binary-mul-tab.md), we identified the kth smallest number contained in a multiplication table given the values `m` and `n` for the rows, columns respectively of the table.

Recall the recursive definition for our binary search template below.

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

Let's proceed with the next example from the [original article](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) which is to find the kth smallest pair distance for a list of numbers.


## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The [problem](https://leetcode.com/problems/find-k-th-smallest-pair-distance/description/) requires finding the `k-th` smallest absolute pair difference from a list of numbers provided by a `nums` array. The difference from the previous entry for finding the `kth` smallest number in the multiplication table is obvious as this requires identifying the `kth` smallest pair. A few aspects need to be observed to solve this problem.

The required auxiliary data structures and the `enough` function are of the form:
```python
from collections import namedtuple
SearchSpace = namedtuple("SearchSpace", ["nums", "k"])
```
The `enough` function takes the `search_space`, `distance` as input and is expected to return `True` if there are at least `k` pairs whose difference is less than or equal to `distance` and this makes the problem slightly more involved than the previous one.

Also, let's assume that the `nums` array is sorted before invoking the `enough` function.

Reviewing the article, we find the function defined as below:
```python
def enough(search_space, distance) -> bool:
    count, i, j = 0, 0, 0
    nums = search_space.nums
    n = len(nums)
    while i < n - 1:
        while j < n and nums[j] - nums[i] <= distance:  # move fast pointer
            j += 1
        count += j - i - 1  # count pairs
        i += 1  # move slow pointer
    return count >= search_space.k
```


Assuming `nums` is sorted, here are a few clarifications:
* A pair `i < j` entails `nums[j] - nums[i]` is not negative.
* For each `i`, the inner loop pushes `j` to the first index too far from `nums[i]`, and `i+1 .. j-1` which are `j - i - 1` valid pairs.
* Why `j` never moves back when `i` is incremented: for any index `x` with `i < x < j`, we know `nums[x] - nums[i] <= distance`. Since `nums` is sorted, `nums[i+1] >= nums[i]`, we have `nums[x] - nums[i+1] <= nums[x] - nums[i] <= distance` and we do not reset.

```python
def smallest_k_pair(nums, k) -> int:
    nums.sort()
    max_diff = max(nums) - min(nums)
    return binary_search_recursive(SearchSpace(nums, k), enough, 0, max_diff)
```

The above definition of `smallest_k_pair` solves the stated problem.

## Notes

The kth smallest absolute pair distance in a list of numbers provided in the [reference](https://leetcode.com/discuss/post/786126/python-powerful-ultimate-binary-search-t-rwv8/) was discussed in this entry.

---
· Continues from:

· Continued in:

Tags: #binary-search #algorithms #python #programming #generic
