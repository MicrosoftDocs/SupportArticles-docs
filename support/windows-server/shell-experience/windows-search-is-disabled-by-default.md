---
title: Windows Search is disabled by default
description: Provides steps to re-enable the Windows Search service for Windows Server 2016.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Cortana and Search
ms.technology: windows-server-shell-experience
---
# Windows Search is disabled by default in Windows Server 2016

This article provides the steps to re-enable the Windows Search service in Windows Server 2016.

_Original product version:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 3204979

## Symptoms

When you try to search from the **Start** menu or from Cortana on a Windows Server 2016-based computer, you may receive no results or inconsistent results.

## Cause

By default, the Windows Search service is set to **Disabled** in Windows Server 2016. It's because indexing of the volumes can cause problems in certain scenarios, including：

- Cluster Shared Volumes (CSV)
- Running Remote Desktop Session Host (RDSH) with multiple simultaneous sessions.

## Resolution

You can re-enable the Windows Search service in the following scenarios:

- You plan to use Windows Server 2016 as your client desktop computer.
- You want Windows Search functionality from the **Start** menu.

To do so, follow these steps:

1. Press the Windows key‌ ![Windows logo key](./media/windows-search-is-disabled-by-default/windows-logo.jpg)+R to open the **Run** box.
2. Type *services.msc*, and then press Enter.
3. Right-click **Windows Search**, and then select **Properties**.
4. Change the Startup type to **Automatic (Delayed Start)**.
5. Select **Apply**, and then select **Start**.
6. Select **OK**, and then close the Services console.
