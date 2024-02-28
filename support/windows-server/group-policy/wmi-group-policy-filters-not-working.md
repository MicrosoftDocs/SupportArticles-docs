---
title: WMI Group Policy filters don't work
description: Describes an issue in which Windows 10 builds are excluded from WMI filter results.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# WMI Group Policy filters that compare Win32_OperatingSystem BuildNumber don't work as expected

This article provides a solution to an issue where Windows Management Instrumentation (WMI) Group Policy filters that compare Win32_OperatingSystem BuildNumber don't work as expected in Windows 10.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3119213

## Symptoms

Consider the following scenario:

- You want Group Policy to apply to Windows 8.1 and later versions of Windows.
- You want to use Win32_OperatingSystem BuildNumber to do this.
- You create the following WMI filter, based on known build numbers of Windows versions:

    ```console
    "Select BuildNumber from Win32_OperatingSystem WHERE BuildNumber >= 9200 "
    ```

    |Build number|Windows version|
    |---|---|
    |9200|Windows 8|
    |9600|Windows 8.1|
    |10240|Windows 10|
    |10586|Windows 10, version 1511|
    |14393|Windows 10, version 1607|
    |15063|Windows 10, version 1703|
    |16299|Windows 10, version 1709|
    |17134|Windows 10, version 1803|
    |17763|Windows 10, version 1809|
    |18362|Windows 10, version 1903|

In this scenario, although you would expect the WMI filter to cause the Group Policy setting to apply to build number 9200 and later builds, Windows 10 builds are excluded.

## Cause

This issue occurs because the data type for **BuildNumber**  is String and not Integer. Therefore, 10*** < 9600.

## Resolution

To fix this issue, use a filter that resembles the following example.

> [!NOTE]
> There are several ways to force the string compare to return the result that you want. You can use any method that you prefer. The example is fully functional.

```console
Select BuildNumber from Win32_OperatingSystem WHERE BuildNumber >= 10000 AND BuildNumber LIKE "%[123456789][0123456789][0123456789][0123456789][0123456789]%" OR BuildNumber >= 9200 AND BuildNumber LIKE "%[123456789][0123456789][0123456789][0123456789]%"
```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#wmi).
