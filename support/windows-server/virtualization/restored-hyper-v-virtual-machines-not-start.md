---
title: Restored Hyper-V virtual machines won't start
description: Provides a solution to an issue where Hyper-V virtual machines that are restored to a new Hyper-V Host machine won't start.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, chrit
ms.custom: sap:virtual-machine-will-not-boot, csstroubleshoot
ms.technology: hyper-v
---
# Restored Hyper-V virtual machines won't start

This article provides a solution to an issue where Hyper-V virtual machines that are restored to a new Hyper-V Host machine won't start.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2502233

## Symptoms

If the Backup Application being used to restore a Hyper-V virtual machine restores a virtual machine to a new Hyper-V Host machine, the virtual machine may not start.

## Cause

The failure to start the virtual machine after a successful restore may be caused by the following failures:

- The network adapter name is not consistent with the new Host

- There is a conflict in the saved state data from the original Host and the new Host regarding machine configuration (for example, video state).

## Resolution

1. Open the Hyper-V Management Console.

2. Open **Virtual Network Manager** that can be found in the right side pane.

3. Rename the network adapter to the same name as the name used on the New Host.

4. Attempt to start the virtual machine. If it does not start, delete the saved state files for this virtual machine by right-clicking on the virtual machine and selecting the **Delete Saved State...** menu item.

5. If step 4 doesn't work, then you will have to navigate to the virtual machines folder and locate the appropriate GUID folder and manually delete these files (.bin and .vsv files).

6. The virtual machine should now start.

## More information

This behavior is expected and by design. Step 4 in the [Resolution](#resolution) section will resolve the second cause listed in the [Cause](#cause) section, by deleting the saved state data you allow the machine to reset the video state.
