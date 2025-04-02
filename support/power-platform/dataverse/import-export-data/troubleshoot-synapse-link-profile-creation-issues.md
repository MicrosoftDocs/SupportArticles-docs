---
title: Troubleshoot Azure Synapse Link profile creation issues
description: Resolves networking, permissions, regional mismatches, or profile limits in Microsoft Dataverse.
author: Greggbarker-ms
ms.author: grbarker
ms.reviewer: saukuma
ai-usage: ai-assisted
ms.date: 03/28/2025
ms.custom: sap:Importing and exporting data\Configuring Export to Azure Data Lake and Azure Synapse Link integration 
---
# Troubleshoot Azure Synapse Link profile creation issues

This article provides detailed guidance for troubleshooting common issues encountered during the [creation of Azure Synapse Link profiles](/power-apps/maker/data-platform/azure-synapse-link-synapse). The steps outlined address causes like networking misconfigurations, insufficient permissions, regional mismatches, and other factors that might impact the setup process.

## Networking misconfiguration

**Cause:** Public network access is disabled or IP access rules are improperly configured for the storage account.

**Solution:**

1. Ensure **Public network access** is enabled for the linked storage account.
2. Set the IP addresses access rule to "allowAll" if linking to a Synapse Workspace. If restricting public access, enable the [managed identities feature](/power-apps/maker/data-platform/azure-synapse-link-msi) for the linked storage account and workspace.

:::image type="content" source="media/troubleshoot-synapse-link-profile-creation-issues/synapse-networking-configuration.png" alt-text="Screenshot of the Networking setup page in synapse.":::

## Insufficient permissions

**Cause:** Missing required roles and permissions for Synapse Workspace, storage account, or Dataverse environment.

**Solution:**

1. Ensure you have the following roles:

    - **Dataverse System Administrator** security role.
    - **Synapse Administrator** role for Synapse Workspace.
    - **Reader** role for the resource group containing the storage account and Synapse Workspace.
    - **Owner** and **Storage Blob Data Contributor** roles for the Azure Data Lake Storage Gen2 account.

   For more information, review the prerequisites based on your profile type:

    - [Prerequisites for Azure Synapse Link profile with Azure Data Lake](/power-apps/maker/data-platform/azure-synapse-link-data-lake#prerequisites)
    - [Prerequisites for Azure Synapse Link profile with your Azure Synapse Workspace](/power-apps/maker/data-platform/azure-synapse-link-synapse#prerequisites) 

2. Select the **Enable storage account key access** checkbox during initial setup.

   :::image type="content" source="media/troubleshoot-synapse-link-profile-creation-issues/permissions-setup-create-storage-account.png" alt-text="Screenshot of the Advanced setup page in Create a storage account page.":::

## Azure region mismatch

**Cause:** Synapse Workspace, storage account, and Power Apps environment aren't in the same Azure region.

**Solution:**

1. Verify that all resources are in the same region.
2. If necessary, move the storage account to the appropriate region using [Relocate Azure Storage Account to another region](/azure/storage/common/storage-account-move).

## The Track changes property isn't enabled

**Cause:** The tables intended for export don't have the **Track changes** property enabled.

**Solution:**

To solve this issue, enable the **Track changes** property for the desired tables by following the steps described in [Enable change tracking to control data synchronization](/power-platform/admin/enable-change-tracking-control-data-synchronization).

## Maximum number of Azure Synapse Link profiles is reached

**Cause:** The Dataverse environment has reached its limit for Azure Synapse Link profiles.

**Solution:**

1. Review the current Azure Synapse Link profiles in your environment.
2. If the maximum limit is reached, consider removing unused profiles to create new ones.

## Mitigation for UI stuck on the "Fetching App..." status

**Cause:** The "Common Data Service - Azure Data Lake Storage" app (ID: 546068c3-99b1-4890-8e93-c8aeadcfe56a) is missing in your Microsoft Entra ID.

**Validation:**

1. Use [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) or the following [Azure PowerShell](/powershell/module/az.resources/get-azadserviceprincipal) command to check if the app exists:

   ```powershell
   Get-AzADServicePrincipal -ApplicationId 546068c3-99b1-4890-8e93-c8aeadcfe56a
   ```

2. If a 404 error is returned in Graph Explorer, the app is missing.

   ```jsonc
   {
       "error": {
          "code": "Request_ResourceNotFound",
          "message": "Resource '' does not exist or one of its queried reference-property objects are not present.",
          "innerError": 
   }
   ```

    :::image type="content" source="media/troubleshoot-synapse-link-profile-creation-issues/graph-explorer-404-error.png" alt-text="Screenshot of the 404 error that occurs in Graph Explorer.":::

**Solution:**

1. Ensure you have the necessary privileges (Application Administrator or Global Administrator).

2. Open PowerShell and run:

    ```powershell
    Connect-AzAccount
    ```

3. Add the missing service principal using:

    ```powershell
    New-AzADServicePrincipal -ApplicationId '546068c3-99b1-4890-8e93-c8aeadcfe56a'
    ```

4. After adding the principal, retry creating the Azure Synapse Link profile.
