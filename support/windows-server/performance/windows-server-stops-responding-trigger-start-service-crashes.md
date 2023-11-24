---
title: Windows Server stops responding when a service crashes with a failed restart
description: Helps resolve an issue in which Windows Server stops responding during the sign-in process if a Trigger Start service crashes with a failed restart.
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.date: 11/23/2023
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, jasone, v-lianna
ms.custom: sap:system-hang, csstroubleshoot, ikb2lmc
ms.technology: windows-server-performance
---
# Windows Server stops responding when a Trigger Start service crashes with a failed restart

This article helps resolve an issue in which Windows Server stops responding during the sign-in process if a Trigger Start service has a recovery action and the reset period is set to **0**.

When you try to sign in to a Windows Server-based device, the system stops responding. On a Windows Server Failover Cluster node, [bug check 0x9E](/windows-hardware/drivers/debugger/bug-check-0x9e--user-mode-health-monitor) may occur. 

When the service crashes, the service control manager (SCM) queues a recovery work item based on the failure action configuration of the service. The service is set to restart after 60 seconds if a failure occurs, and the reset period is set to **0**, which indicates an indefinitely continuous action. The recovery work item results in acquiring a critical section, followed by a request to start the service. If the service crashes again, it triggers another recovery process.

> [!NOTE]
> To see the triggers, run the `sc triggerinfo <short service name>` command.

## Check Event ID 1000 and isolate the service

To resolve this issue, isolate the service causing the crash by checking Event ID 1000 in the Event Viewer log. Additionally, you can configure the service to have a reset period of one day. To change the setting, right-click the service in the Windows Services Manager (*services.msc*), select **Properties**, and set the **Reset fail count after value** to **1** on the **Recovery** tab.
