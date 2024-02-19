---
title: Error 0xC004F06C when you activate Windows
description: Provides a solution to an error 0xC004F06C when you activate Windows.
ms.date: 12/20/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-naqviadil, v-lianna
ms.custom: sap:activation, csstroubleshoot
---
# Error 0xC004F06C when you activate Windows

This article helps fix the error 0xC004F06C and the error message "The Key Management Service (KMS) determined that the request timestamp is invalid" when you activate Windows.

When you try to activate Windows by using the `Slmgr /ato` command, you receive the following error message:

> Error: 0xC004F074 The Software Licensing Service reported that the computer could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information.

In addition, Event ID 12288 with the 0xC004F06C error is logged in the application event log.

```output
    Log Name:      Application
    Source:        Microsoft-Windows-Security-SPP
    Date:         
    Event ID:      12288
    Task Category: None
    Level:         Information
    Keywords:      Classic
    User:          N/A
    Computer:     
    Description:
    0xC004F06C, 0x00000000, azkms.core.windows.net:1688, <CMID>, <DateTime>, 1, 5, 0, 34e1ae55-27f8-4950-8877-7a03be5fb181, 
```

This error occurs in one of the following conditions:

- The Windows Time service isn't working.
- The `NtpClient` time provider isn't enabled.
- Domain-joined computers don't sync time with Active Directory Domain Services (AD DS).

To resolve this error, follow these steps:

1. Make sure the Windows Time service is running.
    1. Type *services.msc* in the **Search** box and press <kbd>Enter</kbd> to open the **Services** window.
    2. Search for **Windows Time** and make sure the service is running.
    3. Run the following command from an elevated command prompt to make sure the service is working properly:

        ```console
        w32tm.exe /query /status /verbose
        ```

2. For non-domain-joined computers, use the Network Time Protocol (NTP) time source by enabling the `NtpClient` provider.

    [!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

    1. Open Registry Editor and go to the following registry key:

        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient`

    2. Change the value of the **Enabled** registry entry to **1** to enable the `NtpClient` provider in the current time service.

3. For domain-joined computers, use the AD DS time source by configuring the time client type.

    1. Open Registry Editor and go to the following registry key:

        `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\W32Time\Parameters`.

    2. Make sure the value of the **Type** registry entry is **NT5DS**. This means the computer is synchronizing its time with the AD DS time hierarchy.
