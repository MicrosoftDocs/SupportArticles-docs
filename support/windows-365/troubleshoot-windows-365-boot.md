---
title: Troubleshoot Windows 365 Boot
description: Troubleshoot issues that occur when you set up or manage Windows 365 Boot devices.
manager: dcscontentpm
ms.date: 03/06/2026
ms.topic: troubleshooting
ms.reviewer: elluthra, erikje
ms.custom:
- pcy:WinComm User Experience
- sap:Windows 365 Boot
ms.collection:
- M365-identity-device-management
- tier2
appliesto:
- ✅ <a href=https://learn.microsoft.com/lifecycle/products/windows-365target=_blank>Supported versions of Windows 365</a>
---

# Troubleshoot Windows 365 Boot

This article provides troubleshooting steps for issues that occur when you set up or manage Windows 365 Boot devices.

## User can't access the Cloud PC from the Windows 365 Boot physical device

If the user can't access the Cloud PC from the Windows 365 Boot physical device, follow these steps:

1. Check whether the user can sign in to the Cloud PC from either of the other available locations:

   - [Windows 365](https://windows365.microsoft.com).
   - The Windows App on another (non-Windows 365 Boot) device.

1. If a user has more than one Cloud PC, make sure that they select a default Cloud PC to use each time that they sign in. To set this default, follow these steps:

   1. Go to [Windows 365](https://windows365.microsoft.com).
   1. On the card for the Cloud PC that you that want to set as default, select the **Settings** button (**...**).
   1. On the **Integrated experiences** tab, locate the **Boot to this Cloud PC** section, and then select **Connect while signed into device**.
   1. Select **Save**.

1. If the user can sign in to the Cloud PC from the app or web, and a default Cloud PC is set, check the Windows 365 Boot physical device for issues. In this case, verify that the physical device is correctly configured and has the required software versions. For more information, see [Windows 365 Boot physical device requirements](/windows-365/enterprise/windows-365-boot-physical-device-requirements).

1. To deliver policies more quickly to the device, administrators can try to manually select **Device sync**. After this change, the user can try to restart the device.

## Physical device registry key configuration

Check the following registry keys to verify that the physical device is correctly configured to run Windows 365 Boot. 

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

This cmdlet shows all the Microsoft-maintained apps (such as QuickAssist and Microsoft Family) on the physical device. To make sure that Windows 365 Boot works correctly, verify that the app versions meet the following requirements:

- Windows App version 2.0.285 or a later version.
- Azure Virtual Desktop (HostApp) app version 1.2.4159 or a later version.
- The latest version of Windows 11.

## Remove and add Windows 365 Boot to the physical device again

If you can't identify the source of the issue, remove Windows 365 Boot from the device, and then restore it.

### Remove Windows 365 Boot from the physical device

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Groups** > **All groups**.
1. Select the group for your Windows 365 Boot device, and then select **Members**.
1. Select the physical device, and then select **Remove** > **Yes**.
1. Select **Devices** > **All devices**, select the physical device, and then select **Overview** > **Sync**.

It takes up to eight hours for Intune to remove the policies. After the removal, the physical device is no longer set up for Windows 365 Boot.

### Restore Windows 365 Boot to the physical device

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Groups** > **All groups**.
1. Select the group for your Windows 365 Boot device, and then select **Members**.
1. Select **Add members**, and then select the physical device.
1. Wait about 10 minutes.
1. Select **Devices** > **All devices**, select the physical device, and then select **Overview** > **Sync**.

The physical device is now set up for Windows 365 Boot. Retest it to verify that it works.

## Issues connecting to a captive portal

### Network connection doesn't update after the device connects to the captive portal

This issue indicates that the device didn't fully authenticate on the network.

To fix the issue, disconnect the device from the Wi-Fi network that requires a captive portal sign-in, and then reconnect and complete the sign-in steps again.

### User can't reconnect to their Cloud PC after signing in to a captive portal

After the user signs in by using the captive portal, the network state might not propagate correctly.

Cancel the connection to return to the connection lounge. To reconnect, select **Connect** for the Cloud PC that you want to connect to.

## Contact Microsoft Support

If the issue persists, collect the following log and ID information, and then contact Microsoft Support.

### Local logs

Collect Windows 365 and Microsoft Entra ID log information from the following locations:

- C:\\Users\\\*username*\\AppData\\Local\\Temp\\DiagOutputDir\\Windows365\\Logs  
- C:\\Users\\\*username*\\AppData\\Local\\Temp\\DiagOutputDir\\RdClientAutoTrace

Put these logs into a zip file, and provide it to the Microsoft Support team for further investigation.

### Windows 365 error and session IDs

To help the investigation, collect the CorrelationId, SessionID, or ActivityID of the physical device.

#### Session ID

The Windows 365 Session ID is provided in an error dialog box that displays an error message such as **Something went wrong**.

:::image type="content" source="media/troubleshoot-windows-365-boot/something-went-wrong.png" alt-text="Screenshot that shows the error that contains the Windows 365 session ID." border="false":::

#### Correlation ID

The Correlation ID is displayed in the interstitial screen that appears during a five-minute timeout.

:::image type="content" source="media/troubleshoot-windows-365-boot/connection-issue.png" alt-text="Screenshot that shows the interstitial screen that contains the Correlation ID." border="false":::

## Next steps

For more information about Windows 365 Boot, see [What is Windows 365 Boot?](/windows-365/enterprise/windows-365-boot-overview).
