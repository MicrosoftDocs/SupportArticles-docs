---
title: Guidance for troubleshooting Windows Server update
description: Introduces general guidance for troubleshooting scenarios related to Windows Server update.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Windows Server update troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806295" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Windows Update issues.

This solution is designed to get you started on Windows Update troubleshooting scenarios.

## Troubleshooting checklist

### Step 1: Identify the issue by examining the event log for specific errors

1. Open Event Viewer from the **Control Panel** > **Administrative Tools**.
2. Look for Windows Update Agent events in the System log, and the errors in the System and Application logs around the same time that updates were applied.
3. Expand the Event Viewer tree to **Application and Service Logs** > **Microsoft** > **Windows** > **WindowsUpdateClient** > **Operational**.
4. Identify the Update that is failing to install and the failure code.
5. Find the error and the resolution in [Common Windows Update errors](/windows/deployment/update/windows-update-errors) or [Windows Update error codes by component](/windows/deployment/update/windows-update-error-reference).

### Step 2: Check for Pending Reboot state

If the computer hasn't been restarted, restart the computer.

### Step 3: Services Stack update

Install the latest servicing stack update. See [Latest Servicing Stack Updates](https://msrc.microsoft.com/update-guide/vulnerability/ADV990001).

### Step 4: Run the Windows Update troubleshooter for Windows

1. Download the troubleshooter, and select **Open** or **Save** in the pop-up window. (If you choose **Save**, you'll need to open the troubleshooter from the save location.)
2. Select **Next** to start the troubleshooter, and follow the steps to identify and fix any issues.
3. After the troubleshooter finishes, try running Windows Update again. From the **Start** button, select **Settings** > **Update & security** > **Windows Update** > **Check for updates**, and  install any available updates.
4. If applicable, [Reset windows update components](https://support.microsoft.com/kb/971058).

### Step 5: Use DISM or System Update Readiness tool to troubleshoot Windows Update issue

See [Fix Windows Update errors by using the DISM or System Update Readiness tool](fix-windows-update-errors.md) for more information.

## Common issues and solutions

### You receive "Update not applicable" error message

Error message  
> The update is not applicable to your computer.

#### Cause 1: Update is superseded

To troubleshoot this issue, check that the package that you are installing contains newer versions of the binaries. Alternatively, check that the package is superseded by another new package.

#### Cause 2: Update is already installed

To troubleshoot this issue, verify that the package that you are trying to install isn't already installed.

#### Cause 3: Wrong update for architecture

To troubleshoot this issue, verify that the package that you're trying to install matches the Windows version that you are using. The Windows version information can be found in the "Applies To" section of the article for each update. For example, Windows Server 2012-only updates cannot be installed on Windows Server 2012 R2-based computers.  
Verify that the package you want to install matches the processor architecture of the Windows version that you are using. For example, an x86-based update can't be installed on x64-based installations of Windows.

#### Cause 4: Missing prerequisite update

To troubleshoot this issue, read the package’s related article to find out whether the prerequisite updates are installed. For example, if you receive the error message in Windows 8.1 or Windows Server 2012 R2, you might have to install the April 2014 update 2919355 as a prerequisite and one or more pre-requisite servicing updates (KB 2919442 and KB 3173424).  
To determine if these prerequisite updates are installed, run this PowerShell command:  
`get-hotfix KB3173424, KB2919355, KB2919442`  
If the updates are installed, the command returns the installed date in the InstalledOn section of the output.

### Updates aren't downloading from Windows Server Update Services (WSUS) or Configuration Manager

Error message:  
> Failed to connect to Mux due to network or cert errors  

To troubleshoot this issue, check the numeric code provided in the error message code: this corresponds to the winsock error code. Certificate errors are granular (for example, cert cannot be verified, cert not authorized, etc.)

### The device isn't receiving an update that you deployed

To troubleshoot this issue, follow these steps:

1. Check that the device’s updates for the relevant category aren’t paused. See [Pause feature updates](/windows/deployment/update/waas-configure-wufb#pause-feature-updates) and [Pause quality updates](/windows/deployment/update/waas-configure-wufb#pause-quality-updates).
2. Feature updates only: The device might have a safeguard hold applied for the given feature update version. For more information about safeguard holds, see [Safeguard holds](/windows/deployment/update/safeguard-holds) and [Opt out of safeguard holds](/windows/deployment/update/safeguard-opt-out).
3. Check that the deployment to which the device is assigned has the state **offering**. Deployments that have the states **paused** or **scheduled** won't deploy content to devices.
4. Check that the device has scanned for updates and is scanning the Windows Update service. To learn more about scanning for updates, see [Scanning updates](/windows/deployment/update/how-windows-update-works#scanning-updates).
5. Feature updates only: Verify that the device is successfully enrolled in feature update management by the deployment service. A device that is successfully enrolled is represented by a Microsoft Entra device resource with an update management enrollment for feature updates and has no Microsoft Entra device registration errors.
6. Expedited quality updates only: Check that the device has the Update Health Tools installed (available for Windows 10 version 1809 or later in the update described in [KB 4023057 - Update for Windows 10 Update Service components](https://support.microsoft.com/topic/kb4023057-update-for-windows-10-update-service-components-fccad0ca-dc10-2e46-9ed1-7e392450fb3a), or a more recent quality update). The Update Health Tools are required for a device to receive an expedited quality update. The program’s location on the device is *C:\\Program Files\\Microsoft Update Health Tools*.  
   To verify its presence, view the installed programs list or use this PowerShell script:

   ```powershell
   Get-WmiObject -Class Win32\_Product \| Where-Object {$\_.Name -amatch "Microsoft Update Health Tools"}
   ```

### The device is receiving an update that you didn't deploy

To troubleshoot this issue, follow these steps:

1. Check that the device is scanning the Windows Update service and not a different endpoint. If the device is scanning for updates from a WSUS endpoint, for example, it might receive different updates. To learn more about scanning for updates, see [Scanning updates](/windows/deployment/update/how-windows-update-works#scanning-updates).
2. Feature updates only: Check that the device is successfully enrolled in feature update management by the deployment service. A device that isn't successfully enrolled might receive different updates according to its feature update deferral period. A device that is successfully enrolled is represented by a Microsoft Entra device resource with an update management enrollment for feature updates and has no Microsoft Entra device registration errors.

## WSUS troubleshooting  

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

To fix the issue, follow these steps on the WSUS server:

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

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

## Reference

- [Log files created by Windows Update](/windows/deployment/update/windows-update-logs)
- [Windows Update troubleshooting](/windows/deployment/update/windows-update-troubleshooting)
- [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors)
- [Troubleshooting issues with WSUS client agents](../../mem/configmgr/troubleshoot-issues-with-wsus-client-agents.md)
- [PowerShell script to decline superseded updates in WSUS](../../mem/configmgr/decline-superseded-updates.md)
- [Windows Server Update Services best practices](../../mem/configmgr/windows-server-update-services-best-practices.md)
- [WSUS client computers restart without any notification](../../mem/configmgr/wsus-client-computers-restart-automatically.md)
- [WSUS client takes too long to finish an update scan](../../mem/configmgr/wsus-client-long-time-finish-update-scan.md)
