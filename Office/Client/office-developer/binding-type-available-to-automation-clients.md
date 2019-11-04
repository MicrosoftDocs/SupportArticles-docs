---
title: Use early binding and late binding in Automation
description: Explains the types of binding available to Automation clients, and weighs both sides of each method.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: rtaylor, terusu
appliesto:
- Office 365
- Office 2019
- Office 2016
- Office 2013
- Office 2010
---

# Using early binding and late binding in Automation

## Summary

How you bind to an Automation server can affect many things in your program, such as performance, flexibility, and maintainability.

This article explains the types of binding available to Automation clients, and weighs both sides of each method.

## More Information

Automation is a process where one software component communicates with and/or controls another software component using Microsoft's Component Object Model (COM). It is the basis for most cross-component communication used in languages such as Visual Basic or Visual Basic for Applications, and has become a normal part of most programs.

Historically, an Automation object is any object that supports the IDispatch interface. This interface allows clients to call methods and properties at run time without having to know the exact object they are communicating with at design time; a process called late binding. Today, however, the term Automation object can be applied to virtually any COM object, even those that do not support IDispatch (and therefore cannot be late bound). This article assumes the object you are Automating supports both binding methods.

### What is binding?

Binding is a process of matching function calls written by the programmer to the actual code (internal or external) that implements the function. It is done when the application is compiled, and all functions called in code must be bound before the code can be executed.

To understand the process, think of "binding" in terms of publishing a book. Imagine your code is like the text of the book where in a certain paragraph you have written something like "see chapter 12, page x for more details." You don't know what the page number is until the book is finished, so before the paragraph can be read as intended, all the pages of the book must be bound together and the correct page number inserted into the paragraph. You wait for the book to be "bound" before you can reference other parts of the book.

Binding software is similar. Your code is made up of parts that need to be pulled together before the code can be "read." Binding is the act of replacing function names with memory addresses (or memory offsets, to be more precise) where the code will "jump to" when the function is called. For COM objects, the address is a memory offset in a table of pointers (called the v-table) held by the object. When a COM function is bound, it is bound through the v-table.

The structure of a COM object is simple. When your code holds a reference to an object, it holds an indirect pointer to the top of the v-table. The v-table is an array of memory addresses where each entry is a different function that can be called on that object. To call the third function on a COM object, you jump down three entries in the table and then jump to the memory location given there. That executes the code for the function and, when complete, returns you back ready to execute the next line of code.

```
+-[Code]------------+  +.................................[COM Object]...+
|                   |  : +-------------+                                :
|Set obj = Nothing -|--->| obj pointer |                                :
|                   |  : +-|-----------+                                :
+-------------------+  :   |   +-----------------+                      :
                       :   +-->| v-table pointer |                      :
                       :       +--|--------------+                      :
                       :          |                                     :
                       :          |  +----------------------------+     :
                       :  (3rd)   |  | Function 1 Address pointer |     :
                       : (Offset) |  +----------------------------+     :
                       :          |  | Function 2 Address pointer |     :
                       :          |  +----------------------------+     :
                       :          +->| Function 3 Address pointer |     :
                       :             +----------------------------+     :
                       +................................................+
```                      

The example above shows what happens when releasing a COM object. Because all COM objects inherit from IUnknown, the first three entries in the table are the methods to IUnknown. When you need to free an object, your code calls the third function in the v-table (IUnknown::Release).

Fortunately, this work is done by Visual Basic behind the scenes. As a Visual Basic programmer, you never have to deal with a v-table directly. But, this structure is how all COM objects are bound, and it is important that you are familiar with it to understand what binding is.

#### Early binding

The example above is what is known as early (or v-table) binding. For all COM objects, this form of binding takes place whenever a COM object's IUnknown interface is called. But what about the other functions of the object? How do you call its Refresh method or its Parent property? These are custom functions that are typically unique to an object. If their locations in the v-table cannot be assumed, how do you find the function addresses needed to call them?

The answer, of course, depends on whether or not you know in advance what the object's v-table looks like. If you do, you can perform the same early-binding process to the object's custom methods as you did to its IUnknown methods. This is what is generally meant by "early-binding."

To use early binding on an object, you need to know what its v-table looks like. In Visual Basic, you can do this by adding a reference to a type library that describes the object, its interface (v-table), and all the functions that can be called on the object. Once that is done, you can declare an object as being a certain type, then set and use that object using the v-table. For example, if you wanted to Automate Microsoft Office Excel using early binding, you would add a reference to the "Microsoft Excel 8.0 Object Library" from the Project|References dialog, and then declare your variable as being of the type "Excel.Application." From then on, all calls made to your object variable would be early bound:

```vb

' Set reference to 'Microsoft Excel 8.0 Object Library' in
' the Project|References dialog (or Tools|References for VB4 or VBA).

' Declare the object as an early-bound object
  Dim oExcel As Excel.Application

  Set oExcel = CreateObject("Excel.Application")

' The Visible property is called via the v-table
  oExcel.Visible = True
  ```

