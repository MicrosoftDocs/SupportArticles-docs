---
title: There was a problem starting PolicyAgentProvider.dll error installing client 
description: Fixes an issue where you receive There was a problem starting PolicyAgentProvider.dll error when installing a Configuration Manager client.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Client Installation, Registration and Assignment\Client Installation
---
# There was a problem starting PolicyAgentProvider.dll error when installing a Configuration Manager client

This article helps you fix an issue where you receive the **There was a problem starting PolicyAgentProvider.dll** error when installing a Configuration Manager client.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 2737378

## Symptoms

When installing the Configuration Manager (ConfigMgr) client, the process fails with the following error:

> There was a problem starting PolicyAgentProvider.dll The specified module could not be found

You may also see the following in ccmsetup.log after selecting **OK** on the error above:

> MSI: Action 11:53:11: CcmRegisterWmiMofFile. Registering WMI settings  
> MSI: Setup failed due to unexpected circumstances  
> The error code is 80004005  
> MSI: Action 13:01:48: Rollback. Rolling back action:  
> Installation failed with error code 1603

## Cause

This can occur if the value of `CWDIllegalInDllSearch` in the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager` registry subkey is set to **0xFFFFFFFF**.

## Resolution

There are two resolutions to this issue:

- Remove the `CWDIllegalInDllSearch` entry or change it to a different value.

- Add the full path to the CCM folder (C:\Windows\CCM) to the environment variable `PATH`.

## More information

CcmSetup is running the `rundll32.exe PolicyAgentProvider.dll,setup_checknamespaces` command when this failure occurs.

If `CWDIllegalInDllSearch` is configured to **0xFFFFFFFF**, rundll32.exe is unable to find the PolicyAgentProvider.dll when running in the current working directory.
