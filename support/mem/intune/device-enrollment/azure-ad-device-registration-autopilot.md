---
title: Troubleshoot Microsoft Entra device registration and Windows Autopilot
description: Provides tips for troubleshooting Microsoft Entra device registration and Windows Autopilot.
author: helenclu
ms.author: luche
ms.reviewer: kaushika, horemaw
ms.date: 02/11/2025
search.appverid: MET150
ms.custom: sap:Autopilot\DevicePrep
---
# Troubleshooting Microsoft Entra device registration and Windows Autopilot

This article contains tips for troubleshooting Microsoft Entra device registration and Windows Autopilot issues.

<a name='azure-ad-device-registration'></a>

## Microsoft Entra device registration

By connecting devices to Microsoft Entra ID, users can easily access the organization's assets, and IT administrators can easily control and manage the connected devices to protect the organization's assets. For more information about device identity, see [What is a device identity?](/azure/active-directory/devices/overview)

You have the following options to connect a device to Microsoft Entra ID:

- Microsoft Entra registered
- Microsoft Entra joined
- Microsoft Entra hybrid joined

To troubleshoot common device registration issues, use the [Device Registration Troubleshooter Tool](https://aka.ms/DevRegTS).

The following screenshot shows the main menu of the tool:

:::image type="content" source="media/azure-ad-device-registration-autopilot/device-registration-troubleshooter.png" alt-text="Screenshot of the Troubleshooter main menu." border="false":::

For example, if the device health status is **Pending**, select **5** on the menu. If the device doesn't have the Primary Refresh Token (PRT) issued, select **6** on the menu.

For more information about Microsoft Entra device registration, see the [Microsoft Entra device identity documentation](/azure/active-directory/devices).

## Windows Autopilot

To add [Windows Autopilot](/mem/autopilot/windows-autopilot) devices in Microsoft Intune, import a CSV file that contains the device information. To import the CSV file, open the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Devices** > **Windows** > **Windows enrollment** > **Devices** (under **Windows Autopilot Deployment Program**) > **Import**.

You can use the [Get-WindowsAutoPilotInfo](https://www.powershellgallery.com/packages/Get-WindowsAutoPilotInfo) PowerShell script to generate the CSV file. You can either manually download the script or run the following command to install the script:

```powershell
Install-Script -Name Get-WindowsAutoPilotInfo
```

For more information about how to use the script, see [Collecting the hardware hash from existing devices using PowerShell](/mem/autopilot/add-devices#collecting-the-hardware-hash-from-existing-devices-using-powershell).

To troubleshoot Windows Autopilot issues, first [collect logs](understand-troubleshoot-esp.md#collect-logs). The following files are useful for troubleshooting related issues:

- microsoft-windows-devicemanagement-enterprise-diagnostics-provider-admin.evtx
- microsoft-windows-moderndeployment-diagnostics-provider-autopilot.evtx
- MdmDiagReport_RegistryDump.reg
- TpmHliInfo_Output.txt
- microsoft-windows-provisioning-diagnostics-provider-admin.evtx
      This file contains some informational messages about the Enrollment Status Page (ESP), such as app installation failures or timeouts. Here are some examples:

  - AutoPilotGetOobeSettingsOverride succeeded:  OOBE setting = AUTOPILOT_OOBE_SETTINGS_AAD_JOIN_ONLY; state = enabled.
  - CloudExperienceHost Web App Event 1. Name: 'UnifiedEnrollment_ProvisioningProgressPage_ApplicationsFailed'.
  - CloudExperienceHost Web App Event 1. Name: 'UnifiedEnrollment_ProvisioningProgressPage_DeviceConfigurationTimeOut'.

For additional guidance, see [Troubleshooting overview](/windows/deployment/windows-autopilot/troubleshooting) in the Windows Autopilot documentation, and [Troubleshooting Windows Autopilot (level 300/400)](https://techcommunity.microsoft.com/t5/windows-blog-archive/troubleshooting-windows-autopilot-level-300-400/ba-p/706512).
