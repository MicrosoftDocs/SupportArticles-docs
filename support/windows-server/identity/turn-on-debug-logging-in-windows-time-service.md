---
title: Turn on debug logging in Windows Time Service
description: Describes how to turn on debug logging for the Windows Time service
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, tdetzner
ms.custom: sap:windows-time-service, csstroubleshoot
ms.subservice: active-directory
---
# Turn on debug logging in the Windows Time Service  

This article describes how to turn on debug logging for the Windows Time service (also known as W32time). If you are an administrator, you can use the debug logging feature of the Windows Time service to help troubleshoot issues.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Window 10 – all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 816043

> [!NOTE]
> Microsoft recommends that you use debug logging after you have performed all other troubleshooting steps. Because of the nature of the detailed information in the debug log, you may have to contact a Microsoft Support Professional.

## Turn on debug logging for Windows Time Service

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To turn on debug logging in the Windows Time service:

1. Start Registry Editor.
2. Locate and then click the registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config`.
3. On the **Edit** menu, click **New Value**, and then add the following registry values:

    - Value Name: **FileLogSize**  
    - Data Type: DWORD
    - Value data: 10000000

    This registry value specifies the size of the log file in bytes.
    A value of 10000000 bytes will limit the log file to approximately 10 MB.

    - Value name: **FileLogName**  
    - Data Type: String
    - Value data: C:\Windows\Temp\w32time.log

    This registry value specifies the location of the log file. The path is not fixed. You can use a different path.

    - Value name: **FileLogEntries**  
    - Data Type: String
    - Value: 0-116

    This registry value specifies the level of detail of the information in the debug log. If you must have more detailed logging information, contact a Microsoft Support Professional.

    > [!NOTE]
    > The Data Type value must be of type REG_SZ (String). You must type the value exactly as shown (that is, type 0-116 ). The highest possible value is 0-300 for most detailed logging. The meaning of this value is: Log all entries within the range of 0 and 116.
