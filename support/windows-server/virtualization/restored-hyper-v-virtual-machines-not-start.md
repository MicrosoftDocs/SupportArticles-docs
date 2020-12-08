---
title: Restored Hyper-V Virtual Machines Won't Start
description: 
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: chrit
---
# Restored Hyper-V Virtual Machines Won't Start

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 2502233

## Symptoms

If the Backup Application being used to restore a Hyper V Virtual Machine restores a VM to a new Hyper V Host machine the Virtual Machine may not start.

## Cause

The failure to start the Virtual Machine after a successful restore may be caused by the following failures:

1) The network adapater name is not consistent with the new Host

2) There is a conflict in the saved state data from the original Host and the new Host regarding machine configuration (ie video state)

## Resolution

The steps to resolve this are:

1) Open the Hyper-V Management Console.

2) Open *Virtual Network Manager* ** which can be found in the right side pane.

3) Rename the network adapater to the same name as the name used on the New Host.

4) Attempt to start the virtual machine. If it does not start, delete the saved state files for this virtual machine by right clicking on the virtual machine and selecting the *Delete Saved State...* menu item.

5) If step 4 doesn't work then you will have to navigate to the virtual machines folder and locate the appropriate GUID folder and manually delete these files (.bin and .vsv files).

6) The virtual machine should now start.

## More Information

This behavior is expected and by design. Step 4 will resolve the 2nd cause listed, by deleting the saved state data you allow the machine to reset the video state.
