---
title: Capture Linux Images for Upload Preparation
description: Offers the steps to capture a Linux image for upload preparation.
ms.topic: how-to
ms.custom: sap:Cannot create a VM, linux-related-content
ms.service: azure-virtual-machines
ms.date: 05/19/2025
ms.reviewer: srijangupta, scotro, maries, jarrettr, v-weizhu
---
# How to capture a Linux image for upload preparation

**Applies to:** :heavy_check_mark: Linux VMs

This article outlines the steps to capture a Linux image for preparing to upload it to Azure.

## Prerequisites

- Access to the Linux machine whose disk you want to image.
- Azure CLI installed on your local machine.
- An Azure account with appropriate permissions to upload images.

## Steps to capture a Linux image

1. Prepare the Linux VM for imaging, including stopping unnecessary services and cleaning up temporary files:

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
