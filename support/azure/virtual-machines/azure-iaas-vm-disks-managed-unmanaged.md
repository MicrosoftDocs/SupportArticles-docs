---
title: Frequently asked questions - Azure IaaS VM disks, and managed and unmanaged premium disks
description: This article answers some frequently asked questions about Azure Managed Disks and Azure Premium SSD disks.
ms.date: 08/24/2021
ms.prod-support-area-path: 
ms.reviewer: 
ms.service: virtual-machines
ms.collection: windows
---

# Frequently asked questions - Azure IaaS VM disks, and managed and unmanaged premium disks

This article answers frequently asked questions about Azure Managed Disks and Azure Premium SSD disks.

## Managed Disks
<details>
  <summary>Click here to expand this section.</summary>

**Q: What is Azure Managed Disks?**

**A:** Managed Disks is a feature that simplifies disk management for Azure IaaS VMs by handling storage account management for you.

For more information, see the [Managed Disks overview](/azure/virtual-machines/managed-disks-overview).

**Q: If I create a standard managed disk from an existing VHD that's 80 GB, how much will that cost me?**

**A:** A standard managed disk created from an 80-GB VHD is treated as the next available standard disk size, which is an S10 disk. You're charged according to the S10 disk pricing.

For more information, see the [pricing page](https://azure.microsoft.com/pricing/details/storage).

**Q: Are there any transaction costs for standard managed disks?**

**A:** Yes. You're charged for each transaction.

For more information, see the [pricing page](https://azure.microsoft.com/pricing/details/storage).

**Q: For a standard managed disk, will I be charged for the actual size of the data on the disk or for the provisioned capacity of the disk?**

**A:** You're charged based on the provisioned capacity of the disk.

For more information, see the [pricing page](https://azure.microsoft.com/pricing/details/storage).

**Q: How is pricing of premium managed disks different from unmanaged disks?**

**A:** The pricing of premium managed disks is the same as unmanaged premium disks.

**Q: Can I change the storage account type (Standard or Premium) of my managed disks?**

**A:** Yes. You can change the storage account type of your managed disks by using the Azure portal, PowerShell, or the Azure CLI.

**Q: Can I use a VHD file in an Azure storage account to create a managed disk with a different subscription?**

**A:** Yes. You can use a VHD file in an Azure storage account to create a managed disk with a different subscription.

**Q: Can I use a VHD file in an Azure storage account to create a managed disk in a different region?**

**A:** No. You can't use a VHD file in an Azure storage account to create a managed disk in a different region.

**Q: Are there any scale limitations for customers that use managed disks?**

**A:** Managed Disks eliminates the limits associated with storage accounts. However, the maximum limit is 50,000 managed disks per region and per disk type for a subscription.

**Q: Can VMs in an availability set consist of a combination of managed and unmanaged disks?**

**A:** No. The VMs in an availability set must use either all managed disks or all unmanaged disks. When you create an availability set, you can choose which type of disks you want to use.

**Q: Is Managed Disks the default option in the Azure portal?**

**A:** Yes. Managed Disks is the default option in the Azure portal.

**Q: Can I create an empty managed disk?**

**A:** Yes. You can create an empty disk. A managed disk can be created independently of a VM, for example, without attaching it to a VM.

**Q: What is the supported fault domain count for an availability set that uses Managed Disks?**

**A:** Depending on the region where the availability set that uses Managed Disks is located, the supported fault domain count is 2 or 3.

**Q: How is the standard storage account for diagnostics set up?**

**A:** You set up a private storage account for VM diagnostics.

**Q: What kind of Azure role-based access control support is available for Managed Disks?**

**A:** Managed Disks supports three key default roles:

- Owner: Can manage everything, including access
- Contributor: Can manage everything except access
- Reader: Can view everything, but can't make changes

**Q: Is there a way that I can copy or export a managed disk to a private storage account?**

**A:** You can generate a read-only shared access signature (SAS) URI for the managed disk and use it to copy the contents to a private storage account or on-premises storage. You can use the SAS URI using the Azure portal, Azure PowerShell, the Azure CLI, or [AzCopy](/azure/storage/common/storage-use-azcopy-v10)

**Q: Can I create a copy of my managed disk?**

**A:** Customers can take a snapshot of their managed disks and then use the snapshot to create another managed disk.

**Q: Are unmanaged disks still supported?**

**A:** Yes, both unmanaged and managed disks are supported. We recommend that you use managed disks for new workloads and migrate your current workloads to managed disks.

**Q: Can I co-locate unmanaged and managed disks on the same VM?**

**A:** No. You can't co-locate unmanaged and managed disks on the same VM.

**Q: If I create a 128-GB disk and then increase the size to 130 gibibytes (GiB), will I be charged for the next disk size (256 GiB)?**

**A:** Yes. You'll be charged for the next disk size (256 GiB).

**Q: Can I create locally redundant storage, geo-redundant storage, and zone-redundant storage managed disks?**

**A:** Azure Managed Disks currently supports only locally redundant storage managed disks.

**Q: Can I shrink or downsize my managed disks?**

**A:** No. This feature isn't supported currently.

**Q: Can I break a lease on my disk?**

**A:** No. This isn't supported currently as a lease is present to prevent accidental deletion when the disk is being used.

**Q: Can I change the computer name property when a specialized (not created by using the System Preparation tool or generalized) operating system disk is used to provision a VM?**

**A:** No. You can't update the computer name property. The new VM inherits it from the parent VM, which was used to create the operating system disk.

**Q: Where can I find sample Azure Resource Manager templates to create VMs with managed disks?

**A:** You can find them here:

- [List of templates using Managed Disks](https://github.com/Azure/azure-quickstart-templates/)
- [MDPP on GitHub](https://github.com/chagarw/MDPP)

**Q: When creating a disk from a blob, is there any continually existing relationship with that source blob?**

**A:** No, when the new disk is created it is a full standalone copy of that blob at that time and there is no connection between the two. If you like, once you've created the disk, the source blob may be deleted without affecting the newly created disk in any way.

**Q: Can I rename a managed or unmanaged disk after it has been created?**

**A:** For managed disks you can't rename them. However, you may rename an unmanaged disk as long as it's not currently attached to a VHD or VM.

**Q: Can I use GPT partitioning on an Azure Disk?**

**A:** Generation 1 images can only use GPT partitioning on data disks, not OS disks. OS disks must use the MBR partition style.

[Generation 2 images](/azure/virtual-machines/generation-2) can use GPT partitioning on the OS disk as well as the data disks.

**Q: What disk types support snapshots?**

**A:** Premium SSD, standard SSD, and standard HDD support snapshots. For these three disk types, snapshots are supported for all disk sizes (including disks up to 32 TiB in size). Ultra disks do not support snapshots.

**Q: What are Azure disk reservations?**

**A:** Disk reservation is the option to purchase one year of disk storage in advance, reducing your total cost. For details regarding Azure disk reservations, see our article on the subject: [Understand how your reservation discount is applied to Azure Disk](/azure/cost-management-billing/reservations/understand-disk-reservations).

**Q: What options does Azure disk reservation offer?**

**A:** Azure disk reservation provides the option to purchase Premium SSDs in the specified SKUs from P30 (1 TiB) up to P80 (32 TiB) for a one-year term. There is no limitation on the minimum amount of disks necessary to purchase a disk reservation. Additionally, you can choose to pay with a single, upfront payment or monthly payments. There is no additional transactional cost applied for Premium SSD Managed Disks.

Reservations are made in the form of disks, not capacity. In other words, when you reserve a P80 (32 TiB) disk, you get a single P80 disk, you can't then divide that specific reservation up into two smaller P70 (16 TiB) disks. You can, of course, reserve as many or as few disks as you like, including two separate P70 (16 TiB) disks.

**Q: How is Azure disk reservation applied?**

**A:** Disks reservation follows a model like reserved virtual machine (VM) instances. The difference being that a disk reservation can't be applied to different SKUs, while a VM instance can. See [Save costs with Azure Reserved VM Instances](/azure/virtual-machines/prepay-reserved-vm-instances) for more information on VM instances.

**Q: Can I use my data storage purchased through Azure disks reservation across multiple regions?**

**A:** Azure disks reservation are purchased for a specific region and SKU (like P30 in East US 2), and therefore can't be used outside these constructs. You can always purchase an additional Azure Disks Reservation for your disk storage needs in other regions or SKUs.

**Q: What happens when my Azure disks reservation expires?**

**A:** You'll receive email notifications 30 days prior to expiration and again on the expiration date. Once the reservation expires, deployed disks will continue to run and will be billed with the latest [pay-as-you-go rates](https://azure.microsoft.com/pricing/details/managed-disks/).

**Q: Do Standard SSD Disks support "single instance VM SLA"?**

**A:** Yes, all disk types support single instance VM SLA.
</details>

## Azure shared disks
<details>
  <summary>Click here to expand this section.</summary>

**Q: Is the shared disks feature supported for unmanaged disks or page blobs?**

**A:** No, it is only supported for ultra disks and premium SSD managed disks.

**Q: What regions support shared disks?**

**A:** For regional information, see our [conceptual article](/azure/virtual-machines/disks-shared).

**Q: Can shared disks be used as an OS disk?**

**A:** No, shared disks are only supported for data disks.

**Q: What disk sizes support shared disks?**

**A:** For supported sizes, see our [conceptual article](/azure/virtual-machines/disks-shared).

**Q: If I have an existing disk, can I enable shared disks on it?**

**A:** All managed disks created with API version 2019-07-01 or higher can enable shared disks. To do this, you need to unmount the disk from all VMs that it is attached to. Next, edit the maxShares property on the disk.

**Q: If I no longer want to use a disk in shared mode, how do I disable it?**

**A:** Unmount the disk from all VMs that it is attached to. Then edit the maxShare property on the disk to 1.

**Q: Can I resize a shared disk?**

**A:** Yes. You can resize a shared disk.

**Q: Can I enable write accelerator on a disk that also has shared disks enabled?**

**A:** No. You can't enable write accelerator on a disk that also has shared disks enabled.

**Q: Can I enable host caching for a disk that has shared disk enabled?**

**A:** The only supported host caching option is None.
</details>

## Ultra disks
<details>
  <summary>Click here to expand this section.</summary>

**Q: What should I set my ultra disk throughput to?**

**A:** If you're unsure what to set your disk throughput to, we recommend you start by assuming an IO size of 16 KiB and adjust the performance from there as you monitor your application. The formula is: Throughput in MBps = # of IOPS * 16 / 1000.

**Q: I configured my disk to 40000 IOPS but I'm only seeing 12800 IOPS, why am I not seeing the performance of the disk?**

**A:** In addition to the disk throttle, there is an IO throttle that gets imposed at the VM level. Ensure that the VM size you're using can support the levels that are configured on your disks. For details regarding IO limits imposed by your VM, see [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

**Q: Can I use caching levels with an ultra disk?**

**A:** No, ultra disks do not support the different caching methods that are supported on other disk types. Set the disk caching to None.

**Q: Can I attach an ultra disk to my existing VM?**

**A:** Maybe, your VM has to be in a region and availability zone pair that supports Ultra disks. See [getting started with ultra disks](/azure/virtual-machines/disks-enable-ultra-ssd) for details.

**Q: Can I use an ultra disk as the OS disk for my VM?**

**A:** No, ultra Disks are only supported as data disks and are only supported as 4K native disks.

**Q: Can I convert an existing disk to an ultra disk?**

**A:** No, but you can migrate the data from an existing disk to an ultra disk. To migrate an existing disk to an ultra Disk, attach both disks to the same VM, and copy the disk's data from one disk to the other or leverage a 3rd party solution for data migration.

**Q: Can I create snapshots for ultra disks?**

**A:** No, snapshots aren't yet available.

**Q: Is Azure Backup available for ultra disks?**

**A:** No, Azure Backup support isn't yet available.

**Q: Can I attach an ultra disk to a VM running in an availability set?**

**A:** No, this isn't yet supported.

**Q: Can I enable Azure Site Recovery for VMs using ultra disks?**

**A:** No, Azure Site Recovery isn't yet supported for ultra disks.
</details>

## Uploading to a managed disk
<details>
  <summary>Click here to expand this section.</summary>

**Q: Can I upload data to an existing managed disk?**

**A:** No, upload can only be used during the creation of a new empty disk with the ReadyToUpload state.

**Q: How do I upload to a managed disk?**

**A:** Create a managed disk with the [createOption](/rest/api/compute/disks/createorupdate#diskcreateoption) property of [creationData](/rest/api/compute/disks/createorupdate#creationdata) set to "Upload", then you can upload data to it.

**Q: Can I attach a disk to a VM while it is in an upload state?**

**A:** No. You can't attach a disk to a VM while it is in an upload state.

**Q: Can I take a snapshot of a manged disk in an upload state?**

**A:** No. You can't take a snapshot of a manged disk in an upload state.
</details>

## Standard SSD disks
<details>
  <summary>Click here to expand this section.</summary>

**Q: What are Azure Standard SSD disks?**

**A:** Standard SSD disks are standard disks backed by solid-state media, optimized as cost effective storage for workloads that need consistent performance at lower IOPS levels.

**Q: What are the regions currently supported for Standard SSD disks?**

**A:** All Azure regions now support Standard SSD disks.

**Q: Is Azure Backup available when using Standard SSDs?**

**A:** Yes, Azure Backup is now available.

**Q: What is the benefit of using Standard SSD disks instead of HDD?**

**A:** Standard SSD disks deliver better latency, consistency, availability, and reliability compared to HDD disks. Application workloads run a lot more smoothly on Standard SSD because of that. Note, Premium SSD disks are the recommended solution for most IO-intensive production workloads.

**Q: Can I use Standard SSDs as Unmanaged Disks?**

**A:** No, Standard SSDs disks are only available as Managed Disks.
</details>

## Migrate to Managed Disks
<details>
  <summary>Click here to expand this section.</summary>

**Q: Is there any impact of migration on the Managed Disks performance?**

**A:** Migration involves movement of the Disk from one Storage location to another. This is orchestrated via background copy of data, which can take several hours to complete, typically less than 24 Hrs depending on the amount of data in the disks. During that time your application can experience higher than usual read latency as some reads can get redirected to the original location, and can take longer to complete. There is no impact on write latency during this period.

**Q: What changes are required in a pre-existing Azure Backup service configuration prior/after migration to Managed Disks?**

**A:** No changes are required.

**Q: Will my VM backups created via Azure Backup service before the migration continue to work?**

**A:** Yes, backups work seamlessly.

**Q: What changes are required in a pre-existing Azure Disks Encryption configuration prior/after migration to Managed Disks?**

**A:** No changes are required.

**Q: Is automated migration of an existing virtual machine scale set from unmanaged disks to Managed Disks supported?**

**A:** No. You can create a new scale set with Managed Disks using the image from your old scale set with unmanaged disks.

**Q: Can I create a Managed Disk from a page blob snapshot taken before migrating to Managed Disks?**

**A:** No. You can export a page blob snapshot as a page blob and then create a Managed Disk from the exported page blob.

**Q: Can I fail over my on-premises machines protected by Azure Site Recovery to a VM with Managed Disks?**

**A:** Yes, you can choose to failover to a VM with Managed Disks.

**Q: Is there any impact of migration on Azure VMs protected by Azure Site Recovery via Azure to Azure replication?**

**A:** No. Azure Site Recovery Azure to Azure protection for VMs with Managed Disks is available.

**Q: Can I migrate VMs with unmanaged disks that are located on storage accounts that are or were previously encrypted to managed disks?**

**A:** Yes. You can migrate VMs with unmanaged disks that are located on storage accounts that are or were previously encrypted to managed disks.
</details>

## Managed Disks and Storage Service Encryption
<details>
  <summary>Click here to expand this section.</summary>

**Q: Is Server-side Encryption enabled by default when I create a managed disk?**

**A:** Yes. Managed Disks are encrypted with server-side encryption with platform managed keys.

**Q: Is the boot volume encrypted by default on a managed disk?**

**A:** Yes. By default, all managed disks are encrypted, including the OS disk.

**Q: Who manages the encryption keys?**

**A:** Platform managed keys are managed by Microsoft. You can also use and manage your own keys stored in Azure Key Vault.

**Q: Can I disable Server-side Encryption for my managed disks?**

**A:** No. You can't disable Server-side Encryption for my managed disks.

**Q: Is Server-side Encryption only available in specific regions?**

**A:** No. Server-side Encryption with both platform and customer managed keys are available in all the regions where Managed Disks are available.

**Q: Does Azure Site Recovery support server-side encryption with customer-managed key for on-premises to Azure and Azure to Azure disaster recovery scenarios?**

**A:** Yes. Azure Site Recovery supports server-side encryption with customer-managed key for on-premises to Azure and Azure to Azure disaster recovery scenarios.

**Q: Can I backup Managed Disks encrypted with server-side encryption with customer-managed key using Azure Backup service?**

**A:** Yes. You can backup Managed Disks encrypted with server-side encryption with customer-managed key using Azure Backup service.

**Q: Are managed snapshots and images encrypted?**

**A:** Yes. All managed snapshots and images are automatically encrypted.

**Q: Can I convert VMs with unmanaged disks that are located on storage accounts that are or were previously encrypted to managed disks?**

**A:** Yes, you can convert VMs with unmanaged disks that are located on storage accounts that are or were previously encrypted to managed disks.

**Q: Will an exported VHD from a managed disk or a snapshot also be encrypted?**

**A:** No. But if you export a VHD to an encrypted storage account from an encrypted managed disk or snapshot, then it's encrypted.
</details>

## Premium disks: Managed and unmanaged
<details>
  <summary>Click here to expand this section.</summary>

**Q: If a VM uses a size series that supports Premium SSD disks, such as a DSv2, can I attach both premium and standard data disks?**

**A:** Yes.

**Q: Can I attach both premium and standard data disks to a size series that doesn't support Premium SSD disks, such as D, Dv2, G, or F series?**

**A:** No. You can attach only standard data disks to VMs that don't use a size series that supports Premium SSD disks.

**Q: If I create a premium data disk from an existing VHD that was 80 GB, how much will that cost?**

**A:** A premium data disk created from an 80-GB VHD is treated as the next-available premium disk size, which is a P10 disk. You're charged according to the P10 disk pricing.

**Q: Are there transaction costs to use Premium SSD disks?**

**A:** There is a fixed cost for each disk size, which comes provisioned with specific limits on IOPS and throughput. The other costs are outbound bandwidth and snapshot capacity, if applicable.

For more information, see the [pricing page](https://azure.microsoft.com/pricing/details/storage).

**Q: What are the limits for IOPS and throughput that I can get from the disk cache?**

**A:** The combined limits for cache and local SSD for a DS series are 4,000 IOPS per core and 33 MiB per second per core. The GS series offers 5,000 IOPS per core and 50 MiB per second per core.

**Q: Is the local SSD supported for a Managed Disks VM?**

**A:** The local SSD is temporary storage that is included with a Managed Disks VM. There is no extra cost for this temporary storage. We recommend that you do not use this local SSD to store your application data because it isn't persisted in Azure Blob storage.

**Q: Are there any repercussions for the use of TRIM on premium disks?**

**A:** There is no downside to the use of TRIM on Azure disks on either premium or standard disks.
</details>

## New disk sizes: Managed and unmanaged
<details>
  <summary>Click here to expand this section.</summary>

**Q: What regions support bursting capability for applicable premium SSD disk size?**

**A:** Credit-based bursting is currently supported in all regions in Azure Public Cloud, sovereign clouds aren't currently supported.

On-demand bursting is only available in West Central US.

**Q: Are P1/P2/P3 disk sizes supported for unmanaged disks or page blobs?**

**A:** No, it is only supported on premium SSD managed disks.

**Q: Are E1/E2/E3 disk sizes supported for unmanaged disks or page blobs?**

**A:** No, standard SSD managed disks of any size can't be used with unmanaged disks or page blobs.

**Q: What is the largest Managed disk size supported for operating system and data disks on Gen1 VMs?**

**A:** The partition type that Azure supports for Gen1 operating system disks is the master boot record (MBR). Although Gen1 OS disks only support MBR the data disks support GPT. While you can allocate up to a 4 TiB OS disk, the MBR partition type can only use up to 2 TiB of this disk space for the operating system. Azure supports up to 32 TiB for managed data disks.

**Q: What is the largest Managed disk size supported for operating system and data disks on Gen2 VMs?**

**A:** The partition type that Azure supports for Gen2 operating system disks is GUID Partition Table (GPT). Gen2 VMs support up to a 4 TiB OS disk. Azure supports up to 32 TiB for managed data disks.

**Q: What is the largest Unmanaged Disk size supported for operating system and data disks?**

**A:** The partition type that Azure supports for an operating system disk using unmanaged disks is the master boot record (MBR). While you can allocate up to a 4 TiB OS disk, the MBR partition type can only use up to 2 TiB of this disk space for the operating system. Azure supports up to 4 TiB for Unmanaged data disks.

**Q: What is the largest page blob size that's supported?**

**A:** The largest page blob size that Azure supports is 8 TiB (8,191 GiB). The maximum page blob size when attached to a VM as data or operating system disks is 4 TiB (4,095 GiB).

**Q: Do I need to use a new version of Azure tools to create, attach, resize, and upload disks larger than 1 TiB?**

**A:** You don't need to upgrade your existing Azure tools to create, attach, or resize disks larger than 1 TiB. To upload your VHD file from on-premises directly to Azure as a page blob or unmanaged disk, you need to use the latest tool sets listed below. We only support VHD uploads of up to 8 TiB.

|Azure tools|Supported versions|
|--|--|
|Azure PowerShell|Version number 4.1.0: June 2017 release or later|
|Azure CLI v1|Version number 0.10.13: May 2017 release or later|
|Azure CLI v2|Version number 2.0.12: July 2017 release or later|
|AzCopy|Version number 6.1.0: June 2017 release or later|

**Q: Are P4 and P6 disk sizes supported for unmanaged disks or page blobs?**

**A:** P4 (32 GiB) and P6 (64 GiB) disk sizes aren't supported as the default disk tiers for unmanaged disks and page blobs. You need to explicitly [set the Blob Tier](/rest/api/storageservices/set-blob-tier) to P4 and P6 to have your disk mapped to these tiers. If you deploy a unmanaged disk or page blob with the disk size or content length less than 32 GiB or between 32 GiB to 64 GiB without setting the Blob Tier, you'll continue to land on P10 with 500 IOPS and 100 MiB/s and the mapped pricing tier.

**Q: If my existing premium managed disk less than 64 GiB was created before the small disk was enabled (around June 15, 2017), how is it billed?**

**A:** Existing small premium disks less than 64 GiB continue to be billed according to the P10 pricing tier.

**Q: How can I switch the disk tier of small premium disks less than 64 GiB from P10 to P4 or P6?**

**A:** You can take a snapshot of your small disks and then create a disk to automatically switch the pricing tier to P4 or P6 based on the provisioned size.

**Q: Can I resize existing Managed Disks from sizes fewer than 4 tebibytes (TiB) to new newly introduced disk sizes up to 32 TiB?**

**A:** Yes, you can resize existing Managed Disks from sizes fewer than 4 tebibytes (TiB) to new newly introduced disk sizes up to 32 TiB.

**Q: What are the largest disk sizes supported by Azure Backup and Azure Site Recovery service?**

**A:** The largest disk size supported by Azure Backup is 32 TiB (4 TiB for encrypted disks). The largest disk size supported by Azure Site Recovery is 8 TiB. Support for the larger disks up to 32 TiB isn't yet available in Azure Site Recovery.

**Q: What are the recommended VM sizes for larger disk sizes (>4 TiB) for Standard SSD and Standard HDD disks to achieve optimized disk IOPS and Bandwidth?**

**A:** To achieve the disk throughput of Standard SSD and Standard HDD large disk sizes (>4 TiB) beyond 500 IOPS and 60 MiB/s, we recommend you deploy a new VM from one of the following VM sizes to optimize your performance: B-series, DSv2-series, Dsv3-Series, ESv3-Series, Fs-series, Fsv2-series, M-series, GS-series, NCv2-series, NCv3-series, or Ls-series VMs. Attaching large disks to existing VMs or VMs that aren't using the recommended sizes above may experience lower performance.

**Q: How can I upgrade my disks (>4 TiB) which were deployed during the larger disk sizes preview in order to get the higher IOPS & bandwidth at GA?**

**A:** You can either stop and start the VM that the disk is attached to or, detach and re-attach your disk. The performance targets of larger disk sizes have been increased for both premium SSDs and standard SSDs at GA.

**Q: What regions are the managed disk sizes of 8 TiB, 16 TiB, and 32 TiB supported in?**

**A:** The 8 TiB, 16 TiB, and 32 TiB disk SKUs are supported in all regions under global Azure, Microsoft Azure Government, and Azure China 21Vianet.

**Q: Do we support enabling Host Caching on all disk sizes?**

**A:** Host Caching (ReadOnly and Read/Write) is supported on disk sizes less than 4 TiB. This means any disk that is provisioned up to 4095 GiB can take advantage of Host Caching. Host caching isn't supported for disk sizes more than or equal to 4096 GiB. For example, a P50 premium disk provisioned at 4095 GiB can take advantage of Host caching and a P50 disk provisioned at 4096 GiB can't take advantage of Host Caching. We recommend leveraging caching for smaller disk sizes where you can expect to observe better performance boost with data cached to the VM.
</details>

## Private Links for securely exporting and importing Managed Disks
<details>
  <summary>Click here to expand this section.</summary>

**Q: What is the benefit of using Private Links for exporting and importing Managed Disks?**

**A:** You can leverage Private Links for restricting the export and import to Managed Disks only from your Azure virtual network.

**Q: What can I ensure that a disk can be exported or imported only via Private Links?**

**A:** You must set the DiskAccessId property to an instance of a disk access object and also set the NetworkAccessPolicy property to AllowPrivate.

**Q: Can I link multiple virtual networks to the same disk access object?**

**A:** No. Currently, you can link a disk access object to only one virtual network.

**Q: Can I link a virtual network to a disk access object in another subscription?**

**A:** No. Currently, you can link a disk access object to a virtual network in the same subscription.

**Q: Can I link a virtual network to a disk access object in another subscription?**

**A:** No. Currently, you can link a disk access object to a virtual network in the same subscription.

**Q: How many exports or imports using the same disk access object can happen at the same time?**

**A:** You can have five exports or imports.

**Q: Can I use a SAS URI of a disk/snapshot to download the underlying VHD of a VM in the same subnet as the subnet of the private endpoint associated with the disk?**

**A:** Yes. You can use a SAS URI of a disk/snapshot, to download the underlying VHD of a VM in the same subnet as the subnet of the private endpoint, associated with the disk.

**Q: Can I use a SAS URI of a disk/snapshot to download the underlying VHD of a VM not in the same subnet as the subnet of the private endpoint not associated with the disk?**

**A:** No. You can't use a SAS URI of a disk/snapshot, to download the underlying VHD of a VM not in the same subnet as the subnet of the private endpoint, not associated with the disk
</details>

## What if my question isn't answered here?

If your question isn't listed here, post a question at the end of this article in the comments. To engage with the Azure Storage team and other community members about this article, use the [Microsoft Q&A question page for Azure Storage](/answers/products/azure).

To request features, submit your requests and ideas to the [Azure Storage feedback forum](https://feedback.azure.com/forums/217298-storage).

## Recommended content

- [Share an Azure managed disk across VMs](/azure/virtual-machines/disks-shared)
- [Convert a Windows virtual machine from unmanaged disks to managed disks](/azure/virtual-machines/windows/convert-unmanaged-to-managed-disks)
- [Change the performance of Azure managed disks using the Azure portal](/azure/virtual-machines/disks-performance-tiers-portal)
- [Convert managed disks storage between different disk types using Azure CLI](/azure/virtual-machines/linux/convert-disk-storage)
- [Enable shared disks for Azure managed disks](/azure/virtual-machines/disks-shared-enable)
- [Use Azure Storage Explorer to manage Azure managed disks](/azure/virtual-machines/disks-use-storage-explorer-managed-disks)
- [Attach a managed data disk to a Windows VM](/azure/virtual-machines/windows/attach-managed-disk-portal)
- [Resize a virtual machine using the Azure portal or PowerShell](/azure/virtual-machines/windows/resize-vm)







