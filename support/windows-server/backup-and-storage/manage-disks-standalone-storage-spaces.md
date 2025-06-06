---
title: Manage Disks in Standalone Storage Spaces
description: Provides a detailed guide on how to identify the Logical Unit Number (LUN) of a physical disk presented from Azure for Storage Spaces on Windows Server.
ms.date: 06/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:backup,recovery,disk,and storage\storage spaces
- pcy:WinComm Storage High Avail
---
# Manage disks in standalone Storage Spaces on Windows Server hosted in Azure

This article provides a detailed guide on how to identify the Logical Unit Number (LUN) of a physical disk presented from Azure for Storage Spaces on Windows Server. This is essential when you remove or replace a physical disk from the storage pool. By following these instructions, you can effectively manage your storage spaces' configurations without compromising data integrity or service availability.

> [!Important]
> To complete the following procedures, ensure you have administrator privileges in Windows PowerShell and the necessary permissions to manage disks in [Microsoft Azure portal](https://aka.ms/azureportal).

## Identify the LUN from a storage pool and match it in the Azure portal

To identify the LUN of a physical disk, follow these steps:

1. To retrieve information about the physical disks in a specified storage pool, run the following PowerShell cmdlet as an administrator:

    ```powershell
    Get-StoragePool -FriendlyName "<StoragePoolName>" | Get-PhysicalDisk | Select-Object FriendlyName, UniqueId, HealthStatus, Size, PhysicalLocation, DeviceID, CannotPoolReason, Usage | Format-List
    ```

    Here's an example output:

    ```output
    Friendlyname     : Msft Virtual Disk
    UniqueId         : <UniqueID>
    HealthStatus     : Healthy
    Size             : 37580963840
    PhysicalLocation : Integrated : Adapter 1 : Port 0 : Target 0 : LUN 2
    DeviceID         : 4
    CannotPoolReason : In a Pool
    Usage            : Auto-Select
    ```

    > [!NOTE]
    > Breakdown of the cmdlet:
    >
    > - `FriendlyName`: The user-friendly name of the physical disk.
    > - `UniqueId`: A unique identifier for the disk.
    > - `PhysicalLocation`: Specifies the physical location of the disk in the system. `Adapter 0` is for operating system disk and temp disk, and `Adapter 1` is for data disks.
    > - `Usage`: Displays how the disk is currently being used (for example, for storage pools, virtual disks, and so on).

2. To retrieve the unique ID of the virtual disk in the storage pool, run the following cmdlets:

    ```powershell
    Get-StorageNode
    ```

    Here's an example output:

    ```output
    Name                          Manufacturer            Model             OperationalStatus 
    ---                           ------------            -----             ------------                     
    Node1-2019-pool.fabrikam.com  Microsoft Corporation   Virtual Machine   Up
    Node1-2019-pool.fabrikam.com  Microsoft Corporation   Virtual Machine   Up
    Node2-2019-pool.fabrikam.com  Microsoft Corporation   Virtual Machine   Up
    ```

    ```powershell
    Get-StorageNode -name "<StorageNodeName>" | get-virtualdisk | ft friendlyname, uniqueid, allocatedsize, footprintonpool
    ```

    Here's an example output:

    ```output
    friendlyname uniqueid    allocatedsize footprintonpool
    ------------ --------    ------------- ---------------
    Virtualdisk  <UniqueID>  1073741824      1073741824
    ```

    > [!NOTE]
    > The numbers shown in the `allocatedsize` and `footprintonpool` are in bytes.

3. To locate the LUN of the data disks in the Azure portal, go to Azure portal, select the virtual machine, and select **Settings** > **Disks**. Note down the LUN and match it with the retrieved information from Step 1.

    :::image type="content" source="media/manage-disks-standalone-storage-spaces/storage-spaces-vm.png" alt-text="Screenshot of the StorageSpacesVM window showing the Disks information with LUN.":::

## Remove a physical disk from the storage pool

1. To retire a physical disk from the storage pool, run the [Set-PhysicalDisk](/powershell/module/storage/set-physicaldisk) cmdlet by using the unique ID (get from Step 1 of the preceding section):

    ```powershell
    Set-PhysicalDisk -UniqueId <UniqueID> -Usage Retired
    ```

    Here's an example output when the physical disk is retired:

    ```output
    PS C:\Users\Administrator1> Set-PhysicalDisk -UniqueId <UniqueID> -Usage Retired
    PS C:\Users\Administrator1> Get-PhysicalDisk

    Number FriendlyName      SerialNumber MediaType   CanPool OperationalStatus HealthStatus Usage         Size
    ------ ------------      ------------ ---------   ------- ----------------- ------------ -----         ----
    5      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select  40 GB
    0      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select 127 GB
    3      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select  40 GB
    2      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select  32 GB
    1      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select  16 GB
    4      Msft Virtual Disk              Unspecified False   OK                Healthy      Retired      35 GB
    ```

2. To identify the physical disks associated with the virtual disk, run the following cmdlet by using the unique ID (get from Step 2 of the preceding section):

    ```powershell
    Get-VirtualDisk -UniqueId <UniqueID> | Get-PhysicalDisk
    ```

    Here's an example output:

    ```output
    DeviceId FriendlyName      SerialNumber MediaType   CanPool OperationalStatus HealthStatus Usage        Size
    -------- ------------      ------------ ---------   ------- ----------------- ------------ -----        ----
    1        Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select 40 GB
    2        Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select 35 GB
    ```

3. To start the storage job by forcing the data to move from the retired physical disk, run the following cmdlet by using the unique ID from the preceding step:

    ```powershell
    Get-VirtualDisk -UniqueID <UniqueID> | Repair-VirtualDisk
    ```

4. Check the storage job status by using the following cmdlet and wait for the storage job to complete.

    ```powershell
    Get-StorageJob
    ```

5. Confirm that no virtual disk footprint exists on the retired physical disk by running the following cmdlet:

    ```powershell
    Get-StorageNode -Name "<StorageNodeName>" | Get-PhysicalDisk -PhysicallyConnected | Select FriendlyName, CanPool, UniqueID, @{Name="Size (GB)"; Expression={[math]::Round($_.Size / 1GB, 2)}}, PhysicalLocation, Usage, VirtualDiskFootprint
    ```

    Here's an example of the expected output:

    ```output
    FriendlyName         : Msft Virtual Disk
    CanPool              : False
    UniqueID             : <UniqueID>
    Size (GB)            : 35
    PhysicalLocation     : Integrated : Adapter 1 : Port 0 : Target 0 : LUN 2
    Usage                : Retired
    VirtualDiskFootprint : 0
    ```

    > [!NOTE]
    > Breakdown of the cmdlet:
    >
    > - `FriendlyName`: The user-friendly name of the physical disk.
    > - `CanPool`: Indicates whether the disk can be added to a storage pool.
    > - `UniqueID`: A unique identifier for the disk.
    > - Custom property: `Size (GB)`
    >
    >   - Code: `@{Name="Size (GB)"; Expression={[math]::Round($_.Size / 1GB, 2)}}`
    >   - Explanation:
    >     - `@{...}`: A hashtable defining a calculated property.
    >     - `Name="Size (GB)"`: Specifies the name of the new property (in this case, "Size (GB)").
    >     - `Expression={...}`: Defines how the property value is calculated:
    >       - `$_.Size`: Refers to the size property of the current physical disk (value is in bytes).
    >       - `/ 1GB`: Converts the size from bytes to gigabytes (1 GB is a constant in PowerShell equal to 1024 * 1024 * 1024 bytes).
    >       - `[math]::Round(..., 2)`: Rounds the result to `2` decimal places for readability.
    >
    > - `PhysicalLocation`: Specifies the physical location of the disk in the system.
    > - `Usage`: Displays how the disk is currently being used (for example, for storage pools, virtual disks, and so on).
    > - `VirtualDiskFootprint`: Indicates how much of the physical disk's capacity is being used by virtual disks.

6. Remove the physical disk ([Remove-PhysicalDisk](/powershell/module/storage/remove-physicaldisk)) from the server by running the following cmdlets using the unique ID from Step 1:

    ```powershell
    $PDToRemove = Get-PhysicalDisk -UniqueID <UniqueID>
    Remove-PhysicalDisk -PhysicalDisks $PDToRemove -StoragePoolFriendlyName "<StoragePoolName>"
    ```

7. Reconfirm the `CanPool` property of the physical disk which should show as `True` after the physical disk is removed from the storage pool. Run the `Get-PhysicalDisk` cmdlet:

    ```powershell
    PS C:\Users\Administrator1> Get-PhysicalDisk
    Number FriendlyName      SerialNumber MediaType   CanPool OperationalStatus HealthStatus Usage         Size
    ------ ------------      ------------ ---------   ------- ----------------- ------------ -----         ----
    5      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select  40 GB
    0      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select 127 GB
    3      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select  40 GB
    2      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select  32 GB
    1      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select  16 GB
    4      Msft Virtual Disk              Unspecified True    OK                Healthy      Auto-Select  35 GB 
    ```

8. Once the disk is removed from the storage pool, it should be available under the primordial pool.

    :::image type="content" source="media/manage-disks-standalone-storage-spaces/primordial-pool.png" alt-text="Screenshot of the storage pool showing that the disk is available under the primordial pool." lightbox="media/manage-disks-standalone-storage-spaces/primordial-pool.png":::

9. After confirming the removal with the `Get-PhysicalDisk` cmdlet in PowerShell, detach the physical disk in the Azure portal if necessary.
10. Verify the health of the storage pool and the virtual disk by running the `Get-StoragePool` and `Get-VirtualDisk` cmdlets.
