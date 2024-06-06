---
title: Task Manager displays incorrect processor affinity
description: Describes a known issue in which Task Manager displays incorrect processor affinity in Windows Server 2022.
ms.date: 05/29/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rblume, v-lianna
ms.custom: sap:System Performance\Performance tools (Task Manager, Perfmon, WSRM, and WPA), csstroubleshoot
---
# Task Manager displays incorrect processor affinity in Windows Server 2022

This article describes a known issue in which Task Manager displays incorrect processor affinity in Windows Server 2022.

When you use Task Manager to set process affinity in Windows Server 2022, the processors might show processor groups incorrectly.

For example, when you right-click a process under the **Details** tab in Task Manager and select **Set affinity**, a system with 64 logical processors and two NUMA nodes incorrectly shows four sets of CPU nodes numbered repeatedly as follows:

```output
CPU 0 (Node 0)
CPU 1 (Node 0)
...
CPU 15 (Node 0) 
CPU 0 (Node 1)
CPU 1 (Node 1)
...
CPU 15 (Node 1) 
CPU 0 (Node 0)
CPU 1 (Node 0)
...
CPU 15 (Node 0) 
CPU 0 (Node 1)
CPU 1 (Node 1)
...
CPU 15 (Node 1) 
```

This is a known issue in Windows Server 2022, and it doesn't affect the performance or usage of the system.
