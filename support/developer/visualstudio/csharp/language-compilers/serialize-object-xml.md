---
title: Serialize object to XML by Visual C#
description: This article describes how to serialize an object to XML by using Visual C#. This article also provides some sample steps to explain related information.
ms.date: 04/14/2020
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to serialize an object to XML  

This article provides a method about how to serialize an object to Extensible Markup Language (XML) by using Visual C#.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 815813

## Summary

The method described in this article is useful for persisting the state of an object. The method is also useful for cloning an object by de-serializing the XML back to a new object.

This article refers to the following Microsoft .NET Framework Class Library namespaces:

- `System.Xml`
- `System.Xml.Serialization`

## Requirements

This article assumes that you're familiar with the following topics:

- Visual Studio
- General familiarity with XML
- General familiarity with Visual C#

## XML serialization

Serialization is the process of taking the state of an object and persisting it in some fashion. The .NET Framework includes powerful objects that can serialize any object to XML. The `System.Xml.Serialization` namespace provides this capability.

Follow these steps to create a console application that creates an object, and then serializes its state to XML:

1. In Visual C#, create a new Console Application project.
2. On the **Project** menu, select **Add Class** to add a new class to the project.
3. In the **Add New Item** dialog box, change the name of the class to *clsPerson*.
4. Select **Add**. A new class is created.
5. Add the following code after the public class `clsPerson` statement.

    ```csharp
    public string FirstName;
    public string MI;
    public string LastName;
    ```

6. Switch to the code window for *Program.cs* in Visual Studio.
7. In the `void Main` method, declare and create an instance of the `clsPerson` class:

    ```csharp
    clsPerson p = new clsPerson();
    ```

8. Set the properties of the `clsPerson` object:

    ```csharp
    p.FirstName = "Jeff";
    p.MI = "A";
    p.LastName = "Price";
    ```

9. The `Xml.Serialization` namespace contains an `XmlSerializer` class that serializes an object to XML. When you create an instance of `XmlSerializer`, you pass the type of the class that you want to serialize into its constructor:

    ```csharp
    System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(p.GetType());
    ```

10. The `Serialize` method is used to serialize an object to XML. Serialize is overloaded and can send output to a `TextWriter`, `Stream`, or `XMLWriter` object. In this example, you send the output to the console:

    ```csharp
    x.Serialize(Console.Out,p);
    Console.WriteLine();
    Console.ReadLine();
    ```

## Complete code listing

```csharp
using System;

public class clsPerson
{
    public  string FirstName;
    public  string MI;
    public  string LastName;
}

class class1
{
    static void Main(string[] args)
    {
        clsPerson p=new clsPerson();
        p.FirstName = "Jeff";
        p.MI = "A";
        p.LastName = "Price";
        System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(p.GetType());
        x.Serialize(Console.Out, p);
        Console.WriteLine();
        Console.ReadLine();
    }
}
```

## Verification

To verify that your project works, press CTRL+F5 to run the project. A `clsPerson` object is created and populated with the values that you entered. This state is serialized to XML. The console window shows the following code:

```xml
<?xml version="1.0" encoding="IBM437"?>
<clsPerson xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <FirstName>Jeff</FirstName>
    <MI>A</MI>
    <LastName>Price</LastName>
</clsPerson>
```

## Troubleshoot

The `Xml.Serialization.XmlSerializer` object performs only shallow serialization. If you also want to serialize the private variables of an object or child objects, you must use deep serialization.
