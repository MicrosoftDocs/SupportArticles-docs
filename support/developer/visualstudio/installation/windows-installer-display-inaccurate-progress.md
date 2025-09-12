---
title: Windows Installer may display inaccurate progress
description: This article describes that the percentage, progress bar, and time remaining during an install or uninstall is not always accurate.
ms.date: 01/04/2021
ms.custom: sap:Installation\Setup, maintenance, or uninstall
ms.reviewer: 
---
# Windows Installer Packages may display inaccurate progress during Install and Uninstall

This article describes that the percentage, progress bar, and time remaining during an install or uninstall is not always accurate.

_Applies to:_ &nbsp; Windows Installer  
_Original KB number:_ &nbsp; 2533844

## Symptoms

Most installation and uninstalls using Windows Installer service have dialog boxes that show the remaining time. This can be displayed as a percentage, number of minutes and seconds, a progress bar, or a combination.

There are circumstances where the **Standard Windows Installer** progress dialog time estimates will fluctuate and will not show the true time remaining.

## Cause

There are many factors that strongly affect the display, particularly when trying to determine the actual time remaining. For example, having a high quantity of files during an uninstall will impact the calculation. Resources on the target machine also introduce variances since subsystems (CPU, memory, disk speed, and network) will respond at different rates.

## More information

Windows Installer's existing internal UI does not provide the flexibility necessary for unique setups or complex scenarios. Setup authors, who want a UI experience that Windows Installer's internal UI doesn't support, use [MsiSetExternalUIA function (msi.h)](/windows/win32/api/msi/nf-msi-msisetexternaluia) / [MsiSetExternalUIRecord function (msi.h)](/windows/win32/api/msi/nf-msi-msisetexternaluirecord) to initialize and use their custom UI. For information on how to use these APIs to control your own user experience refer to the links below:

- [MsiSetExternalUI Function](/windows/win32/api/msi/nf-msi-msisetexternaluia) and [MsiSetExternalUIRecord Function](/windows/win32/api/msi/nf-msi-msisetexternaluirecord)

- [Using the User Interface](/windows/win32/msi/using-the-user-interface)

You might see similar MSI Verbose logging entries while the dialog displays zero (0) minutes remaining:

> 00503393 52260.63281250 [1560]  
00503394 52261.12109375 [1560] MSI (s) (18:0C) [08:30:23:270]: Verifying accessibility of file: File65053.txt  
00503395 52261.12500000 [1560]  
00503396 52261.62109375 [1560] MSI (s) (18:0C) [08:30:23:770]: Executing op: FileRemove(,FileName=File65054.txt,,ComponentId={041D91CF-DF4B-4945-B8E5-03FBE723ACD2})  
00503397 52261.62500000 [1560]  
00503398 52262.12109375 [1560] MSI (s) (18:0C) [08:30:24:270]: Verifying accessibility of file: File65054.txt  
00503399 52262.12500000 [1560]  
00503400 52262.61718750 [1560] MSI (s) (18:0C) [08:30:24:770]: Executing op: FileRemove(,FileName=File65055.txt,,ComponentId={041D91CF-DF4B-4945-B8E5-03FBE723ACD2})  
00503401 52262.62890625 [1560]  
00503402 52263.11328125 [1560] MSI (s) (18:0C) [08:30:25:270]: Verifying accessibility of file: File65055.txt  
00503403 52263.12109375 [1560]  
00503404 52263.61718750 [1560] MSI (s) (18:0C) [08:30:25:770]: Executing op: FileRemove(,FileName=File65056.txt,,ComponentId={041D91CF-DF4B-4945-B8E5-03FBE723ACD2})  
00503405 52263.62500000 [1560]  
00503406 52264.11718750 [1560] MSI (s) (18:0C) [08:30:26:270]: Verifying accessibility of file: File65056.txt  
00503407 52264.12500000 [1560]  
00503408 52264.61328125 [1560] MSI (s) (18:0C) [08:30:26:770]: Executing op: FileRemove(,FileName=File65057.txt,,ComponentId={041D91CF-DF4B-4945-B8E5-03FBE723ACD2})
00503409 52
