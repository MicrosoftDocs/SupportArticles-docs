---
title: Troubleshoot partner connectors in Windows 365
description: Provides troubleshooting information to the issues related to partner connectors in Windows 365.
manager: dcscontentpm
ms.date: 01/20/2025
ms.topic: troubleshooting
ms.reviewer: aradinger, erikje
ms.custom:
- pcy:Partner Solutions for W365
- sap:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---

# Troubleshoot partner connectors in Windows 365

This article provides some troubleshooting steps and possible solutions for the issues related to partner connectors in Windows 365.

## Troubleshoot partner agent installation issues

When you enable a partner connector ([Citrix HDX Plus](/windows-365/enterprise/set-up-citrix), [Omnissa Horizon](/windows-365/enterprise/set-up-omnissa-horizon), or [HP Anyware](/windows-365/enterprise/hp-anyware-set-up)) for a user, the partner agent is automatically installed on that user's Cloud PCs. The agent enables the corresponding third-party protocol.

If the installation encounters an issue, an error message appears in the **All Cloud PC** list, providing advice on how to troubleshoot the error.  

Even though the installation fails, the user can still connect to their Cloud PC using Remote Desktop.

### Troubleshooting steps

While troubleshooting the error, make sure that the following steps are successful:

- The user's license state is synchronized from the partner service to Microsoft Intune, including the user's Microsoft Entra user ID.
  - The prerequisites are met.
  - The partner connector is enabled and healthy in Microsoft Intune.
  - The correct permissions are set for the partner third-party apps in Microsoft Entra ID.
  - The Microsoft Entra user is added and discoverable in the Partner Cloud console.
- The partner agent is downloaded on the Cloud PC.
  - The Cloud PC can access partner download URLs.
  - No security policy blocks PowerShell or any app/agent installation as **System**.
- The partner agent is installed.
  - Check **Apps & Features** to see if the partner agent is installed on the Cloud PC.
  - Check Windows Event Viewer (**eventvwr.msc**) logs to make sure that the agent installation is executed.
  - Check installation logs for any failures:
    - Citrix: **%TEMPsystemdrive%\\Windows\\Temp\\Citrix\\XenDesktop Installer**
    - Omnissa Horizon:
      - For installation issues: **C:\\Windows\\Temp\\Omnissa_Horizon_Agents_Installer_\**.log**.
      - Run this script for collecting the logs for post-installation issues: **C:\\Program Files\\Omnissa\\Horizon Agents\\Horizon Agent\\DCT\\support.bat**.
    - HP Anyware:
      - **C:\\Teradici\\provisioning.log**.
      - Or, select **Generate support bundle** on the client side.
- The Cloud PC is registered to the partner cloud tenant.
  - Check the Cloud PC registration status in the partner configuration console.
  - If the Cloud PC is unregistered, check the **Application** sign-in events in Windows Event Viewer (**eventvwr.msc**) for partner service errors and warnings.

After you find the root cause, remove the assigned license from the partner console and then add the license back to trigger the reinstallation of the partner agent.

> [!NOTE]
> If no other solution works, you can [reprovision](/windows-365/enterprise/reprovision-cloud-pc) the Cloud PC to reattempt the enablement. Reprovisioning deletes the Cloud PC and creates a new one. All data on the original Cloud PC will be lost. Therefore, reprovisioning should be the last resort to resolve the issue.

## Troubleshoot connection issues

If you have connectivity issues with your partner-provisioned Cloud PC, test the default RDP-based connectivity to determine if the issue is with the Cloud PC or the partner connectivity.

### Turn on the Remote Desktop Protocol (RDP) protocol

When the partner protocol is enabled, the Windows 365 remote protocol remains enabled but inactive. This inactivity means that users trying to connect to the Windows 365-supported Remote Desktop clients (including the HTML5 browser) are blocked by default. Users can only connect using the partner protocol. Users trying to connect to non-partner clients receive a generic error message.

You can enable the RDP protocol so users can sign in with RDP to test the Cloud PC connectivity. You can enable the RDP protocol by:

- [Making a user a local administrator](/windows-365/enterprise/assign-users-as-local-admin) on the Cloud PC.
- [Adding the user to the Direct Access Users group on the Cloud PC](/windows/client-management/mdm/policy-csp-localusersandgroups).

After taking either of these steps, you might need to restart the Cloud PC for the group membership updates to take effect. The user can then connect using either RDP or the partner protocol.

You can now test the connectivity using RDP and raise a support case with the relevant support team if problems persist.

## Next steps

- For more information about Citrix HDX Plus for Windows 365, see [Set up Citrix HDX Plus for Windows 365 Enterprise](/windows-365/enterprise/set-up-citrix).
- For more information about HP Anyware for Windows 365, see [Set up HP Anyware for Windows 365 Enterprise](/windows-365/enterprise/hp-anyware-set-up).
- For more information about Omnissa Horizon for Windows 365, see [Set up Omnissa Horizon for Windows 365 Enterprise](/windows-365/enterprise/set-up-omnissa-horizon).
