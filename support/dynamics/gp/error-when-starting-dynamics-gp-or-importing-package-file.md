---
title: Error occurs when starting Dynamics GP or importing package file
description: This article describes how to resolve the error that occurs when you start Microsoft Dynamics GP or import a package file with a user form.
ms.reviewer: theley, dlanglie, dclauson
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Errors occurred during load" when starting Dynamics GP or "Class {C62A69F0-16DC-11CE-9E98-00AA00574A4F}" error when importing a package file

This article provides a resolution for the error that occurs when you start Microsoft Dynamics GP or import a package file that has a user form.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 961568

## Symptoms

When you start Microsoft Dynamics GP, you receive the following error message:

> Errors occurred during load.

When you import a `.package` file into Microsoft Dynamics GP with a user form, you receive the following error message:

> Class {C62A69F0-16DC-11CE-9E98-00AA00574A4F} of control frmXXX was not a loaded control class. The file C:\Program Files\Microsoft Dynamics\GP\XXX.frm could not be loaded.

## Cause

This problem may occur because a Windows registry entry for the Fm20.dll file is missing or is incorrect. The correct registration of the Fm20.dll file is required when you work with **UserForms** and form controls.

## Resolution

To resolve this problem, register the Fm20.dll file. To do this, follow these steps:

1. Use Windows Explorer to locate the Fm20.dll file in the Windows\System32 folder or in the Winnt\system32 folder.

   If the Fm20.dll file is not present, copy the Fm20.dll file from the OS\System folder on the Microsoft Office CD to the appropriate location.

2. Exit all the programs that are running.
3. Select **Start**, select **Run**, type regsvr32 C:\Windows\System32\Fm20.dll, and then press Enter.
4. Select **OK**.

    You receive the following message:

    > DllRegisterServer in c:\windows\system\fm20.dll succeeded.
