---
title: Suggested hotfixes for WMI issues
description: Provides suggested hotfixes for Windows Management Intrumentation (WMI) related issue on Windows platforms.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-management-instrumentation-wmi, csstroubleshoot
---
# Suggested hotfixes for WMI related issue on Windows platforms

This article provides suggested hotfixes for Windows Management Instrumentation (WMI) related issue on Windows platforms.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2591403

## Symptoms

Due to the volume of support incidents handled by Microsoft Support Services for issues related to the following hotfixes, these are recommended for installation for the platforms indicated below. These hotfixes are associated with the operation and functionality of the WMI service and its related components. When experiencing issues related to WMI on a system the symptoms can vary widely depending upon the root cause. The following are a few examples of high-level symptoms noted in support incidents that may be resolved with the application of the indicated hotfixes:

- Loss of functionality with enterprise management/monitoring software for various machines. Software examples: Microsoft SCOM/SMS, IBM Tivoli, LANDesk Management, HP OpenView, BMC Patrol, etc.
- Loss of functionality related to Citrix terminal services load-balancing.
- Loss of functionality for WMI-based scripts.
- Slow user logon times on Citrix terminal servers.
- Slow user logon times on Windows clients where WMI-based group policy filters are in-place.

### More granular symptoms

- Unable to connect to root\default, root\cimv2 and/or root\citrix namespaces via WBEMTEST.
- Repository growing large related to OBJECTS.DATA file.
- Note repeating-nested CITRIX namespace entries in WMIMGMT.MSC. WMI CONTROL > PROPERTIES > SECURITY > expand ROOT structure to note missing/repeating namespaces.

## Resolution

- **Hotfix for Windows Vista and Windows Server 2008**

    [2464876](https://support.microsoft.com/help/2464876)  The WMI repository is corrupted on a computer that is running Windows Server 2008 or Windows Vista

- **Hotfix list for Windows 7 and Windows Server 2008 R2**

  - [2692929](https://support.microsoft.com/help/2692929) 0x80041001 error when the Win32_Environment WMI class is queried by multiple requestors in Windows 7 or in Windows Server 2008 R2

  - [2617858](https://support.microsoft.com/help/2617858)  Unexpectedly slow startup or logon process in Windows Server 2008 R2 or in Windows 7

    > [!NOTE]
    > MSKB 2617858 includes the a resolution for the high CPU fix in MSKB 2505348 AND a fix for WMI repositories being improperly marked drity after graceful shutdowns, triggering full verification on the following OS startup. MSKB 2505348 is there fore superceded by MKSB [2617858](https://support.microsoft.com/help/2617858).

  - [2492536](https://support.microsoft.com/help/2492536)  Msinfo32.exe takes a long time to display or export system information on a computer that has many MSI-X-supported devices and that is running Windows 7 or Windows Server 2008 R2

    > [!NOTE]
    > MSKB 2492536 updates Cimwin32.dll on the computers running Windows 7 and Windows Server 2008 R2 RTM or with Service Pack 1 (SP1) installed. While as MSKB 2692929 updates Cimwin32.dll to a latest version and is applicable to the computer that have SP1 installed.

  - [982293](https://support.microsoft.com/help/982293)  The Svchost.exe process that has the WMI service crashes in Windows Server 2008 R2 or in Windows 7 Note: MSKB 982293 is applicable to the computers running Windows 7 or Windows Server 2008 R2 without Service Pack 1 (SP1)

  - [974930](https://support.microsoft.com/help/974930)  An application or service that queries information about a failover cluster by using the WMI provider may experience low performance or a time-out exception

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#wmi).
