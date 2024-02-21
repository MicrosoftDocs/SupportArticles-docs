---
title: Multiple operations fail if Windows 8 is improperly identified as a Windows To Go installation
description: Discusses issues that occur when Windows 8 is improperly identified as a Windows To Go installation.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Multiple operations fail if Windows 8 is improperly identified as a Windows To Go installation

This article discusses issues that occur when Windows 8 is improperly identified as a Windows To Go installation.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2778881

## Symptoms

Consider the following scenario:  

- You have a computer that is running Windows 8.
- The Windows may report that it's running as a Windows To Go (WTG) installation, while it's not.
- Running or configuring certain Windows components may fail since the OS is reported as Windows to Go. Since these components aren't expected to work and shouldn't work when running Windows To Go installations.

In this scenario, you may notice the following issues:  

- Refresh your PC fails reporting:

    Your PC can't be refreshed because it's running Windows To Go  

- The Windows To Go control panel reports:

    Can't change startup options when you're in a Windows To Go Workspace  

- Microsoft Store fails with error

    Microsoft Store isn't available on Windows To Go Workspaces  

## Cause

Certain functionality may be blocked from working on Windows To Go Installations as the user experience may not work as desired or expected.

## Resolution

To resolve this problem, change the PortableOperatingSystem registry by editing the Windows registry.

> [!NOTE]
> This section contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base:
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

> [!NOTE]
> The below mentioned steps should only be followed on machines that aren't running as Windows To Go installations.

To check if the installation is running WTG, Open the Disk Management (diskmgmt.msc) and ensure the Hard Drive the OS is installed to isn't seen as a Removable Drive, which may indicate to the OS that it's running in a Windows To Go scenario.

### Prerequisites  

Install the following update and then perform the steps mentioned below:

 [2795944](https://support.microsoft.com/kb/2795944) Windows 8 and Windows Server 2012 cumulative update: February 2013

To change the PortableOperatingSystem registry, follow these steps:

1. Open **Registry editor** (regedit.exe)
2. **Locate** and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`

3. From the right-side pane, double-click on **PortableOperatingSystem** Dword value
4. Change the value data to **0** (The default value is 1)
5. Close the registry editor
6. Restart the computer.

You can also use the command-line option to make the change. Run the below command from an elevated command prompt:

```console
reg add HKLM\SYSTEM\CurrentControlSet\Control /v PortableOperatingSystem /t REG_DWORD /d 0
```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
