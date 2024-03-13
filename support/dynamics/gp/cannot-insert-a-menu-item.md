---
title: Cannot insert a menu item
description: Explains that you can't insert a menu item that is always visible by using Visual Studio Tools for Microsoft Dynamics GP.
ms.reviewer:
ms.date: 03/13/2024
---
# You can't insert a menu item that is always visible by using Visual Studio Tools for Microsoft Dynamics GP

This article discusses that you can't insert a menu item that is always visible by using Visual Studio Tools for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 922871

## Introduction

You can use the AddMenuHandler method on a specific Microsoft Dynamics GP form to add to the menu structure in Microsoft Dynamics GP. This menu item is only visible when the selected Microsoft Dynamics GP form is open. However, you can't insert a menu item that is always visible in Microsoft Dynamics GP.

## More information

For example, the following line of C# code adds a new item to the **Extras** menu that is visible when the Sales Transaction window is open.

```csharp
Dynamics.Forms.SopEntry.AddMenuHandler(new EventHandler(SOPEntryFormHandler), "SOP Menu Item");
```

For version 10.00 of Microsoft Dynamics GP, there's a utility that can be used to add your own entries into the navigation menus of the application.

## References

For more information, read the Visual Studio Tools for Microsoft Dynamics GP Programmer's Guide.
