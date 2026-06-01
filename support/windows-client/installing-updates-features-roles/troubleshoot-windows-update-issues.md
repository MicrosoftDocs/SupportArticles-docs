---
title: Guidance for troubleshooting Windows Update issues
description: Discusses how to troubleshoot Windows Update issues and identify and fix common issues.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate, lumenahe
ms.custom:
- sap:windows servicing, updates and features on demand\windows update - install errors unknown or code not listed
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---

# Windows Update troubleshooting guidance

<p class="alert is-flex is-primary"><span class="has-padding-left-medium has-padding-top-extra-small"><a class="button is-primary" href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806295" target='_blank'><b>Try our Virtual Agent</b></a></span><span class="has-padding-small"> - It can help you quickly identify and fix common Windows Update issues</span>

## Summary

This article helps you diagnose and resolve common Windows Update issues. It includes step-by-step guidance for initial troubleshooting procedures that restore Windows Update functionality in most cases. It includes more in-depth guidance to address specific symptoms and error messages. For some more complicated issues, the article directs you to a more in-depth discussion of the specific issue.

## Troubleshooting checklist

### Step 1: Run the diagnostic tool for your version of Windows

For any [supported versions of Windows](/windows/release-health/supported-versions-windows-client), open an administrative command prompt window, and then run the following command:  

  ```cmd
  Dism /online /cleanup-image /restorehealth
  ```

### Step 2: Restart the computer

If the computer didn't restart after a previous update, pending actions might still have to finish before you can apply new updates.

### Step 3: Install the latest servicing stack update

For more information, see [Latest Servicing Stack Updates](https://msrc.microsoft.com/update-guide/vulnerability/ADV990001) or review the update history for your Windows version to identify the latest servicing stack that's required for the latest cumulative update.

### Step 4: Check for and fix any Windows file corruption

For more information, see [Fix Windows file corruption](../../windows-server/deployment/fix-windows-update-errors.md).

### Step 5: Download the update package and try to install the update manually

Follow these steps:

1. Open [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/home.aspx).
1. In the search box, type the update number that you want to download, and then select **Search**.
1. Find the update that applies to your operating system in the search results. Next to that update, select **Add** to add the update to your basket.
1. Select **View basket**, and then select **Download**.
1. To choose a destination for the update, select **Browse**, and then select **Continue**.
1. When the download process finishes, select **Close**.
1. Browse to the download location, and then double-click the download package to install the update.

> [!NOTE]
> To skip Windows Update agent applicability checks and make the installation go further or quicker, open an elevated command prompt and run the following command:
>
> ```cmd
> Dism /online /add-package /packagepath:<path_to_package>
> ```

## Common issues and solutions

### Error: The update is not applicable to your computer

This error has several possible causes. The following instructions help you identify the specific cause that affects you.

#### Step 1: Has the update been superseded?

Make sure that the update package contains newer versions of the binaries than the system that you're updating. Alternatively, check the [Microsoft Update Catalog](https://catalog.update.microsoft.com/home.aspx) to see if a newer update has superseded the update that you're trying to install.

As updates for a component are released, the updated component supersedes the older component that is already on the system. When this occurs, Windows marks the previously-installed update as superseded. If the update that you're trying to install already has a newer version of the payload that's on your system, you might receive this error message.

#### Step 2: Has the update already been installed?

Verify that the package that you're trying to install isn't already installed.

#### Step 3: Is the update appropriate for this architecture?

1. Verify that the package that you're trying to install matches the Windows version that you're using.  

   The Windows version information can be found in the "Applies To" section of the article for each update. For example, Windows Server 2019 updates can't be installed on Windows Server 2016, or Windows Server updates on a Windows client.

1. Verify that the package you want to install matches the processor architecture of the Windows version that you're using.  

   For example, an x86-based update can't be installed on x64-based installations of Windows.

#### Step 4: Have all prerequisite updates been installed?

Read the package's related article to find out if the prerequisite updates are installed. For example, if you receive the error message in Windows 10, version 22H2 update [Windows July 23, 2024—KB5040525 (OS Build 19045.4717) Preview](https://support.microsoft.com/topic/july-23-2024-kb5040525-os-build-19045-4717-preview-381f029e-b20e-4a0f-9b7e-695ee7845168), you might have to install KB50282445, KB5031539, or more prerequisite servicing updates.

To determine whether these prerequisite updates are installed, open a Windows PowerShell window and run the following command:  

```powershell
Get-HotFix KB50282445, KB5031539
```

If the updates are installed, the command returns the installed date in the **InstalledOn** section of the output.

### The device isn't receiving an update that you deployed

To troubleshoot this issue, follow these steps.

1. Check that the device's updates for the relevant category aren't paused.  

   For more information, see [Pause feature updates](/windows/deployment/update/waas-configure-wufb#pause-feature-updates) and [Pause quality updates](/windows/deployment/update/waas-configure-wufb#pause-quality-updates).
1. **Feature updates only:** Check to see if the device might have a safeguard hold applied for the given feature update version.  

   For more information about safeguard holds, see [Safeguard holds](/windows/deployment/update/safeguard-holds) and [Opt out of safeguard holds](/windows/deployment/update/safeguard-opt-out).
1. Check that the deployment to which the device is assigned has the state **offering**. Deployments that have the states **paused** or **scheduled** don't deploy content to devices.
1. Check that the device has scanned for updates and is scanning the Windows Update service.  

   To learn more about scanning for updates, see [Scanning updates](/windows/deployment/update/how-windows-update-works#scanning-updates).
1. **Feature updates only:** Verify that the device is successfully enrolled in feature update management by the deployment service. A device that's successfully enrolled is represented by a Microsoft Entra ID device resource. That resource documents an update management enrollment for feature updates, and has no Microsoft Entra ID device registration errors.
1. **Expedited quality updates only:** Check that the device has the Update Health Tools installed (available for Windows 10 version 1809 or later in the update described in [KB 4023057 - Update for Windows 10 Update Service components](https://support.microsoft.com/topic/kb4023057-update-for-windows-10-update-service-components-fccad0ca-dc10-2e46-9ed1-7e392450fb3a), or a more recent quality update).  

   The Update Health Tools are required for a device to receive an expedited quality update. The program's location on the device is *C:\\Program Files\\Microsoft Update Health Tools*. To verify its presence, view the installed programs list or run the following PowerShell script:  

   ```powershell
   Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -Match "Microsoft Update Health Tools"}
   ```

### The device is receiving an update that you didn't deploy

To troubleshoot this issue, follow these steps:

1. Check that the device is scanning the Windows Update service and not a different endpoint.  

   For example, if the device is scanning for updates from a Windows Server Update Service (WSUS) endpoint, it might receive different updates. To learn more about scanning for updates, see [Scanning updates](/windows/deployment/update/how-windows-update-works#scanning-updates).
1. **Feature updates only:** Check that the device is successfully enrolled in feature update management by the deployment service.  

   A device that isn't successfully enrolled might receive different updates according to its feature update deferral period. A device that's successfully enrolled is represented by a Microsoft Entra ID device resource. That resource documents an update management enrollment for feature updates, and has no Microsoft Entra ID device registration errors.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

## References

- [Log files created by Windows Update](/windows/deployment/update/windows-update-logs)
- [Windows Update troubleshooting](/windows/deployment/update/windows-update-troubleshooting)
- [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors)
- [Windows 11 update history](https://support.microsoft.com/topic/july-25-2024-kb5040527-os-builds-22621-3958-and-22631-3958-preview-de3e1e24-0c07-4210-9777-8e03a1446bae)

