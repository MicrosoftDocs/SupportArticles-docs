---
title: 0x80070BC9 error when installing MSI package
description: Describes an issue that occurs during Windows Setup or a hotfix installation.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:msi, csstroubleshoot
---
# "HRESULT: 0x80070BC9" error message while you're installing an MSI package during Windows setup or hotfix installation

This article provides help to fix the 0x80070BC9 error that occurs when you're installing an MSI package during Windows setup or hotfix installation.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 3024471

## Symptoms

While you're installing an MSI package, you may receive an error message that resembles the following:

> Installation of assembly component {guid id} failed HRESULT: 0x80070BC9. \<Ok>

If you capture an MSI log, you see the following "more information" pointer to the CBS log:

> MSI (s) (1C:38) \<DateTime>: Note: 1: 1935 2: {matching guid id} 3: 0x80070BC9 4:
>
> MSI (s) (1C:38) \<DateTime>: Assembly Error (sxs): Look into Component Based Servicing Log located at 1608941560ndir\logs\cbs\cbs.log to get more diagnostic information.

If you examine the CBS log, you may also see a message whose time stamp corresponds to the time of the failure:  

> \<DateTime>, Error CSI 00001928 (F) Impactful transactions are disabled at this time, cannot continue.[gle=0x80004005]

> [!NOTE]
> This issue may occur under any of the following conditions:  
>
> - During certain hotfix installations
> - During an installation for which someone has pre-created the installation image  
> - If you are incorporating an MSI installer package in an unattended installation.

## Cause

As the CBS log indicates, the operating system disables transactions that may affect the system. These transactions include MSI packages that may be trying to run at this point.

## Resolution

To resolve this issue, restart the system, and then run the MSI installation manually after the Setup program is complete.  

## More information

You may also encounter this issue when you install certain system updates or hotfixes. Typically, a restart will be required to complete the update installation. If the restart is postponed, the system tries to install MSI packages during this time, and you may encounter a situation that will prevent the MSI package installation.

After you encounter this issue, it will not be resolved unless you restart the computer and make sure that the change is applied.
