---
title: Troubleshoot Windows Installation Error 0x800f0831
description: Learn how to resolve Windows installation error 0x800f0831.
ms.date: 07/31/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---

# Troubleshoot Windows Installation Error 0x800f0831

> [!WARNING]
> This error is flagged to have an IPU performed to recover the VM if the instructions do not resolve the issue.

The Windows Update error 0x80070002 typically occurs because of missing or corrupt files necessary for the update or incomplete previous updates. Understanding the root causes and following the appropriate troubleshooting steps can help resolve this issue effectively.

## Summary

When you install an update, you can get the following error 0x800f0831 (CBS_E_STORE_CORRUPTION.). This error occurs because an update did not install properly some mandatory manifest files for the package.
This TSG is designed to mitigate this issue and be able to install the updates needed.

## Symptom

:::image type="content" source="../../../SharePoint/SharePointOnline/Media/download-and-install-updates .jpg" alt-text="Download and install error":::

:::image type="content" source="../../../SharePoint/SharePointOnline/Media/windows-update.jpg" alt-text="Windows update error message"::::

:::image type="content" source="../../../SharePoint/SharePointOnline/Media/retry-deba.jpg" alt-text="Retry screenshot":::

When you try to install any patch using the standalone installer (.msu) or Windows Update and the update was not installed:

## Root cause

In order to see exactly what is happening, we need to open and check the CBS.log (location C:\windows\logs\CBS) it looks similar to the following output:

## CBS logs

```output
2017-11-15 12:40:00, Info CBS Store corruption, manifest missing for package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4

2017-11-15 12:40:00, Error CBS Failed to resolve package 'Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4' [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

2017-11-15 12:40:00, Info CBS Mark store corruption flag because of package: Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4. [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]

2017-11-15 12:40:00, Info CBS Failed to resolve package [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]
```

- For this specific scenario, it happens because there is an assembly missing or corrupted from the KB3192392, specifically "Package_123_for_KB3192392~31bf3856ad364e35~amd64~~6.3.1.4" these packages are located into the registy path: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages. An update either was not installed at all, or it was installed without applying some packages to the registry.

> [!IMPORTANT]
> This issue may vary depending on each case but the baseline of the issue is the same.

> [!NOTE]
> To get the CBS.log or logs, you can use the TSSv2 to collect all the logs  you need for such cases. For more information see, [CBS logs](https://aka.ms/dndlogs).

## Mitigation

Backup
Before proceeding with the mitigation of this document, follow the process to backup the OS disk: Back up OS Disk

## Online Mitigation

### Mitigation 1

We need to move to the plan, to either add or remove the culprit KB manually from the OS. It depends if the update was installed or not before:

### If KB was installed:

1. Check if the complaining KB that we took from the first step to identify the KB is installed or not in the machine. If it is not installed proceed to the "If KB was not installed" steps.
1. If you found that the KB was installed, you need to remove it, the best approach is the following steps:

### Instructions

1. Reproduce the issue by trying to install the patch or the feature with issues. We need to do this step to ensure that the latest data is logged into the latest CBS.log.
1. Identify the package that the CBS process is complaining about, ensure you verify the KB as well.
1. In any web browser, go to [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx).
1. Search for the  identified KB number. 
1. Select and download the proper KB depending on the OS version and architecture
1. When you download the KB, paste it into a temp folder in the C drive C:\temp
1. When we have the KB there, we need to run the command in cmd as admin navigating to the folder itself

```output
cd \
cd temp
expand -F:* windows10.0-kb4462937-x64_9e250691ae6d00cdf677707e83435a612c3264ea.msu C:\temp
```

> [!NOTE]
> The file name is just an example. Use the name of the file downloaded.

8. When you expand it, you can see several packages that are coming from the main package. Check the .cab file with the format "windows 10.0-KBxxxxxxx-x64.cab" (this file can vary depending on the OS version).
9. Then we need to run the command in cmd as admin:

```output
Dism /online /remove-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
```

> [!NOTE]
> We are using KB4462937 as an example, remember to use the KB extracted into the c:\temp folder

10. If you are asked to reboot, do it and then run the command in a cmd with administrator privileges. If the reboot is not required, just run the command in a cmd with administrator privileges:

```output
Dism /online /add-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
```

11. Reboot the machine
12. Try again to install the update or feature

### If KB was not installed:

1. Download the KB that we identified from [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx).
1. When you have it move it to a temp folder in the C drive C:\temp
1. When we have it, we need to run the command in cmd as admin navigating to the folder itself.

```output
cd \
cd temp
expand -F:* windows10.0-kb4462937-x64_9e250691ae6d00cdf677707e83435a612c3264ea.msu C:\temp 
```

> [!NOTE]
> The file name is just an example, use the name of the file downloaded.

4. When you expand it, you can see several packages that are coming from the main package.
5. Then we need to run the command in cmd as admin:

```output
Dism /online /add-package /packagepath:C:\temp\windows10.0-kb4462937-x64.cab
```

> [!NOTE]
> We are using KB4462937 as an example, remember to use the KB extracted into the c:\temp folder 7. Reboot the machine 8. Try again to install the update or feature.

### IPU Process (In-place Upgrade)

> [!NOTE]
> Awareness: If the mitigations given did not fix the issue, this specific Windows Update (WU) error code is identified that may require an In-Place Upgrade (IPU) to recover the virtual machine (VM). For Windows on Azure (WOA) scenarios—especially in alignment with efforts to reduce days to closure—these WU errors are reviewed and approved as eligible for IPU as a simplified recovery path. Customers encountering these specific issues can be confidently offered the in-place upgrade option as an effective resolution.