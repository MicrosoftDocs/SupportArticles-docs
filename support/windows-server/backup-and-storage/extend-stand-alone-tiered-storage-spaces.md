---
title: How to extend stand-alone tiered storage spaces
description: Shows how to extend stand-alone tiered storage spaces
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-mafect
ms.custom: sap:storage-spaces, csstroubleshoot
---
# How to extend stand-alone tiered storage spaces

This article shows how to extend stand-alone tiered storage spaces.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4562879

The following article explains how to expand tiered storage spaces on a stand-alone server. Here's an example of a tiered space created with a 12.1 TB size in Windows Server 2016.  

:::image type="content" source="media/extend-stand-alone-tiered-storage-spaces/storage-pools.png" alt-text="Example of a tiered space created with a 12.1 TB size in Windows Server 2016.":::

Here's how to extend the Tiered Storage Space:  

1. Add hard drives to the storage pool.

    :::image type="content" source="media/extend-stand-alone-tiered-storage-spaces/add-hard-drives.png" alt-text="Add physical disks to the storage pool.":::
  
2. Update the **Media Type** of the new added disk.

    :::image type="content" source="media/extend-stand-alone-tiered-storage-spaces/media-type.png" alt-text=" Update the Media Type of the new added disk." border="false":::
  
3. Run the `get-physicaldisk | fl *` cmdlet and copy the UniqueId of the newly added disk:

    :::image type="content" source="media/extend-stand-alone-tiered-storage-spaces/get-physicaldisk.png" alt-text="Run the Get-physicaldisk cmdlet and copy the UniqueId of the newly added disk." border="false":::  

4. Run the following cmdlet to change the **Media Type** of the newly added disk:

    ```powershell
    Set-PhysicalDisk -UniqueId 6002  -MediaType HDD
    ```

    Refresh the **Server Manager**  to change the **Media Type**.

    :::image type="content" source="media/extend-stand-alone-tiered-storage-spaces/change-media-type.png" alt-text="Change the media type by refreshing the Server Manager.":::

5. Run this cmdlet to expand the disk:

    ```powershell
    Resize-StorageTier -FriendlyName Vdisk01_Microsoft_HDD_Template -size 16.1TB
    ```

    :::image type="content" source="media/extend-stand-alone-tiered-storage-spaces/expand-disk.png" alt-text="Run the Resize-StorageTier cmdlet to expand disk.":::

6. Resize the disk volume in the **Disk Management**.

    :::image type="content" source="media/extend-stand-alone-tiered-storage-spaces/resize-disk-volume.png" alt-text="Resize disk volume in the Disk Management.":::

7. The storage has been expanded.

    :::image type="content" source="media/extend-stand-alone-tiered-storage-spaces/storage-expanded.png" alt-text="The stand-alone tiered storage space is now expanded.":::
