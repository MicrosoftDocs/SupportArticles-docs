---
title: Offline Servicing a wim image with Latest Cumulative Update may fail
description: Describes how to correct an issue when Offline Servicing may fail after you use Microsoft Endpoint Configuration Manager to perform Offline Servicing on a wim file with the Latest Cumulative Update.
ms.date: 05/19/2021
ms.prod-support-area-path:
---

# Offline Servicing a wim image with Latest Cumulative Update may fail

## Symptoms

You use Microsoft Endpoint Configuration Manager current branch to do offline servicing on a WIM image by using the Latest Cumulative Update (LCU) for Windows 10. To do the offline servicing, you import a Windows 10 install.wim file and the latest ADK.

In this scenario, offline servicing fails and generates an error.

### Example

1. You import the install.wim for Windows 10, version 2024 (Enterprise edition, EN, x64) that has the February 2021 cumulative update installed.
2. You do offline servicing on this .wim file by using ([March 2021 Cumulative Update for Windows 10 Version 20H2 for x64-based Systems](https://support.microsoft.com/topic/march-9-2021-kb5000802-os-builds-19041-867-and-19042-867-63552d64-fe44-4132-8813-ef56d3626e14)) (OS Builds 19041.867 and 19042.867).
3. The following error entry is logged in the OfflineServicingMgr log:

   ```output
   GetUpdateApplicability returned code 0x80004001~
   Applicability State = APPLICABILITY_CHECK_NOT_SUPPORTED, Update Binary = C:\ConfigMgr_OfflineImageServicing\73676b06-20a9-48a6-89c7-7646d20ce44f\Windows10.0-KB5000802-x64.cab.
   ```

## Cause

This problem is caused by a change in the LCU. It occurs if you do offline servicing by using any of the following LCUs:

- May 2021 Cumulative Update for Windows 10
- April 2021 Cumulative Update for Windows 10
- March 2021 Cumulative Update for Windows 10

> [!Note]
> This problem does not occur if you do offline servicing by using an earlier version LCU (such as the February 2021 Cumulative Update for Windows 10).

## Workaround

1. Download the LCU that you want to manually apply from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx). In the example that's described in the "Symptoms" section, the LCU is [KB5000802](https://support.microsoft.com/topic/march-9-2021-kb5000802-os-builds-19041-867-and-19042-867-63552d64-fe44-4132-8813-ef56d3626e14).
2. Use the `dism` command to manually apply the LCU to the WIM image.

### Example

The following example illustrates the recommended workaround. Make sure that you adjust the paths and the “/index:XY” value per your system requirements.

```console
mkdir D:\_Mount
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /mount-wim /wimfile:"D:\temp\W10 20H2 (updated Feb-2021)\w10-20H2-install.wim" /mountdir:D:\_Mount /index:3
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /image:D:\_Mount /add-package /packagepath:"D:\temp\2021-03 Cumulative Update for Windows 10 Version 20H2 for x64-based Systems (KB5000802)\AMD64-all-windows10.0-kb5000802-x64_f1da84b3bfa1c402d98dfb3815b1f81d7dceb001.msu"
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /Image:"D:\_Mount" /Cleanup-Image /StartComponentCleanup /ResetBase
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /unmount-wim /mountdir:D:\_Mount /commit
rmdir /Q /S D:\_Mount
```

## Additional information

A .wim file might contain multiple Windows editions (such as [Windows 10 Education](https://support.microsoft.com/topic/windows-10-editions-for-education-customers-bf2572aa-5555-2b1e-f7ce-81e8ba890444) or [Windows 10 Enterprise](https://support.microsoft.com/windows/windows-10-enterprise-e3-89de5699-3030-eea1-ee49-1ccbcfe9413f)).

You can query the .wim file by using the `/index` parameter to get the version information.

### Example 1

```console
dism /Get-WimInfo /WimFile:"D:\temp\W10 20H2 (updated Feb-2021)\w10-20H2-install.wim" /index:3
```

### Example 2

```console
dism /Get-WimInfo /WimFile:"D:\temp\W10 20H2 (updated Feb-2021)\w10-20H2-install.wim" /index:1
```
