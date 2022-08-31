---
title: How to merge checkpoints that have multiple differencing disks
description: Describes different methods of merging checkpoints and their associated differencing disks with the related virtual machine.
ms.date: 08/31/2022
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:snapshots-checkpoints-and-differencing-disks, csstroubleshoot
ms.technology: hyper-v
keywords: 
---

# How to merge checkpoints that have multiple differencing disks

_Applies to:_ &nbsp; 

## Introduction

This article describes methods that you can use to merge checkpoints with a virtual machine (VM) when Hyper-V has generated a large number of differencing disks. The method that you use depends on the details of the situation.

## Merging checkpoints that you can view in Hyper-V Manager

Checkpoints that you can view in Hyper-V Manager are the simplest to deal with. Most of the time, you can use the **Delete Checkpoint** command on the context menu to delete these checkpoints.

![temp](./media/title/delete-checkpoint.png)

In some cases, **Delete Checkpoint** does not appear on the context menu. This can happen when third-party backup software generates checkpoints but doesn't delete them after a backup operation.

![temp](./media/title/checkpoint-menu.png)

In these cases, you can still use the Delete key to delete the checkpoint.

In summary, to delete checkpoints in Hyper-V Manager (and merge the differencing disk files), follow these steps:

1. In Hyper-V Manager, select the virtual machine.
2. In the **Checkpoints** list, right-click the checkpoint that you want to delete, and then do one of the following:
   - Select **Delete Checkpoint**.
   - If **Delete Checkpoint** is not available, select the checkpoint and then select **Del**.

### Merging checkpoints that you cannot view in Hyper-V Manager

You may encounter a situation where Hyper-V Manager doesn't show checkpoints for a specific VM, but the corresponding file system folder shows a large number of differencing disk files. This can happen when third-party backup software generates checkpoints but doesn't delete them after a backup operation.

You can merge the differencing disk files in one of two ways, depending on whether or not you can shut down the VM.

#### When you can shut down the VM

To merge the differencing disk files, shut down the VM. Typically, the differencing disk files merge as part of the VM shutdown process.

#### When you cannot shut down the VM

Merging differencing disks with an online VM is possible, but is a multi-step process that involves Windows Powershell scripts. To do this, follow these general steps:

1. Back up all of the differencing disk files (VHD files).
1. [Create and run the `Get-VHDChain` function](#getchain). This step is described in detail later in this section.
1. [Create and run merge commands](#mergechain). This step is described in detail later in this section.
1. Change the VM settings to point to the merged parent VHD.
1. Start the VM. A successful startup means that the merge completed successfully.

<a id="getchain"></a>**Create and run the Get-VHDChain function**

1. On the Hyper-V host server, open an administrative PowerShell command prompt window.
1. Copy the following script, and then paste it into the PowerShell window.

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

   This script defines a `Get-VHDChain` function that identifies the VHD chain (the set of differencing disks for the VM). The script should appear similar to the following:

   ![temp](./media/title/powershell-script.png)

1. Run the following command:

   ```
   Get-vhdchain -name <virtual machine name>
   ```

   > [!NOTE]  
   > In this command, <_virtual machine name_> represents the name of the virtual machine.

   ![temp](./media/title/powershell-script-step-2.png)

1. Make sure that `Get-VHDChain` runs without errors.

   > [!IMPORTANT]  
   > If the `Get-VHDChain` output contains errors, you have to remove the affected differencing disks from the folder. In the following example, Disk 24 has generated an error and must be removed from the differencing disk folder.
   > ![temp](media/title/powershell-script-step-2b.png)

<a id="mergechain"></a>**Create and run merge commands**

1. Follow these steps to create a script to merge the disks. These instructions create a script in `C:\temp\merge.txt`.
   1. On the local `C:` drive, create a folder that is named `temp`.
   1. Open an Administrative Powershell window, and then run the following command:

      ```powershell
      $vm = Read-Host("please enter the VMname") 
      ```

   1. At the command prompt, enter the virtual machine name.
   1. Copy the following script, and then past it at the command prompt.

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

      ![temp](media/title/powershell-script-step-3.png)

1. Open `C:\temp\merge.txt`. This file contains a list of command-line commands that are grouped into pairs. Each pair of commands addresses a single differencing disk. For example, in the following file, the highlighted pair of commands address **Disk4**.

   ![temp](media/title/powershell-script-step-4.png)

1. Copy the first command of the first pair, paste it at the command prompt, and then run it. Then do the same for the second command of the first pair. These operations merge the differencing disk that the commands address.

   ![temp](media/title/powershell-script-step-5.png)

1. After the disk merges, repeat step 7 for the next differencing disk in the list. Continue for all of the differencing disks that the `merge.txt` file addresses.
