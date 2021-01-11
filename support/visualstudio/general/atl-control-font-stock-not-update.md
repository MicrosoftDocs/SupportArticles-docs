---
title: ATL control font stock property doesn't update
description: You create an ATL ActiveX control with a Font stock property. When this control is added to a dialog in the Visual Studio dialog editor and you change the font with the dialog editor properties window, the ATL control does not update with the new font.
ms.date: 04/27/2020
ms.prod-support-area-path: Integrated development environment (IDE)
ms.reviewer: shorne, scotbren
---
# ATL control font stock property doesn't update in Visual Studio Resource Editor

This article helps you resolve a problem where the Active Template Library (ATL) control doesn't automatically update with the new font when you change the font in the dialog editor properties window.

_Original product version:_ &nbsp; Visual Studio Professional 2010  
_Original KB number:_ &nbsp; 2481467

## Symptoms

You create an ATL ActiveX control with a font stock property. When this control is added to a dialog in the Visual Studio dialog editor and you change the font with the dialog editor properties window, the ATL control doesn't automatically update with the new font.

## Cause

It is a bug in the Resource Editor for Visual Studio. The update event for the stock property is not fired when the font property is changed and the font displayed by the control is therefore not updated.

## Resolution

You can change some other control properties to cause the control to update. For instance, change the **size** or **background color** of the control (and then change it back). It will force an update of the control and the new font will be used when the control is redrawn.

## Status

It is a bug in the Visual Studio Resource Editor and is under investigation for a possible fix in a future version of Visual Studio.
