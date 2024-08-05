---
title: VMMAdminUI has stopped working
description: Resolves an issue that an unexpected error may be thrown when you import a new console add-in.
ms.date: 04/09/2024
ms.reviewer: jarrettr
---
# VMMAdminUI has stopped working error when you import a new console add-in

This article helps you fix an issue in which you receive the **VMMAdminUI has stopped working** error when you import a new console add-in in System Center 2016 Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2016 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3154229

## Symptoms

When you use System Center 2016 Virtual Machine Manager to import a new console add-in, you may receive the following error message:

> VMMAdminUI has stopped working.
>
> A problem caused the program to stop working correctly. Windows will close the program and notify you if a solution is available.

## Cause

It's a known issue. This error occurs if the VMM console doesn't have access to the Program Files folder.

## Workaround 1

1. Copy the console add-in .zip file from the Program Files folder to your desktop or to another location.
2. From the settings workspace of the VMM console, start the Import Console add-in, and then select the .zip file from the new location.

## Workaround 2  

1. Start the VMM console as an administrator. To do it, right-click the icon for the Virtual Machine Manager console, and then select **Run as administrator**.
2. From the **Settings** workspace of the VMM console, start the **Import Console** add-in, and then select the .zip file from the original location.

## More information

For more information, see [Virtual Machine Manager Add-in SDK](/previous-versions/system-center/developer/jj860311(v=msdn.10)).
