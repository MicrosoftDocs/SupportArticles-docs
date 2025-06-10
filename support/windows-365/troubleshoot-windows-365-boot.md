---
title: Troubleshoot Windows 365 Boot
description: Troubleshoot issues that occur when you set up or manage Windows 365 Boot devices.
manager: dcscontentpm
ms.date: 01/20/2025
ms.topic: troubleshooting
ms.reviewer: elluthra, erikje
ms.custom:
- pcy:Windows 365 Boot
- sap:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---

# Troubleshoot Windows 365 Boot

This article provides troubleshooting steps for issues that occur when you set up or manage Windows 365 Boot devices.

## User can't access the Cloud PC from the Windows 365 Boot physical device

If the user can't access the Cloud PC from the Windows 365 Boot physical device, try these troubleshooting steps:

1. Check if you can sign in to the Cloud PC from either:

    - Navigate to [Windows 365](https://windows365.microsoft.com).
    - The Windows App on another (non-Windows 365 Boot) device.

2. If a user has more than one Cloud PC, make sure they have selected a default Cloud PC to use each time they sign in. To set this default:

   1. Navigate to [Windows 365](https://windows365.microsoft.com).
   2. In the card for the Cloud PC you want to set as default, select the ellipses (...) > **Settings**.
   3. In the **Integrated experiences** tab, under **Boot to this Cloud PC**, select **Connect while signed into device**.
   4. Select **Save**.

3. If you can sign in to the Cloud PC from the app or web, and a default Cloud PC has been set, then there's an issue with the Windows 365 Boot physical device. In this case, confirm that the physical device is correctly configured and has the requisite software versions. For more information, see [Windows 365 Boot physical device requirements](/windows-365/enterprise/windows-365-boot-physical-device-requirements).

4. Administrators can try to manually select **Device sync** to get the policies delivered faster on the device. Users can try to restart the device.

## Physical device registry key configuration

Confirm that the physical device is correctly configured to run Windows 365 Boot by setting the following registry keys:

| Registry key name | Registry value name | Registry value |
| --- | --- | --- |
| HKLM\Software\Microsoft\PolicyManager\current\device\CloudDesktop | BootToCloudMode | 1 |
| HKLM\Software\Microsoft\PolicyManager\current\device\WindowsLogon | OverrideShellProgram | 1 |
| HKLM\Software\Microsoft\Windows\CurrentVersion\SharedPC\NodeValues | 18 | 1 |
| HKLM\Software\Microsoft\Windows\CurrentVersion\SharedPC\NodeValues | 01 | 1 |

## Physical device versions of Windows 365, Azure Virtual Desktop Apps, and Windows

Windows 365 Boot requires that the physical device runs specific versions of both Windows 365 and Azure Virtual Desktop (HostApp) apps. To check the installed versions, run the following PowerShell cmdlet as an administrator:

```azurepowershell
Get-AppxPackage -AllUsers -name *MicrosoftCorporationII*
```

This cmdlet shows all the Microsoft-maintained apps (like QuickAssist and Microsoft Family) on the physical device. To make sure Windows 365 Boot works correctly, confirm the following versions:

- Windows App version 2.0.285 or later.
- Azure Virtual Desktop (HostApp) app version 1.2.4159 or later.
- The latest version of Windows 11.

## Remove and add Windows 365 Boot to the physical device again

If you can't identify the source of the issue, try removing and adding Windows 365 Boot to the physical device again.

### Remove Windows 365 Boot from the physical device

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Groups** > **All groups**.
2. Select the group for your Windows 365 Boot devices, and then select **Members**.
3. Select the physical device, and then select **Remove** > **Yes**.
4. Select **Devices** > **All devices**, select the physical device, and then select **Overview** > **Sync**.

It takes up to 8 hours for Intune to complete policy removal. After that, the physical device will no longer be set up for Windows 365 Boot.

### Add Windows 365 Boot back to the physical device

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Groups** > **All groups**.
2. Select the group for your Windows 365 Boot devices, and then select **Members**.
3. Select **Add members** and select the physical device.
4. Wait about 10 minutes.
5. Select **Devices** > **All devices**, select the physical device, and then select **Overview** > **Sync**.

The physical device will again be set up for Windows 365 Boot. Retest it to see if it works.

## Contact Microsoft support

If you still can't troubleshoot the problem, contact Microsoft support. To help expedite a solution, collect logs and session IDs beforehand.

## Collect local logs

Collect Windows 365 and Microsoft Entra ID log information from the following locations:

- **C:\\Users\\\{username}\\AppData\\Local\\Temp\\DiagOutputDir\\Windows365\\Logs**  
- **C:\\Users\\\{username}\\AppData\\Local\\Temp\\DiagOutputDir\\RdClientAutoTrace**

Put these logs in a zip file and provide it to the Microsoft support team for further investigation.

## Windows 365 error and session IDs

When contacting Microsoft support about Windows 365 Boot issues, collect relevant IDs to help in the investigation.

On the physical device, get the CorrelationId, SessionID, or ActivityID.

### Session ID

You can find the Windows 365 Session ID in an error dialog. For example, a **Something went wrong** error dialog.

:::image type="content" source="media/troubleshoot-windows-365-boot/something-went-wrong.png" alt-text="Screenshot that shows the error that contains the Windows 365 session ID." border="false":::

### Correlation ID

You can find the Correlation ID in the interstitial screen displayed during a five-minute time-out.

:::image type="content" source="media/troubleshoot-windows-365-boot/connection-issue.png" alt-text="Screenshot that shows the interstitial screen that contains the Correlation ID." border="false":::

## Next steps

For more information about Windows 365 Boot, see [What is Windows 365 Boot?](/windows-365/enterprise/windows-365-boot-overview).
