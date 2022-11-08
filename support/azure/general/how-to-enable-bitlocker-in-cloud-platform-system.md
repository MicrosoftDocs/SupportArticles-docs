---
title: How to enable BitLocker in Cloud Platform System (CPS)
description: Describes how to enable BitLocker on Cloud Platform System (CPS) in Windows Server 2012. Includes the scripts to automate this process.
author: genlin
ms.author: genli
ms.service: cloud-platform-system
ms.date: 08/14/2020
ms.reviewer: fiseraci
---
# How to enable BitLocker in Cloud Platform System (CPS)

_Original product version:_ &nbsp; Cloud Platform System, Windows Server 2012 R2 Datacenter  
_Original KB number:_ &nbsp; 3078425

This article explains how to enable BitLocker to provide Data at Rest encryption in Microsoft Cloud Platform System (CPS).

## More information

Microsoft Cloud Platform System leverages the Windows Server 2012 ability to encrypt Cluster Shared Volumes (CSV) by using BitLocker&reg;. This article explains how to enable BitLocker. It also provides the scripts to automate the process.
> [!NOTE]
> BitLocker should be enabled as early as possible in the CPS lifecycle because the process generates significant downtime. That is, the second script in this process will turn off all tenant VMs and all management VMs (except AD/DC VMs) to enable BitLocker . Follow these steps carefully. Failure to do so could result in extended downtime and data corruption.

## Step 1 Enable Ethe BitLocker Drive Encryption feature

Enable the BitLocker Drive Encryption feature on every node of the storage cluster:

1. Copy the following code, and then save it as Enable-BitLockerFeature.ps1 in \<myFolder\> on the Console VM:

    ```
    <###################################################
    # #
    # Copyright (c) Microsoft. All rights reserved. #
    # #
    ##################################################>
    <#
    .SYNOPSIS
    Install BitLocker Drive Encryption feature on each of the storage cluster nodes
    .DESCRIPTION
    Install BitLocker Drive Encryption feature on each node of the storage cluster. 
    THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY
    IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.
    #>
    　
    Param(
    [Parameter (Mandatory = $true)] [string] $storageClusterName 
    )
    $clusterNodes =Invoke-Command -ComputerName $storageClusterName {Get-ClusterNode}
    if($clusterNodes -eq $null)
    {
    $errorMessageForUser = "Failed while retrieving the nodes of the storage cluster $storageClusterName"
    throw $errorMessageForUser 
    }
    foreach ($node in $clusterNodes.Name)
    {
    Write-Verbose "Installing BitLocker feature on node $node..."
    $BitlockerStatus = Invoke-Command -ComputerName $node {Add-WindowsFeature Bitlocker -Verbose}
    if(($BitlockerStatus -eq $null) -or (!$BitlockerStatus.Success))
    {
    $errorMessageForUser = "Add-WindowsFeature failed on node $node. Please try to install the feature on this node manually and then rerun this script to continue with the installation on the other nodes. "
    throw $errorMessageForUser
    }
    if($BitlockerStatus.RestartNeeded -eq "Yes")
    {
    Write-Verbose "Restarting Node $node..."
    Restart-Computer -ComputerName $BitlockerStatus.PSComputerName -wait
    Write-Verbose "Node $node restarted."
    }
    }
    $installedCounter=0
    foreach ($node in $clusterNodes.Name)
    {
    $featureState = Invoke-Command -ComputerName $node {Get-WindowsFeature "bitlocker"}
    if($featureState -eq $null)
    {
    $errorMessageForUser = "Could not verify that BitLocker feature is correctly installed on storage node $node. Please connect to the node and run 'Get-WindowsFeature bitlocker' to verify the correct installation."
    Write-Warning $errorMessageForUser
    }
    if ($featureState.InstallState -eq "Installed")
    {
    $installedCounter++
    }
    }
    if($installedCounter -eq $clusterNodes.Count)
    {
    Write-Verbose "BitLocker feature is now installed on all the nodes of the storage cluster"
    }
    else
    {
    Write-Error "BitLocker feature was not properly installed on all the nodes of the storage cluster"
    }
    
    ```

