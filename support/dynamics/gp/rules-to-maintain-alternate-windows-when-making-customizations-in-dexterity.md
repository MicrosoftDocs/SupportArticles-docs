---
title: Rules to keep alternate windows when making customizations in Dexterity
description: Describes how to maintain alternate windows when you make customizations in Dexterity in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/13/2024
---
# Rules to maintain alternate windows when you make customizations in Dexterity in Microsoft Dynamics GP

This article describes the rules that are used to maintain alternate windows when you make customizations in Dexterity in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929211

## More information

When you make customizations in Dexterity in Microsoft Dynamics GP, you may have to change existing windows in the core Dynamics.dic dictionary. These modified windows become alternate windows when they are transferred to the extracted dictionary. The windows are transferred when a chunk file is created. In alternate windows, scripts may be added to existing fields, windows, or form events.

You can experience difficulty when you maintain an alternate window because you cannot easily know what scripts have been added to the window. If the window changes significantly between versions, you may have to remake the changes that you made to the original window. If a previous script change is not maintained, the code may not work correctly.

To make it easier to maintain an alternate window, follow these rules:

- Never change or add scripts on an alternate window.
- Only make layout changes to an alternate window.
- Use triggers to add scripts to fields, to windows, and to form events.
- Determine whether the alternate window is being used. If the window is not being used, stop the trigger scripts to prevent illegal address errors.

Use triggers to see and to maintain all the scripts easily because triggers are global procedures. If the alternate windows do not upgrade correctly, you can remake the layout changes that you made to the original window. If you do not add a particular field, one or more of the scripts that handle triggers will not compile successfully. Therefore, use triggers to avoid missing any fields.

> [!NOTE]
> We recommend that you avoid having alternate windows because you can have only one alternate version of a window active at a time. If two customizations have alternate versions of the same window, only the window that is set up in the Security window will be active. To avoid having alternate windows, use triggers or a synchronized third-party window.

## References

For more information about how to create a chunk file from a development dictionary, see [How to create a chunk file in Dexterity in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-create-a-chunk-file-in-dexterity-in-microsoft-dynamics-gp-1da8009b-b957-3a4c-b177-9204dbef9b64).
