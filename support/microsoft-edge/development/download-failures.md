---
title: Resolve download failures in Microsoft Edge
description: Resolve "Couldn't download" errors in Microsoft Edge by using this step-by-step troubleshooting guide. Fix SmartScreen blocks, permission issues, and network problems quickly.
ms.date: 03/31/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Web Platform and Development\Connectivity and Navigation: TCP, HTTP, TLS, DNS, Proxies, Downloads'
---

# Troubleshoot download failures

## Summary

This article helps you troubleshoot download failures in Microsoft Edge if you receive error messages such as "Couldn't download" or similar notifications. Downloads might fail because of SmartScreen or antivirus blocks, Group Policy restrictions, network problems, or file system permission issues. Use the following checklist to identify and fix the problem.

## Symptoms

You experience one or more of the following problems:

- Downloads fail and return a "Couldn't download" error message.
- A download starts but immediately fails or gets interrupted.
- The download progress bar stops progressing after it reaches a certain percentage, and then returns an error message.
- Specific file types don't download while others succeed.
- Downloads fail on certain websites only but work on others.

## Solution

Work through the following checks in the given order. After each section, retry the download to check whether the problem is fixed before you proceed to the next section.

### Check the specific download error message

Microsoft Edge shows different error codes within the "Couldn't download" message. Identify the specific error to narrow down the cause.

| Error message and code                           | Cause                                                                                 |
| ------------------------------------------------ | ------------------------------------------------------------------------------------- |
| **Couldn't download - Blocked**                  | Security settings, SmartScreen, or Group Policy blocked the download.                 |
| **Couldn't download - Virus detected**           | Microsoft Defender or antivirus software flagged the file.                            |
| **Couldn't download - Network error**            | Network connectivity problem or timeout occurred during the download.                 |
| **Couldn't download - Disk full**                | Insufficient disk space in the download location.                                     |
| **Couldn't download - Insufficient permissions** | No write permission to the download folder.                                           |
| **Couldn't download - Failed - Forbidden**       | The server returned a "403" error to indicate an authentication or access problem.    |

### Check the download folder and disk space

The download might fail if the target folder doesn't exist or is read-only, or the disk is full. Follow these steps:

1. Open Microsoft Edge, and go to `edge://settings/downloads`.
1. Check the **Location** setting, and verify that the download folder path is valid and accessible.
1. Open File Explorer, and go to the Download folder. Verify that:
   - The folder exists.
   - You have write permissions (try creating a test file in the folder).
1. Check the available disk space on the drive where the download folder is located. Free up space, if it's necessary.
1. If the download folder is on a network drive, verify that the network share is accessible and that you have write permissions.

### Check security and SmartScreen settings

[Microsoft Defender SmartScreen](/deployedge/microsoft-edge-security-smartscreen) or other security features might block the download if the file is considered unsafe. Follow these steps:

1. When SmartScreen blocks a download, a notification appears at the bottom of Edge or in the downloads panel. Select **More actions** (**...**) next to the blocked download.
1. If you trust the source, select **Keep** > **Show more** > **Keep anyway** to override the block.
1. To review SmartScreen settings:
   1. Go to `edge://settings/privacy`.
   1. Under **Security**, check whether **Microsoft Defender SmartScreen** is turned on.
   1. If SmartScreen blocks legitimate downloads, consider temporarily turning it off for testing only.

     > [!CAUTION]
     > Turning off SmartScreen reduces your protection against malicious downloads. Turn it back on after you finish testing.

1. Check whether Windows Security is blocking the download:
   1. Open **Windows Security** > **Virus & threat protection** > **Protection history**.
   1. Look for recent blocked items that are related to your download.

### Check antivirus and security software

Third-party antivirus software or Microsoft Defender might intercept and block the download. Follow these steps:

1. Check your antivirus software's quarantine or activity log for the blocked file.
1. Temporarily turn off real-time protection in your antivirus software, and retry the download.
1. If the download succeeds by having antivirus turned off, add an exception for:
   - The download URL or domain.
   - The download folder path.
   - The specific file type (if the antivirus blocks by file extension).
1. Turn real-time protection back on after you finish testing.

> [!CAUTION]
> Download files only from sources you trust. Turning off antivirus protection, even temporarily, increases the risk of malware infection.

### Check Group Policy restrictions on downloads

Your organization might have policies that restrict or block downloads. Follow these steps:

