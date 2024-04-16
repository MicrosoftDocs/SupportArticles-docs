---
title: Error 1603 installing Configuration Manager client
description: Describes an issue in which installation of Configuration Manager client current branch version 1602 to 1702 or LSTB version 1606 fails on Windows Server 2008 SP2 clients.
ms.date: 12/05/2023
ms.reviewer: kaushika, cmkbreview, yohuang, delhan
ms.custom: sap:Client Installation, Registration and Assignment\Client Installation
---
# Installation of Configuration Manager client version 1602 to 1710 or long-term servicing branch (LSTB) version 1606 fails in Windows Server 2008 SP2

This article provides a solution for the issue that you cannot install the Configuration Manager client current branch versions 1602 through 1710 or LSTB version 1606 on Windows 2008 Service Pack 2 (SP2) clients.

_Original product version:_ &nbsp;  Configuration Manager (LTSB), Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4015968

## Symptoms

On some Windows 2008 SP2 clients, when you try to install the Configuration Manager client current branch versions 1602 through 1710 or LSTB version 1606, client setup fails, and errors that resemble the following are logged.

CCMSetup.log

> MSI: Action 17:56:36: Rollback. Rolling back action:  
> File C:\Windows\ccmsetup\\{CA4329EC-A4F5-4E5E-A9FE-EFAAE88B0D67}\client.msi installation failed. Error text: ExitCode: 1603

ClientMSI.log

> Compiling Sql CE script file: C:\Windows\CCM\StateMessageStore.sqlce into database C:\Windows\CCM\StateMessageStore.sdf
>
> ERROR: Failed to execute SQL statement:
>
> DROP TABLE CCM_StateMsg;
>
> with error (0x80040e37).
>
> WARNING: Failed to compile
>
> DROP TABLE CCM_StateMsg;
>
> . Error code = 0x80040e37.
>
> This script is marked as ignore on failure. Continue with other scripts.  
> Action ended 17:56:36: InstallFinalize. Return value 3.  
> ...
>
> MSI (s) 128 (0x80) Product: Configuration Manager Client -- Installation operation failed.
>
> MSI (s) 128 (0x80) Windows Installer installed the product. Product Name: Configuration Manager Client. Product Version: 5.00.8458.1000. Product Language: 1033. Installation success or error status: 1603.

## Cause

This is caused by the issue in Visual C++ 2013 C runtime described in [Update for Visual C++ 2013 and Visual C++ Redistributable Package](https://support.microsoft.com/help/3179560).

## Resolution

To resolve this issue, manually install the updated version of Visual C++ 2013 Redistributable. After you install the updated Visual C++ 2013 Redistributable package, reinstall the Configuration Manager client.
