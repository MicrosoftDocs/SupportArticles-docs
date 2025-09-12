---
title: How to Display Encryption Settings on Azure Linux Virtual Machines
description: Learn how to visualize encryption settings stamped on a disk or VM after Azure Disk Encryption (ADE) is deployed.
author: elicorme
ms.author: elcorral
ms.date: 01/20/2025
ms.reviewer: divargas
ms.service: azure-virtual-machines
ms.custom: linux-related-content
ms.topic: how-to
ms.collection: linux
---

# How to display encryption settings on Azure Linux Virtual Machines

**Applies to:** :heavy_check_mark: Linux VMs

When Azure Disk Encryption (ADE) is enabled on an Azure Linux Virtual Machine (VM), encryption settings are configured at a platform level to either the disk object or the VM object. This guide shows how to visualize these encryption settings after ADE is deployed.

## Prerequisites

- Access to [the Azure portal Resource Explorer](https://portal.azure.com/?feature.customportal=false#view/HubsExtension/ArmExplorerBlade)
- Access to [Azure web Resource Explorer](https://resources.azure.com/)

## How to identify the ADE extension version

You can identify the ADE version in the Azure portal. To do this, open the properties of the VM, and then select **Extensions** to open the **Extensions** blade. On the **Extensions** blade, view the version number of **AzureDiskEncryptionForLinux**.

- If the version number is `0.*`, the disk uses **dual-pass encryption**.
- If the version number is `1.*` or a later version, the disk uses **single-pass encryption**.

If ADE single-pass is used, the extension process stamps the encryption settings on the disk object itself. If ADE dual-pass is used, encryption settings are stamped on the VM object.

> [!NOTE]
> We recommend that you use single-pass encryption instead of dual-pass encryption.

## <a id="portal"> </a> Verify ADE encryption settings through Azure portal

1. Log in to your subscription in [the Azure portal](https://portal.azure.com)
2. Search for "resource explorer" on the search bar.

    :::image type="content" source="./media/how-to-display-encryption-settings-in-azure-vms/searchresourceexplorerportal.png" alt-text="Screenshot that shows searching for resource explorer on the Azure portal search bar.":::

3. Select the **Resource Explorer** icon.
4. Select the subscription that you want to review.
5. Locate the disk that you want to review by using either by the resource group path or the provider path.

    :::image type="content" source="./media/how-to-display-encryption-settings-in-azure-vms/providersrgs.png" alt-text="Screenshot that shows the provider and resource groups view in which you can select the desired disk for review.":::

    :::image type="content" source="./media/how-to-display-encryption-settings-in-azure-vms/compute.jpeg" alt-text="Screenshot that shows the desired disk selected.":::

6. After the disk is selected, the corresponding JSON metadata is shown in the right panel. The encryption settings block is enclosed inside the `encryptionSettingsCollection` key. It resembles the following code:

    ```json
    "encryptionSettingsCollection": {
        "enabled": true,
        "encryptionSettings": [
            {
                "diskEncryptionKey": {
                    "sourceVault": {
                        "id": "/subscriptions/12345678-1234-4321-5678-987654321987/resourceGroups/RGName/providers/Microsoft.KeyVault/vaults/KeyvaultName"
                    },
                    "secretUrl": "https://kevaultName.vault.azure.net/secrets/12345678-1234-4321-5678-987654321987/12345678998765432112345678998765"
                },
                "keyEncryptionKey": {
                    "sourceVault": {
                        "id": "/subscriptions/12345678-1234-4321-5678-987654321987/resourceGroups/RGName/providers/Microsoft.KeyVault/vaults/KeyvaultName"
                    },
                    "keyUrl": "https://kevaultName.vault.azure.net/keys/kek/"
                }
            }
        ],
        "encryptionSettingsVersion": "1.1"
    }
    ```

- `encryptionSettingsCollection` - This value is set to `True` if the disk has encryption settings stamped.
- `encryptionSettings` - This value corresponds to the JSON array that contains the encryption settings on a disk.
- `sourceVault` - This value is the complete URL of the key vault that's used for ADE.
- `secretUrl` - This value is the complete URL of the secret that's generated during encryption.
- `keyEncryptionKey` - This value is optional. If you used [Key Encryption Key (KEK)](/azure/virtual-machines/linux/disk-encryption-overview#terminology), the URL of the wrapping key is listed in this section.
- `encryptionSettingsVersion` - The extension (ADE) version that's used to encrypt the disk.
  - If the version number is `0.*`, the disk uses dual-pass encryption.
  - If the version number is `1.*` or a later version, the disk uses single-pass encryption.

The first version of ADE relied on Microsoft Entra ID for authentication (dual-pass). The current version of ADE doesn't rely on Entra ID (single-pass). We strongly encourage you to use the current version.

If you're already using the dual-pass version of ADE, the encryption settings are shown in the VM component.

## Verify ADE encryption settings through Azure Web Resource Explorer

Open the [web version of Resource Explorer](https://resources.azure.com), and then follow steps 1 through 6 under ["Verify ADE encryption settings through Azure portal"](#portal) to locate the component that you want to analyze.

## Next steps

For more information, see [the ADE documentation](/azure/virtual-machines/linux/disk-encryption-overview).
