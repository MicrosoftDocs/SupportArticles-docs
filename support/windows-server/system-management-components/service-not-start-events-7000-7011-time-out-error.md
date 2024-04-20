---
title: A service does not start, and events 7000 and 7011 are logged in Windows Server
description: Describes a problem in which a service times out before it starts. Explains how to work around this problem by increasing the value of the ServicesPipeTimeout registry entry.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, pfazekas, v-dgit
ms.custom: sap:System Management Components\Microsoft Management Console (MMC), csstroubleshoot
---
# A slow service does not start due to time-out error in Windows

This article provides a workaround to an issue where a slow service does not start due to time-out error in Windows.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 922918

To work around this problem, modify the registry to increase the default time-out value for the service control manager. To increase this value to 60 seconds, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`
3. In the right pane, locate the **ServicesPipeTimeout** entry.

    > [!Note]
    > If the ServicesPipeTimeout entry does not exist, you must create it. To do this, follow these steps:
    >
    > 1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
    > 2. Type *ServicesPipeTimeout* , and then press **Enter**.

4. Right-click **ServicesPipeTimeout**, and then click **Modify**.
5. Click **Decimal**, type *60000*, and then click **OK**. This value represents the time in milliseconds before a service times out.
6. Restart the computer.

> [!Note]
>
> - This workaround may resolve the problem where the service does not start. However, we recommend that you research this problem to determine whether it is a symptom of another problem.
> - Increase the number carefully. We recommend you increase the number with a small amount at a time untill the service can start.

## More Information

The service control manager waits for the time that is specified by the ServicesPipeTimeout entry before logging event 7000 or 7011. Services that depend on the Windows Trace Session Manager service may require more than 60 seconds to start. Therefore, increase the ServicesPipeTimeout value appropriately to give all the dependent services enough time to start.

For more information, click the following article number to view the article in the Microsoft Knowledge Base:  
[839803](https://support.microsoft.com/help/839803) The Windows Trace Session Manager service does not start and Event ID 7000 occurs
