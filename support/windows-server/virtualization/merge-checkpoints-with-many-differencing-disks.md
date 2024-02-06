---
title: How to merge checkpoints that have multiple differencing disks
description: Describes different methods of merging checkpoints and their associated differencing disks into the related virtual machine.
ms.date: 09/17/2022
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:snapshots-checkpoints-and-differencing-disks, csstroubleshoot
keywords: differencing disks, avhdx, merge checkpoint, merge vhd
---

# How to merge checkpoints that have multiple differencing disks

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016

## Introduction

This article describes methods that you can use to merge checkpoints into a virtual machine (VM) if Hyper-V has generated many differencing disks. The method that you use depends on the details of the situation.

## Merging checkpoints that you can view in Hyper-V Manager

Checkpoints that you can view in Hyper-V Manager are the simplest to handle. Usually, you can use the **Delete Checkpoint** command on the context menu to delete these checkpoints.

:::image type="content" source="./media/merge-checkpoints-with-many-differencing-disks/delete-checkpoint.png" alt-text="Screenshot of a checkpoint in Hyper-V Manager in which the context menu includes the Delete Checkpoint command.":::

In some cases, **Delete Checkpoint** and **Delete Checkpoint Subtree** don't appear on the context menu. This can occur if third-party backup software generates checkpoints but doesn't delete them after a backup operation.

In these cases, you can still use the Delete key to delete the checkpoint.

In summary, to delete checkpoints in Hyper-V Manager (and merge the differencing disk files), follow these steps:

1. In Hyper-V Manager, select the virtual machine.
2. In the **Checkpoints** list, right-click the checkpoint that you want to delete, and then take one of the following actions:
   - Select **Delete Checkpoint**.
   - If **Delete Checkpoint** isn't available, select the checkpoint, and then select **Del**.

## Merging checkpoints that you can't view in Hyper-V Manager

You might encounter a situation in which Hyper-V Manager doesn't show checkpoints for a specific VM. At the same time, the corresponding file system folder shows many differencing disk files. This can occur if third-party backup software generates checkpoints but doesn't delete them after a backup operation.

You can merge the differencing disk files in one of two ways, depending on whether you can shut down the VM.

### When you can shut down the VM

To merge the differencing disk files, shut down the VM. Typically, the differencing disk files merge as part of the VM shutdown process.

### When you can't shut down the VM

You can merge differencing disks into an online VM. However, this is a multi-step process that involves Windows PowerShell scripts. To do this, follow these general steps:

1. Back up all the differencing disk files (VHD files).
1. [Create and run the `Get-VHDChain` function](#getchain). This step is described in detail later in this section.
1. [Create and run merge commands](#mergechain). This step is described in detail later in this section.
1. Change the VM settings to point to the merged parent VHD.
1. Start the VM. A successful startup means that the merge completed successfully.

#### <a id="getchain"></a>Create and run the Get-VHDChain function

1. On the Hyper-V host server, open an administrative PowerShell Command Prompt window.
1. Copy the following script, and then paste it into the PowerShell window:

   ```powershell
   function Get-VHDChain {
       [CmdletBinding()]
       param(
           [string]$ComputerName = $env:COMPUTERNAME,
           [string[]]$Name = '*'
       )
       try {
           $VMs = Get-VM -ComputerName $ComputerName -Name $Name -ErrorAction Stop
       }
       catch {
           Write-Warning $_.Exception.Message
       }
       foreach ($vm in $VMs){
           $VHDs = ($vm).harddrives.path
           foreach ($vhd in $VHDs){
               Clear-Variable VHDType -ErrorAction SilentlyContinue
               try {
                   $VHDInfo = $vhd | Get-VHD -ComputerName $ComputerName -ErrorAction Stop
               }
               catch {
                   $VHDType = 'Error'
                   $VHDPath = $vhd
                   Write-Verbose $_.Exception.Message
               }
               $i = 1
               $problem = $false
               while (($VHDInfo.parentpath -or $i -eq 1) -and (-not($problem))){
                   If ($VHDType -ne 'Error' -and $i -gt 1){
                       try {
                           $VHDInfo = $VHDInfo.ParentPath | Get-VHD -ComputerName $ComputerName -ErrorAction Stop
                       }
                       catch {
                           $VHDType = 'Error'
                           $VHDPath = $VHDInfo.parentpath
                           Write-Verbose $_.Exception.Message
                       }
                   }
                   if ($VHDType -ne 'Error'){
                       $VHDType = $VHDInfo.VhdType
                       $VHDPath = $VHDInfo.path
                   }
                   else {
                       $problem = $true
                   }
                   [pscustomobject]@{
                       Name = $vm.name
                       VHDNumber = $i
                       VHDType = $VHDType
                       VHD = $VHDPath
                   }
                   $i++
               }
           }
       }
   }
   ==================================
   ```

   This script defines a `Get-VHDChain` function that identifies the VHD chain (the set of differencing disks for the VM).

1. Run the following command:

   ```powershell
   Get-vhdchain -name <virtual machine name>
   ```

   > [!NOTE]  
   > In this command, <_virtual machine name_> represents the name of the virtual machine.

   When the script runs, you should see output that resembles the following output.

   :::image type="content" source="./media/merge-checkpoints-with-many-differencing-disks/get-vhdchain-run.png" alt-text="Screenshot of the output of the Get-VHDChain script.":::

1. Make sure that `Get-VHDChain` runs without errors.

   > [!IMPORTANT]  
   > If the `Get-VHDChain` output contains errors, you have to remove the affected differencing disks from the folder. In the following example, Disk 24 generated an error and must be removed from the differencing disk folder.
   >
   > :::image type="content" source="./media/merge-checkpoints-with-many-differencing-disks/get-vhdchain-error.png" alt-text="Screenshot of the output of the Get-VHDChain script when the script generates an error.":::

#### <a id="mergechain"></a>Create and run merge commands

1. The following instructions create a script in _C:\temp\merge.txt_ to merge the disks. Follow these steps:
   1. On the local _C:_ drive, create a folder that is named _temp_.
   1. Open an Administrative PowerShell window, and then run the following command:

      ```powershell
      $vm = Read-Host("please enter the VMname") 
      ```

   1. At the command prompt, enter the virtual machine name.
   1. Copy the following script, and then paste it at the command prompt.

      ```powershell
      $vhds=Get-VM $vm | Select-Object -Property VMId | Get-VHD 
      if (Test-Path '.\merge.txt'){Remove-Item -Path '.\merge.txt'}
      foreach($vhd in $vhds){
      $chain=[ordered]@{}
          while ($vhd.ParentPath){
              $chain.add($vhd.Path,$vhd.ParentPath)
              $vhd=Get-VHD -Path $vhd.ParentPath
              }
      $chain.GetEnumerator() | ForEach-Object {
          $line='Merge-VHD -Path "{0}" -Destination "{1}"' -f $_.key, $_.value
          $line | Out-File -FilePath .\merge.txt  -Append
          }    
      }
      ```

      The script should resemble the following script:

      :::image type="content" source="./media/merge-checkpoints-with-many-differencing-disks/mergescript-pasted.png" alt-text="Screenshot of the script after it's pasted into a PowerShell window.":::

1. Open _C:\temp\merge.txt_. This file contains a list of command line commands that are grouped into pairs. Each pair of commands defines the merge operations for a single differencing disk.

1. Copy the first command of the first pair, paste it at the command prompt, and then run it. Then, do the same for the second command of the first pair. These operations merge the differencing disk that the commands address.

1. After the disk merges, repeat step 7 for the next differencing disk in the list. Continue for all the differencing disks that the _merge.txt_ file addresses.
