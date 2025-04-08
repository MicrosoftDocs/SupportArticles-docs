---
title: Troubleshoot Windows Update Error Code 0x8024002E
description: Learn how to resolve the Windows Update error code 0x8024002E indicating that access to an unmanaged server is not allowed.
ms.date: 04/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: ''
ms.custom:
- sap:add_sap
- pcy:add_pcy
---
# Troubleshoot Windows Update Error Code 0x8024002E

**Applies to:** :heavy_check_mark: Windows VMs

The Windows Update error code 0x8024002E indicates that access to an unmanaged server is not allowed, typically because the Windows Update Client service is disabled on the server. This document provides steps to identify and resolve this issue.

## Prerequisites

Ensure you have administrative access to the server to modify system settings and policies.

## How to Identify the Issue

To identify the issue, check the CBS.log for entries similar to the following:

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

## Root Cause

The error code 0x8024002E occurs when the Windows Update Client service is disabled, preventing access to unmanaged servers. This is often due to a Group Policy setting that disables Windows Update access.

## Resolution or Troubleshooting Steps

### Enable Windows Update Service

1. Open the **Run** dialog by pressing `Win + R`, type `services.msc`, and press **Enter**.
2. In the **Services** window, locate **Windows Update**.
3. Right-click **Windows Update** and select **Properties**.
4. Set the **Startup type** to **Automatic** and click **Start**.
5. Click **OK** to apply the changes.

### Modify Registry Key

1. Open the **Run** dialog by pressing `Win + R`, type `regedit`, and press **Enter**.
2. Navigate to the following registry key:
   - `HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\DisableWindowsUpdateAccess`
3. If the value is set to `1`, change it to `0` to enable the service.
4. It's recommended to manage this setting via Group Policy if possible.

### Disable Group Policy

1. Open the **Run** dialog by pressing `Win + R`, type `gpedit.msc`, and press **Enter**.
2. Navigate to:
   - `Computer Configuration\Administrative Templates\System\Internet Communication Management\Internet Communication settings\`
3. Disable the policy **Turn off access to all Windows Update features**.

### Verify Manual Patching

1. Open **Control Panel** and navigate to **Windows Update**.
2. Attempt to manually patch the server through the Updates applet.
3. If manual patching fails, collaborate with the Devices and Deployment team for further assistance.

## Next Steps

If the issue persists after following these steps, contact the team supporting the Windows Update client for further assistance.

**Partial Use of AI disclaimer**

Certain sections of this document have been generated or enhanced using artificial intelligence (AI) technology.
