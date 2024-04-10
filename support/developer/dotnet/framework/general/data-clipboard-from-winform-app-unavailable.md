---
title: Data on clipboard from Windows Forms app unavailable
description: This article provides information about resolving a problem where the data placed on clipboard from Windows Forms Application is unavailable.
ms.date: 05/11/2020
---
# Data placed on clipboard from Windows Forms Application is unavailable

This article helps you resolve the problem where the data placed on clipboard from an Windows Forms application is unavailable.

_Original product version:_ &nbsp; Microsoft .NET Framework 4.0  
_Original KB number:_ &nbsp; 2843635

## Symptoms

You've developed an application using the Microsoft .NET Framework 4.0. The application creates a new `System.Windows.Forms.DataObject` using an unregistered clipboard format, and then calls the `System.Windows.Forms.Clipboard`.`SetDataObject` method to place the custom `DataObject` on the Windows Clipboard. On an intermittent basis, applications are unable to retrieve the contents of this custom `IDataObject` from the Clipboard. For example, calling `System.Windows.Forms.Clipboard.GetDataObject` using the specified clipboard format returns null, instead of the expected `System.Windows.Forms.DataObject` previously placed on the Clipboard.

## Cause

It's because of a bug in the Microsoft .NET Framework 4.0.

## Resolution

This bug has been corrected in the Microsoft .NET Framework 4.5.

## More information

The Windows operating system registers Clipboard format ID's as unsigned 16-bit integers with the leading bit set. In Microsoft .NET Framework 4.0, the Windows Forms implementation caches the Format ID's in an internal list as signed 32-bit integers. When an application calls into the Windows Forms `IDataObject::GetData` method to retrieve an `IDataObject` for a specified format, Windows Forms iterates over its internal list comparing the requested format ID (as an unsigned16-bit integer) with the cached format ID (stored as a 32-bit signed integer). Without the proper casts, the comparison fails and the expected Format isn't returned. Which eventually leads to the Windows Forms `IDataObject::GetData` returning null to the caller.
