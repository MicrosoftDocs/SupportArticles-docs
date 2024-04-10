---
title: Confusing description for DefaultValueAttribute
description: This article explains the confusing DefaultValueAttribute class documentation.
ms.date: 05/06/2020
ms.reviewer: sedwards
---
# Documentation for the DefaultValueAttribute class is confusing

This article explains the confusing documentation for the [DefaultValueAttribute](/dotnet/api/system.componentmodel.defaultvalueattribute?view=netcore-3.1&preserve-view=true) class.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 311339

## Summary

The [documentation](/dotnet/api/system.componentmodel.defaultvalueattribute?view=netcore-3.1&preserve-view=true) for the `DefaultValueAttribute` class may be confusing. In particular, this documentation states:  
A member's default value is typically its initial value.

From this, you may conclude that if you set the `DefaultValue` attribute for a property, the property is initialized to that value. However, you should set the property's `DefaultValue` attribute equal to its initialized value.

## More information

The [Extending Metadata Using Attributes](/dotnet/standard/attributes/) topic states:

The common language runtime allows you to add keyword-like descriptive declarations, called attributes, to annotate programming elements such as types, fields, methods, and properties. Attributes are saved with the metadata of a Microsoft .NET Framework file and can be used to describe your code to the runtime or to affect application behavior at run time.

If the property's attribute equals its initialized value, you can access the property's metadata to determine the default value. You can then use this default value to reset the corresponding member variable if necessary. You can also write code generators to use the `DefaultValue` attribute to determine whether code should be generated for the member variable. You must determine if code should be generated for the member variable to set its initial value properly.

However, the `DefaultValue` attribute does not cause the initial value to be initialized with the attribute's value. For example, in the following code sample, the `IsValueSet` property has a default value of **True** and is also initialized to a value of **True**. If not initialized, the initial value of `m_isValueSet` is **False**.

```vb
Imports System.ComponentModel
Public Class DefaultAttributeSample
    ' You must still initialize your member variable to its default value;
    ' the DefaultValue attribute does not do this.
    Private m_isValueSet As Boolean = True
    ' The DefaultValue attribute should be equal to the member's initial
    ' value.
    <DefaultValueAttribute(True)> _
    Public Property IsValueSet() As Boolean
        Get
            IsValueSet = m_isValueSet
        End Get
        Set(ByVal Value As Boolean)
            m_isValueSet = Value
        End Set
    End Property
End Class
```

For more information about how to apply attributes so that they provide metadata to the common language runtime, refer to [Extending Metadata Using Attributes](/dotnet/standard/attributes/).

Because you can display components in a designer such as Visual Studio .NET or Visual Studio, components require attributes that provide metadata to design-time tools.

To display your control and its members correctly at design time, design-time attributes are essential because they provide valuable information to a visual design tool. For example, in the following code fragment, the `CategoryAttribute` attribute enables the property browser to display the `TextAlignment` property in the `Alignment` category. The `DescriptionAttribute` attribute enables the property browser to provide a brief description of the property when a user clicks it.

```csharp
[
    Category ("Alignment"),
    Description ("Specifies the alignment of text.")
]
public ContentAlignment TextAlignment { //... }
```

```vb
<Category("Alignment"), _
Description("Specifies the alignment of text.")> _
Public Property TextAlignment As ContentAlignment
    ' ...
End Property
```

> [!NOTE]
> In Visual C# .NET, Visual Basic .NET, or Visual Basic, you can reference an attribute class named `AttributeNameAttribute` simply as `AttributeName` in the attribute syntax.

## References

For more information, see [Attributes Overview](/dotnet/visual-basic/programming-guide/concepts/attributes/).
