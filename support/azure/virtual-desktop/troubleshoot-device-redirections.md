---
title: Device redirections in Azure Virtual Desktop
description: Helps resolve issues with device redirections in Azure Virtual Desktop.
ms.topic: troubleshooting
ms.date: 01/21/2025
ms.reviewer: daknappe
ms.custom: docs_inherited, pcy:wincomm-user-experience
---
# Troubleshoot device redirections for Azure Virtual Desktop

> [!IMPORTANT]
> This content applies to Azure Virtual Desktop with Azure Resource Manager Azure Virtual Desktop objects.

This article helps resolve issues with device redirections in Azure Virtual Desktop.

## WebAuthn redirection

If WebAuthn requests from the session aren't redirected to the local PC, check to make sure you've fulfilled the following requirements:

- Are you using supported operating systems for [in-session passwordless authentication](/azure/virtual-desktop/authentication#in-session-passwordless-authentication) on both the local PC and session host?
- Have you enabled WebAuthn redirection as a [device redirection](/azure/virtual-desktop/redirection-configure-webauthn)?

If you've answered "yes" to both of the preceding questions but still don't see the option to use Windows Hello for Business or security keys when accessing Microsoft Entra resources, make sure you've enabled the FIDO2 security key method for the user account in Microsoft Entra ID. To enable this method, follow the directions in [Enable FIDO2 security key method](/azure/active-directory/authentication/howto-authentication-passwordless-security-key#enable-fido2-security-key-method).

If a user signs in to the session host with a single-factor credential like username and password, and then tries to access a Microsoft Entra resource that requires multifactor authentication (MFA), they might be unable to use Windows Hello for Business. The user should follow these instructions to authenticate properly:

1. If the user isn't prompted for a user account, they should first sign out.
2. On the **account selection** page, select **Use another account**.
3. Choose **Sign-in options** at the bottom of the window.
4. Select **Sign in with Windows Hello or a security key**. They should see an option to select Windows Hello or security authentication methods.

## Clipboard and Window Resizing Issues After SxS Network Stack Update

**Applies to:** Azure Virtual Desktop – SxS Network Stack version 1.0.2501.05600 and later

### Symptoms
- Clipboard redirection fails (e.g., copying from the AVD session to the local device does not work).
- The AVD session window cannot be resized.
- Issues occur after updating to SxS Network Stack version `1.0.2501.05600` or later.
- Affects environments that use restrictive application control policies (e.g., antivirus allow lists).

### Cause
The updated SxS network stack introduces new executables—`rdpclipcdv.exe` and `rdpinputcdv.exe`—used to handle clipboard and window resizing functionality. If these executables are blocked, the functionality fails to initialize properly.

This impacts environments that enforce application restriction policies, such as:
- Software Restriction Policies (SRP)
- AppLocker
- Third-party endpoint protection software

### Resolution
Ensure the following executables are allow-listed **when executed from subfolders of** `C:\Program Files\Microsoft RDInfra`:
- `rdpinit.exe`
- `rdpshell.exe`
- `rdpstartup.exe`
- `rdpstartuplauncher.exe`
- `rdpvchost.exe`
- `rdpclipcdv.exe`
- `rdpinputcdv.exe`

## Provide feedback

Visit the [Azure Virtual Desktop Tech Community](https://techcommunity.microsoft.com/t5/azure-virtual-desktop/bd-p/AzureVirtualDesktopForum) to discuss the Azure Virtual Desktop service with the product team and active community members.

## More information

- For an overview of troubleshooting Azure Virtual Desktop and the escalation tracks, see [Troubleshooting overview, feedback, and support](troubleshoot-set-up-overview).
- To troubleshoot issues while creating an Azure Virtual Desktop environment and host pool in an Azure Virtual Desktop environment, see [Environment and host pool creation](troubleshoot-set-up-issues).
- To troubleshoot issues while configuring a virtual machine (VM) in Azure Virtual Desktop, see [Session host virtual machine configuration](troubleshoot-vm-configuration).
- To troubleshoot issues related to the Azure Virtual Desktop agent or session connectivity, see [Troubleshoot common Azure Virtual Desktop Agent issues](troubleshoot-agent).
- To troubleshoot issues when using PowerShell with Azure Virtual Desktop, see [Azure Virtual Desktop PowerShell](troubleshoot-powershell).
