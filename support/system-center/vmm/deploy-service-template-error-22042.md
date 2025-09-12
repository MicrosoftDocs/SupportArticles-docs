---
title: Error 22042 deploying a service template
description: Fixes an issue in which you receive error 22042 when you deploy a service template in System Center 2012 Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# Deploying a service template in SCVMM 2012 using a Windows core VHD fails

This article fixes an issue in which you receive error 22042 when you deploy a service template in System Center 2012 Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2680242

## Symptoms

When attempting to deploy a service template in System Center 2012 Virtual Machine Manager using a Windows core virtual hard disk (VHD), the process fails with the following errors:

> Error (22042)  
> The service was not successfully deployed. Review the event log to determine the cause before you take corrective action.  
>
> Recommended Action  
> The deployment can be restarted by retrying the job.
>
> Information (21947)  
> The script command (dism.exe dism.exe /online /NoRestart /enable-feature /featurename:NetFx2-ServerCore /featurename:MicrosoftWindowsPowerShell /featurename:ServerManager-PSH-Cmdlets) was executed on the computer and returned a result exit code (87).  
>
> Error (22010)  
> VMM failed to enable Server Manager PowerShell on the guest virtual machine. Please log into the virtual machine and look in the event logs (%WINDIR%\Logs\Dism\dism.log).

## Cause

This is by design. Service templates using Windows core operating systems are not currently supported.

## Resolution

The following workarounds are available:

- Enable all the roles or features in the virtual machine prior to creating the Sysprep VHD.
- Run `DISM.exe` as part of the application deployment using a pre-install script.

  - **Executable program**: `C:\Windows\system32\dism.exe`
  - **Parameters**: `/online /norestart /enable-feature /featurename:NetFx2-ServerCore /featurename:NetFx3-ServerCore /featurename:DNS-Server-Core /featurename:DirectoryServices-DomainController-ServerFoundation`
  - **Timeout**: 240 seconds
