---
title: Guidance of troubleshooting Windows Server update
description: Introduces general guidance of troubleshooting scenarios related to Windows Server update.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-server-deployment
---
# Windows Server update troubleshooting guidance

This solution is designed to get you started on Windows Update troubleshooting scenarios. Most users are able to resolve their issue using the solutions mentioned below

## Troubleshooting checklist

For Windows 7: run the System Readiness (Checksur tool) - Windows 7,  Windows 2008 R2 or Windows 2008 SP2:  
[Fix errors that are found in the CheckSUR log file](fix-windows-update-errors.md#how-to-fix-errors-that-are-found-in-the-checksur-log-file)

For Windows 8 and later version of Windows: run this command from an administrative CMD prompt:  
`Dism /online /cleanup-image /restorehealth`

Pending Reboot:  If the computer hasn't been restarted, pending actions might have to be completed.

Services Stack update: Install the latest servicing stack update. [Latest Servicing Stack Updates](https://msrc.microsoft.com/update-guide/vulnerability/ADV990001).

Fix Windows file corruption: See [Fix Windows file corruption](fix-windows-update-errors.md#resolution-for-windows-81-windows-10-and-windows-server-2012-r2).

Install the update package manually: Download the update package and try to install the update manually. Here's how to do this:

1. Open [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/home.aspx).
2. In the search box, type the update number that you want to download and then select Search.
3. Find the update that applies to your operating system in the search results and select Add to add the update to your basket.
4. Select view basket to open your basket.
5. Select Download to download the update in your basket.
6. Select Browse to choose a location for the update you are downloading, and then select Continue.
7. Select **Close** when the download process is done. Browse to the location that you specified for the download.
8. Open the folder that contains the update package and double-select the update package to install the update.

## Common errors and solutions

### Issue 1

> The update is not applicable to your computer.

#### Cause 1

Update is superseded.

Troubleshooting:  
Check that the package that you are installing contains newer versions of the binaries. Alternatively, check that the package is superseded by another new package.

#### Cause 2

Update is already installed.

Troubleshooting:  
Verify that the package that you are trying to install isn't already installed.

#### Cause 3

Wrong update for architecture.

Troubleshooting:  
Verify that the package that you're trying to install matches the Windows version that you are using. The Windows version information can be found in the "Applies To" section of the article for each update. For example, Windows Server 2012-only updates cannot be installed on Windows Server 2012 R2-based computers.  
Verify that the package you want to install matches the processor architecture of the Windows version that you are using. For example, an x86-based update can't be installed on x64-based installations of Windows.

#### Cause 4

Missing prerequisite update.

Troubleshooting:  
Read the package’s related article to find out whether the prerequisite updates are installed. For example, if you receive the error message in Windows 8.1 or Windows Server 2012 R2, you might have to install the April 2014 update 2919355 as a prerequisite and one or more pre-requisite servicing updates (KB 2919442 and KB 3173424).  
To determine if these prerequisite updates are installed, run this PowerShell command:  
`get-hotfix KB3173424, KB2919355, KB2919442`  
If the updates are installed, the command returns the installed date in the InstalledOn section of the output.

### Issue 2

Updates aren't downloading from WSUS or Configuration Manager

Error message:  
> Failed to connect to Mux due to network or cert errors  

Troubleshooting: Check the numeric code provided in the error message code: this corresponds to the winsock error code. Certificate errors are granular (for example, cert cannot be verified, cert not authorized, etc.)

### Issue 3

The device isn't receiving an update that you deployed.

Troubleshooting:

1. Check that the device’s updates for the relevant category aren’t paused. See [Pause feature updates](/windows/deployment/update/waas-configure-wufb#pause-feature-updates) and [Pause quality updates](/windows/deployment/update/waas-configure-wufb#pause-quality-updates).
2. Feature updates only: The device might have a safeguard hold applied for the given feature update version. For more information about safeguard holds, see [Safeguard holds](/windows/deployment/update/safeguard-holds) and [Opt out of safeguard holds](/windows/deployment/update/safeguard-opt-out).
3. Check that the deployment to which the device is assigned has the state **offering**. Deployments that have the states **paused** or **scheduled** won't deploy content to devices.
4. Check that the device has scanned for updates and is scanning the Windows Update service. To learn more about scanning for updates, see [Scanning updates](/windows/deployment/update/how-windows-update-works#scanning-updates).
5. Feature updates only: Verify that the device is successfully enrolled in feature update management by the deployment service. A device that is successfully enrolled is represented by an Azure AD device resource with an update management enrollment for feature updates and has no Azure AD device registration errors.
6. Expedited quality updates only: Check that the device has the Update Health Tools installed (available for Windows 10 version 1809 or later in the update described in [KB 4023057 - Update for Windows 10 Update Service components](https://support.microsoft.com/topic/kb4023057-update-for-windows-10-update-service-components-fccad0ca-dc10-2e46-9ed1-7e392450fb3a), or a more recent quality update). The Update Health Tools are required for a device to receive an expedited quality update. The program’s location on the device is *C:\\Program Files\\Microsoft Update Health Tools*.  
   To verify its presence, view the installed programs list or use this PowerShell script:

   ```powershell
   Get-WmiObject -Class Win32\_Product \| Where-Object {$\_.Name -amatch "Microsoft Update Health Tools"}
   ```

### Issue 4

The device is receiving an update that you didn't deploy.

Troubleshooting:

1. Check that the device is scanning the Windows Update service and not a different endpoint. If the device is scanning for updates from a WSUS endpoint, for example, it might receive different updates. To learn more about scanning for updates, see [Scanning updates](/windows/deployment/update/how-windows-update-works#scanning-updates).
2. Feature updates only: Check that the device is successfully enrolled in feature update management by the deployment service. A device that isn't successfully enrolled might receive different updates according to its feature update deferral period. A device that is successfully enrolled is represented by an Azure AD device resource with an update management enrollment for feature updates and has no Azure AD device registration errors.

## Windows Server Update Services (WSUS) Troubleshooting  

### WSUS connection failures

If you are using WSUS 3.0 SP2 on Windows Server 2008 R2, you must have update [4039929](https://support.microsoft.com/help/4039929) or a later-version update package installed on the WSUS server.

Here's how to verify the server version:

1. Open the WSUS console.
2. Select the server name.
3. Locate the version number under **Overview** > **Connection** > **Server Version**.
4. Check whether the version is **3.2.7600.283** or a later version.

If you are using WSUS on Windows Server 2012 or a later version, you must have one of the following Security Quality Monthly Rollups or a later-version rollup installed on the WSUS server:

- Windows Server 2012 - [KB4039873](https://support.microsoft.com/help/4039873)
- Windows Server 2012 R2 - [KB4039871](https://support.microsoft.com/help/4039871)
- Windows Server 2016 - [KB4039396](https://support.microsoft.com/help/4039396/)

> [!NOTE]
> If you're using Configuration Manager with the software update point installed on a remote site system server, the WSUS Administration Console must be installed on the site server. For WSUS 3.0 SP2, [KB 4039929](https://support.microsoft.com/help/4039929) or a later update must also be installed on the WSUS Administration console. A server restart is required after installing [4039929](https://support.microsoft.com/help/4039929) (remotely or locally). Check whether the issue persists after the restart.  

To troubleshoot connection failures, follow these steps:

1. Verify that the **Update Services** service and the **World Wide Web Publishing Service** are running on the WSUS server.
2. Verify that the Default website or WSUS Administration website is running on the WSUS server.
3. Review the IIS logs for the WSUS Administration website (*c:\\inetpub\\logfiles*), and check for errors.  

### Error code: 80244007

Error message:  
> SyncUpdates_WithRecovery failed

Troubleshooting: To fix the issue, follow these steps on the WSUS server:

1. Open an elevated Command Prompt window and go to the following location:  
   *%programfiles%\\Update Services\\WebServices\\ClientWebService*
2. Type the following commands, and press Enter after each command:

   ```console
   takeown /f web.config
   icacls web.config /grant administrator:(F)
   notepad.exe web.config
   ```

3. Locate the following line in web.config:

   ```xml
   <add key="maxInstalledPrerequisites" value="400"/>
   ```

4. Change the value from **400** to **800**.
5. Save the web.config file.
6. Run `IISReset`.

## Reference

- [Log files created by Windows Update](/windows/deployment/update/windows-update-logs)
- [Windows Update troubleshooting](/windows/deployment/update/windows-update-troubleshooting)
- [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors)
- [Troubleshooting issues with WSUS client agents](../../mem/configmgr/troubleshoot-issues-with-wsus-client-agents.md)
- [PowerShell script to decline superseded updates in WSUS](../../mem/configmgr/decline-superseded-updates.md)
- [Windows Server Update Services best practices](../../mem/configmgr/windows-server-update-services-best-practices.md)
- [WSUS client computers restart without any notification](../../mem/configmgr/wsus-client-computers-restart-automatically.md)
- [WSUS client takes too long to finish an update scan](../../mem/configmgr/wsus-client-long-time-finish-update-scan.md)
