---
title: OneDrive sync error FSLogix_unsupported_environment on VMs
description: The OneDrive sync client can't sync on virtual machines that use FSLogix versions earlier than FSLogix 2009 hotfix 1.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 174101
  - CSSTroubleshoot
ms.reviewer: prbalusu, hdonald
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
  - SPO160
ms.date: 12/17/2023
---
# "FSLogix_unsupported_environment" and OneDrive sync error on virtual machines

## Symptoms

On virtual machines that are configured by using FSLogix, the OneDrive sync client can't sync, and you receive the following error messages:

> OneDrive can't sync  
> Contact your system administrator for help.  
> Error code: FSLogix_unsupported_environment

Additionally, the OneDrive sync client closes after you close the error message window.

## Cause

This issue occurs because the OneDrive sync client is blocked on virtual machines that use FSLogix versions that are earlier than FSLogix 2009 hotfix 1. These earlier versions are no longer supported by Microsoft.

## Resolution

To fix the issue, [download and install the latest version of FSLogix](https://aka.ms/fslogix-latest) on all virtual machines that use the OneDrive sync client.

## More information

Administrators can use one of the following methods to check the version of FSLogix on virtual machines that are running in their environment.

### Check the version of FSLogix on multiple virtual machines

**Note:** The following PowerShell script is provided as is and isn't supported by Microsoft.

Use the [FSLogix Version Validation](https://aka.ms/FSLVersionScript) script.

### Check the version of FSLogix on one virtual machine

- Use the FSLogix FRX command-line tool:

  ```console
  C:\Program Files\FSLogix\Apps\frx.exe version
  ```

- Run the following PowerShell command to get the `InstallVersion` property of the FSLogix registry key:

  ```powershell
  (Get-ItemProperty -Path HKLM:\SOFTWARE\FSLogix\Apps).InstallVersion
  ```

- Run the following PowerShell commands to get the version of Microsoft FSLogix Apps that's installed on the system:

  ```powershell
  $uninstallPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
  $appCheck = Get-ItemProperty -Path $uninstallPath\* | Where-Object { $_.DisplayName -eq "Microsoft FSLogix Apps" }
  ($appCheck | Where-Object {$_.EstimatedSize -eq ($appCheck | Measure-Object -Maximum EstimatedSize).Maximum}).DisplayVersion
  ```
