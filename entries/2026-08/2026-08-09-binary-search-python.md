# Python Bisect Module

<!-- — describing the event, concepts learnt or progress made. -->
[Previous](./2026-08-04-review-access-codes.md) · [Next](./2026-08-17-binary-search-template.md)

Date: 2026-08-09 <!-- · Repo: [repo-name](https://github.com/username/repo-name) --> <!-- · PR #__ --> <!-- · Issue #__ --> <!-- · Commits #__ -->

## Context
<!-- What problem existed, or what I set out to do. 1–3 sentences. -->
Yesterday, I was unable to implement a binary search procedure to find the index in an array.

```python
In [1]: my_list = [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
   ...: key = 15
```

I needed a solution that returns the index of `12`, the largest number less than the required key.

Knowing an existing solution precisely would eliminate the need for rolling one by hand every time.

## Concepts
<!-- Ideas, terms, or tools I came across — and how they relate to things I already knew. -->

The required solution using `bisect` is shown below:

```python
In [1]: import bisect
   ...: my_list = [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
   ...: key = 15

In [2]: bisect.bisect_left(my_list, key)
Out[2]: 4

In [3]: bisect.bisect_right(my_list, key)
Out[3]: 4
```
The above was slightly confusing for me as both return the same value.

Turns out, either function identifies the index to insert the new element to maintain sorted order.

The difference between the two variants appears when there are multiple elements of searched key.

```python
In [1]: import bisect
   ...: my_list = [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
   ...: target = 23

In [2]: bisect.bisect_left(my_list, target)
Out[2]: 5

In [3]: bisect.bisect_right(my_list, target)
Out[3]: 6
```

Let's revisit the above with another example to further highlight the difference:

```python
In [1]: import bisect
   ...: my_list = [2, 5, 8, 8, 8, 12, 16, 23, 23, 38, 56, 72, 91]

In [2]: bisect.bisect_left(my_list, 8)
Out[2]: 2

In [3]: bisect.bisect_right(my_list, 8)
Out[3]: 5

In [4]: bisect.bisect_left(my_list, 23)
Out[4]: 7

In [5]: bisect.bisect_right(my_list, 23)
Out[5]: 9
```
For `bisect.bisect_left(a, x, lo=0, hi=len(a), *, key=None)` the definition states:
> If x is already present in a, the insertion point will be before (to the left of) any existing entries.

For `bisect.bisect_right(a, x, lo=0, hi=len(a), *, key=None)`, we have
> Similar to bisect_left(), but returns an insertion point which comes after (to the right of) any existing entries of x in a.

The above is also `bisect.bisect(a, x, lo=0, hi=len(a), *, key=None)` is the same as `bisect_right` defined above.

Thus, we have understood approaches with nuances of standard library's `bisect` for performing binary search. 

## Notes

Refer the [bisect](https://docs.python.org/3/library/bisect.html) module for Python.

---
· Continues from:

· Continued in: [Binary Search Python](././2026-08-09-binary-search-python.md)

Tags: #binary-search #bisect #algorithms #python #programming
