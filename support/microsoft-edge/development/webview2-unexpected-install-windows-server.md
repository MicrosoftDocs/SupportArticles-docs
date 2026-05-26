---
title: Fix unexpected WebView2 installation on Windows Server
description: Microsoft Edge Update can force-install WebView2 on Windows Server with multi-session roles. Learn how to identify and prevent this unexpected installation.
ms.date: 05/26/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: sap:Web Platform and Development\WebBrowser and WebView2 controls
---

# WebView2 is unexpectedly installed on Windows Server operating systems

## Summary

This article helps you troubleshoot an issue in which WebView2 runtimes are unexpectedly installed on Windows Server operating systems. After WebView2 is installed in this manner, you can't uninstall it. This behavior occurs because Microsoft Edge Update detects multi-session support on the server and force-installs WebView2 as a required component for user application workflows.

## Symptoms

- WebView2 runtimes appear on a Windows Server computer without an administrator explicitly installing them.
- You can't uninstall WebView2 from the server after the installation.
- The `MicrosoftEdgeUpdate.log` (or `.bak`) file contains the following entries:

  ```output
  [IsMultiUserTerminalServerMachine: 1]
  [bundle_creator::CreateForceInstallBundle][Adding WebView2 to force-install bundle.]
  ```

## Cause

On Windows Server operating systems, Microsoft Edge Update checks whether the device is configured for multi-session support. This condition is triggered when one of the following roles is enabled:

- **Terminal Services** (Windows Server 2008 and earlier)
- **Remote Desktop Services** (Windows Server 2008 R2 and later)

If Windows Server supports multiple user sessions, Edge Update assumes that those sessions run user application workflows. To support apps that depend on WebView2 runtimes, Edge Update installs the evergreen WebView2 Runtime as a required Windows component.

> [!NOTE]
> After WebView2 is installed in this manner, you can't uninstall it.

### Verify the cause

1. Go to the Edge Update log file location:

   ```output
   %ProgramData%\Microsoft\EdgeUpdate\Log\MicrosoftEdgeUpdate.log
   ```

   If the primary log was rotated, check `MicrosoftEdgeUpdate.log.bak`.

1. Search the log file for the following entries:

   ```output
   [IsMultiUserTerminalServerMachine: 1]
   [bundle_creator::CreateForceInstallBundle][Adding WebView2 to force-install bundle.]
   ```

1. If both entries are present, Edge Update detected multi-session support and force-installed WebView2.

## Solution

The right solution depends on whether the server is joined to a domain.

### For domain-joined computers: disable WebView2 installation through policy

On computers that are joined to Active Directory or Microsoft Entra ID, use the Edge Update **Install** policy for WebView2 to prevent the installation.

1. Open the Group Policy Editor (`gpedit.msc`).
1. Go to **Computer Configuration** > **Administrative Templates** > **Microsoft Edge Update** > **Applications** > **Microsoft Edge WebView2 Runtime**.
1. Open the **Install** policy, and set it to either **Disabled** or **Enabled**. For **Enabled**, use the value, **Installs disabled** (`0`).
1. To apply the policy immediately, run `gpupdate /force`.

For more information about this policy, see [Install (WebView)](/deployedge/microsoft-edge-update-policies#install-webview).

> [!IMPORTANT]
> This policy only prevents future installations. It doesn't uninstall WebView2 if it's already installed on the computer. Apply this policy **before** WebView2 is installed.

### For non-domain-joined computers: block Edge Update endpoints

On computers that aren't domain-joined, you can't apply Edge Update policies through Group Policy. Instead, prevent the computers from reaching the public Edge Update endpoints by blocking the following URLs at the network or firewall level:

- **Update service endpoints:** See [Update service](/deployedge/microsoft-edge-security-endpoints#update-service) for the full list of URLs to block.
- **Download location endpoints:** See [Download locations for Microsoft Edge](/deployedge/microsoft-edge-security-endpoints#download-locations-for-microsoft-edge) for the full list of URLs to block.

> [!CAUTION]
> Blocking these endpoints also prevents Microsoft Edge and other Edge-managed components from receiving updates. Use this approach only on servers where Edge updates aren't needed or are managed through alternative methods (such as offline update packages).

## Data collection

If you have to contact Microsoft Support for more help, collect the following diagnostic information, and include it in your support request:

1. **Windows Server version**: Go to **Settings** > **System** > **About**, and note the full OS version and build number.
1. **Installed server roles**: Run the following command in PowerShell, and note the output:

   ```powershell
   Get-WindowsFeature | Where-Object {$_.Installed -eq $true} | Select-Object Name, DisplayName
   ```

1. **Edge Update log**: Collect the file at `%ProgramData%\Microsoft\EdgeUpdate\Log\MicrosoftEdgeUpdate.log` (and `.bak` if present).
1. **Active policies**: Run `gpresult /h gpresult.html` at a command prompt, and save the output.
1. **Domain join status**: Run `dsregcmd /status` at a command prompt, and note the output.

## Related content

- [Distribute your app and the WebView2 Runtime](/microsoft-edge/webview2/concepts/distribution)
- [Enterprise management of WebView2 Runtimes](/microsoft-edge/webview2/concepts/enterprise)
- [Configure Microsoft Edge policy settings on Windows devices](/deployedge/configure-microsoft-edge)
