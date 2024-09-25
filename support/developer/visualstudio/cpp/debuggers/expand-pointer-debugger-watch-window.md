---
title: Expand an array pointer in VC++ debugger
description: Describes how to expand an array pointer to view all array elements in the Visual C++ Debugger Watch window.
ms.date: 04/16/2020
ms.reviewer: shaunm
ms.topic: how-to
ms.custom: sap:Debuggers and Analyzers\Visual Studio Debugger
---
# Expand an array pointer in the Visual C++ debugger Watch window

This article describes how to expand an array pointer to view all array elements in the Visual C++ debugger **Watch** window.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 198953

## Summary

Starting with Visual C++ version 6.0, it's now possible to expand an array pointer to view all array elements in the Visual C++ debugger **Watch** window. This feature isn't documented.

In the **Watch** window, type an expression that evaluates to a pointer followed by a comma and the number of elements in the array.

## More information

1. Build the debug version of the following code as a console application.

    ```cpp
    // Filename main.cpp
    // No compile option needed
    #include <iostream.h>
    void main(void)
    {
        int * p;
        char* ptr = "Hello World";
        p = new int [10];

        for(int i=0; i<=9; i++){*(p+i) = i+1;}
        cout << i <<endl;
    }
    ```

2. Step into the code with the debugger and stop at the last line of code.
3. In the **Watch** or **QuickWatch** window, add the variable `p` or `ptr` . You'll see a plus (+) symbol next to the variable.
4. Click the plus (+) symbol to expand the variable. You'll see only the first element of the array to which it points.
5. Now, type *p,10* or *ptr,11* in the **Watch** window.
6. Click the plus (+) symbol to expand the variable. Now you see all elements of the array to which it points.

If you want to see a specific range of elements, then enter the address of the first element to specify the starting index, followed by the format specifier as described in the preceding steps. For example, *(p+3),8* shows elements `p[3..10]`, and *(ptr+3),10* shows elements `ptr[3..12]`. Unfortunately, the starting index in the **Watch** window will be **[0]**, which actually corresponds to index 3 in this example. Remember that the offset 3 has to be added to each displayed index to get the actual index of the array element.