This method works great most of the time, but what if you don't know the exact object you will be using at design time? For example, what if you need to talk to multiple versions of Excel, or possibly to an "unknown" object altogether?

#### Late binding

COM includes IDispatch. Objects that implement IDispatch are said to have a dispinterface (if it is the only interface they support) or dual interface (if they also have a custom interface that you can early bind to). Clients that bind to IDispatch are said to be "late bound" because the exact property or method they are calling is determined at run time using the methods of IDispatch to locate them. Going back to the book example earlier, think of it as being like a footnote that directs you to the table of contents where you have to "look up" the page number at "read time" rather than having it already printed there in the text.

The magic of the interface is controlled by two functions: GetIDsOfNames and Invoke. The first maps function names (strings) to an identifier (called a dispid) that represents the function. Once you know the ID for the function you want to call, you can call it using the Invoke function. This form of method invocation is called "late binding."


Again, in Visual Basic the way you specify how the object is bound is by your object declaration. If you declare an object variable as "Object" you are, in fact, telling Visual Basic to use IDispatch, and are therefore late binding:

```vb
' No reference to a type library is needed to use late binding.
' As long as the object supports IDispatch, the method can 
' be dynamically located and invoked at run-time.

' Declare the object as a late-bound object
  Dim oExcel As Object

  Set oExcel = CreateObject("Excel.Application")

' The Visible property is called via IDispatch
  oExcel.Visible = True
```
As you can see, the rest of your code is the same. The only difference between early binding and late binding (in terms of the code you write) is in the variable declaration.

It is important to note that what is "late bound" is the function being called and not the way it is called. From the earlier discussion on binding in general, you should notice that IDispatch itself is "early bound:" that is to say that Visual Basic makes the call to set the Visible property through a v-table entry (IDispatch::Invoke) as it would any COM call. The COM object itself is responsible for forwarding the call to the correct function to make Excel visible. This indirection allows the Visual Basic client to be compiled (that is, bound to a valid function address) but still not know the exact function that will actually do the work.

#### Dispid binding

Some Automation clients (most noticeably MFC and Visual Basic 3.0, but also Visual Basic 5.0 and 6.0 with respect to ActiveX Controls) use a hybrid form of late binding called dispid binding. If the COM object is known at design time, the dispids for the functions that are called can be cached and passed directly to IDispatch::Invoke without the need to call GetIDsOfNames at run time. This can greatly increase performance, because instead of making two COM calls per function, you only need to make one.

Dispid binding is not an option you can normally choose in Visual Basic 5.0 or 6.0. It is used for objects that are referenced in a type library but do not contain a custom interface (that is, for objects that have a dispinterface only) and for aggregated ActiveX Controls but, in general, Visual Basic uses early binding any place you would normally use dispid binding.

#### Which form of binding should I use?

The answer to this question depends as much on the design of your project as anything else. Microsoft recommends early binding in almost all cases. However, there may be reasons for choosing late binding.

Early binding is the preferred method. It is the best performer because your application binds directly to the address of the function being called and there is no extra overhead in doing a run-time lookup. In terms of overall execution speed, it is at least twice as fast as late binding.

Early binding also provides type safety. When you have a reference set to the component's type library, Visual Basic provides IntelliSense support to help you code each function correctly. Visual Basic also warns you if the data type of a parameter or return value is incorrect, saving a lot of time when writing and debugging code.

Late binding is still useful in situations where the exact interface of an object is not known at design-time. If your application seeks to talk with multiple unknown servers or needs to invoke functions by name (using the Visual Basic 6.0 CallByName function for example) then you need to use late binding. Late binding is also useful to work around compatibility problems between multiple versions of a component that has improperly modified or adapted its interface between versions.

The advantages given to early binding make it the best choice whenever possible.

#### Maintaining compatibility across multiple versions

If you will be using a component that you do not redistribute with your setup package, and cannot be assured of the exact version you will be communicating with at run-time, you should pay special attention to early bind to an interface that is compatible with all versions of the component, or (in some cases) use late binding to call a method that may exist in a particular version and fail gracefully if that method is not present in the version installed on the client system.

Microsoft Office applications provide a good example of such COM servers. Office applications will typically expand their interfaces to add new functionality or correct previous shortcomings between versions. If you need to automate an Office application, it is recommended that you early bind to the earliest version of the product that you expect could be installed on your client's system. For example, if you need to be able to automate Excel 95, Excel 97, Excel 2000, and Excel 2002, you should use the type library for Excel 95 (XL5en32.olb) to maintain compatibility with all three versions.

Office applications also demonstrate that object models with large dual interfaces can suffer limitations in marshalling on some platforms. For your code to work best across all platforms, use IDispatch.

## References

For more information about COM, v-tables, and using Automation, please see the following books:

**Rogerson, Dale, Inside COM, MSPRESS, ISBN: 1-57231-349-8.**

**Curland, Matt, Advanced Visual Basic 6, DevelopMentor, 0201707128.**