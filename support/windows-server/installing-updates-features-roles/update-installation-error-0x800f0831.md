---
title: Update Installation Error 0x800f0831 CBS E STORE CORRUPTION_Windows
description: Learn how to resolve Windows Update error 0x8024002E, indicating that access to an unmanaged server isn't allowed.
ms.date: 07/32/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---
> [!WARNING]
> This error has been flagged to have an IPU performed to recover the VM if the instructions below do not resolve the issue.

# Troubleshoot Windows Update error 0x80070002

The Windows Update error 0x80070002 typically occurs because of missing or corrupt files necessary for the update or incomplete previous updates. Understanding the root causes and following the appropriate troubleshooting steps can help resolve this issue effectively.

## Summary
When you install an update you can get the following error 0x800f0831 (CBS_E_STORE_CORRUPTION.).This happens because an update did not install properly some mandatory manifest files for the package..
This TSG is designed to mitigate this issue and be able to install the updates needed.

## Symptom
When you try to install any patch using the standalone installer (.msu) or Windows Update and the update was not installed:

:::image type="content" source="../../../SharePoint/SharePointOnline/Media/Download and Install Updates Screenshot.jpg" alt-text="Download and install updates screenshot":::

:::image type="content" source="../../../SharePoint/SharePointOnline/Media/Windows updates screenshot.jpg" alt-text="Windows update screenshot":::

:::image type="content" source="../../../SharePoint/SharePointOnline/Media/Retry screenshot.jpg" alt-text="Retry screenshot":::

## Root cause

In order to see exactly what is happening we need to open and check the CBS.log (location C:\windows\logs\CBS) it will look similar to the following output:

## CBS logs

```output
2017-11-15 12:40:00, Info CBS Store corruption, manifest missing for package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4

2017-11-15 12:40:00, Error CBS Failed to resolve package 'Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4' [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

2017-11-15 12:40:00, Info CBS Mark store corruption flag because of package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4. [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

2017-11-15 12:40:00, Info CBS Failed to resolve package [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]
```

- For this specific scenario, this is happening because there is an assembly missing or corrupted from the KB3192392, specifically "Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4" these packages are located into the registy path: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages. This can happen if the update was never installed or was installed but some packages were not applied into the registry.

> [!IMPORTANT]
> This may vary depending on each case but the baseline of the issue will be the same.

> [!NOTE]
> To get the CBS.log or logs you can use the TSSv2 to collect all the logs that you need for these type of cases, the information in how to do it will be in https://aka.ms/dndlogs

## Mitigation

### Backup
Before proceeding with the mitigation of this document, please follow the process to backup the OS disk: Backup OS Disk

## Online Mitigation


### Mitigation 1

We will need to move to the plan that is to add or remove the culprit KB manually from the OS, it depends if the update has been installed or not before:

### If KB was installed:

1. Check if the complaining KB that we took from the first step to identify the KB is installed or not in the machine, if it is not installed proceed to the "If KB was not installed" steps below.
1. If you found that the KB was installed we need to remove it, the best approach is the following:

### Instructions

1. Reproduce the issue by trying to install the patch or the feature with issues (we need to do this to ensure that the latest data is logged into the latest CBS.log).
1. Now that we have identified the package that the CBS process is complaining about, ensure you have verified the KB as well.
1. Now in any web browser go the Microsoft Update Catalog: https://www.catalog.update.microsoft.com/Home.aspx 
1. Search for the KB number we have already identified
1. Select and download the proper KB depending on the OS version and architecture
1. Once you have downloaded the KB, paste it into a temp folder in the C drive C:\temp
1. Once we have the KB there we need to run the below command in cmd as admin navigating to the folder itself

```output
cd \
cd temp
expand -F:* windows10.0-kb4462937-x64_9e250691ae6d00cdf677707e83435a612c3264ea.msu C:\temp
```

> [!NOTE]
> The file name is just an example, please use the name of the file downloaded.

8. Once we have expanded it, we will see several packages that are coming from the main package. Check the .cab file with the format "windows 10.0-KBxxxxxxx-x64.cab" (this file can vary depending on the OS version).
9. Then we need to run the below command in cmd as admin:

```output
Dism /online /remove-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
```

> [!NOTE]
> We are using KB4462937 as an example, remember to use the KB extracted into the c:\temp folder

10. If you are asked to reboot, please do it and then run the below command in a cmd with administrator privileges. If the reboot is not required, just run the below command in a cmd with administrator privileges:

```output
Dism /online /add-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
```

11. Reboot the machine
12. Try again to install the update or feature

### If KB was not installed:

1. Download the KB that we have identified from the Microsoft update catalog: https://www.catalog.update.microsoft.com/Home.aspx 
1. Once you have it move it to a temp folder in the C drive C:\temp
1. Once we have it we need to run the below command in cmd as admin navigating to the folder itself.

```output
cd \
cd temp
expand -F:* windows10.0-kb4462937-x64_9e250691ae6d00cdf677707e83435a612c3264ea.msu C:\temp 
```

(note: the file name is just an example, please use the name of the file downloaded)

4. Once we have expanded it, we will see several packages that are coming from the main package.
5. Then we need to run the below command in cmd as admin:

```output
Dism /online /add-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
```

> [!NOTE]
> We are using KB4462937 as an example, remember to use the KB extracted into the c:\temp folder 7. Reboot the machine 8. Try again to install the update or feature.

### IPU Process (In-place Upgrade)

**Awareness:If the mitigations given did not fix the issue, this specific Windows Update (WU) error code have been identified that may require an In-Place Upgrade (IPU) to recover the virtual machine (VM). For Windows on Azure (WOA) scenarios—especially in alignment with efforts to reduce days to closure—these WU errors have been reviewed and approved as eligible for IPU as a simplified recovery path. Customers encountering these specific issues can be confidently offered the in-place upgrade option as an effective resolution."**