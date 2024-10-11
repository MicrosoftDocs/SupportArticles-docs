---
title: Automatic deployment rule (ADR) fails to download updates
description: Fixes an issue in which updates aren't downloaded when you run an ADR. This issue is caused by excessive zero-byte .tmp files.
author: helenclu
ms.author: luche
ms.reviewer: kaushika, lamosley
ms.date: 12/05/2023
ms.custom: sap:Software Update Management (SUM)\Automatic Deployment Rules (ADR)
---
# Updates aren't downloaded when you run an ADR

*Applies to*: Configuration Manager current branch, versions 1910, 2002, 2006, and 2010

## Symptoms

You use an automatic deployment rule (ADR) to deploy software updates. However, the updates aren't downloaded when you run the ADR. Additionally, you receive the following error messages in the Patchdownloader.log file:

```output
Failed to create temp file with GetTempFileName() at temp location C:\Windows\TEMP\, error 80 Software Updates Patch Downloader 

ERROR: DownloadUpdateContent() failed with hr=0x80070050 Software Updates Patch Downloader 
```

When this problem occurs, the c:\windows\temp directory contains more than 65,535 0-byte .tmp files.

## Cause

This problem is caused by an issue in the following Microsoft Endpoint Configuration Manager updates:

- [Office updates fail to download in Configuration Manager current branch, version 1910](https://support.microsoft.com/topic/office-updates-fail-to-download-in-configuration-manager-current-branch-version-1910-5c9d6432-0c49-f118-17ba-6f715982b6a2)
- [Office updates fail to download in Configuration Manager current branch, version 2002](https://support.microsoft.com/topic/office-updates-fail-to-download-in-configuration-manager-current-branch-version-2002-cb77b9d9-5cd8-88c2-044e-f98e11c32f80)
- [Update Rollup for Microsoft Endpoint Configuration Manager version 2006](https://support.microsoft.com/topic/update-rollup-for-microsoft-endpoint-configuration-manager-version-2006-2986e36e-a634-7756-163f-4c17cb776c2f)

The .tmp files are created but not removed. This problem occurs if the number of .tmp files exceeds 65,535.

## Resolution

This problem is fixed in [Update Rollup for Microsoft Endpoint Configuration Manager current branch, version 2010](https://support.microsoft.com/topic/update-rollup-for-microsoft-endpoint-configuration-manager-current-branch-version-2010-403fa677-e418-e39d-6eb6-f279ea991a95).

The fix will be included in Configuration Manager current branch, version 2103.

To fix the problem in Configuration Manager current branch, versions 1910, 2002, and 2006, delete the .tmp files in c:\windows\temp, and then rerun the ADR.
