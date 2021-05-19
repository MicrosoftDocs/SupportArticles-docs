---
title: Offline Servicing a wim image with Latest Cumulative Update may fail
description: Describes how to correct an issue when Offline Servicing may fail after you use Microsoft Endpoint Configuration Manager to perform Offline Servicing on a wim file with the Latest Cumulative Update.
ms.date: 05/19/2021
ms.prod-support-area-path:
---

# Offline Servicing a wim image with Latest Cumulative Update may fail

## Symptom

When you use the current branch of *Microsoft Endpoint Configuration Manager* to perform Offline Servicing on a `wim` file with the **Latest Cumulative Update** (LCU). To perform the servicing, you have imported a Windows 10 `install.wim` file, and then use the latest ADK.

In that scenario, Offline Servicing may fail with an error.

Sample:

1. You imported the following LCU: **W10 20H2 (updated Feb 2021) install.wim | Enterprise edition, EN, x64**
2. You perform Offline Servicing on that wim file with **2021-03 Cumulative Update for Windows 10 Version 20H2 for x64-based Systems** ([KB5000802](https://support.microsoft.com/topic/march-9-2021-kb5000802-os-builds-19041-867-and-19042-867-63552d64-fe44-4132-8813-ef56d3626e14))
3. You receive the following error messages in the **OfflineServicingMgr.log** file:

  ```output
  GetUpdateApplicability returned code 0x80004001~
  Applicability State = APPLICABILITY_CHECK_NOT_SUPPORTED, Update Binary = C:\ConfigMgr_OfflineImageServicing\73676b06-20a9-48a6-89c7-7646d20ce44f\Windows10.0-KB5000802-x64.cab.
  ```

## Cause

This problem is caused by a change inside the LCU, and occurs if you perform Offline Servicing with one of the following three (3) LCUs:

* 2021-03 Cumulative Update for Windows 10
* 2021-04 Cumulative Update for Windows 10
* 2021-05 Cumulative Update for Windows 10

  > [!Note]
  > This problem does not occur if you perform Offline Servicing with an LCU before **2021-03** (such as *2021-02 Cumulative Update for Windows 10*)

## Resolution/Workaround

1. Download the LCU you want to apply manually from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx). In the above sample, the LCU is [KB5000802](https://support.microsoft.com/topic/march-9-2021-kb5000802-os-builds-19041-867-and-19042-867-63552d64-fe44-4132-8813-ef56d3626e14).
2. Use **Dism** to manually apply the LCU to the wim image.

### Workaround Sample

The following example is a sample of the workaround. Be sure to adjust the used paths and the `/index:XY` as per your system needs.

```output
mkdir D:\_Mount
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /mount-wim /wimfile:"D:\temp\W10 20H2 (updated Feb-2021)\w10-20H2-install.wim" /mountdir:D:\_Mount /index:3
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /image:D:\_Mount /add-package /packagepath:"D:\temp\2021-03 Cumulative Update for Windows 10 Version 20H2 for x64-based Systems (KB5000802)\AMD64-all-windows10.0-kb5000802-x64_f1da84b3bfa1c402d98dfb3815b1f81d7dceb001.msu"
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /Image:"D:\_Mount" /Cleanup-Image /StartComponentCleanup /ResetBase
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" /unmount-wim /mountdir:D:\_Mount /commit
rmdir /Q /S D:\_Mount
```

## Additional information

A *wim* file may contain multiple Windows editions, such as [Windows 10 Education](https://support.microsoft.com/topic/windows-10-editions-for-education-customers-bf2572aa-5555-2b1e-f7ce-81e8ba890444) or [Windows 10 Enterprise](https://support.microsoft.com/windows/windows-10-enterprise-e3-89de5699-3030-eea1-ee49-1ccbcfe9413f).

You can query your wim file using the `/index` parameter to get the version information.

**Sample 1:** `dism /Get-WimInfo /WimFile:"D:\temp\W10 20H2 (updated Feb-2021)\w10-20H2-install.wim" /index:3`

**Sample 2:** `dism /Get-WimInfo /WimFile:"D:\temp\W10 20H2 (updated Feb-2021)\w10-20H2-install.wim" /index:1`
