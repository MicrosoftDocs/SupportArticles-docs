---
title: How to upload existing on-premises Hyper-V domain controllers to Azure by using Azure PowerShell
description: Describes how to upload existing on-premises Hyper-V domain controllers to Azure by using Azure PowerShell.
ms.date: 05/22/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-deploy
ms.custom: devx-track-azurepowershell
---
# How to upload existing on-premises Hyper-V domain controllers to Azure by using Azure PowerShell

This article describes how to upload existing on-premises Hyper-V domain controllers to Microsoft Azure by using Azure PowerShell.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles)  
_Original KB number:_ &nbsp; 2904015

On-premises domain controllers that are moved to Azure must have the following components:

- System Volume (SYSVOL) shared directory
- Active Directory Domain Services (AD DS) database
- AD DS log files that are located on one or more drives that do not share the same hard disk as the operating system.

Including these components on different volumes that use the same disk as the operating system is not valid. Such a configuration could result in Jet database inconsistencies because the operating system disk in Azure had Writeback cached enabled.

For more information, refer [Safely virtualizing Active Directory Domain Services (AD DS)](/windows-server/identity/ad-ds/introduction-to-active-directory-domain-services-ad-ds-virtualization-level-100) to deploy Windows Server Active Directory on Azure Virtual Machines.

## Prepare the on-premises domain controllers

To prepare the on-premises domain controllers to be uploaded or moved into Azure Infrastructure as a Service (IaaS), follow these steps:

1. Create a Storage account.
2. Create an Azure virtual network that has a site-to-site virtual private network (VPN) connection to your on-premises network.
   1. Create a subnet within the Azure virtual network.
   2. Define an on-premises domain name system (DNS) server on the Azure virtual network. This is the server that the virtual machines that are running in Azure will use to locate the on-premises domain controllers.
3. Create an Azure virtual machine.
   - If you are uploading the only domain controller in your forest, go step 5.
   - If you are uploading an additional domain controller for an existing domain, you should define an on-premises DNS server for the Azure virtual network to make sure that the domain controller locates other domain controllers when it comes online in Azure.
4. Run the following command:

    ```console
    diskpart san policy=onlineall
    ```

5. If the **StopReplicationOnAutoRecovery** value exists in the registry of the domain controller, make sure that it is set to zero (0) in case the Distributed File System Replication (DFSR) Automatic Recovery process has to occur.

    For information about the **StopReplicationOnAutoRecovery**  registry value, read [DFSR event ID 2213 in Windows Server 2008 R2 or Windows Server 2012](https://support.microsoft.com/help/2846759)

6. Before you restart the computer, set the IP and DNS settings to **Automatic (Dynamic)**.

## Prepare the host

To prepare the host that will upload the virtual machines, follow these steps:

1. Download and install the latest [Azure PowerShell](https://azure.microsoft.com/downloads/)  version that is listed on the Azure download webpage.
2. Open an elevated Azure PowerShell Command Prompt window, and then run the `Get-AzurePublishSettingsFile` command.

    > [!NOTE]
    >  This command starts a browser instance and connects to `https://windows.azure.com/download/publishprofile.aspx` When you are signed in to your Azure Account, you are prompted to save the management certificate (contains management credentials for your Azure account) in a `.publishsettings` file.
3. Import the downloaded `.publishsettings` file by running the following command:

    ```azurepowershell
    Import-AzurePublishSettingsFile <path to folder that contains .publishsettings file>
    ```

## Upload on-premises VHDs

Upload your on-premises virtual hard disks into your Azure Storage account, and then create the domain controller in an Azure virtual machine. To do this, follow these steps by using the commands as shown:

1. Start Azure PowerShell, and then retrieve your subscription name by running the `Get-AzureSubscription` command.

    ```azurepowershell
    $subscriptionName = 'MY SUBSCRIPTION'
    ```

2. Retrieve your storage account name by running the `Get-AzureStorageAccount` command.

    ```azurepowershell
    $storageAccountName = 'MY_STORAGE_ACCOUNT'
    ```

3. Specify the storage account location to store the newly created virtual hard disks.

    ```azurepowershell
    Set-AzureSubscription -SubscriptionName $subscriptionName -CurrentStorageAccount $storageAccountName
    ```

4. Select the correct subscription (multiple subscriptions are supported).

    ```azurepowershell
    Select-AzureSubscription -SubscriptionName $subscriptionName
    ```

5. Retrieve the Azure location and Affinity group name in which the storage account is running by using the Get-AzureAffinityGroup command.

    ```azurepowershell
    $location = 'Azure_Location'
    $affinity = 'AFFINITY_GROUP_NAME'
    ```

6. Specify the virtual machine size as either Small, Medium, Large, or ExtraLarge.

    ```azurepowershell
    $instanceSize = 'Medium'
    ```

7. Specify a cloud service name. Run the `Test-AzureName -Service 'CLOUD_SERVICE_NAME'` command to see whether the name is already being used. A return of **false** indicates that you can use the name.

    ```azurepowershell
    $serviceName = 'CLOUD_SERVICE_NAME'
    ```

8. Specify the virtual network and the subnet in which your virtual machine will run. Run the Get-AzureVNetSite command to return the virtual network name in the "name" value and the list of available subnets in the "subnet" value.

    ```azurepowershell
    $vnet = 'VIRTUAL_NETWORK_NAME'
    $subnet = 'SUBNET_NAME_IN_YOUR_AZURE_NETWORK'
    ```

9. Enter the server name.

    ```azurepowershell
    $vmname1 = 'MY_VM_NAME'
    ```

10. Enter the path of the virtual hard disks that are to be uploaded.

    ```azurepowershell
    $sourceosvhd = 'C:\MyVHDsDC1OSDisk.vhd'
    $sourcedatavhd = 'C:\MyVHDsDC1DataDisk.vhd'
    ```

11. Provide the target upload location to upload the virtual hard disks.

    ```azurepowershell
    $destosvhd = 'https://' + $storageAccountName + '.blob.core.windows.net/uploads/DC1OSDisk.vhd'
    $destdatavhd = 'https://' + $storageAccountName + '.blob.core.windows.net/uploads/DC1DataDisk.vhd'
    Add-AzureVhd -LocalFilePath $sourceosvhd -Destination $destosvhd
    Add-AzureVhd -LocalFilePath $sourcedatavhd -Destination $destdatavhd
    Add-AzureDisk -OS Windows -MediaLocation $destosvhd -DiskName 'DC1OSDisk'
    Add-AzureDisk -MediaLocation $destdatavhd -DiskName 'DC1DataDisk'
    $migratedVM = New-AzureVMConfig -Name $vmname1 -DiskName 'DC1OSDisk' -InstanceSize $instanceSize | Add-AzureDataDisk -Import -DiskName 'DCDataDisk' -LUN 0 | Add-AzureEndpoint -Name 'Remote Desktop' -LocalPort 3389 -Protocol tcp
    Set-AzureSubnet -SubnetNames $subnet -VM $migratedVM
    New-AzureVM -ServiceName $serviceName -Location $location -VMs $migratedVM -VNetName $vnet -AffinityGroup $affinity
    ```

12. Start the virtual machine, move the system-managed page file to the Temporary volume, and then restart the virtual machine.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
