---
title: USB device drivers are removed unexpectedly after Windows 10 is updated
description: Address an issue in which USB device drivers are removed unexpectedly after Windows 10 is updated. Provides a workaround.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits, wesk, amirsc
ms.custom: sap:Windows Device and Driver Management\Peripherals driver installation or update, csstroubleshoot
---
# USB device drivers are removed unexpectedly after Windows 10 is updated

This article provides a workaround for an issue in which USB device drivers are removed unexpectedly after Windows 10 is updated.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4098563

## Symptoms

Consider the following scenario:

- You have developed an application that works on Windows 10 Long Term Servicing Branch (LTSB).
- The application relies on custom or third-party universal serial bus (USB) device drivers.
- The application logic expects to find these drivers in the INF cache. Therefore, devices are automatically identified without having to specify the driver on each connection.
- You install some Windows updates.

In this scenario, the drivers are silently removed from the INF cache. Therefore, the application cannot use the drivers as expected.

Additionally, when the scenario occurs, the Process Monitor log shows the following chain:
> 11:55:21.8170826 svchost.exe 868 2424 Process Create C:\\Program Files\\rempl\\remsh.exe SUCCESS PID: 3076,  
Command line: "C:\\Program Files\\rempl\\remsh.exe" C:\\Windows\\system32\\svchost.exe -k netsvcs
11:56:47.3634292 remsh.exe 3076 4152 Process Create C:\\Windows\\system32\\rundll32.exe SUCCESS PID: 1248,  
Command line: C:\\Windows\\system32\\rundll32.exe C:\\Windows\\system32\\pnpclean.dll,RunDLL_PnpClean /DEVICES /DRIVERS /MAXCLEAN "C:\\Program Files\\rempl\\remsh.exe"  
11:56:47.3634539 rundll32.exe 1248 4152 Process Start SUCCESS Parent PID: 3076,  
Command line: C:\\Windows\\system32\\rundll32.exe C:\\Windows\\system32\\pnpclean.dll,RunDLL_PnpClean /DEVICES /DRIVERS /MAXCLEAN

> [!Note]
>
> - The parent svchost.exe process is hosting the task scheduler service.
> - The specific scheduled task that is run in this scenario is located in the following path:  
> **Task Scheduler (Local)**/**Task Scheduler Library**/**Microsoft**/**Windows**/**rempl**

## Cause

This issue occurs because Windows receives an update reliability tool during a Windows Update installation of KB 4023057. The tool is designed to clean up the INF driver cache as part of its remediation procedures.

## Workaround

The applicability rules for the Windows update reliability tool have been improved. In addition, the latest version of this tool (10.0.14393.10020 or a later version) should not cause the issue.

As a workaround, you can completely block the update reliability tool from running. To do this, run the following commands:

```console
takeown /f "C:\Program Files\rempl" /r /d y
icacls "C:\Program Files\rempl" /grant administrators:F /t /q
icacls "C:\Program Files\rempl" /deny system:F /t /q
```  

> [!Note]
> The Windows update reliability tool is not published to WSUS servers.

## Reference

For more information, see the following articles:  
[Update to Windows 10 Versions 1507, 1511, 1607, and 1703 for update reliability: March 22, 2018](https://support.microsoft.com/help/4023057/update-to-windows-10-versions-1507-1511-1607-and-1703-for-update-relia)  
[Overview of Windows as a service](/windows/deployment/update/waas-overview)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