1. Open Microsoft Edge, and go to `edge://policy`.
1. Search for the following policies:
   - [DownloadRestrictions](/deployedge/microsoft-edge-browser-policies/downloadrestrictions):
     - **0**: no restrictions (default)
     - **1**: block dangerous downloads
     - **2**: block potentially dangerous downloads
     - **3**: block all downloads
     - **4**: block potentially dangerous downloads with special handling
   - [DownloadDirectory](/deployedge/microsoft-edge-browser-policies/downloaddirectory) sets the download directory. An invalid path causes downloads to fail.
   - [ExemptFileTypeDownloadWarnings](/deployedge/microsoft-edge-browser-policies/exemptfiletypedownloadwarnings) exempts specific file types from download warnings.
1. If **DownloadRestrictions** is set to **3** (block all downloads), contact your IT administrator to update the policy.
1. If **DownloadDirectory** is set to a path that doesn't exist or isn't accessible, update the policy or create the directory manually.

### Test network connectivity

Network problems can interrupt or prevent downloads, especially for large files. Follow these steps:

1. To determine whether the problem is site-specific, try to download the same file from a different website or URL.
1. To rule out network-level blocking, try to download from a different network (for example, a mobile hotspot).
1. If your organization uses a proxy server:
   1. Go to `edge://settings/system`, and check the proxy settings.
   1. Verify that the download URL isn't blocked by the proxy.
   1. If the proxy is intercepting HTTPS traffic, contact your network administrator.
1. For large files that fail partway through, the problem might be a timeout or unstable connection. Try:
   - Using a wired connection instead of Wi-Fi
   - Using a download manager that supports resume
1. Try downloading the file in a different browser (for example, Chrome or Firefox). If the download also fails, the problem is likely network-related and not Edge-specific.

### Clear browser cache and reset download settings

Corrupted cache or misconfigured download settings might cause persistent download failures. Follow these steps:

1. Clear the browser cache:
   1. Go to `edge://settings/privacy`.
   1. Under **Clear browsing data**, select **Choose what to clear**.
   1. Select **Cached images and files**.
   1. Set the time range to **All time**, and select **Clear now**.
1. Reset download settings:
   1. Go to `edge://settings/downloads`.
   1. Turn off **Ask me what to do with each download** to determine whether the prompt behavior causes the failure.
   1. Reset the download location to the default folder (*Downloads*).
1. If the problem persists, reset Microsoft Edge:
   1. Go to `edge://settings/reset`.
   1. Select **Restore settings to their default values**.
   1. Retry the download.

### Check for file type or extension-specific blocks

Certain file types might be blocked by Edge, Windows, or Group Policy. Follow these steps:

1. Note the file extension of the download that failed (for example, `.exe`, `.msi`, `.zip`, `.dll`).
1. To determine whether the problem is file type-specific, try to download a different file type from the same site.
1. To determine whether an exemption is necessary if your organization blocks specific file types, check the [ExemptFileTypeDownloadWarnings](/deployedge/microsoft-edge-browser-policies/exemptfiletypedownloadwarnings) policy in `edge://policy`.
1. By design, some high-risk file types (for example, `.exe`, `.bat`, `.cmd`, `.ps1`) trigger extra security warnings. Follow the steps in [Check security and SmartScreen settings](#check-security-and-smartscreen-settings) to proceed to download the file if you trust the source.

### Test in a new browser profile or InPrivate window

A corrupted browser profile or conflicting extensions might interfere with downloads. Follow these steps:

1. Try to download the file in an **InPrivate** window (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>N</kbd>). If the download succeeds in InPrivate, an extension might be interfering.
1. Try downloading in a new browser profile:
   - Select the profile icon in the upper-left corner of Edge.
   - Select **Add profile** > **Add**.
   - In the new profile, retry the download.
1. If the download works in InPrivate or a new profile, turn off extensions one by one in your original profile to identify the conflicting extension:
   - Go to `edge://extensions`.
   - Turn off each extension, and retry the download until you find the cause.

## Data collection

If you need to contact Microsoft Support for more help, collect the following diagnostic information, and include it in your support request:

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **Exact error message**: Take a screenshot of the download error, including any error code.
- **Download URL**: Note the URL of the file that you're trying to download (if it isn't confidential).
- **Active policies**: Go to `edge://policy`, and export the policy list.
- **Network trace**: Go to `edge://net-export/`, start logging, reproduce the download failure, and then save the log file.
- **Operating system version**: Go to **Settings** > **System** > **About**, and note the OS version.
- **Antivirus software**: Note the name and version of any antivirus or security software that's installed.

## Related content

- [Unexpected SmartScreen block or warning on website](unexpected-block-warning.md)
- [Microsoft Edge browser policy reference](/deployedge/microsoft-edge-policies)
