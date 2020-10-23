---
title: Azure AD device registration and Windows Autopilot
description: Provides tips for troubleshooting Azure AD device registration and Windows Autopilot.
author: helenclu
ms.author: luche
ms.reviewer: horemaw
ms.date: 10/10/2020
ms.prod-support-area-path: Windows enrollment
---
# Support Tip: Azure AD device registration and Windows Autopilot

This article contains tips for troubleshooting Azure Active Directory (Azure AD) device registration and Windows Autopilot issues.

## Azure AD device registration

By connecting devices to Azure AD, users can easily access the organization's assets, and IT administrators can easily control and manage the connected devices to protect the organization's assets. For more information about the benefits, see [Do I really need to connect my device to Azure AD?](https://azureera.com/do-i-really-need-to-connect-my-device-to-azure-ad) For more information about device identity, see [What is a device identity?](/azure/active-directory/devices/overview)

To get a device in Azure AD, you have the following options:

- Azure AD registered
- Azure AD joined
- Hybrid Azure AD joined

To troubleshoot common device registration issues, use the [Device Registration Troubleshooter Tool](https://aka.ms/DevRegTS).

The following screenshot shows the main menu of the tool:

:::image type="content" source="media/azure-ad-device-registration-autopilot/device-registration-troubleshooter.png" alt-text="Troublehooter main menu":::

For example, if the device health status is **Pending**, select **5** on the menu. If the device doesn't have the Primary Refresh Token (PRT) issued, select **6** on the menu.

For more information about Azure AD device registration, see the following articles:

- [Azure AD device identity documentation](/azure/active-directory/devices)
- [Azure AD registered devices](/azure/active-directory/devices/concept-azure-ad-register)
- [How to: Plan your Azure AD join implementation](/azure/active-directory/devices/azureadjoin-plan)
- [How To: Plan your hybrid Azure Active Directory join implementation](/azure/active-directory/devices/hybrid-azuread-join-plan)

## Windows Autopilot

You can use [Windows Autopilot](/mem/autopilot/windows-autopilot) to set up new devices and reset devices. 

To add Windows Autopilot devices in Microsoft Intune, import a CSV file that contains the device information. To import the CSV file, open the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Devices** > **Windows** > **Windows enrollment** > **Devices** (under **Windows Autopilot Deployment Program**) > **Import**.

You can use the [Get-WindowsAutoPilotInfo](https://www.powershellgallery.com/packages/Get-WindowsAutoPilotInfo) PowerShell script to generate the CSV file. You can either manually download the script or run the following command to install the script:

```powershell
Install-Script -Name Get-WindowsAutoPilotInfo
```
For more information about how to use the script, see [Collecting the hardware hash from existing devices using PowerShell](/mem/autopilot/add-devices#collecting-the-hardware-hash-from-existing-devices-using-powershell).

To troubleshoot Windows Autopilot issues, first [collect logs](understand-troubleshoot-esp.md#collect-logs). The following files are useful for troubleshooting related issues:

-	microsoft-windows-devicemanagement-enterprise-diagnostics-provider-admin.evtx
-	microsoft-windows-moderndeployment-diagnostics-provider-autopilot.evtx
-	MdmDiagReport_RegistryDump.reg
-	TpmHliInfo_Output.txt
-	microsoft-windows-provisioning-diagnostics-provider-admin.evtx
    
    This file contains some informational messages about the Enrollment Status Page (ESP), such as app installation failures or timeouts. Here are some examples:

	- AutoPilotGetOobeSettingsOverride succeeded:  OOBE setting = AUTOPILOT_OOBE_SETTINGS_AAD_JOIN_ONLY; state = enabled.
	- CloudExperienceHost Web App Event 1. Name: 'UnifiedEnrollment_ProvisioningProgressPage_ApplicationsFailed'.
	- CloudExperienceHost Web App Event 1. Name: 'UnifiedEnrollment_ProvisioningProgressPage_DeviceConfigurationTimeOut'.

For more information about Windows Autopilot troubleshooting, see the following articles:

-	[Troubleshooting Windows Autopilot](/windows/deployment/windows-autopilot/troubleshooting)
-	[Windows Autopilot - known issues](/mem/autopilot/known-issues)
-	[Troubleshooting Windows Autopilot (level 300/400)](https://techcommunity.microsoft.com/t5/windows-blog-archive/troubleshooting-windows-autopilot-level-300-400/ba-p/706512)
