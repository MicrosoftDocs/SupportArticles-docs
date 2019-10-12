---
title: How to use a class (object) from outside of the VBA project
description: Describes two set up steps required before one VBA project can access an object declared in the class module of another VBA project.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft Excel
- Microsoft PowerPoint
- Microsoft Word
---

# How to use a class (object) from outside of the VBA project in which it is declared

## Introduction

One of the benefits of using Object Oriented Programming (OOP) is the reusability of code. The typical way to do so is to instantiate an object of an already defined class with the Set *variable* = *New ClassName* syntax. VBA programmers use such objects whenever they use any object within their application platform. Examples include the Workbook object in Excel, the Presentation object in PowerPoint or the Document object in Word. In addition, VBA programmers use userforms, which are objects that belong to a special kind of class. All these objects are defined in libraries that are outside of the VBA developer's project. Click on the Tools | References… menu item to see the list of external libraries that the Visual Basic Editor (VBE) automatically establishes on behalf of the developer.

In this tip, we explore how to access a custom class in an external library created by us. While the example used below is based on Excel 2003, the tips applies to other MS Office products that support VBA and is applicable to versions 2000 or later.

This is an intermediate/advanced level tip and it presumes a certain comfort level with VB(A) programming.

There are two distinct set up steps required before one VBA project can access an object declared in the class module of another VBA project. The first set makes the class module usable outside of the project in which it is declared and provides a means by which an object can be instantiated. The second set deals with how the client project uses this class.

## Set up the project that contains the class definition

By default a class module has the Instancing property set to Private. That means that only the project which contains the definition of the class can instantiate an object of that class. The only other choice that VBA supports is Public, not creatable. What that means is that an external project can use an object of this class, but it cannot instantiate it. Might seem strange, but that's the way it is. The way to change the property from the default value is to select the class module in the VBE Project Explorer, select the class module of interest, access the Properties Window (if necessary, use F4 to make it visible), and change the *Instancing* property to *2-PublicNotCreatable*.

To follow along with the example in this tip, create a class module, name it **clsEmployee**, change its Instancing property, and add the following code to it.

```vb
Option Explicit
Dim sName As String
Property Get Name() As String
    Name = sName
    End Property
Property Let Name(uName As String)
    sName = uName
    End Property
```

Next, since the Instancing property of the class is *PublicNotCreatable*, the project must provide a way for a client to instantiate the object. Add a new function in a standard module:

```vb
Option Explicit
Public Function New_clsEmployee() As clsEmployee
    Set New_clsEmployee = New clsEmployee
    End Function
```

where clsEmployee is the name of the class of interest. Also, this should not be a private module.

One final change will make life a little easier. Rename the project from the default *VBAProject* to *ClassProvider*. To do so, select the project in the VBE Project Explorer, then select Tools | VBAProject Properties… | General tab | and in the *Project Name* field enter *ClassProvider*.

Save this file, say, as *Class Provider.xls*.

Next, move on to the client project.

## Set up the project that will use the exported class

The client project uses the class very much as it would a class defined in any other external library (such as an userform) -- with one key difference. Since it cannot instantiate an object of that class, it must use the New_clsEmployee() function declared above. As with any other external library, decide whether to use early binding or late binding. The code below demonstrates both. Remember that to use the early binding code, the client project must include a reference (Tools | References…) to the *Class Provider.xls* file.

```vb
Option Explicit
Sub UseExportedClass_EarlyBinding()
    Dim anEmployee As ClassProvider.clsEmployee
    Set anEmployee = ClassProvider.New_clsEmployee
    anEmployee.Name = "Tushar Mehta"
    MsgBox anEmployee.Name
    End Sub
Sub UseExportedClass_LateBinding()
    Dim anEmployee As Object
    Set anEmployee = Application.Run("'g:\temp\class provider.xls'!new_clsEmployee")
    anEmployee.Name = "Tushar Mehta"
    MsgBox anEmployee.Name
    End Sub
```

## Final note

The external library doesn't have to be a normally saved file. It can be in a application-specific add-in (such as a file saved with the suffix .xla or .ppa). Just remember that such an add-in is opened not through the normal File | Open… method but loaded with the Tools | Add-Ins… command.