2. From the console VM, open a PowerShell console with admin rights, go to \<myFolder\>, and then enter the following: ./Enable-BitLockerFeature.ps1 -storageClusterName \<yourStorageCluster\> -verbose
The script will iterate through all the nodes of the storage cluster and install BitLocker. The nodes will be rebooted during the process.

3. After the script finishes running successfully, go to step 2.

## Step 2 Create GPO for Active Directory-based BitLocker recovery

Note that BIOS configured TPM is not required, as BitLocker is being managed and configured through Active Directory.

1. From the console VM, open the Group Policy Management editor.

2. Expand the forest, right-click the CPS domain, and then click **Create a GPO in this domain** and **Link it here**.
3. Give the GPO a name of your choice (for example, BitLocker), and then click **OK**.

4. A new GPO should now appear under the CPS domain. Click the **Settings** tab of the BitLocker GPO, right-click **Computer Configuration**, and then click **Edit**. This will open another Group Policy Management Editor window.

5. In the left pane of the Group Policy Management Editor, navigate to **Computer Configuration** -> **Policies** -> **Administrative Templates** -> **Windows Components** -> **BitLocker Drive Encryption** -> **Fixed Data Drives**, and then right-click **Choose how BitLocker-protected fixed drives can be recovered**.

6. In the policy setting pop-up dialog box, enable the policy, and set the following options:
    1. Allow data recovery agent
    2. Save BitLocker recovery information to AD DS for fixed data drives
    3. Do not enable BitLocker until recovery information is stored to AD DS for fixed data drives
7. Click **OK**, and then close the Editor window.

8. In the Security Filtering frame, click **Add** to add all the storage nodes computer accounts. In CPS, there are four nodes per rack. After you add them, all the nodes should be listed in the Security Filtering frame. You can remove the default Authorized Users group.

9. In the left pane, right-click the BitLocker policy, and then click **Enforced**. Close the Group Policy Management Editor.

10. At this point, the policy is applied, but it might take as long as one hour to propagate.

    1. In case you don't want to wait for the policy to propagate, you can manually enforce it by logging in to each storage node and running PS C:\Users\admin1\Desktop> gpupdate /force .
    2. Verify that the policy has been successfully applied by running the following cmdlet on each storage node: `PS C:\Users\admin1\Desktop> gpresult /scope computer /v`
    3. In the output, look for the Applied Group Policy objects. If your policy (in this example we called it BitLocker) is listed, the policy is applied, and you can go to step 3.

    1.

## Step 3 Turn off tenant VMs

**IMPORTANT [do not skip this step]:** If you have tenant VMs running, you must turn them off before you continue with the next step. The script in step 4 will turn off all the active VMs on the stamp. So make sure that you turn off all the tenant VMs before executing the script in step 4. Do not turn off the VMs with Domain controller role. After the volumes have an **Online (Redirected)** status, the tenant VMs can be safely restarted.

## Step 4 Enable BitLocker on storage

Enable BitLocker encryption on all the storage volumes.

> [!IMPORTANT]
> This procedure needs to be repeated on each rack of your CPS stamp as each rack has its own storage cluster.

