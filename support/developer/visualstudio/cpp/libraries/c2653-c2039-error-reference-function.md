---
title: C2653/C2039 error when you reference STD functions
description: Explains that when you try to reference a function from the STD C++ library header <cstdlib>, you may receive a C2653 or a C2039 compiler error message. A workaround is provided in this article.
ms.date: 04/22/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.reviewer: v-ingor
---
# C2653 or C2039 error when you try to reference a function from the STD C++ library

This article provides the information about solving the C2653 or C2039 error that occurs when you reference a function from the STD C++ library.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 243444

## Symptoms

Attempting to reference a function from the STD C++ library header `<cstdlib>` using the namespace `std` (for example, `std::exit(0)`) causes the compiler to emit a C2653 or a C2039 (depending upon whether or not namespace `std` is defined at the point where the error is emitted) error message.

## Cause

`<cstdlib>` does not define the namespace `std`. This is contrary to the Visual C++ documentation, which says:

Include the standard header `<cstdlib>` to effectively include the standard header `<stdlib.h>` within the `std` namespace.

## Resolution

To work around the problem, place the `#include <cstdlib>` in the namespace `std`.

## More information

Attempting to compile the following will cause the compiler to display the following error:

> error C2653: 'std' : is not a class or namespace name

```cpp
// Compile Options: /GX
#include <cstdlib>

void main()
{
    std::exit(0);
}
```

However, attempting to compile the following causes the compiler to display the following error:

> error C2039: 'exit' : is not a member of 'std'

```cpp
// Compile Options: /GX
#include <vector>
#include <cstdlib>

void main()
{
    std::exit(0);
}
```

In the first case, the C2653 is displayed, because the namespace `std` has not been defined. In the second case, the C2039 is displayed, because the namespace `std` has been defined (in the header `<vector>`), but the function `exit` is not part of that namespace. To work around the problem in either case, simply enclose the `#include <cstdlib>` in the namespace `std`, as follows:

```cpp
// Compile Options: /GX
namespace std
{
    #include <cstdlib>
};

void main()
{
    std::exit(0);
}
```
