# Understanding Pydantic Models, Pydantic dataclasess, standard dataclasses, namedtuples 

**Date:** 2026-07-03
**Repo/Project:** 
**Related:** PR #__ / Issue #__ (link if applicable)
**Follows:** _(link to the earlier entry this continues, if any)_
**Followed by:** _(filled in later, once a follow-up entry exists)_

## Concepts

Gathering related concepts with a short sentence for quick recall:

* The `namedtuple()`, a factory function in the `collections` module allows creating a `tuple` sublclass with named fields.
* The advantage of `dataclasses` module is that it mainly reduces boiler plate code
* Pydantic Models - simply classes which inherit from `BaseModel` and define fields as annotated attributes.
* Pydantic validates data in three different modes: Python, JSON and strings.
* Pydantic Dataclasses - enhanced dataclass (stdlib) that performs validation

So, the natural question is what is the benefit of Pydantic dataclasses compared to standard Python dataclass?

```
import dataclasses
import pydantic

@dataclasses.dataclass
class Z:
    z: int

@dataclasses.dataclass
class Y(Z):
    y: int = 0

@pydantic.dataclasses.dataclass
class X(Y):
    x: int = 0

foo = X(x=b'1', y='2', z='3')
print(foo)
#> X(z=3, y=2, x=1)
try:
    X(z='pika')
except pydantic.ValidationError as e:
    print(e)
    """
    1 validation error for X
    z
      Input should be a valid integer, unable to parse string as an integer [type=int_parsing, input_value='pika', input_type=str]
    """
```

In the above [example code snippet](https://pydantic.dev/docs/validation/latest/concepts/dataclasses/#stdlib-dataclasses-and-pydantic-dataclasses), we see that a validation error is thrown for incorrect type assigned to a parent field. It is interesting to note that the parent classes are all standard dataclasses. So, this is the benefit of using `pydantic.dataclass` when compared to standard `dataclass` from `dataclasses` in the standard library and review

```
@dataclasses.dataclass
class A(Y):
    a: int = 1
A(z='abc')
A(z='abc')
#> A(z='abc', y=0, a=1)

# In fact, even the simpler version does not check the type
Z(z="324")
#> Z(z='324')

```
This clearly illustrates that standard dataclasses do not have in-built validation.

## Summary

This was a short overview or motivation for Pydantic dataclasses, models and relation with standard dataclasses.

## Next Steps

A related topic is the validation in Pydantic models versus that for Pydantic dataclasses.

---
Tags: #pydantic #dataclass #pydantic-model
