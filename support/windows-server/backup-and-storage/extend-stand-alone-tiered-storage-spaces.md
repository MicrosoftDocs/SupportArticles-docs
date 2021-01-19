---
title: How to extend stand-alone tiered storage spaces
description: Shows how to extend stand-alone tiered storage spaces
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Storage Spaces
ms.technology: windows-server-backup-and-storage
---
# How to extend stand-alone tiered storage spaces

This article shows how to extend stand-alone tiered storage spaces.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4562879

The following article explains how to expand tiered storage spaces on a stand-alone server. Here's an example of a tiered space created with a 12.1 TB size in Windows Server 2016.  

 ![storage pool.png](./media/extend-stand-alone-tiered-storage-spaces/storage-pools.png)

 Here's how to extend the Tiered Storage Space:  

 1.Add hard drives to the storage pool.  
 ![add hard drives.png](./media/extend-stand-alone-tiered-storage-spaces/add-hard-drives.png)  

 2.Update the **Media Type** of the new added disk.  
 ![media type.png](./media/extend-stand-alone-tiered-storage-spaces/media-type.png)  

 3.Run the get-physicaldisk | fl *cmdlet and copy the UniqueId of the newly added disk:  
 ![get physicaldisk](./media/extend-stand-alone-tiered-storage-spaces/get-physicaldisk.png)

 4.Run the following cmdlet to change the **Media Type** of the newly added disk:

  Set-PhysicalDisk -UniqueId 6002  -MediaType HDD  
  Refresh the **Server Manager**  to change the **Media Type**.  
 ![change media type.png](./media/extend-stand-alone-tiered-storage-spaces/change-media-type.png)

 5.Run this cmdlet to expand the disk:  
  Resize-StorageTier -FriendlyName Vdisk01_Microsoft_HDD_Template -size 16.1TB
 ![expand disk.png](./media/extend-stand-alone-tiered-storage-spaces/expand-disk.png)

 6.Resize the disk volume in the **Disk Management**.
 ![resize disk volume.png](./media/extend-stand-alone-tiered-storage-spaces/resize-disk-volume.png)  

 7.The storage has been expanded.
 ![storage expanded.png](./media/extend-stand-alone-tiered-storage-spaces/storage-expanded.png)  