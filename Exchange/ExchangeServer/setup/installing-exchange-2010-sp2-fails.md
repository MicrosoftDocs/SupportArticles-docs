---
title: AuthorizationManager check failed
description: Describes an issue that can occur when you try to install Exchange Server 2010 SP2.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: patkling, v-six
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
ms.date: 01/24/2024
---
# Error message when you try to install Exchange Server 2010 SP2: AuthorizationManager check failed

_Original KB number:_ &nbsp; 2668686

## Symptoms

Consider the following scenario:

- You install Exchange Server 2010 or Exchange Server 2010 Service Pack 1 (SP1).
- You use the Group Policy Management Console (GPMC) or the Local Group Policy Editor (Gpedit.msc) to create a Group Policy Object (GPO) or a local policy.
- The GPO or the local policy sets the Windows PowerShell Execution policy to a status other than **Undefined**.
- You install Exchange Server 2010 SP2.

In this scenario, the installation fails, and you receive an error message that resembles the following:

> The following error was generated when "$error.Clear();  
> & $RoleBinPath\ServiceControl.ps1 EnableServices Critical  
> " was run: "AuthorizationManager check failed.".  
> AuthorizationManager check failed.

When this error occurs, Exchange Server 2010 does not work and is not listed in **Add or Remove Programs**. Additionally, you cannot reinstall Exchange Server 2010.

## Cause

This issue occurs because the Windows Management Instrumentation (WMI) service is stopped during the installation process. Therefore, the ServiceControl.ps1 Windows PowerShell script that runs as part of the Exchange Server 2010 SP2 installation process cannot call the WMI service to verify the execution permissions.

## Resolution

To resolve this issue, follow these steps:

1. Recover the server that is running Exchange Server 2010. For more information about how to recover a server that is running Exchange Server 2010, see [Recover Exchange servers](/Exchange/high-availability/disaster-recovery/recover-exchange-servers).

2. Use the GPMC or the Gpedit.msc to turn off the GPO or the local policy.
3. Install Exchange Server 2010 SP2.
4. Set the execution policy for the `LocalMachine` scope to `RemoteSigned`. To do this, run the following cmdlet:

    ```powershell
    Set-ExecutionPolicy RemoteSigned -scope LocalMachine
    ```

## More information

To verify the execution policies before you begin the installation, run the following Windows PowerShell cmdlet:

```powershell
Get-ExecutionPolicy -list
```

The output should resemble the following:

```console
Scope ExecutionPolicy
----- ---------------
MachinePolicy Undefined
UserPolicy Undefined
Process Undefined
CurrentUser Undefined
LocalMachine RemoteSigned
```

If any of the following scopes are set to a status other than Undefined, refer to the steps in the [Resolution](#resolution) section before you install Exchange Server 2010 SP2:

- MachinePolicy
- UserPolicy
- Process
- CurrentUser

If the `LocalMachine` scope is set to Undefined, you may receive an error message that resembles the following when you start the Exchange Management Console (EMC):

> Exception calling "GetSteppablePipeline" with "1" argument(s): "File C:\Program Files\Microsoft\Exchange Server\V14\RemoteScripts\ConsoleInitialize.ps1 cannot be loaded because the execution of scripts is disabled on this system. Please see "get-help about_signing" for more details."

Additionally, you may receive an error message that resembles the following when you start the Exchange Management Shell (EMS):

> The term 'Connect-ExchangeServer' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.

> [!NOTE]
> When this issue occurs, Exchange Server 2010 works as expected even though you cannot start the EMC or the EMS.

## References

[You cannot install an update rollup for Exchange Server 2010 with a deployed GPO that defines a PowerShell execution policy for the server to be updated](https://support.microsoft.com/help/2467565)
