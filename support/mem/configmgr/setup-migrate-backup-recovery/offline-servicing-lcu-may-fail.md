---
title: Offline servicing a WIM image with Latest Cumulative Update fails with error 0x80004001 "Applicability check not supported".
description: Describes how to correct a failed process if you use Microsoft Endpoint Configuration Manager to do Offline Servicing on a .wim file after you install the latest cumulative update for Windows 10.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Operating Systems Deployment (OSD)\Boot Images
---

# Error 0x80004001 "Applicability check not supported" when offline servicing a WIM image with the Latest Cumulative Update

## Symptoms

You use Microsoft Endpoint Configuration Manager current branch together with the latest ADK to do offline servicing on a .wim file by using the Latest Cumulative Update (LCU) for Windows 10. To do the servicing, you select an available operating system image in the Configuration Manager console from the *\Software Library\Overview\Operating Systems\Operating System Images* folder.

In this scenario, offline servicing fails and generates an error.

For example:

- You import the "Windows 10 20H2 (updated Feb 2021)" .wim file.
- You do offline servicing on this .wim file by using "2021-03 Cumulative Update for Windows 10 Version 20H2 for x64-based Systems" (KB 5000802).
- The following error entry is logged in the OfflineServicingMgr log:

  ```output
  GetUpdateApplicability returned code 0x80004001~
  Applicability State = APPLICABILITY_CHECK_NOT_SUPPORTED, Update Binary = C:\ConfigMgr_OfflineImageServicing\73676b06-20a9-48a6-89c7-7646d20ce44f\Windows10.0-KB5000802-x64.cab.
  ```

## Cause

This problem occurs only if you do offline servicing for one of the affected Windows versions in combination with any of the listed LCUs.

Affected Windows versions:

- Windows 10 21H1
- Windows 10 20H2
- Windows 10 20H1
- Windows 10 2004

Used together with the following LCUs:

- 2021-06 Cumulative Update for Windows 10
- 2021-05 Cumulative Update for Windows 10
- 2021-04 Cumulative Update for Windows 10
- 2021-03 Cumulative Update for Windows 10

  > [!NOTE]
  > This problem does not occur if you do offline servicing by using an earlier version LCU (such as "2021-02 Cumulative Update for Windows 10").

## Resolution

The issue is resolved in current Windows 10 releases.

We recommend that you use one of the following Windows versions to do offline servicing:

- Windows 10 21H1 (updated June 2021) or a later version
-    Windows 10 20H2 (updated May 2021) or a later version
-    Windows 10 20H1 (updated May 2021) or a later version
-    Windows 10 2004 (updated May 2021) or a later version

The issue is resolved in any .wim image that is on Build 985 (or a later build). Make sure that you use the appropriate build level by using an already updated image, such as Windows 10 21H1 (updated June 2021), or a later version. Alternatively, update your custom .wim image (one time) to Build 985 (or a later build) by using the workaround in the next section.

You can use the `dism` command to query the current build number of a .wim image.

### Query example

The following example shows how to query the current build number. The number will be listed as **ServicePack Build : XY**. Make sure that you adjust the paths and the **/index:XY** value per your system requirements.

`dism /Get-WimInfo /WimFile:"D:\temp\W10 20H2 (updated May-2021)\w10-20H2-install.wim" /index:3`

## Workaround

1. Download the LCU that you want to manually apply from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx). In the example that's described in the "Symptoms" section, the LCU is [KB 5000802](https://support.microsoft.com/topic/march-9-2021-kb5000802-os-builds-19041-867-and-19042-867-63552d64-fe44-4132-8813-ef56d3626e14).
2. Use the `dism` command to manually apply the LCU to the WIM image.

### Workaround example

The following example illustrates the recommended workaround. Make sure that you adjust the paths and the `/index:XY` value per your system requirements.

```output
mkdir D:\_Mount
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /mount-wim /wimfile:"D:\temp\W10 20H2 (updated Feb-2021)\w10-20H2-install.wim" /mountdir:D:\_Mount /index:3
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /image:D:\_Mount /add-package /packagepath:"D:\temp\2021-03 Cumulative Update for Windows 10 Version 20H2 for x64-based Systems (KB5000802)\AMD64-all-windows10.0-kb5000802-x64_f1da84b3bfa1c402d98dfb3815b1f81d7dceb001.msu"
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /Image:"D:\_Mount" /Cleanup-Image /StartComponentCleanup /ResetBase
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /unmount-wim /mountdir:D:\_Mount /commit
rmdir /Q /S D:\_Mount
```

## Additional information

A .wim file might contain multiple Windows editions, such as [Windows 10 Education](https://support.microsoft.com/topic/windows-10-editions-for-education-customers-bf2572aa-5555-2b1e-f7ce-81e8ba890444) or [Windows 10 Enterprise](https://support.microsoft.com/windows/windows-10-enterprise-e3-89de5699-3030-eea1-ee49-1ccbcfe9413f).

You can query the .wim file by using the `/index` parameter to get the version information.

**Example 1:** `dism /Get-WimInfo /WimFile:"D:\temp\W10 20H2 (updated Feb-2021)\w10-20H2-install.wim" /index:3`

**Example 2:** `dism /Get-WimInfo /WimFile:"D:\temp\W10 20H2 (updated Feb-2021)\w10-20H2-install.wim" /index:1`
