---
title: Dynamics CRM for Outlook Preview Pane does not show
description: Microsoft Dynamics CRM 2011 Outlook client Preview Pane not displaying. Provides a resolution.
ms.reviewer: Kevtunst, aaronric
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM 2011 for Outlook client Preview Pane does not display

This article provides a resolution for the issue that Microsoft Dynamics CRM 2011 for Outlook client Preview Pane doesn't display.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2691482

## Symptoms

You do not see the Microsoft Dynamics CRM 2011 Preview Pane. This problem occurs when the Microsoft Dynamics CRM for Outlook client has corrupt or incorrect values for registry keys on the client machine.

Consider the following scenario:

In the Outlook client on the Activities view, the Preview Pane shows the default Outlook Contact form instead of the Microsoft Dynamics CRM Activity form. The rows in the grid view may also show the incorrect icon.

## Cause

The registry key `DisableFormRegions` on the client machine is set to **2** instead of **0**. Microsoft Dynamics CRM does not alter this key. If this key had been altered, it may have been done by a third party program accessing the key, or possibly a Group Policy change on the key.

## Resolution

To resolve this issue:

1. On the client machine, point to the **Start Menu**, select **Run**, and type *Regedit*.
2. Locate the `DisableFormRegions` key and if present, change the value to **0**. This will then allow form regions for Microsoft Dynamics CRM extensions to work properly.

    For Outlook 2007:  
    `HKCU\Software\Microsoft\Office\12.0\Outlook\Addins`

    For Outlook 2010:  
    `HKCU\Software\Microsoft\Office\14.0\Outlook\Addins`  
    `HKCU\Software\Wow6432Node\Microsoft`  
    `HKCU\Software\Office\Outlook\FormRegions`

    The registry can also be searched from top to bottom by pressing Ctrl+F on keyboard and searching for `DisableFormRegions`.

## More information

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can contact [Microsoft Support](https://support.microsoft.com/contactus).
