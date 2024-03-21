---
title: Measure-Object not found error with Enter-PSSession cmdlet
description: Enter-PSSession unexpectedly terminates when a network path is specified in PSModulePath.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, Gbrag, jerrycif
ms.custom: sap:System Management Components\PowerShell, csstroubleshoot
---
# Enter-PSSession cmdlet fails when network path is specified in PSModulePath environment variable

This article provides a resolution to an issue that `Enter-PSSession` unexpectedly terminates when a network path is specified in PSModulePath.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4076842

## Symptom

When a network path is specified in the **PSModulePath** environment variable, the `Enter-PSSession` cmdlet fails, and you receive the following error message:

> Enter-PSSession: The 'Measure-Object' command was found in the module 'Microsoft.PowerShell.Utility', but the module
could not be loaded. For more information, run 'Import-Module Microsoft.PowerShell.Utility'.  
At line:1 char:1  
\+ Enter-PSSession server_name  
\+ ~~~~~~~~~~~~~~~~~~~~~~~~  
\+ CategoryInfo : ObjectNotFound: (Measure-Object:String) [Enter-PSSession], CommandNotFoundException  
\+ FullyQualifiedErrorId : CouldNotAutoloadMatchingModule

## Cause

When a PowerShell session is created and authenticates through Kerberos, the session doesn't support double hop. So, the PowerShell session can't authenticate by using network resources.  

When PowerShell tries to enumerate the modules in the network path, the operation fails with the Access Denied error, and the command unexpectedly terminates.

## Resolution

To fix the issue, create the PowerShell session to authenticate with CredSSP. It needs to be configured in advance. On the computer that is the target of the `Enter-PSSession` command, run this command:

```powershell
Enable-WSManCredSSP -Role Server
```

On the computer on which you run the `Enter-PSSession` command, run this command:

```powershell
Enable-WSManCredSSP -Role Client -DelegateComputer Server_name  
```

> [!NOTE]
> *Server_name* is the name of the computer that is the target of the `Enter-PSSession` command.

Every time that this command is executed, the specified Server_name is added to the list. The list is stored in the following registry subkey:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentials`

To view the status of the CredSSP configuration, run the `Get-WSManCredSSP` command.

After CredSSP is enabled, you can authenticate through CredSSP by using this command:

```powershell
Enter-PSSession server_name -Authentication CredSSP -Credential (Get-Credential user_name)
```

## Workaround

To work around this issue, map the network share to a drive letter such as `S:`, and then put the drive letter in the `PSModulePath`. Having a drive letter that points to a network share won't cause the unexpected termination of `Enter-PSSession`.  

However, inside the remote PowerShell session the mapped drive letter won't be available, and the modules on the network share will still not be available. Only the local modules will be available.  

This workaround will only prevent the `Enter-PSSession` from crashing while allowing normal PowerShell sessions to have access to the modules that are on the network share.
