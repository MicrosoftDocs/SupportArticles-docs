---
title: AuthorizationManager check failed error during Exchange Server installation
description: Describes an issue that can occur when you try to install Exchange Server
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: patkling, v-six, v-kccross
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11509
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 05/27/2026
---

# AuthorizationManager check fails when you install Exchange Server

_Original KB number:_ &nbsp; 2668686

## Summary

This article describes an Exchange Server installation failure that returns an AuthorizationManager check failed error when a Group Policy or local policy sets the Windows PowerShell execution policy to a value other than Undefined. The issue occurs because the WMI service stops during installation, which prevents Exchange setup scripts from validating execution permissions. To resolve the issue, disable the policy, reinstall Exchange Server, and set the execution policy for the LocalMachine scope to RemoteSigned.

## Symptoms

Consider the following scenario:

- You install Exchange Server.
- You use the Group Policy Management Console (GPMC) or the Local Group Policy Editor (Gpedit.msc) to create a Group Policy Object (GPO) or a local policy.
- The GPO or the local policy sets the Windows PowerShell Execution policy to a status other than **Undefined**.

The installation fails, and you receive an error message similar to the following message:

> The following error was generated when "$error.Clear();  
> & $RoleBinPath\ServiceControl.ps1 EnableServices Critical  
> " was run: "AuthorizationManager check failed.".  
> AuthorizationManager check failed.

When this error occurs, Exchange Server doesn't work and isn't listed in **Add or Remove Programs**. Also, you can't reinstall Exchange Server.

## Cause

This issue occurs because the Windows Management Instrumentation (WMI) service stops during the installation process. Therefore, the `ServiceControl.ps1` Windows PowerShell script that runs as part of the Exchange Server installation process can't call the WMI service to verify the execution permissions.

## Resolution

To resolve this issue, follow these steps:

1. Recover the server that's running Exchange Server. For more information about how to recover a server that's running Exchange Server, see [Recover Exchange servers](/Exchange/high-availability/disaster-recovery/recover-exchange-servers).
1. Use the GPMC or the `Gpedit.msc' to turn off the GPO or the local policy.
1. Install Exchange Server.
1. Set the execution policy for the `LocalMachine` scope to `RemoteSigned`. Run the [Set-ExecutionPolicy](/powershell/module/microsoft.powershell.security/set-executionpolicy) Windows PowerShell cmdlet:

    ```powershell
    Set-ExecutionPolicy RemoteSigned -scope LocalMachine
    ```

## More information

To verify the execution policies before you begin the installation, run the [Get-ExecutionPolicy](/powershell/module/microsoft.powershell.security/get-executionpolicy) Windows PowerShell cmdlet:

```powershell
Get-ExecutionPolicy -list
```

The output should resemble the following text:

```console
Scope ExecutionPolicy
----- ---------------
MachinePolicy Undefined
UserPolicy Undefined
Process Undefined
CurrentUser Undefined
LocalMachine RemoteSigned
```

If any of the following scopes are set to a status other than Undefined, refer to the steps in the [Resolution](#resolution) section before you install Exchange Server:

- MachinePolicy
- UserPolicy
- Process
- CurrentUser

If the `LocalMachine` scope is set to Undefined, you might receive an error message that resembles the following when you start the Exchange Management Console (EMC):

> Exception calling "GetSteppablePipeline" with "1" argument(s): "File C:\Program Files\Microsoft\Exchange Server\V14\RemoteScripts\ConsoleInitialize.ps1 cannot be loaded because the execution of scripts is disabled on this system. Please see "get-help about_signing" for more details."

Additionally, you might receive an error message that resembles the following when you start the Exchange Management Shell (EMS):

> The term 'Connect-ExchangeServer' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.

When this issue occurs, Exchange Server works as expected even though you can't start the EMC or the EMS.

## References

[You cannot install an update rollup for Exchange Server with a deployed GPO that defines a PowerShell execution policy for the server to be updated](https://support.microsoft.com/help/2467565).
