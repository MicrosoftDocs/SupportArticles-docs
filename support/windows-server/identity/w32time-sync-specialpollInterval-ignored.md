---
title: W32time settings fail when starting Windows Time Service
description: Fixes an issue where the NTP client doesn't synchronize time at the SpecialPollInterval period as expected.
ms.date: 01/18/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-time-service, csstroubleshoot
---
# W32Time: Sync: SpecialPollInterval may be ignored on workgroup computers

This article helps fix an issue where the NTP client doesn't synchronize time at the SpecialPollInterval period as expected.

_Original KB number:_ &nbsp; 3205089

## Symptoms

Assume that you modify W32time settings to always run and that one of the following conditions is true:

- You use the default workstation settings.
- You use custom NTP synchronization settings with a large SpecialPollInterval setting value.

In this scenario, the NTP client doesn't synchronize time at the SpecialPollInterval period as expected.

## Cause

Because of the way that the Windows Time Service handles large SpecialPollInterval values, time may be synchronized from the NTP server at longer intervals than expected.

## Resolution

### Workaround 1

Specify a smaller SpecialPollInterval value than the default value. The default values are as follows:

MinPollInterval = 0xA (== 2^10 seconds == 1024 seconds)  
MaxPollInterval = 0xF (== 2^15 seconds == 32768 seconds)  
SpecialPollInterval = 604800 seconds  

Specify a SpecialPollInterval value that falls between the MinPollInterval and MaxPollInterval. An example value is 3600 seconds (== 1 hour).  

To configure W32time with the new setting, follow these steps:

1. Start Registry Editor.
2. Change the value of the following registry key:

    `HKEY_LOCAL_MACHINE \SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient`

    Value name: SpecialPollInterval  
    Default: 604800  
    Modified value: 3600  
3. Restart the Windows Time Service, or run the following command to signal W32time about the modified configuration:  

    ```console
    w32tm /config /update  
    ```

### Workaround 2

Use the built-in poll interval adjustments based on MinPollInterval, MaxPollInterval instead of using SpecialPollInterval. This built-in tool automatically adjusts the polling interval from MinPollInterval all the way up to MaxPollInterval if the client machine keeps fairly accurate time. You need only modify a flag in the NtpServer configuration in order to switch from SpecialPollInterval to the automatic poll interval, as follows:

1. Start Registry Editor.
2. Change the value of the following registry key:

    `HKEY_LOCAL_MACHINE \SYSTEM\CurrentControlSet\Services\W32Time\Parameters`  

    Value name: NtpServer  
    Default value: `time.windows.com`, 0x9  
    Modified value: `time.windows.com`, 0x8  
3. Restart the Windows Time service, or run the following command:

    ```console
    w32tm /config /update  
    ```
