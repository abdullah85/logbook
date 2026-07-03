# Understanding Pydantic Models, Pydantic dataclasess, standard dataclasses, namedtuples 

**Date:** 2026-07-03
**Repo/Project:** 
**Related:** PR #__ / Issue #__ (link if applicable)
**Follows:** _(link to the earlier entry this continues, if any)_
**Followed by:** _(filled in later, once a follow-up entry exists)_

## Concepts & Connections

Gathering related concepts with a short sentence for quick recall:

* The `namedtuple()`, a factory function in the `collections` module allows creating a `tuple` sublclass with named fields.
* The advantage of `dataclasses` module is that it mainly reduces boiler plate code
* Pydantic Models - simply classes which inherit from `BaseModel` and define fields as annotated attributes.
* Pydantic validates data in three different modes: Python, JSON and strings.
* Pydantic Dataclasses - enhanced dataclass (stdlib) that performs validation

So, the natural question is what is the benefit of Pydantic dataclasses compared to standard Python dataclass?

---
Tags: #pydantic #dataclass #namedtuple
