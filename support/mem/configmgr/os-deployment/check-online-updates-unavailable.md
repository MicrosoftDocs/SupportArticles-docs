---
title: No Option to Check Online for Updates from Microsoft Update
description: Fixes an issue in which the Check online for updates from Microsoft Update option is unavailable after upgrading an OS to Windows 11, version 24H2.
ms.date: 03/03/2025
ms.reviewer: kaushika, lamosley
ms.custom: sap:Operating Systems Deployment (OSD)\Task Sequence Step for Applying Windows Settings
---
# "Check online for updates from Microsoft Update" option is unavailable

## Symptoms

After you upgrade an operating system to Windows 11, version 24H2 using a task sequence in Configuration Manager, the **Check online for updates from Microsoft Update** option becomes invisible and unavailable.

## Cause

Before the upgrade, the task sequence engine enables the following local group policy to prevent the client from connecting to Microsoft Update:

- **Do not connect to any Windows Update Internet locations**

  > [!NOTE]
  > The group policy is located under **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows Update** > **Manage updates offered from Windows Server Update Service**.

Once the upgrade is complete and the task sequence finishes, the task sequence disables the group policy. This group policy is controlled by the following registry key:

- Registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate`
- Value name: `DoNotConnectToWindowsUpdateInternetLocations`
- Value data:
  - `1` = **Enabled**
  - `0` = **Disabled**

However, when the registry value is set to `0`, the **Check online for updates from Microsoft Update** option is hidden in Windows 11, version 24H2.

## Resolution

To resolve this issue, change the state of the local group policy to **Not Configured**, which removes the registry value (`DoNotConnectToWindowsUpdateInternetLocations`).
