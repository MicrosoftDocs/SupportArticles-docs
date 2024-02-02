---
title: How to manually turn disk write caching on or off
description: Describes the steps to manually turn on or off disk write caching.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:storage-hardware, csstroubleshoot
ms.subservice: backup-and-storage
---
# How to manually turn disk write caching on or off

This article describes steps to manually turn disk write caching on or off.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 324805

## Summary

With some third-party programs, disk write caching has to be turned on or off. Additionally, turning disk write caching on may increase operating system performance; however, it may also result in the loss of information if a power failure, equipment failure, or software failure occurs. This article describes how to turn disk write caching on or off.

## Turn disk write caching on or off

1. Right-click **My Computer**, and then click **Properties**.
2. Click the **Hardware** tab, and then click **Device Manager**.
3. Expand **Disk Drives**.
4. Right-click the drive on which you want to turn disk write caching on or off, and then click **Properties**.
5. Click the **Policies** tab.
6. Click to select or clear the **Enable write caching on the disk** check box as appropriate.
7. Click **OK**.

### For Windows Server 2008

1. Right-click **Computer**, and then click **Properties**.
2. Click the **Device Manager** link under **Tasks**.
3. Expand **Disk Drives**.
4. Right-click the drive on which you want to turn disk write caching on or off, and then click **Properties**.
5. Click the **Policies** tab.
6. Click to select or clear the **Enable write caching on the disk** check box as appropriate.
7. Click **OK**.
