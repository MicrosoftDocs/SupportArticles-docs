---
title: DFSR event ID 2212 after you restart the DFSR service
description: Describes an issue in which you receive the DFS Replication event 2212, and DFSR stops after you restart Windows Server 2008. A short time later, event 2214 is logged in the DFS Replication log.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dfsr, csstroubleshoot
---
# You receive DFSR event ID 2212 after you restart the DFSR service in Windows Server 2008

This article describes an issue in which you receive the DFS Replication event 2212, and DFSR stops after you restart Windows Server 2008. A short time later, event 2214 is logged in the DFS Replication log.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 977518

## Symptoms

When you restart the Distributed File System Replication (DFSR) service on a server that is running Windows Server 2008, or you restart the server, the following event may be logged in the DFS Replication log:

> Log Name: DFS Replication
>
> Source: DFSR
>
> Event ID: 2212
>
> Task Category: None
>
> Level: Warning
>
> Keywords: Classic
>
> User: N/A
>
> Computer: **MyDfsrMember**.contoso.com
>
> Description:
>
> The DFS Replication service has detected an unexpected shutdown on volume **Drive_Letter**. This can occur if the service terminated abnormally (due to a power loss, for example) or an error occurred on the volume. The service has automatically initiated a recovery process. The service will rebuild the database if it determines it cannot reliably recover. No user action is required.

After some time has passed, DFSR logs event ID 2214. This event indicates that the database recovery process has finished. During database recovery, replication performance is slowed.

## Cause

This issue occurs because the Service Control Manager (SCM) uses the default time-out value of 20 seconds for stopping a service. In some complex DFSR implementations, this time-out value may be too short, and DFSR stops before the appropriate database is closed. At service restart, DFSR detects this condition and performs the database recovery.

## Resolution

To resolve this issue, you can change the default time-out value that is used by the SCM by adding the following registry value:

Value Name WaitToKillServiceTimeout  

Data Type REG_SZ  

String 20000 milliseconds (default value)  

To specify the wait time, follow these steps:

1. Click **Start**, click **Run**, type `regedit`, and then click **OK**.

2. Locate and then click the following key in the registry:
 `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control`  

3. On the **Edit** menu, point to **New**, and then click **String Value**.
4. Type WaitToKillServiceTimeout, and then press ENTER.

5. On the **Edit** menu, click **Modify**.

6. Type 60000, and then click **OK**.

7. Exit Registry Editor.
8. Restart the server.

If the time interval is something other than 60 seconds, you can set the value of the WaitToKillServiceTimeout registry value to the difference in time, in milliseconds, between the following two events in the DFSR event log:

- 1006 - The DFS Replication service is stopping.

- 1008 - The DFS Replication service has stopped.

Make sure to install KB 2549760 to ensure proper performance of the WaitToKillServiceTimeout registry value

 [2549760 WaitToKillServiceTimeout registry value does not work in Windows 7 or in Windows Server 2008 R2](https://support.microsoft.com/help/2549760)  
