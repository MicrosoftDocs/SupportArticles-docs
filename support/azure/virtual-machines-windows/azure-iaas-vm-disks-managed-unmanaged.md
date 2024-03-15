---
title: FAQs for Azure Disks
description: This article answers some frequently asked questions about Azure Managed Disks and Azure Premium SSD disks.
ms.date: 08/24/2021
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-support-statements
ms.collection: windows
---

# FAQs for Azure Disks

This article answers frequently asked questions about Azure Managed Disks and Azure Premium SSD disks.

## Azure Managed Disks

<details>
  <summary>Click here to expand this section.</summary>

**Q: What is Azure Managed Disks?**

**A:** Managed Disks is a feature that simplifies disk management for Azure IaaS virtual machines (VMs) by handling storage account management for you.

For more information, see the [Managed Disks overview](/azure/virtual-machines/managed-disks-overview).

**Q: If I create a Standard managed disk from an existing VHD that's 80 GiB large, how much will that cost me?**

**A:** A Standard managed disk that's created from an 80 GiB VHD is treated as the next available standard disk size: an S10 disk. Therefore, you'll be charged according to the S10 disk pricing.

For more information, see the [pricing page](https://azure.microsoft.com/pricing/details/storage).

**Q: Are there any transaction costs for Standard managed disks?**

**A:** Yes. You're charged for each transaction.

For more information, see the [pricing page](https://azure.microsoft.com/pricing/details/storage).

**Q: For a Standard managed disk, will I be charged for the actual size of the data on the disk or for the provisioned capacity of the disk?**

**A:** You're charged based on the provisioned capacity of the disk.

For more information, see the [pricing page](https://azure.microsoft.com/pricing/details/storage).

**Q: How does pricing differ for Premium managed disks and Premium unmanaged disks?**

**A:** The pricing of Premium managed disks is the same as for Premium unmanaged disks.

**Q: Can I change the storage account type (Standard or Premium) of my managed disks?**

**A:** Yes. You can change the storage account type of your managed disks by using the Azure portal, PowerShell, or the Azure CLI.

**Q: Can I use a VHD file in an Azure storage account to create a managed disk that has a different subscription?**

**A:** Yes.

**Q: Can I use a VHD file in an Azure storage account to create a managed disk in a different region?**

**A:** No.

**Q: Are there any scale limitations for customers who use managed disks?**

**A:** Managed Disks eliminates the limits that are associated with storage accounts. However, the maximum limit is 50,000 managed disks per region and per disk type for a subscription.

**Q: Can VMs in an availability set contain both managed and unmanaged disks?**

**A:** No. The VMs in an availability set must use either all managed disks or all unmanaged disks. When you create an availability set, you can choose which type of disks you want to use.

**Q: Is Managed Disks the default option in the Azure portal?**

**A:** Yes. Managed Disks is the default option in the Azure portal.

**Q: Can I create an empty managed disk?**

**A:** Yes. A managed disk can be created independently of a VM and not be attached to it.

**Q: What is the supported fault domain count for an availability set that uses Managed Disks?**

**A:** Depending on the region of the availability set that uses Managed Disks, the supported fault domain count is 2 or 3.

**Q: How is the standard storage account for diagnostics set up?**

**A:** You set up a private storage account for VM diagnostics.

**Q: What kind of Azure role-based access control support is available for Managed Disks?**

**A:** Managed Disks supports three key default roles:

- Owner: Can manage everything, including access
- Contributor: Can manage everything except access
- Reader: Can view everything, but can't make changes

**Q: Is there a way that I can copy or export a managed disk to a private storage account?**

**A:** You can generate a read-only shared-access signature (SAS) URI for the managed disk, and use it to copy the contents to a private storage account or on-premises storage. You can use the SAS URI by using the Azure portal, Azure PowerShell, the Azure CLI, or [AzCopy](/azure/storage/common/storage-use-azcopy-v10)

**Q: Can I create a copy of my managed disk?**

**A:** Customers can take a snapshot of their managed disks, and then use the snapshot to create another managed disk.

**Q: Are unmanaged disks still supported?**

**A:** Yes. Both unmanaged and managed disks are supported. We recommend that you use managed disks for new workloads, and migrate your current workloads to managed disks.

**Q: Can I co-locate unmanaged and managed disks on the same VM?**

**A:** No. You can't co-locate unmanaged and managed disks on the same VM.

**Q: If I create a 128 GiB disk, and then increase the size to 130 gibibytes (GiB), will I be charged for the next standard disk size (256 GiB)?**

**A:** Yes. You'll be charged for the next standard disk size (256 GiB, in this example).

**Q: Can I create locally redundant storage, geo-redundant storage, and zone-redundant storage managed disks?**

**A:** Azure Managed Disks currently supports locally redundant storage and Zone Redundant storage which is currently in preview.

For more information on Managed Disk Redundancy, see [Redundancy options for managed disks](/azure/virtual-machines/disks-redundancy)

**Q: Can I shrink or downsize my managed disks?**

**A:** No. This feature isn't currently supported.

**Q: Can I break a lease on my disk?**

**A:** No. This isn't currently supported because a lease exists to prevent accidental deletion when the disk is being used.

**Q: Can I change the computer name property when a specialized operating system disk (one that is generalized or is not created by using the System Preparation tool) is used to provision a VM?**

**A:** No. You can't update the computer name property. The new VM inherits the property from the parent VM that was used to create the operating system disk.

**Q: Where can I find sample Azure Resource Manager templates to create VMs that have managed disks?

**A:** You can find them here:

- [List of templates using Managed Disks](https://github.com/Azure/azure-quickstart-templates/)
- [MDPP on GitHub](https://github.com/chagarw/MDPP)

**Q: When I create a disk from a blob, is there any continually existing relationship with that source blob?**

**A:** No. When the new disk is created, it's a full, standalone copy of that blob at that time. There is no connection between the two. If you want, you can delete the source blob after you create the disk without affecting the newly created disk in any way.

**Q: Can I rename a managed or unmanaged disk after it's created?**

**A:** You can't rename managed disks. However, you can rename an unmanaged disk if it's not currently attached to a VHD or VM.

**Q: Can I use GPT partitioning on an Azure disk?**

**A:** Generation 1 images can use GPT partitioning only on data disks, not OS disks. OS disks must use the MBR partition style.

[Generation 2 images](/azure/virtual-machines/generation-2) can use GPT partitioning on the OS disk in addition to the data disks.

**Q: Which disk types support snapshots?**

**A:** Premium SSD, Standard SSD, and Standard HDD support snapshots. For these three disk types, snapshots are supported for all disk sizes (including disks up to 32 TiB). Ultra disks do not support snapshots.

**Q: What are Azure disk reservations?**

**A:** A disk reservation is the option to purchase one year of disk storage in advance, reducing your total cost. For more information about Azure disk reservations, see [Understand how your reservation discount is applied to Azure disk storage](/azure/cost-management-billing/reservations/understand-disk-reservations).

**Q: What options does Azure disk reservation offer?**

**A:** Azure disk reservation provides the option to purchase Premium SSDs in the specified SKUs from P30 (1 TiB) up to P80 (32 TiB) for a one-year term. There's no limitation on the minimum amount of disks that are necessary to purchase a disk reservation. Additionally, you can choose to pay with a single, upfront payment or monthly payments. There is no additional transactional cost applied for Premium SSD Managed Disks.

Reservations are made in the amount of disks, not capacity. In other words, when you reserve a P80 (32 TiB) disk, you get a single P80 disk. You're not allowed to then divide that specific reservation up into two smaller P70 (16 TiB) disks. You can, of course, reserve as many or as few disks as you want, including two separate P70 (16 TiB) disks.

**Q: How is Azure disk reservation applied?**

**A:** Disks reservation follows a model similar to reserved virtual machine (VM) instances. They differ in that a disk reservation can't be applied to different SKUs, but a VM instance can. See [Save costs with Azure Reserved VM instances](/azure/virtual-machines/prepay-reserved-vm-instances) for more information on VM instances.

**Q: Can I use the data storage that I purchased through Azure disks reservation across multiple regions?**

**A:** Azure disks reservation are purchased for a specific region and SKU (such as P30 in East US 2), and therefore can't be used outside these constructs. You can always purchase an additional Azure Disks Reservation for your disk storage needs in other regions or SKUs.

**Q: What happens when my Azure disks reservation expires?**

**A:** You'll receive email notifications 30 days prior to expiration and again on the expiration date. After the reservation expires, deployed disks will continue to run. They will be billed with the latest [pay-as-you-go rates](https://azure.microsoft.com/pricing/details/managed-disks/).

**Q: Do Standard SSD Disks support "single instance VM SLA"?**

**A:** Yes. All disk types support "single instance VM SLA."
</details>

## Ultra disks

<details>
  <summary>Click here to expand this section.</summary>

**Q: What should I set my ultra disk throughput to?**

**A:** If you're unsure about what to set your disk throughput to, we recommend that you start by assuming an IO size of 16 KB, and then adjust the performance from there as you monitor your application. The formula is as follows:

> Throughput in MBps = # of IOPS * 16 / 1000

**Q: I configured my disk to 40,000 IOPS, but I'm only seeing 12,800 IOPS. Why am I not seeing the full performance of the disk?**

**A:** In addition to the disk throttle, there is an IO throttle that gets imposed at the VM level. Make sure that the VM size that you're using can support the levels that are configured on your disks. For details regarding IO limits that are imposed by your VM, see [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

**Q: Can I use caching levels with an ultra disk?**

**A:** No. Ultra disks do not support the different caching methods that are supported on other disk types. Set disk caching to **None**.

**Q: Can I attach an ultra disk to my existing VM?**

**A:** Maybe. Your VM has to be in a region and availability zone pair that supports Ultra disks. For more information, see [getting started with ultra disks](/azure/virtual-machines/disks-enable-ultra-ssd).

**Q: Can I use an ultra disk as the OS disk for my VM?**

**A:** No. Ultra Disks are supported only as data disks and 4K native disks.

**Q: Can I convert an existing disk to an ultra disk?**

**A:** No. However, you can migrate the data from an existing disk to an ultra disk. To migrate an existing disk to an ultra Disk, attach both disks to the same VM, and copy the disk data from one disk to the other, or use a third-party solution for data migration.

**Q: Can I create snapshots for ultra disks?**

**A:** No. Snapshots aren't yet available.

**Q: Is Azure Backup available for ultra disks?**

**A:** No. Azure Backup support isn't yet available.

**Q: Can I attach an ultra disk to a VM that's running in an availability set?**

**A:** No. This procedure isn't yet supported.

**Q: Can I enable Azure Site Recovery for VMs using ultra disks?**

**A:** No, Azure Site Recovery isn't yet supported for ultra disks.
</details>

## Uploading to a managed disk

<details>
  <summary>Click here to expand this section.</summary>

**Q: Can I upload data to an existing managed disk?**

**A:** No. Upload can be used only during the creation of a new empty disk in the **ReadyToUpload** state.

**Q: How do I upload to a managed disk?**

**A:** Create a managed disk by using the [createOption](/rest/api/compute/disks/createorupdate#diskcreateoption) property of [creationData](/rest/api/compute/disks/createorupdate#creationdata) set to "Upload." Then, you can upload data to it.

**Q: Can I attach a disk to a VM while it is in an upload state?**

**A:** No.

**Q: Can I take a snapshot of a managed disk that's in an upload state?**

**A:** No.
</details>

## Standard SSD disks

<details>
  <summary>Click here to expand this section.</summary>

**Q: What are Azure Standard SSD disks?**

**A:** Standard SSD disks are standard disks backed by solid-state media, optimized as cost effective storage for workloads that need consistent performance at lower IOPS levels.

**Q: What are the regions currently supported for Standard SSD disks?**

**A:** All Azure regions now support Standard SSD disks.

**Q: Is Azure Backup available when using Standard SSDs?**

**A:** Yes. Azure Backup is now available.

**Q: What is the benefit of using Standard SSD disks instead of HDD?**

**A:** Standard SSD disks deliver better latency, consistency, availability, and reliability compared to HDD disks. Therefore, application workloads run much more smoothly on Standard SSD. Premium SSD disks are the recommended solution for most IO-intensive production workloads.

**Q: Can I use Standard SSDs as unmanaged disks?**

**A:** No. Standard SSDs disks are available only as managed disks.
</details>

## Migrate to Azure Managed Disks

<details>
  <summary>Click here to expand this section.</summary>

**Q: Is there any effect of migration on managed disk performance?**

**A:** Migration involves transfer of the disk from one storage location to another. This is orchestrated through background copy of data. This can take several hours to complete — typically, less than 24 hours, depending on the amount of data on the disks. During that time, your application can experience higher-than-usual read latency because some reads can get redirected to the original location and, therefore, take longer to complete. There is no effect on write latency during this period.

**Q: What changes are required in a pre-existing Azure Backup service configuration prior to or after migration to Managed Disks?**

**A:** No changes are required.

**Q: Will my VM backups that were created through Azure Backup service before the migration continue to work?**

**A:** Yes. Backups work seamlessly.

**Q: What changes are required in a pre-existing Azure Disks Encryption configuration prior to or after migration to Managed Disks?**

**A:** No changes are required.

**Q: Is automated migration supported for an existing virtual machine scale set from unmanaged disks to Managed Disks?**

**A:** No. You can create a new scale set for Managed Disks by using the image from your old scale set for unmanaged disks.

**Q: Can I create a managed disk from a page blob snapshot that was taken before a migration to Managed Disks?**

**A:** No. Instead, you can export a page blob snapshot as a page blob, and then create a managed disk from the exported page blob.

**Q: Can I fail over my on-premises computers that are protected by Azure Site Recovery to a VM that has managed disks?**

**A:** Yes. You can choose to fail over to a VM by that has Managed Disks.

**Q: Is there any effect of migration on Azure VMs that are protected by Azure Site Recovery through Azure-to-Azure replication?**

**A:** No. Instead, Azure Site Recovery Azure-to-Azure protection for VMs that have Managed Disks is available.

**Q: Can I migrate VMs that have unmanaged disks that are located on storage accounts that are or were previously encrypted to managed disks?**

**A:** Yes.
</details>

## Manage disk sizes

<details>
  <summary>Click here to expand this section.</summary>

**Q: If a VM uses a size series that supports Premium SSD disks, such as a DSv2, can I attach both Premium and Standard data disks?**

**A:** Yes.

**Q: Can I attach both Premium and Standard data disks to a size series that doesn't support Premium SSD disks, such as D, Dv2, G, or F series?**

**A:** No. You can attach only Standard data disks to VMs that don't use a size series that supports Premium SSD disks.

**Q: If I create a Premium data disk from an existing VHD that was 80 GiB, how much would that cost?**

**A:** A Premium data disk created from an 80 GiB VHD is treated as the next-available Premium disk size. That would be a P10 disk, in this example. You would, then, be charged according to the P10 disk pricing.

**Q: Are there transaction costs to use Premium SSD disks?**

**A:** There is a fixed cost for each disk size. This cost is provisioned with specific limits on IOPS and throughput. The other costs are outbound bandwidth and snapshot capacity, as applicable.

For more information, see [the pricing page](https://azure.microsoft.com/pricing/details/storage).

**Q: What are the limits for IOPS and throughput that I can get from the disk cache?**

**A:** The combined limits for cache and local SSD for a DS series are 4,000 IOPS per core and 33 mebibyte (MiB) per second per core. The GS series offers 5,000 IOPS per core and 50 MiB per second per core.

**Q: Is the local SSD supported for a Managed Disks VM?**

**A:** The local SSD is temporary storage that's included with a Managed Disks VM. There is no extra cost for this temporary storage. We recommend that you do not use this local SSD to store your application data because the local SSD isn't persisted in Azure Blob storage.

**Q: Are there any repercussions for the use of TRIM on Premium disks?**

**A:** There is no downside to using TRIM on Azure disks on either Premium or Standard disks.
</details>

## New disk sizes

<details>
  <summary>Click here to expand this section.</summary>

**Q: Which regions support bursting capability for applicable Premium SSD disk size?**

**A:** Credit-based bursting is currently supported in all regions in Azure Public Cloud. Sovereign clouds aren't currently supported.

On-demand bursting is available only in the west-central United States region.

**Q: Are P1, P2, and P3 disk sizes supported for unmanaged disks or page blobs?**

**A:** No. They are supported only on Premium SSD managed disks.

**Q: Are E1, E2, and E3 disk sizes supported for unmanaged disks or page blobs?**

**A:** No. Standard SSD managed disks of any size can't be used together with unmanaged disks or page blobs.

**Q: What is the largest managed disk size that's supported for operating system and data disks on Gen1 VMs?**

**A:** The partition type that Azure supports for Gen1 operating system disks is the master boot record (MBR). Although Gen1 OS disks support only MBR, the data disks support GPT. Although you can allocate up to a 4 tebibytes (TiB) OS disk, the MBR partition type can use only up to 2 TiB of this disk space for the operating system. Azure supports up to 32 TiB for managed data disks.

**Q: What is the largest Managed disk size that's supported for operating system and data disks on Gen2 VMs?**

**A:** The partition type that Azure supports for Gen2 operating system disks is GUID Partition Table (GPT). Gen2 VMs support up to a 4 TiB OS disk. Azure supports up to 32 TiB for managed data disks.

**Q: If my existing Premium managed disk that's smaller than 64 GiB was created before the small Premium disk was enabled (around June 15, 2017), how is it billed?**

**A:** Existing small Premium disks that are less than 64 GiB continue to be billed according to the P10 pricing tier.

**Q: How can I switch the disk tier of small Premium disks that are less than 64 GiB from P10 to P4 or P6?**

**A:** You can take a snapshot of your small disks, and then create a disk to automatically switch the pricing tier to P4 or P6 based on the provisioned size.

**Q: Can I resize existing Managed Disks from sizes less than 4 TiB to new newly introduced disk sizes up to 32 TiB?**

**A:** Yes.

**Q: What are the largest disk sizes that are supported by Azure Backup and the Azure Site Recovery service?**

**A:** The largest disk size that's supported by Azure Backup is 32 TiB (4 TiB for encrypted disks). The largest disk size that's supported by Azure Site Recovery is 8 TiB. Support for the larger disks up to 32 TiB isn't yet available in Azure Site Recovery.

**Q: What are the recommended VM sizes for larger disk sizes (greater than 4 TiB) for Standard SSD and Standard HDD disks to achieve optimized disk IOPS and Bandwidth?**

**A:** To achieve the disk throughput of Standard SSD and Standard HDD large disk sizes (greater than 4 TiB) beyond 500 IOPS and 60 MiB/s, we recommend that you deploy a new VM from one of the following VM sizes to optimize your performance: B-series, DSv2-series, Dsv3-Series, ESv3-Series, Fs-series, Fsv2-series, M-series, GS-series, NCv2-series, NCv3-series, or Ls-series VMs. Be aware that attaching large disks to existing VMs or VMs that aren't using the recommended sizes can adversely affect performance.

**Q: How can I upgrade my large disks (greater than 4 TiB) that were deployed during the larger disk sizes preview in order to get the higher IOPS and bandwidth at GA?**

**A:** You can either stop and restart the VM that the disk is attached to or detach and re-attach the disk. The performance targets of larger disk sizes were increased for both Premium SSDs and Standard SSDs at GA.

**Q: Which regions are the managed disk sizes of 8 TiB, 16 TiB, and 32 TiB supported in?**

**A:** The 8 TiB, 16 TiB, and 32 TiB disk SKUs are supported in all regions that operate under global Azure, Microsoft Azure Government, and Azure China 21Vianet.

**Q: Do we support enabling Host Caching on all disk sizes?**

**A:** Host Caching (ReadOnly and Read/Write) is supported on disk sizes of less than 4 TiB. This means that any disk that is provisioned up to 4,095 GiB can take advantage of Host caching. Host caching isn't supported for disk sizes that are greater than or equal to 4,096 GiB. For example, a P50 Premium disk that's provisioned at 4,095 GiB can take advantage of host caching, and a P50 disk that's provisioned at 4,096 GiB can't take advantage of host caching. We recommend that you use caching for smaller disk sizes for which you can expect to see a better performance boost because data cached to the VM.
</details>

## Unmanaged disks

<details>
  <summary>Click here to expand this section.</summary>

**Q: What is the largest unmanaged disk size that's supported for operating system and data disks?**

**A:** The partition type that Azure supports for an operating system disk that uses unmanaged disks is the master boot record (MBR). Although you can allocate up to a 4 TiB OS disk, the MBR partition type can use only up to 2 TiB of this disk space for the operating system. Azure supports up to 4 TiB for unmanaged data disks.

**Q: What is the largest page blob size that's supported?**

**A:** The largest page blob size that Azure supports is 8 TiB (8,191 GiB). The maximum page blob size while it's attached to a VM as data or operating system disks is 4 TiB (4,095 GiB).

**Q: Do I have to use a new version of Azure tools to create, attach, resize, or upload disks that are greater than 1 TiB?**

**A:** You don't have to upgrade your existing Azure tools to create, attach, or resize disks greater than 1 TiB. To upload your VHD file from on-premises directly to Azure as a page blob or unmanaged disk, you have to use the following latest tool sets. We support VHD uploads of up to 8 TiB only.

|Azure tools|Supported versions|
|--|--|
|Azure PowerShell|Version number 4.1.0: June 2017 release or later|
|Azure CLI v1|Version number 0.10.13: May 2017 release or later|
|Azure CLI v2|Version number 2.0.12: July 2017 release or later|
|AzCopy|Version number 6.1.0: June 2017 release or later|

**Q: Are P4 and P6 disk sizes supported for unmanaged disks or page blobs?**

**A:** P4 (32 GiB) and P6 (64 GiB) disk sizes aren't supported as the default disk tiers for unmanaged disks and page blobs. You have to explicitly [set the Blob Tier](/rest/api/storageservices/set-blob-tier) to P4 or P6 to have your disk mapped to these tiers. If you deploy an unmanaged disk or page blob that has a disk size or content length less of than 32 GiB, or between 32 and 64 GiB without setting the blob tier, you'll continue to land on P10 with 500 IOPS and 100 MiB/s and the mapped pricing tier.
</details>

## What if my question isn't answered here?

If your question isn't listed here, post a question at the end of this article in the comments. To engage with the Azure Storage team and other community members about this article, use the [Microsoft Q&A question page for Azure Storage](/answers/products/azure).

To request features, submit your requests and ideas to the [Azure Storage feedback forum](https://feedback.azure.com/forums/217298-storage).

## Recommended content

- [Share an Azure managed disk across VMs](/azure/virtual-machines/disks-shared)
- [Convert a Windows virtual machine from unmanaged disks to managed disks](/azure/virtual-machines/windows/convert-unmanaged-to-managed-disks)
- [Change your performance tier using the Azure portal](/azure/virtual-machines/disks-performance-tiers-portal)
- [Change the disk type of an Azure managed disk](/azure/virtual-machines/disks-convert-types)
- [Enable shared disks for Azure managed disks](/azure/virtual-machines/disks-shared-enable)
- [Use Azure Storage Explorer to manage Azure managed disks](/azure/virtual-machines/disks-use-storage-explorer-managed-disks)
- [Attach a managed data disk to a Windows VM](/azure/virtual-machines/windows/attach-managed-disk-portal)
- [Resize a virtual machine using the Azure portal or PowerShell](/azure/virtual-machines/windows/resize-vm)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
