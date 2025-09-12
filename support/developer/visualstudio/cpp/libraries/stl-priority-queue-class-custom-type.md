---
title: Use the PRIORITY_QUEUE class with a custom type
description: This article provides a code sample that describes how to use the priority_queue template container of STL with custom types like classes and structures.
ms.date: 04/22/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.topic: how-to
---
# Use the STL PRIORITY_QUEUE class with a custom type

This article describes how to define a Standard Template Library (STL) `priority_queue` template container adaptor class that uses custom (user-defined) data types.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 837697

## Summary

This article describes how to use the STL `priority_queue` template container adaptor class with custom (user-defined) data types such as structures and classes. This article also describes how to order the `priority_queue` class members by overloading the left angle bracket (<) or the right angle bracket (>) comparison operators. This article also describes how to declare the `priority_queue` container class variables that contain the custom (user-defined) data members and how to access these variables in your program. The information in this article applies only to unmanaged Visual C++ code.

## Requirements

This article assumes that you are familiar with programming with STL data types and container types.

## Creating a custom data type

The `priority_queue` class is a template container adaptor class that limits access to the top element of some underlying container type. To limit access to the top element of an underlying container type is always the highest priority. You can add new elements to the `priority_queue` class and you can examine or remove the top element of the `priority_queue` class.

To use the `priority_queue` class with the custom (user-defined) data types, you must define a custom data type as shown in the following code:

```cpp
//Define a custom data type.
class Student
{
    public:
    char* chName;
    int nAge;
    Student(): chName(""),nAge(0){}
    Student( char* chNewName, int nNewAge ):chName(chNewName), nAge(nNewAge){}
};
```

> [!NOTE]
> To define a structure for the same purpose, you can replace `class` with `struct` in this code sample.

## Specify QUEUE order

You can specify the order of the `priority_queue` class members by overloading the right angle bracket or the left angle bracket comparison operators as shown in the following code sample:

```cpp
//Overload the < operator.
bool operator< (const Student& structstudent1, const Student &structstudent2)
{
    return structstudent1.nAge > structstudent2.nAge;
}
//Overload the > operator.
bool operator> (const Student& structstudent1, const Student &structstudent2)
{
    return structstudent1.nAge < structstudent2.nAge;
}
```

## Create and access priority_queue variables with custom data types

The prototype of the `priority_queue` template class is as follows:

```cpp
template <
  class Type,
  class Container=vector<Type>,
  class Compare=less<typename Container::value_type>
>
class priority_queue
```

Declare a `priority_queue` variable that specifies the custom data type and the comparison operator as follows:

```cpp
priority_queue<Student, vector<Student>,less<vector<Student>::value_type> > pqStudent1;
```

You can use different methods of the `priority_queue` class such as `push`, `pop`, `empty`, and other methods as follows:

```cpp
// Add container elements.
pqStudent1.push( Student( "Mark", 38 ));
pqStudent1.push( Student( "Marc", 25 ));
pqStudent1.push( Student( "Bill", 47 ));
pqStudent1.push( Student( "Andy", 13 ));
pqStudent1.push( Student( "Newt", 44 ));

//Display container elements.
while ( !pqStudent1.empty())
{
    cout << pqStudent1.top().chName << endl;
    pqStudent1.pop();
}
```

## Complete code listing

```cpp
// The debugger cannot handle symbols that are longer than 255 characters.
// STL frequently creates symbols that are longer than 255 characters.
// When symbols are longer than 255 characters, the warning is disabled.
#pragma warning(disable:4786)
#include "stdafx.h"
#include <queue>

#using <mscorlib.dll>

#if _MSC_VER > 1020 // if VC++ version is > 4.2
  using namespace std; // std c++ libs implemented in std
#endif
using namespace System;

//Define a custom data type.
class Student
{
    public:
    char* chName;
    int nAge;
    Student(): chName(""),nAge(0){}
    Student( char* chNewName, int nNewAge ):chName(chNewName), nAge(nNewAge){}
    };

    //Overload the < operator.
    bool operator< (const Student& structstudent1, const Student &structstudent2)
    {
        return structstudent1.nAge > structstudent2.nAge;
    }
    //Overload the > operator.
    bool operator> (const Student& structstudent1, const Student &structstudent2)
    {
        return structstudent1.nAge < structstudent2.nAge;
    }

    int _tmain()
    {
      //Declare a priority_queue and specify the ORDER as <
      //The priorities will be assigned in the Ascending Order of Age
      priority_queue<Student, vector<Student>,less<vector<Student>::value_type> > pqStudent1;

      //declare a priority_queue and specify the ORDER as >
      //The priorities will be assigned in the Descending Order of Age
      priority_queue<Student, vector<Student>,greater<vector<Student>::value_type> > pqStudent2;

      // Add container elements.
      pqStudent1.push( Student( "Mark", 38 ));
      pqStudent1.push( Student( "Marc", 25 ));
      pqStudent1.push( Student( "Bill", 47 ));
      pqStudent1.push( Student( "Andy", 13 ));
      pqStudent1.push( Student( "Newt", 44 ));

      //Display container elements.
      while ( !pqStudent1.empty())
      {
          cout << pqStudent1.top().chName << endl;
          pqStudent1.pop();
      }
      cout << endl;

      // Add container elements.
      pqStudent2.push( Student( "Mark", 38 ));
      pqStudent2.push( Student( "Marc", 25 ));
      pqStudent2.push( Student( "Bill", 47 ));
      pqStudent2.push( Student( "Andy", 13 ));
      pqStudent2.push( Student( "Newt", 44 ));

      //Display container elements.
      while ( !pqStudent2.empty())
      {
          cout << pqStudent2.top().chName << endl;
          pqStudent2.pop();
      }
      cout << endl;
      return 0;
    }
}
```

You must add the common language runtime support compiler option (**/clr:oldSyntax**) in Visual C++ to successfully compile the previous code sample. To add the common language runtime support compiler option in Visual C++, follow these steps:

1. Click **Project**, and then click **\<ProjectName> Properties**.

    > [!NOTE]
    > **\<ProjectName>** is a placeholder for the name of the project.
2. Expand **Configuration Properties**, and then select **General**.
3. Select **Common Language Runtime Support, Old Syntax (/clr:oldSyntax)** in the **Common Language Runtime support** project setting in the right pane, select **Apply**, and then select **OK**.

For more information about the common language runtime support compiler option, see [/clr (Common Language Runtime Compilation)](/cpp/build/reference/clr-common-language-runtime-compilation).
