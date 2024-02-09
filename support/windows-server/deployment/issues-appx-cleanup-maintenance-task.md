---
title: Issues with AppX cleanup maintenance task
description: Provides workarounds for known issues that involve the AppX cleanup maintenance task in Windows 8.1 and Windows Server 2012 R2.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
---
# Known issues that affect the AppX cleanup maintenance task in Windows 8.1 and Windows Server 2012 R2

This article provides solutions to known issues that involve the AppX cleanup maintenance task.

_Applies to:_ &nbsp; Windows 8.1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2928948

## Introduction

To help reduce your overall disk footprint, after you install Windows 8.1 or Windows Server 2012 R2, a pre-staged AppX cleanup maintenance task is run after 60 minutes of computer use followed by 15 minutes of computer idle time. This scheduled maintenance task recovers disk space after the Windows installation process. To do this, the task deletes App Package (.appx) resource packs based on language, scale, and DirectX feature level (DXFL) that are not currently in use for the current user accounts.

## Symptoms

If you run Sysprep after this AppX cleanup maintenance task, it will log the following warning message in the Setupact log in the C:\Windows\System32\Sysprep folder:

> \<Date> \<Time>, Warning SYSPRP Could not re-arm region selection, some files and registry keys are no longer recoverable.
>
> \<Date> \<Time>, Info SYSPRP Exiting SysprepGeneralize (Appx).

If you capture and deploy this image, the end user may experience the following symptoms:

- The modern apps display scale is used (a high-DPI display instead of a low-DPI display).
- Incorrect display language is used for some modern apps if additional language packs are installed.

> [!NOTE]
> In this situation, the modern apps still function. However, they may not have the necessary resources for the computer.

## Cause

This problem is caused by the deletion of resource packs.

## Workaround

To work around this issue, use one of the following methods.

### Workaround 1

If you are creating an image for deployment, run Sysprep within 75 minutes after the first logon of Windows 8.1 or Windows Server 2012 R2. If you cannot do this, try workaround 2. 

### Workaround 2

Disable the maintenance task immediately after the first logon. To automatically disable the maintenance task, run the following command at an elevated command prompt:

```console
Schtasks.exe /change /disable /tn "\Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup"
```

To automatically disable the maintenance task as part of the Configuration Manager build-and-capture task sequence, insert a new "Run Command Line" step immediately after the "Setup Windows and Configuration Manager" step. This new step uses the following command:

```console
Schtasks.exe /change /disable /tn "\Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup"
```

> [!NOTE]
> Insert this new step only to task sequences that are running Sysprep on Windows 8.1 or Windows Server 2012 R2. Windows will automatically re-enable the maintenance task during the Sysprep generalize phase.

### Workaround 3

If you are creating an image for deployment, start the computer in Sysprep Audit mode to make any configuration changes before you run SysprepGeneralize to capture the image that is mentioned in the "Symptoms" section.

> [!NOTE]
> The scheduled task does not run during Audit mode.

#### Workaround 4

Wait 24 hours for the Store autoupdate process to run. Or, manually search for Store updates.

If you deploy the image that is mentioned in the "Symptoms" section to a computer that requires some of the resource packages that were removed, the required resources are updated automatically if the user who logs in to the computer has access to the Microsoft Store. This update occurs 24 hours after the first logon after Sysprep is used if Microsoft Store connectivity is available. There is a Group Policy setting that disables automatic Microsoft Store updates. This setting prevents the missing resource packs from being restored. If the resource packs are missing, the user must have Microsoft Store access in order to update applicable resource packs for the computer.

## Status

This behavior is by design.

## More information

If you delete the maintenance task, the resources are not deleted and the task is never run. Because the maintenance task is not available after the installation, the resources always use disk space on the computer.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
