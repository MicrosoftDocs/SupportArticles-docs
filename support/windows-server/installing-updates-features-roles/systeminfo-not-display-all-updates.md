---
title: SystemInfo.exe doesn't display all updates
description: Works around an issue where SystemInfo.exe can't display all installed updates.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# SystemInfo.exe does not display all updates in Windows Server 2003

This article provides a workaround for an issue where SystemInfo.exe can't display all installed updates.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 2644427

## Symptoms

When using SystemInfo.exe in Windows Server 2003 to display a list of installed hotfixes, some hotfixes may not be listed if over 200 are installed.

## Cause

There is a buffer size limitation that does not allow all system update hotfixes to be displayed.

## Workaround

Microsoft is currently aware of this issue. To work around this issue, run the following command at a Windows command prompt:

```console
wmic qfe list
```

## More information

Windows Server 2003 is currently at end of life cycle and Service Packs are no longer being developed for this product. When installing a Service Pack, the number of hotfixes being shown by the SystemInfo.exe tool is reduced to a much smaller number.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
