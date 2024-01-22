---
title: Microsoft Silverlight add-on issue
description: This article describes that in the add-on management item function of Internet Explorer, the Microsoft Silverlight add-on is listed as not verified, which is by design.
ms.date: 06/03/2020
ms.reviewer: yechen
---
# The Microsoft Silverlight add-on is listed as not verified in Microsoft Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2406108

## Symptoms

You install Microsoft Silverlight in Internet Explorer. Next, you open the **Manage Add-ons** feature in Internet Explorer and view the Silverlight add-on information. The publisher is listed as **(Not verified) Microsoft Corporation**.

## Cause

This behavior occurs because while the installation package of Microsoft Silverlight is digitally signed, the add-on file **npctrl.dll** isn't digitally signed. Internet Explorer checks the digital signature of the control's binary file when it determines the publisher. If the signature is missing, the publisher information will be listed as **Not verified**.

## Resolution

This is a behavior by design.

## More information

The installation package of Microsoft Silverlight is digitally signed. This ensures the add-on is installed from an identified resource. For more information, see [Manage add-ons in Internet Explorer 11](https://support.microsoft.com/help/17447/windows-internet-explorer-11-manage-add-ons).
