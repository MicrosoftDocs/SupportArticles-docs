---
title: Exception when selecting row in WPF DataGrid
description: ArgumentException occurs when you select rows in WPF DataGrid. This article provides a resolution.
ms.date: 05/07/2020
---
# System.ArgumentException when selecting rows in WPF DataGrid

This article provides a resolution to resolve the `System.ArgumentException` that occurs when you select rows in WPF DataGrid controls.

_Original product version:_ &nbsp; Microsoft .NET Framework 4.5  
_Original KB number:_ &nbsp; 2909048

## Symptoms

You've developed a Microsoft .NET Framework 4.x application that uses the Windows Presentation Foundation (WPF) DataGrid control. The DataGrid control's **ItemsSource** property is bound to a collection of custom objects. After modifying values for a row in the DataGrid control, and selecting a different row, you receive the following exception and callstack. This behavior only occurs when running the application on a computer with Microsoft .NET Framework 4.5 or later installed.

> System.ArgumentException was unhandled  
> HResult=-2147024809  
> Message=An item with the same key has already been added.  
> Source=mscorlib  
> StackTrace:  
> at System.ThrowHelper.ThrowArgumentException(ExceptionResource resource)  
> at System.Collections.Generic.Dictionary 2.Insert(TKey key, TValue value, Boolean add)  
> at System.Collections.Generic.Dictionary 2..ctor(IDictionary 2 dictionary, IEqualityComparer 1 comparer)  
> at System.Windows.Controls.Primitives.Selector.InternalSelectedItemsStorage..ctor(InternalSelectedItemsStorage collection, IEqualityComparer 1 equalityComparer)  
> at System.Windows.Controls.Primitives.Selector.SelectionChanger.ApplyCanSelectMultiple()  
> at System.Windows.Controls.Primitives.Selector.SelectionChanger.End()  
> at System.Windows.Controls.SelectedItemCollection.EndUpdateSelectedItems()  
> at System.Windows.Controls.Primitives.MultiSelector.EndUpdateSelectedItems()  
> at System.Windows.Controls.DataGrid.MakeFullRowSelection(ItemInfo info, Boolean allowsExtendSelect, Boolean allowsMinimalSelect)

## Cause

The DataGrid's **ItemsSource** is bound to a collection of custom objects, whose type definition has overridden the [Object.GetHashCode](/dotnet/api/system.object.gethashcode?&view=netcore-3.1&preserve-view=true) method. The overridden `GetHashCode` method has an incorrect implementation that computes a hash based on mutable properties in the class. This is an application bug, which is exposed in Microsoft .NET Framework 4.5 and later. In Microsoft .NET Framework 4.5, the implementation for the WPF `Selector` class was changed to make more extensive use of HashTables; in order to gain performance benefits.

## Resolution

Modify the custom object's type definition to abide by the guidelines of overriding `GetHashCode`.

## More information

If a type computes its hash by relying on mutable properties, and the values of one or more of the mutable properties changes; then the computed hash returned from its overridden `GetHashCode` method also changes. If this takes place while the object is stored in WPF's internal HashTable, then it's no longer retrievable based on the original hash. WPF detects that the object isn't available from the HashTable, and adds it again based on the new hash. It then attempts to insert related `Selector` data into an internal Dictionary using a key. However, an exception occurs because an item with that key had already been added previously to the Dictionary.

You should override `GetHashCode` only if:

- You can compute the hash code from fields that aren't mutable; or
- You can ensure that the hash code of a mutable object doesn't change while the object is contained in a collection that relies on its hash code.
