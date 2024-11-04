---
title: Custom Linux image provisioning errors
description: Provides solutions to provisioning errors when you upload or capture a generalized VM image as a specialized Linux VM image or vice versa.
ms.custom: sap:Cannot create a VM, linux-related-content
ms.service: azure-virtual-machines
ms.date: 11/03/2024
ms.reviewer: srijangupta, scotro, jarrettr
---
# Provisioning errors when deploying custom Linux images

**Applies to:** :heavy_check_mark: Linux VMs

[!INCLUDE [virtual-machines-troubleshoot-deployment-new-vm-issue1](../../../includes/azure/virtual-machines-troubleshoot-deployment-new-vm-issue1-include.md)]

[!INCLUDE [virtual-machines-linux-troubleshoot-deployment-new-vm-table](../../../includes/azure/virtual-machines-linux-troubleshoot-deployment-new-vm-table.md)]

**Y:** If the operating system is a generalized Linux image and it is uploaded or captured using the generalized setting, the upload and deployment will be successful. If the operating system is a generalized Linux image and you upload or capture it using the generalized setting, the upload and deployment will succeed.

## Upload errors

**N<sup>1</sup>:** If the operating system is a generalized Linux image and it is uploaded as a specialized image, you will encounter a provisioning timeout error because the virtual machine will be unable to progress past the provisioning stage.

**N<sup>2</sup>:** If the OS is Linux specialized, and it is uploaded as generalized, you will get a provisioning failure error because the new VM is running with the original computer name, username and password.

<details>
  <summary>Provisioning Timeout Error Scenarios</summary>

When a Linux Generalized Operating System (OS) is uploaded as Specialized, it may result in a provisioning timeout error, causing the Virtual Machine (VM) to get stuck during provisioning. This issue typically arises due to the fundamental differences in configuration between generalized and specialized images. Here are some possible scenarios and their explanations:

**Scenario 1:** Persistent Network Configuration Conflicts
- **Issue**: Generalized images are designed to remove unique identifiers and specific configurations, making them ready for new deployments. Uploading a generalized image as specialized may cause network conflicts, as persistent network configurations might still exist.
- **Cause**: Residual network settings or DHCP client IDs remain in the image, causing the system to hang as it tries to acquire a new IP address during provisioning.
- **Solution**: Verify and remove any static network configurations or identifiers before uploading the image.

Scenario 2: SSH Key or Password Reset Errors
- **Issue**: Generalized images do not retain user-specific configurations like SSH keys or passwords. During provisioning, the VM may attempt to reset these configurations, but the settings are either absent or misconfigured, leading to timeouts.
- **Cause**: Without predefined SSH keys or passwords, the provisioning service is unable to complete the configuration.
- **Solution**: Ensure that the VM configuration includes SSH or password authentication methods compatible with the OS state.

Scenario 3: Missing Cloud-Init or Waagent Configuration
- **Issue**: Generalized images require provisioning agents (like `cloud-init` or `waagent`) to set up the VM during the first boot. If these configurations are missing or incompatible, the provisioning will stall.
- **Cause**: In specialized images, initial setup scripts are already configured, whereas generalized images rely on these initialization tools for configuration.
- **Solution**: Validate that `cloud-init` or `waagent` is properly configured in the image before uploading.

Scenario 4: System Identity Issues
- **Issue**: Specialized images retain system-specific identities (hostname, UUIDs, etc.), which are absent in generalized images. During provisioning, the system fails to configure these identifiers properly, causing delays.
- **Cause**: The lack of unique identifiers prevents the VM from fully initializing.
- **Solution**: Ensure all unique identifiers are removed or generalized before uploading.

Scenario 5: Incompatible Kernel or Module Settings
- **Issue**: Specialized images may have specific kernel modules or settings enabled that are incompatible with generalized deployment.
- **Cause**: Generalized images typically remove custom kernel settings, while specialized images may retain these, causing issues during provisioning.
- **Solution**: Confirm that the kernel and module settings in the image are compatible with the deployment environment.
</details>


## Resolution for upload errors

To resolve these errors, upload the original VHD from your on-premises environment using the same setting as the operating system (generalized or specialized). If you are uploading it as generalized, make sure to run the `-deprovision` command first.

## Capture errors

**N<sup>3</sup>:** If the OS is Linux generalized, and it is captured as specialized, you will get a provisioning timeout error because the original VM is not usable as it is marked as generalized.

**N<sup>4</sup>:** If the OS is a Linux specialized and it is captured as generalized, you will get a provisioning failure error because the new virtual machine will retain the original computer name, username, and password. Additionally, the original virtual machine will become unusable as it will be marked as specialized.

### Resolution for capture errors

To resolve these errors, delete the current image from the portal, and [recapture it from the current VHDs](/azure/virtual-machines/linux/capture-image) with the same setting as that for the OS (generalized/specialized).

<details>
  <summary>How to capture an image to prepare for upload</summary>

## Prerequisites
- Access to the Linux machine whose disk you want to image.
- Azure CLI installed on your local machine.
- An Azure account with appropriate permissions to upload images.

## Step-by-Step Guide

1. Prepare the Linux Machine
Ensure that the Linux machine is prepared for imaging. This includes stopping unnecessary services and cleaning up temporary files.

```bash
sudo systemctl stop <service-name>
sudo apt-get clean
sudo rm -rf /tmp/*
```

2. Create a Disk Image Using `dd` 
Use the `dd` command to create an image of the disk. Replace `/dev/sdX` with the appropriate disk identifier.

```bash
sudo dd if=/dev/sdX of=/path/to/output/image.img bs=4M
```

 3. To reduce upload time Compress the disk image to save space.

```sh
gzip /path/to/output/image.img
```

4. If not already installed, install the Azure CLI on your local machine.

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

5. Log in to your Azure account using the Azure CLI.

```bash
az login
```

6. Create a resource group, if needed, where you will store the image.

```bash
az group create --name <ResourceGroupName> --location <Location>
```

7. Create a storage account to upload the image.

```bash
az storage account create --name <StorageAccountName> --resource-group <ResourceGroupName> --location <Location> --sku Standard_LRS
```

8. Create a storage container within the storage account.

```bash
az storage container create --account-name <StorageAccountName> --name <ContainerName>
```

9. Upload the compressed disk image to the storage container.

```bash
az storage blob upload --account-name <StorageAccountName> --container-name <ContainerName> --name image.img.gz --file /path/to/output/image.img.gz
```

10. Create a managed disk from the uploaded VHD.

```bash
az disk create --resource-group <ResourceGroupName> --name <DiskName> --source https://<StorageAccountName>.blob.core.windows.net/<ContainerName>/image.img.gz
```

11. Create an image from the managed disk.

```bash
az image create --resource-group <ResourceGroupName> --name <ImageName> --source <DiskName>
```

12. Verify that the image has been created successfully.

```bash
az image show --resource-group <ResourceGroupName> --name <ImageName>
```

## Conclusion
You have now created a Linux image from an on-premises disk and uploaded it to Azure. You can use this image to create new virtual machines in your Azure environment.
</details>

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
