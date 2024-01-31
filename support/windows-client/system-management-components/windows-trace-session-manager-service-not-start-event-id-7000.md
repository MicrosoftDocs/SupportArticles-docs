---
title: The Windows Trace Session Manager service does not start and Event ID 7000 occurs
description: Describes the behavior of the Windows Trace Session Manager service not starting in the specified time. You can work around this problem by extending the default timeout value in the registry.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:microsoft-management-console-mmc, csstroubleshoot
ms.subservice: system-mgmgt-components
---
# The Windows Trace Session Manager service does not start and Event ID 7000 occurs

This article provides a workaround for an issue where the Windows Trace Session Manager service doesn't start in the specified time.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 839803

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](../../windows-server/performance/windows-registry-advanced-users.md).

## Symptoms

The Windows Trace Session Manager service does not start in the timeout value that is specified by Service Control Manager (SCM). By default, the timeout value is 30000 milliseconds (30 seconds).

Additionally, the system event log indicates this timeout failure by a log entry that is similar to the following:

> Source : Service Control Manager  
Event ID : 7000
>
> The Windows Trace Session Manager service failed to start due to the following error:
>
> The service did not respond to the start or control request in a timely fashion.  
For more information, see Help and Support Center at `http://support.microsoft.com`.  
This problem becomes apparent when the installation of Microsoft Enterprise Instrumentation Framework (EIF) is not completed. This problem may also become apparent during the computer startup.

## Workaround

To work around this problem, increase the default timeout value for the service control manager in the registry.

> [!IMPORTANT]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To increase the timeout value in the registry, follow these steps:

1. Start Registry Editor (Regedit.exe).

2. To change the value data for the ServicesPipeTimeout DWORD value to 60000 in the Control key, follow these steps:

    1. Locate and then click the following registry key:     `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet`

    2. Click the **Control** subkey.
    3. Right-click the **ServicesPipeTimeout** DWORD value, and then click **Modify**.
    4. Click **Decimal**.
    5. Type *60000*, and then click **OK**.

3. If the **ServicesPipeTimeout** value is *not* available, add the new DWORD value, and then set its value data to 60000 in the Control key. To do so, follow these steps:

    1. Locate and then click the following registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet`

    2. Click the **Control** subkey.
    3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
    4. Type *ServicesPipeTimeout*, and then press ENTER.
    5. Right-click the **ServicesPipeTimeout** DWORD value, and then click **Modify**.
    6. Click **Decimal**.
    7. Type a value of *60000*, and then click **OK**.

    The value is 60000 milliseconds and is equivalent to 60 seconds or to one minute.

> [!NOTE]
> This change does not take effect until the computer is restarted.

## More information

After you increase the ServicesPipeTimeout value in the registry, the service control manager waits for the services to use the whole ServicesPipeTimeout value before the system event log reports that the program did not start.

For services that depend on the Windows Trace Session Manager service and that require several minutes of startup, a value of 60 seconds may not be sufficient time. Therefore, increase the ServicesPipeTimeout value appropriately. This increased value will give all the dependent services sufficient time to start.
