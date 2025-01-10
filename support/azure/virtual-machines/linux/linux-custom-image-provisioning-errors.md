---
title: Custom Linux image provisioning errors
description: Provides solutions to provisioning errors when you upload or capture a generalized virtual machine image as a specialized Linux VM image or vice versa.
ms.custom: sap:Cannot create a VM, linux-related-content
ms.service: azure-virtual-machines
ms.date: 11/27/2024
ms.reviewer: srijangupta, scotro, maries, jarrettr
---
# Provisioning errors when deploying custom Linux images

**Applies to:** :heavy_check_mark: Linux VMs

When you upload or capture a generalized virtual machine (VM) image as a specialized VM image or vice versa, provisioning errors occur. The former will cause a [provisioning timeout error](#provisioning-timeout-error-during-an-upload-process), and the latter will cause a provisioning failure. To deploy your custom image without errors, you must ensure that the type of the image doesn't change during the upload or capture process.

This article covers the possible combinations of generalized and specialized images, the error types you'll encounter, and how to fix the errors.

## Upload and capture combinations of generalized and specialized images

The following table lists the possible upload and capture combinations of Linux generalized and specialized operating system (OS) images. Y indicates the combinations that will process without errors, and N indicates those that will throw errors. For more information about the errors, see the following sections.

| OS | Upload spec. | Upload gen. | Capture spec. | Capture gen. |
| --- | --- | --- | --- | --- |
| Linux gen. |N<sup>1</sup> |Y |N<sup>3</sup> |Y |
| Linux spec. |Y |N<sup>2</sup> |Y |N<sup>4</sup> |

**Y:** If the OS is a generalized Linux image uploaded or captured using the generalized setting, the upload and deployment will succeed. If the OS is a specialized Linux image and you upload or capture it using the specialized setting, the upload and deployment will succeed.

## Upload errors

**N<sup>1</sup>:** If the OS is a generalized Linux image uploaded as a specialized image, the new VM will fail to progress past the provisioning stage with a [provisioning timeout error](#provisioning-timeout-error-during-an-upload-process).

**N<sup>2</sup>:** If the OS is Linux-specialized and uploaded as a generalized image, the new VM will run with the original computer name, username, and password, which causes a provisioning failure error.

### Resolution for upload errors

To resolve these errors, upload the original VHD from your on-premises environment using the same setting as the OS (generalized or specialized). If you upload it as generalized, make sure to run the `-deprovision` command first.

## Capture errors

**N<sup>3</sup>:** If the OS is Linux generalized but captured as specialized, you'll get a provisioning timeout error because the original VM is unusable as it's marked as generalized.

**N<sup>4</sup>:** If the OS is Linux-specialized but captured as generalized, you'll get a provisioning failure error because the new VM will retain the original computer name, username, and password. Additionally, the original VM will become unusable as it's marked as specialized.

### Resolution for capture errors

To resolve these errors, delete the current image from the portal, and [recapture it from the current VHDs](/azure/virtual-machines/linux/capture-image) with the same setting as that for the OS (generalized or specialized). For more information, see [How to capture an image to prepare for upload](#how-to-capture-an-image-to-prepare-for-upload).

## Provisioning timeout error during an upload process

When a Linux generalized OS is uploaded as specialized, it might result in a provisioning timeout error, causing the VM to get stuck during provisioning. This issue typically occurs due to the fundamental differences in configuration between generalized and specialized images. For more information about the differences, see the [Comparison of specialized disks and generalized disks](#comparison-of-specialized-disks-and-generalized-disks) section in this article.

Here are some possible scenarios and explanations of the provisioning timeout error:

|Scenario|Issue|Cause|Solution|
|---|---|---|---|
|Persistent network configuration conflicts|Generalized images are designed to remove unique identifiers and specific configurations, making them ready for new deployments. Uploading a generalized image as specialized might result in network conflicts due to persistent network configurations.|Residual network settings or DHCP client IDs remain in the image, which causes the system to hang when it tries to acquire a new IP address during provisioning.|Verify and remove any static network configurations or identifiers before uploading the image.|
|Secure Shell (SSH) key or password reset issues|Generalized images don't retain user-specific configurations like SSH keys or passwords. During provisioning, the VM might attempt to reset these configurations; however, their absence or misconfiguration can result in timeouts.|Without predefined SSH keys or passwords, the provisioning service can't complete the configuration.|Ensure that the VM configuration includes SSH or password authentication methods compatible with the OS state.|
|Missing Cloud-Init or Waagent configuration|Generalized images require provisioning agents such as `cloud-init` or `waagent` to set up the VM during the first boot. If these configurations are missing or incompatible, the provisioning will stall.|Specialized images come with preconfigured initial setup scripts, while generalized images depend on initialization tools for their configuration.|Validate that `cloud-init` or `waagent` is properly configured in the image before uploading.|
|System identity issues|Specialized images retain system-specific identities such as hostname and UUIDs, which are absent in generalized images. During provisioning, the system fails to configure these identifiers properly, which causes delays.|The lack of unique identifiers prevents the VM from fully initializing.|Ensure all unique identifiers are removed or generalized before uploading.|
|Incompatible kernel or module settings|Specialized images might enable specific kernel modules or settings that are incompatible with generalized deployment.|Generalized images usually remove custom kernel settings, whereas specialized images might retain them, causing issues during provisioning.|Confirm that the kernel and module settings in the image are compatible with the deployment environment.|

## Comparison of specialized disks and generalized disks

In Azure, the terms "specialized disk" and "generalized disk" refer to different states of VM images, specifically in relation to their use for provisioning new VMs. Here's an explanation of each term:

|                | Specialized disk                                      | Generalized disk                                      |
|-----------------------|-------------------------------------------------------|-------------------------------------------------------|
|**Definition**|A specialized disk is an image that contains the unique system and user-specific configurations of an individual VM. It includes all the settings, applications, and data on the source VM.|A generalized disk is an image that has been modified to remove any system-specific information. This is done through a process that prepares the VM for imaging, often known as "generalizing" the image.|
|**Usage**|To create a new VM that retains all the specific settings and configurations of the original VM, specialized disks are used. This approach is particularly useful in situations where you want to replicate a VM already configured with specific applications or settings that must be maintained.|Generalized disks are used as templates to create new VMs. They enable multiple instances to be deployed without duplicating machine-specific information, which is useful for scaling out applications.|
|**Characteristics**|A specialized disk contains unique information about the original VM, such as the machine SID and user accounts. It can't be used to efficiently provision multiple instances because each VM created from it retains the original configuration.|A VM is prepared (using commands like `waagent -deprovision+user` for Linux or `sysprep` for Windows) to remove unique identifiers such as the machine security identifier (SID), user accounts, and other specific configurations. New VMs created from a generalized disk can receive new machine identities, enabling them to operate independently from the original VM.|
|**Example**|Creating a VM backup with all its settings, applications, and data.|Creating a template for a base OS to deploy multiple identical VMs.|

The following table summarizes the differences between specialized and generalized disks. Understanding these differences is important when managing Azure VMs, as it impacts the creation, management, and deployment of your VMs.

|                | Specialized disk                                      | Generalized disk                                      |
|-----------------------|-------------------------------------------------------|-------------------------------------------------------|
| **Purpose**           | Backup of a specific VM with unique settings          | Template for deploying multiple VMs                   |
| **Contents**          | Unique configuration and settings                     | Generic information, with system-specific information removed     |
| **Use case**          | Replicating a configured VM                           | Scaling applications or creating multiple VMs         |
| **Creation process**  | Directly from a running VM                            | Requires preparation (for example, `waagent` and `sysprep`)     |

## How to capture an image to prepare for upload

> [!NOTE]
> Here are the prerequisites to capture an image:
> - Access to the Linux machine whose disk you want to image.
> - Azure CLI installed on your local machine.
> - An Azure account with appropriate permissions to upload images.

1. Prepare the Linux machine for imaging, including stopping unnecessary services and cleaning up temporary files:
    
    ```bash
    sudo systemctl stop <service-name>
    sudo apt-get clean
    sudo rm -rf /tmp/*
    ```

2. Create an image of the disk using the `dd` command:

    ```bash
    sudo dd if=/dev/sdX of=/path/to/output/image.img bs=4M
    ```

    > [!NOTE]
    > Replace `/dev/sdX` with the appropriate disk identifier.

 3. Compress the disk image to save space and reduce upload time:

    ```bash
    gzip /path/to/output/image.img
    ```

4. Install the Azure CLI on your local machine if it's not installed:

    ```bash
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    ```

5. Sign in to Azure using the Azure CLI:

    ```bash
    az login
    ```

6. Create a resource group where you'll store the image (if needed):

    ```bash
    az group create --name <ResourceGroupName> --location <Location>
    ```

7. Create a storage account to upload the image:

    ```bash
    az storage account create --name <StorageAccountName> --resource-group <ResourceGroupName> --location <Location> --sku Standard_LRS
    ```

8. Create a storage container within the storage account:

    ```bash
    az storage container create --account-name <StorageAccountName> --name <ContainerName>
    ```

9. Upload the compressed disk image to the storage container:

    ```bash
    az storage blob upload --account-name <StorageAccountName> --container-name <ContainerName> --name image.img.gz --file /path/to/output/image.img.gz
    ```

10. Create a managed disk from the uploaded VHD:

    ```bash
    az disk create --resource-group <ResourceGroupName> --name <DiskName> --source https://<StorageAccountName>.blob.core.windows.net/<ContainerName>/image.img.gz
    ```

11. Create an image from the managed disk:

    ```bash
    az image create --resource-group <ResourceGroupName> --name <ImageName> --source <DiskName>
    ```

12. Verify that the image has been created successfully:

    ```bash
    az image show --resource-group <ResourceGroupName> --name <ImageName>
    ```

You have now created a Linux image from an on-premises disk and uploaded it to Azure. You can use this image to create new VMs in your Azure environment.



[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
