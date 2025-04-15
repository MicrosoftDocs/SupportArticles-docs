---
title: Troubleshoot Windows Update Error 0x8024002E
description: Learn how to resolve Windows Update error 0x8024002E, indicating that access to an unmanaged server isn't allowed.
ms.date: 04/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---
# Troubleshoot Windows Update error 0x8024002E

Windows Update error 0x8024002E indicates that access to an unmanaged server isn't allowed, typically because the Windows Update Client service is disabled on the server. This document provides steps to identify and resolve this issue.

## Prerequisites

Ensure you have administrative access to the server to modify system settings and policies.

## How to identify the issue

To identify the issue, check the **CBS.log**, **CbsPersist_XXXXXXXXXXXXXX.log**, or **CbsPersist_XXXXXXXXXXXXXX.cab** file for entries similar to the following:

```output
{8F8EA247-1586-48E4-A5F6-1D19A9343341} 2024-04-17 05:14:55:630-0400 1 148 [AGENT_DETECTION_FAILED] 101 {00000000-0000-0000-0000-000000000000} 0
8024002e
Azure VM Guest Patching Failure Software Synchronization Windows Update Client failed to detect with error 0x8024002e.
2024-04-17 08:45:10:060 1084 3a10 Agent *********** Agent: Initializing global settings cache ***********
2024-04-17 08:45:10:060 1084 3a10 Agent * Endpoint Provider: 00000000-0000-0000-0000-000000000000
2024-04-17 08:45:10:060 1084 3a10 Agent * WSUS server: <NULL>
2024-04-17 08:45:10:060 1084 3a10 Agent * WSUS status server: <NULL>
2024-04-17 08:45:10:060 1084 3a10 Agent * Target group: (Unassigned Computers)
2024-04-17 08:45:10:060 1084 3a10 Agent * Windows Update access disabled: Yes
2024-04-17 08:45:10:060 1084 97b0 WuTask WuTaskManager delay initialize completed successfully..
```

## Root cause

The error code 0x8024002E occurs when the Windows Update Client service is disabled, preventing access to unmanaged servers. This issue is often due to a Group Policy setting that disables Windows Update access.

## Resolution or troubleshooting steps

### Enable the Windows Update service

1. Open the **Run** dialog by pressing <kbd>Win</kbd>+<kbd>R</kbd>, type `services.msc`, and press **Enter**.
2. In the **Services** window, locate **Windows Update**.
3. Right-click **Windows Update** and select **Properties**.
4. Set the **Startup type** to **Manual** and select **Start**.
5. Select **OK** to apply the changes.

### Modify the registry key

[!INCLUDE [Registry alert](../../includes/registry-important-alert.md)]

1. Open the **Run** dialog by pressing <kbd>Win</kbd>+<kbd>R</kbd>, type `regedit`, and press **Enter**.
2. Navigate to `HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\DisableWindowsUpdateAccess`.
3. If the value is set to `1`, change it to `0` to enable the service.

   > [!NOTE]
   > We recommend managing this setting via Group Policy if possible.

### Disable the Group Policy

1. Open the **Run** dialog by pressing <kbd>Win</kbd>+<kbd>R</kbd>, type `gpedit.msc`, and press **Enter**.
2. Navigate to `Computer Configuration\Administrative Templates\System\Internet Communication Management\Internet Communication settings\`.
3. Disable the **Turn off access to all Windows Update features** policy.

### Verify manual patching

1. Open **Control Panel** and navigate to **Windows Update**.
2. Try to manually patch the server through the Updates applet.
3. If manual patching fails, collaborate with the Devices and Deployment team for further assistance.

## Next steps

If the issue persists after following these steps and you need further assistance, contact Microsoft Support for further assistance.