1. Copy the following code, and then save it as Enable-ClusterDiskBitlocker.ps1 in \<myFolder\> on one of the nodes of the storage cluster. Let's call that node < _myStorageNode_ >.

    ```
    <###################################################
     #                                                 #
     #  Copyright (c) Microsoft. All rights reserved.  #
     #                                                 #
     ##################################################>
    <#
    .SYNOPSIS
    Enable Bitlocker on all the Cluster Shared Volumes in CPS.
    .DESCRIPTION
    Enable Bitlocker on all the Cluster Shared Volumes on the rack. The volumes will be fully encrypted. The encryption process may take long time (48-72h), depending on the amount of data stored. During that time, 
    the volumes will be in a redirected state. The volumes will automatically go back to Online once the encryption process is complete. 
    NOTE: Please put all the VMs, both management and tenants, into a save state. Failing to do so will result in the VMs crashing and possibly getting into an inconsistent state. 
    Once the volumes are in Online (Redirected) status, the VMs can be safely restarted.
    THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY
    IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.
    #>
    
    Function Stop-ClusterVMs
    {
    #Stop all VMs passed as input
        param([string]$ClusterName,[Object[]]$TargetVMs)
        $proceed = Get-Confirmation -question "The script will now turn off ALL the virtual machines in the $ClusterName cluster"
        $TargetVMs | Out-File ".\$ClusterName.txt"
        if($proceed -eq $true)
        {
            $counter=1
            foreach ($vm in $TargetVMs)
            {
                $progress=  [int] ($counter / $TargetVMs.Count * 100 )
                Write-Progress -Activity "Stopping $ClusterName Virtual Machines..." `
                -PercentComplete  $progress `
                -CurrentOperation "$progress% complete" `
                -Status "Please wait."
                $counter++
                Write-Verbose "Now turning off $vm.Name on node $vm.OwnerNode"
                Stop-VM -Name $vm.Name -ComputerName $vm.OwnerNode -Force
               
            }
            Write-Progress -Activity "Stopping $ClusterName Virtual Machines..." `
            -Completed -Status "All VMs are shut down."
        }
        else
        {
            exit
        }
    }
    Function Start-ClusterVMs
    {
    #start all the VMs passed as input
        param([string]$ClusterName,[Object[]]$TargetVMs)
        
        $counter=1
        foreach ($vm in $TargetVMs)
        {
            $progress=  [int] ($counter / $TargetVMs.Count * 100 )
            Write-Progress -Activity "Starting $ClusterName Virtual Machines..." `
            -PercentComplete  $progress `
            -CurrentOperation "$progress% complete" `
            -Status "Please wait."
            $counter++
            Write-Verbose "Now turning on $vm.Name..."
            Start-VM -Name $vm.Name -ComputerName $vm.OwnerNode 
        }
         Write-Progress -Activity "Starting $ClusterName Virtual Machines..." `
         -Completed -Status "All VMs are running."
    }
    Function Get-ClusterVMs
    {
    #create a table with VM, OwnerNode for the given cluster
        param([string]$Cluster)
        $resultTable =  @{Expression={$_.Name};Label="Volume Name";width=80},`
                    @{Expression={$_.OwnerNode};Label="Owner Node";width=50}
                    
        
        $nodes = Get-ClusterNode -Cluster $Cluster
       
     foreach($node in $nodes)
        {
            $targetVMs =  Get-VM -ComputerName $node | Where{$_.State -like "Running"}
            foreach($vm in $targetVMs)
            {
                [PSCustomObject] @{  
                        "Name" = $vm.Name
                        "OwnerNode" = $node
                }     
            } 
        }
    }
    Function Get-Confirmation 
    {
     param([string]$Question, [string]$message="Do you want to proceed?")
     $optionYes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Yes"
     $optionNo = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "No"
     $options = [System.Management.Automation.Host.ChoiceDescription[]]($optionYes, $optionNo)
     $result = $host.ui.PromptForChoice($Question, $message, $options, 0)
     switch ($result)
        {
      0 {Return $true }
       1 {Return $false }
     }
    }
    Function Suspend-ClusterVMs
    {
    #stop the cluster and put all VMs in saved state
        param([string]$ClusterName)
        $proceed = Get-Confirmation -question "The script will now suspend ALL the virtual machines in the $ClusterName cluster"
        
        Get-ClusterNode -Cluster $ClusterName | Out-File ".\$ClusterName.txt"
        if($proceed -eq $true)
        {
           Stop-Cluster -Cluster $ClusterName -Verbose -Force
        }
        else
        {
            exit
        }
    }
    Function Enable-ClusterDiskBitlocker
    {
    Param(
       [Parameter (Mandatory = $true)] [System.Security.SecureString] $bitlockerEncryptionKey, 
       [Parameter (Mandatory = $false)] [String] $managementClusterName, 
       [Parameter (Mandatory = $true)] [String] $computeClusterName, 
       [Parameter (Mandatory = $true)] [String] $edgeClusterName
    )
        $ErrorActionPreference = "Stop"
    while ((Read-Host "Please make sure all the tenant VMs are turned off before proceeding.`nPress Y to proceed if the tenant VMs are already turned off or after the tenant VMs are turned off") -ne "Y") {}          
    
        $creds = get-credential -Message "Please provide Admin credentials to enable BitLocker"
     if(-not $managementClusterName)
     {
      $managementClusterName = Read-Host "If you are enabling BitLocker on rack #1, please provide the name of the management cluster. If you are enabling BitLocker on rack #2, 3 or 4, please leave this null" 
     }
        #Verifying that cluster names are correct
     if($managementClusterName -ne $null)
     {
      while ((Get-Cluster $managementClusterName) -eq $null)
      {
       $managementClusterName = Read-Host "The name provided for the management cluster is not correct. Please provide name of the management cluster" 
      }
     }
        while ((Get-Cluster $computeClusterName) -eq $null)
        {
            $computeClusterName = Read-Host "The name provided for the compute cluster is not correct. Please provide name of the compute cluster" 
        }
        
        while ((Get-Cluster $edgeClusterName) -eq $null)
        {
            $edgeClusterName = Read-Host "The name provided for the edge cluster is not correct. Please provide name of the edge cluster" 
        }
        #enabling hyper-v-powershell feature on the storage node
        if(!(Get-WindowsFeature |?{$_.Name -match "Hyper-V-Powershell"} | select -ExpandProperty Installed))
        {
            Write-Verbose "Installing Hyper-V-Powershell feature..."
            Add-WindowsFeature "Hyper-V-Powershell" -Verbose
        }
        
        
        #data structures needed to restart the vms later
     if($managementClusterName -ne $null)
     {
      $managementClusterNodes = Get-ClusterNode -Cluster $managementClusterName
      if($managementClusterNodes -eq $null)
      {
       Write-Warning "Could not retrieve the nodes of the management cluster"
      }
     }
        $edgeClusterVMs = Get-ClusterVMs -Cluster $edgeClusterName 
        if($edgeClusterVMs -eq $null)
        {
            Write-Warning "Could not retrieve the virtual machines of the edge cluster"
        }
        $computeClusterVMs = Get-ClusterVMs -Cluster $computeClusterName 
        if($computeClusterVMs -eq $null)
        {
            Write-Warning "Could not retrieve the virtual machines of the compute cluster"
        }
    
        #turning off all VMs to prevent them from crashing and risk of data corruption
        $proceed = Get-Confirmation -Question "Have you enabled RDP connectivity on a storage node?"
        if($proceed -eq $false)
        {
            Write-Error "This script must be run from a storage node. Please enable RDP on a storage node, connect to it and restart the script."
            exit
        }
        $proceed = Get-Confirmation -Question "Are you running this script from a storage node?"
        if($proceed -eq $false)
        {
            Write-Error "This script must be run from a storage node. Please RDP into a storage node and restart the script."
            exit
        }
        Stop-ClusterVMs -ClusterName $computeClusterName -targetVMs $computeClusterVMs
        Stop-ClusterVMs -ClusterName $edgeClusterName -targetVMs $edgeClusterVMs
        if($managementClusterName -ne $null)
     {
      Suspend-ClusterVMs -ClusterName $managementClusterName
     }
        $storageClusterName = (Get-Cluster).name
        while ($storageClusterName -eq $null)
        {
            $storageClusterName = Read-Host "Please provide name of the storage cluster" 
        }
        $clusterNodes = (Get-ClusterNode -Cluster $storageClusterName).Name
        if($clusterNodes -eq $null)
        {
            Write-Error "Could not retrieve the nodes of the storage cluster"
        }
        $ClusterSharedVolumes = Get-ClusterSharedVolume -Cluster $storageClusterName
        if($ClusterSharedVolumes -eq $null)
        {
            Write-Error "'Get-ClusterSharedVolume -Cluster' $storageClusterName failed. Could not retrieve the list of volumes of the storage cluster"
        }
        #temporarily enable CredSSP on the SOFS nodes
        foreach($clusterNode in $clusterNodes)
        {
            Write-Verbose "Enabling CredSSP Client role for $clusterNode..."
            Enable-WSManCredSSP -role Client -DelegateComputer * -Force
            Write-Verbose "Enabling CredSSP Server role on $clusterNode..."
            Invoke-Command -ComputerName $clusterNode  {Enable-WSManCredSSP -Role Server -Force}
        }
      
    
        $counter = 1
        foreach ($clusterSharedVolumeObject in $ClusterSharedVolumes) {
        
            $progress=  [int] ($counter / $ClusterSharedVolumes.Count * 100 )
            Write-Progress -Activity "Enabling BitLocker on the volumes..." `
            -PercentComplete  $progress `
            -CurrentOperation "$progress% complete" `
            -Status "Please wait."
            $counter++
        
            $clusterSharedVolume = $clusterSharedVolumeObject.Name 
            $CSVPhysicalOwner = $clusterSharedVolumeObject.OwnerNode
       
        
            #Verifying the status of the volume before starting the encryption process. only fullydecrypted is acceptable.
            $clusterSharedVolumeStatus = (Invoke-Command -Authentication Credssp -Credential $creds -ComputerName $CSVPhysicalOwner -ArgumentList $clusterSharedVolumeObject {param($clusterSharedVolumeObject) Get-BitlockerVolume -MountPoint $clusterSharedVolumeObject.SharedVolumeInfo.FriendlyVolumeName}).VolumeStatus
            switch ($clusterSharedVolumeStatus) {
                "FullyDecrypted" {"Starting encryption process for $clusterSharedVolume..."; $continueWithEncryption = $true}
                "FullyEncrypted" {"$clusterSharedVolume is already encrypted. Moving to the next volume."; $continueWithEncryption = $false}
                "EncryptionInProgress" {"$clusterSharedVolume is currently being encrypted. Moving to the next volume"; $continueWithEncryption = $false}
                default {"$clusterSharedVolume status is unknown. Moving to the next volume"; $continueWithEncryption = $false}
            }        
            if (!$continueWithEncryption){continue}
        try{
            #Put ClusterSharedVolume in Maintenance Mode
                Write-Verbose "Putting the $clusterSharedVolume in maintenance mode..."
                Invoke-Command -ComputerName $CSVPhysicalOwner -ArgumentList $clusterSharedVolume {param($clusterSharedVolume) Get-ClusterSharedVolume $clusterSharedVolume | Suspend-ClusterResource -Force}
        
            #Configure BitLocker on the volume 
                $CSVMountPoint = Invoke-Command  -ComputerName $CSVPhysicalOwner -Authentication Credssp -Credential $creds -ArgumentList $clusterSharedVolume {param($clusterSharedVolume) (Get-ClusterSharedVolume $clusterSharedVolume).SharedVolumeInfo.FriendlyVolumeName}
                if($CSVMountPoint -eq $null)
                {
                   $errorMessageForUser = "Failed while retrieving the MountPoint associated with $clusterSharedVolume on server node $CSVPhysicalOwner"
                   throw $errorMessageForUser 
                }
                Write-Verbose "Invoking Enable-Bitlocker on $clusterSharedVolume..."
                Invoke-Command -ComputerName $CSVPhysicalOwner -Authentication Credssp -Credential $creds -ArgumentList $CSVMountPoint {param($CSVMountPoint) Enable-BitLocker $CSVMountPoint -RecoveryPasswordProtector}
                Invoke-Command -ComputerName $CSVPhysicalOwner -Authentication Credssp -Credential $creds -ArgumentList $CSVMountPoint,$bitlockerEncryptionKey {param($CSVMountPoint, $bitlockerEncryptionKey) Add-BitLockerKeyProtector $CSVMountPoint -PasswordProtector –Password $bitlockerEncryptionKey}
            #enable using a recovery password protector and backup the protector to Active Directory
                write-verbose "Backup BitLocker Key Protector on AD for $clusterSharedVolume..."        
                $protectorId = Invoke-Command -ComputerName $CSVPhysicalOwner -Authentication Credssp -Credential $creds -ArgumentList $CSVMountPoint {param($CSVMountPoint) (Get-BitLockerVolume $CSVMountPoint).Keyprotector | Where-Object {$_.KeyProtectorType -eq "RecoveryPassword"}}            
    
                if($protectorId -eq $null)
                {
                   $errorMessageForUser = "Failed while retrieving the protector Id associated with $CSVMountPoint on server node $CSVPhysicalOwner"
                   throw $errorMessageForUser 
                }       
           
                Invoke-Command -ComputerName $CSVPhysicalOwner -Authentication Credssp -Credential $creds -ArgumentList $CSVMountPoint,$protectorId {param($CSVMountPoint, $protectorId) Backup-BitLockerKeyProtector $CSVMountPoint -KeyProtectorId $protectorId.KeyProtectorId}
            #Determine the Cluster Name Object for your cluster:        
                $cno = $storageClusterName + "$"
            #Add an Active Directory Security Identifier (SID) to the CSV disk using the Cluster Name Object (CNO)
                Write-Verbose "Enabling ADProtector on $clusterSharedVolume..."
                Invoke-Command -ComputerName $CSVPhysicalOwner -Authentication Credssp -Credential $creds -ArgumentList $CSVMountPoint,$cno {param($CSVMountPoint, $cno) Add-BitLockerKeyProtector $CSVMountPoint -ADAccountOrGroupProtector –ADAccountOrGroup $cno}
     
            #Put the ClusterSharedVolume back online
                Write-Verbose  "Putting $clusterSharedVolume back online..."
                Invoke-Command -ComputerName $CSVPhysicalOwner -Authentication Credssp -Credential $creds -ArgumentList $clusterSharedVolume {param($clusterSharedVolume) Get-ClusterSharedVolume $clusterSharedVolume | Resume-ClusterResource}
         }
         catch
         {
            Invoke-Command -ComputerName $CSVPhysicalOwner -Authentication Credssp -Credential $creds -ArgumentList $CSVMountPoint{param($CSVMountPoint) manage-bde -off $CSVMountPoint}
            Write-Host "The encryption process of $CSVMountPoint encountered a problem. Execution stopped. Disabling BitLocker and decrypting volume $CSVMountPoint" -ForegroundColor Red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            exit
         }
     
        }
    
        #restart all VMs that were previously shut down or suspended
        Write-Verbose "Encryption enabled on all the CSVs. Restarting now all the VMs that were previously shut down or suspended"
     if($managementClusterName -ne $null)
     {
      #restarting management cluster 
      $tempCounter = 0
      $sizeManagementCluster = $managementClusterNodes.length - 1
      $managmentClusterObject = Start-Cluster $managementClusterNodes[$tempCounter]  
      while (($managementClusterObject -eq $null ) -and ($tempCounter -lt $sizeManagementCluster))
      {
       Write-Verbose "Management Cluster did not start on node $managementClusterNodes[$tempCounter]" 
       $tempCounter++
       Write-Verbose "Trying now to start the management cluster on node $managementClusterNodes[$tempCounter]"
       $managmentClusterObject = Start-Cluster $managementClusterNodes[$tempCounter]
      }
      if ($managementClusterObject -eq $null)
      {
       Write-Host "Management cluster could not be started. Please restart it manually" -ForegroundColor Red
      }    
     }
     Start-ClusterVMs -ClusterName $edgeClusterName -TargetVMs $edgeClusterVMs 
        Start-ClusterVMs -ClusterName $computeClusterName -TargetVMs $computeClusterVMs 
    
        #disable credSSP on the SOFS nodes
        foreach($clusterNode in $listOfNodes)
        {
            write-verbose "Disabling CredSSP on $clusterNode..."
            Invoke-Command -ComputerName $clusterNode  {Disable-WSManCredSSP -Role Server}
        }
        write-verbose "Disabling CredSSP on local machine..."
        Disable-WSManCredSSP -role Client
    
        Write-Progress -Activity "Enabling BitLocker on the volumes..." `
        -Completed -Status "All done."
    }
    Enable-ClusterDiskBitlocker -Verbose 
    ```

2. Use Remote Desktop to connect to < _myStorageNode_ > by using your admin credentials, and then open a PowerShell console with administrator rights. If you cannot connect, enable Remote Desktop on the storage nodes. For instructions on how to enable Remote Desktop, please refer to: [Windows 2012 Core Survival Guide - Remote Desktop.](https://blogs.technet.com/b/bruce_adamczak/archive/2013/02/12/windows-2012-core-survival-guide-remote-desktop.aspx)

3. Go to \<myFolder\>, and then enter the following command line:PS C:\Users\admin1\Desktop> .\Enable-ClusterDiskBitlocker.ps1 -Verbose
The encryption key is the key that you want to use for BitLocker. The script prompts for your admin credentials and the names of the management cluster, the compute cluster, and the edge cluster.

4. The script will first turn off all the VMs on the stamps (except the AD/DC VMs), so you will lose the connectivity to the console VM. The script will go through each cluster disk and enable BitLocker encryption. After BitLocker has been enabled on every cluster disk, the script will bring all the VMs online that were turned off during the process.

If you are interested in learning what is going on under the hood, the script closely follows the steps in the following blog post:

[How to configure BitLocker-encrypted clustered disks in Windows Server 2012](https://techcommunity.microsoft.com/t5/failover-clustering/how-to-configure-bitlocker-encrypted-clustered-disks-in-windows/ba-p/371825)

This process takes about 30 minutes per storage cluster.

5. After the script finishes running, open Failover Cluster Manager. All the cluster disks should have an **Online (Redirected)**  status. You can now turn on all the VMs that you turned off earlier and operate the CPS rack as usual. The encryption process might take several days to complete, depending on the amount of data that's written on the disks. After a cluster disk is fully encrypted, its status automatically returns to **Online**.

6. Once the encryption process completed, please disable Remote Desktop on the storage nodes. For instructions on how to disable Remote Desktop, please refer to: [Windows 2012 Core Survival Guide - Remote Desktop.](https://blogs.technet.com/b/bruce_adamczak/archive/2013/02/12/windows-2012-core-survival-guide-remote-desktop.aspx)

## Step 5 Verify the encryption status of the stamp

To get a status update on the encryption process, or to get a printout of the encryption status for compliance reasons, run the following Get-VolumeEncryptionStatus cmdlet.

```
<###################################################
# #
# Copyright (c) Microsoft. All rights reserved. #
# #
##################################################>
<#
.SYNOPSIS
Collect encryption status for each of the volumes in the storage cluster.
.DESCRIPTION
Collect encryption status for each of the volumes in the storage cluster. For each volume, this script returns Volume Name, Owner Node, Encryption Status and Encryption Percentage.
The script requires the Bitlocker Feature installed on every node of the cluster and credssp enabled.
THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY
IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.
#>
Param(
[Parameter (Mandatory = $true)] [string] $storageClusterName
)
$ClusterSharedVolumes = Get-ClusterSharedVolume -Cluster $storageClusterName
if($ClusterSharedVolumes -eq $null)
{
Write-Error "'Get-ClusterSharedVolume -Cluster' $storageClusterName failed. Could not retrieve the list of volumes of the storage cluster"
}
try{
$resultTable = @{Expression={$_.Name};Label="Volume Name";width=45},`
@{Expression={$_.OwnerNode};Label="Owner Node";width=15}, `
@{Expression={$_.VolumeStatus};Label="Encryption Status";width=25}, `
@{Expression={$_.EncryptionPercentage};Label="Encryption Percentage";width=15} 
　
$counter = 1
$temp = foreach($clusterSharedVolumeObject in $ClusterSharedVolumes)
{
$progress= [int] ($counter / $ClusterSharedVolumes.Count * 100 )
Write-Progress -Activity "Collecting data..." `
-PercentComplete $progress `
-CurrentOperation "$progress% complete" `
-Status "Please wait."
$bitlockerVolume = Invoke-Command -ComputerName $clusterSharedVolumeObject.OwnerNode.Name -ArgumentList $clusterSharedVolumeObject {param($clusterSharedVolumeObject) Get-BitlockerVolume -MountPoint $clusterSharedVolumeObject.SharedVolumeInfo.FriendlyVolumeName}
[PSCustomObject] @{ 
"Name" = $clusterSharedVolumeObject.Name
"OwnerNode" = $clusterSharedVolumeObject.OwnerNode.Name
"VolumeStatus" = $bitlockerVolume.VolumeStatus
"EncryptionPercentage" = $bitlockerVolume.EncryptionPercentage
} 
$counter++
} 
　
$temp | Format-Table $resultTable 
Write-Progress -Activity "Collecting data..." `
-Completed -Status "All done."
}
catch
{
Write-Host "The cmdlet encountered a problem. Execution stopped." -ForegroundColor Red
write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
}
```

1. Copy this code and save it as Get-VolumeEncryptionStatus.ps1 in \<myFolder\> on a console VM.

2. Open a Powershell console with admin rights and run the following cmdlet to pass the name of your storage cluster: `PS C:\Users\admin1\Desktop> .\Get-VolumeEncryptionStatus.ps1 -storageClusterName`

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
