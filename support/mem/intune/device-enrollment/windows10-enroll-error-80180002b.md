---
title: Troubleshoot Windows 10 Intune auto-enrollment error 80180002b
description: Fixes an issue in which Windows 10 Group Policy-based auto-enrollment to Microsoft Intune fails with the error code 0x80180002b in Event Viewer.
ms.date: 02/11/2025
search.appverid: MET150
ms.custom: sap:Enroll Device - Windows\AutoEnrollment
ms.reviewer: kaushika, luche
---
# 80180002b error during Windows 10 Group Policy-based auto-enrollment to Intune

This article helps you fix an issue in which Windows 10 Group Policy-based auto-enrollment to Intune fails with the error code 0x80180002b in Event Viewer.

## Symptoms

When you try to [enroll a Windows 10 device automatically by using Group Policy](/windows/client-management/mdm/enroll-a-windows-10-device-automatically-using-group-policy), you experience the following issues:

- In Event Viewer, the following event is logged under `Applications and Services Logs/Microsoft/Windows/DeviceManagement-Enterprise-Diagnostics-Provider/Admin`:

  ```output
  Log Name: Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin  
  Source: DeviceManagement-Enterprise-Diagnostics-Provider  
  Event ID: 76  
  Level: Error  
  Description: Auto MDM Enroll: Failed (Unknown Win32 Error code: 0x80180002b)
  ```

- When you run the `dsregcmd /status` command on the affected device, the value of `AzureAdPrt` is **NO**. This indicates that the user isn't authenticated to Microsoft Entra ID when signing in to the device.

  Additionally, the values of `TenantId` and `AuthCodeUrl` are incorrect.

## Cause

This issue occurs when the device was previously joined to a different tenant and didn't unjoin from the tenant correctly. In this case, the values of the following registry key still contain the information about the old tenant:

`HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\CloudDomainJoin\TenantInfo\<TenantId>`

The `AuthCodeUrl` and `AccessTokenUrl` values in those registry keys are used to get a Primary Refresh Token (PRT). Because the values are incorrect, `AzureAdPrt` is set to **NO**.

## Solution

Use the following steps to fix the issue.

1. On the affected device, open an elevated Command Prompt window, and then run the `dsregcmd /leave` command.
1. Delete the device in Microsoft Entra ID.
1. Unjoin the device from your on-premises Active Directory domain. Then, delete the device object from the domain controller.
1. Rejoin the device to your on-premises Active Directory domain. Then, manually initiate a sync cycle by running the following PowerShell cmdlet:

   ```PowerShell
   Start-ADSyncSyncCycle -PolicyType Delta
   ```

1. Run the `dsregcmd /status` command on the device, and verify that both `AzureAdJoined` and `DomainJoined` are set to **YES**.
1. Sign out from the device, then sign in again to get a PRT.
1. Run the `dsregcmd /status` command on the device, and verify that `AzureAdPrt` is set to **YES** and the tenant information is correct.
1. Run the `gpupdate /force` command to force an update of all Group Policy settings. Then, verify that the device is successfully enrolled in Intune.
