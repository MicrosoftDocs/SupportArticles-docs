---
title: Update Installation Error 0x800f0831 CBS E STORE CORRUPTION_Windows
description: Learn how to resolve Installation Error 0x800f0831 CBS E STORE CORRUPTION_Windows.
ms.date: 08/01/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---
# Troubleshoot Windows Update Installation Error 0x800f0831 CBS_E_STORE_CORRUPTION
Windows Update error 0x800f0831 (CBS_E_STORE_CORRUPTION) typically occurs when an update fails to install required package files properly.
This article helps you understand the root cause and the necessary steps required to mitigate the issue and install the updates effectively.
> [!WARNING]
> This error has been flagged to have an IPU performed to recover the VM if the instructions below do not resolve the issue."

## Prerequisites
Before proceeding with the mitigation of this document, please follow the process to backup the OS disk: [Backup OS Disk](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/495352/Network-Level-Authentication_RDP-SSH?anchor=%3Cspan-class%3D%22mw-customtoggle-mydivision%22%3Ebackup-os-disk%3C/span%3E)

## Symptom

There following error message appears when you try to install any patch using the standalone installer (.msu) or try to install a Windows update:

:::image type="content" source="media/following-updates-were-not-installed.png" alt-text="screenshot of installation error":::

:::image type="content" source="media/windows-update-failed.png" alt-text="screenshot of windows update failed":::

## Root Cause

To identify the cause of the issue, check the CBS.log file located at C:\Windows\Logs\CBS. This log contains detailed information about update-related errors and will help determine what’s causing the error.
## CBS.log:
```output
Info CBS Store corruption, manifest missing for package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4

Error CBS Failed to resolve package 'Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4' [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

Info CBS Mark store corruption flag because of package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4. [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

sInfo CBS Failed to resolve package [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]
```
The  issue can occure due to the following scenarios: 
- This issue is occurring due to a missing or corrupted assembly from KB3192392, specifically: "Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4"
- This can also happen if the update was never installed and in some cases even if the installation happened, some packages were not applied to the registry. 

To locate these packages in the system: Go the registry path:
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages

> [!IMPORTANT]
> This may vary depending on each case, but the baseline of the issue remains the same 
> [!NOTE]
> For more information on how to collect the CBS.log or just logs using TSSv2, see https://aka.ms/dndlogs.
## Adding or removing the culprit KB manually:
Add or remove the culprit KB manually from the OS. You’ll have to consider if the update has been installed before or not:
 
### If KB is installed:  
1. Reproduce the issue by trying to install the patch or the feature with issues. This ensures that the latest data is logged into the latest CBS.log
1. Verify the KB after you have identified the package that the CBS process is complaining about.
1. Navigate to [Microsoft Update Catalog](https://microsoft-my.sharepoint.com/personal/v-sisidhu_microsoft_com/Documents/Microsoft%20Update%20Catalog) and search for the KB number you have identified.
1. Select the KB and download it, depending on the OS version and architecture.
1. Paste the downloaded KB into a temporary folder in the C drive: C:\temp 
1. Run the following command in cmd as admin navigating to the folder. 
```output
cd \
cd temp
expand -F:* windows10.0-kb4462937-x64_9e250691ae6d00cdf677707e83435a612c3264ea.msu C:\temp 
```
> [!NOTE]
> This is just an example of how you should name the file. In your case, use the name of downloaded file. 
7. On expanding, you’ll see several packages coming from the main package.  Check the **.cab** file with the format "windows 10.0-KBxxxxxxx-x64.cab" (this file can vary depending on the OS version).
8. Run the following command in cmd as admin:
```output
Dism /online /remove-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
```
> [!NOTE]
> We are using KB4462937 as an example here. Remember to use the KB extracted into the c:\temp folder
9. If you are asked to reboot, please do it and then run the following command in a **cmd** with administrator privileges. If the reboot is not required, just run the following command in a cmd with administrator privileges:
```output
Dism /online /add-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
```
10. Reboot the machine and Try again to install the update or the feature.
### If KB isn't installed:
1. Download the KB that we have identified from the [Microsoft update catalog](https://www.catalog.update.microsoft.com/Home.aspx): 
1. Paste the downloaded KB into a temporary folder in the C drive: C:\temp
1. Run the following command in cmd as admin navigating to the folder.
```output
 cd \
cd temp
expand -F:* windows10.0-kb4462937-x64_9e250691ae6d00cdf677707e83435a612c3264ea.msu C:\temp 
```
> [!NOTE]
> This is just an example of how you should name the file. In your case, use the name of downloaded file.
5. On expanding, you’ll see several packages coming from the main package.
6. Run the following command in cmd as admin: 
 ```output
Dism /online /add-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
```
> [!NOTE]
> We are using KB4462937 as an example. Remember to use the KB extracted into the c:\temp folder
7. Reboot the machine.
8. Try again to install the update or the feature.
> [!NOTE]
> IPU Process (In-place Upgrade): If the recommended mitigations do not resolve the issue, a specific Windows Update (WU) error code has been identified that may require an In-Place Upgrade (IPU) to restore the virtual machine (VM). In Windows on Azure (WOA) scenarios, in alignment with efforts to reduce days to closure — these WU errors have been reviewed and approved as eligible for IPU as a simplified recovery path. Customers encountering these specific issues can be confidently offered the in-place upgrade option as an effective resolution.