---
title: Troubleshoot Azure File Sync managed identity issues
description: Troubleshoot common issues when your Azure File Sync deployment is configured to use managed identities.
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 04/02/2025
author: khdownie
ms.author: kendownie
---
# Troubleshoot Azure File Sync managed identity issues

This article helps you troubleshoot and resolve issues that you might encounter when using a managed identity with an Azure File Sync deployment. 

## Check if the Storage Sync Service uses a system-assigned managed identity

To check if the Storage Sync Service uses a system-assigned managed identity, run the following command from an elevated PowerShell window:

```powershell
Get-AzStorageSyncService -ResourceGroupName <string> -StorageSyncServiceName <string>
```

Verify the value of the `UseIdentity` property is `True` from the command output. If the value is `False`, the Storage Sync Service uses shared keys to authenticate to Azure file shares.

## Check if a registered server is configured to use a system-assigned managed identity

To check if a registered server is configured to use a system-assigned managed identity, run the following command from an elevated PowerShell window:

```powershell
Get-AzStorageSyncServer -ResourceGroupName <string> -StorageSyncServiceName <string>
```

Verify the `ApplicationId` property has a GUID which indicates that the server is configured to use a system-assigned managed identity. Once the server uses a system-assigned managed identity, the value of the `ActiveAuthType` property is updated to `ManagedIdentity`. If the value is `Certificate`, the server uses shared keys to authenticate to Azure file shares. 

> [!NOTE]
> Once a server is configured to use a system-assigned managed identity, it can take up to 15 minutes before the server uses the system-assigned managed identity to authenticate to the Storage Sync Service and Azure file shares.

## Set-AzStorageSyncServiceIdentity cmdlet doesn't configure a server to use a system-assigned managed identity

If running the `Set-AzStorageSyncServiceIdentity` cmdlet doesn't configure a registered server to use a system-assigned managed identity, it's likely because the server doesn't have a system-assigned managed identity.

To enable a system-assigned managed identity on a registered server that has the Azure File Sync v20 agent installed, perform the following steps:

- If the server is hosted outside of Azure, it must be an Azure Arc-enabled server to have a system-assigned managed identity. For more information about Azure Arc-enabled servers and how to install the Azure Connected Machine agent, see [Azure Arc-enabled servers Overview](/azure/azure-arc/servers/overview).

  - If the server is already Azure Arc-enabled, run the `azcmagent show` command from PowerShell and confirm the **Agent Status** is **Connected**. If the **Agent Status** is **Disconnected**, [troubleshoot Azure Connected Machine agent connection issues](/azure/azure-arc/servers/troubleshoot-agent-onboard)。
- If the server is an Azure virtual machine, [enable a system-assigned managed identity on the virtual machine](/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities#enable-system-assigned-managed-identity-on-an-existing-vm).

## Check if a registered server has a system-assigned managed identity

To check if a registered server has a system-assigned managed identity, run the following PowerShell command:

```powershell
Get-AzStorageSyncServer -ResourceGroupName <string> -StorageSyncServiceName <string>
```

Verify the `LatestApplicationId` property has a GUID which indicates that the server has a system-assigned managed identity but isn't currently configured to use it.

If the `LatestApplicationId` property has a GUID, run the `Set-AzStorageSyncServiceIdentity` cmdlet again to configure the server to use a system-assigned managed identity. Verify the `ApplicationId` property has a GUID which indicates that the server is configured to use the managed identity. Once the server uses the system-assigned managed identity, the value of the `ActiveAuthType` property is updated to `ManagedIdentity`.

## Unable to delete a Storage Sync Service

When you try to delete a Storage Sync Service, you might get the following error: 

> Unable to delete Storage Sync Service in region \<region>. The Storage Sync Service is deleting snapshots that are no longer needed. Please try again in a few hours.

This issue occurs when your file share has unused Azure File Sync snapshots. To reduce your cost, the unused snapshots are deleted before removing the Storage Sync Service. The snapshot count varies with the dataset size. If you can't delete the Storage Sync Service after a few hours, try again the next day.

## Permissions required to access a storage account and Azure file share

When Azure File Sync is configured to use a managed identity, your cloud and server endpoints need the following permissions to access a storage account and Azure file share:

Cloud endpoint:
- Storage Sync Service managed identity must be a member of the **Storage Account Contributor** role on a storage account. 
- Storage Sync Service managed identity must be a member of the **Storage File Data Privileged Contributor** role on an Azure file share.

Server endpoint:
- Register server managed identity must be a member of the **Storage File Data Privileged Contributor** role on an Azure file share.

When you run the `Set-AzStorageSyncServiceIdentity` cmdlet or create new cloud and server endpoints, these permissions are granted. If these permissions are removed, operations fail with the errors listed in the following section.

## Unable to recreate Storage Sync Service due to dangling enterprise app

When you attempt to recreate a Storage Sync Service, you might encounter a failure due to a dangling enterprise app left by the previous Storage Sync Service. If this occurs, you can wait for a few hours for ARM to automatically delete the apps. Alternatively, you can manually delete the app in Entra ID by navigating to **Enterprise applications** and deleting the associated app. 

## Common issues

This section covers common issues that occur when permissions or configuration settings are incorrect.

### Sync fails with error 0x80c8305f (ECS_E_EXTERNAL_STORAGE_ACCOUNT_AUTHORIZATION_FAILED)

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8305f |
| **HRESULT (decimal)** | -2134364065 |
| **Error string** | ECS_E_EXTERNAL_STORAGE_ACCOUNT_AUTHORIZATION_FAILED |
| **Remediation required** | Yes |

This issue occurs when the managed identity for the Storage Sync Service doesn't have access to a storage account.

To resolve this issue, run the following PowerShell command:

```powershell
Set-AzStorageSyncCloudEndpointPermission -ResourceGroupName <string> -StorageSyncServiceName <string> -SyncGroupName <string> -Name <string>
```

> [!NOTE]
> The `-Name` parameter is the name of the cloud endpoint. It's a GUID, not the friendly name that's displayed in the Azure portal. To get the cloud endpoint name, run the [Get-AzStorageSyncCloudEndpoint](/powershell/module/az.storagesync/get-azstoragesynccloudendpoint) cmdlet.

### Sync fails with error 0x80c86053 (ECS_E_AZURE_FILE_SHARE_NOT_ACCESSIBLE)

| Error | Code |
|-|-|
| **HRESULT** | 0x80c86053 |
| **HRESULT (decimal)** | -2134351789 |
| **Error string** | ECS_E_AZURE_FILE_SHARE_NOT_ACCESSIBLE |
| **Remediation required** | Yes |

This issue occurs when the managed identity for the Storage Sync Service doesn't have access to an Azure file share.

To resolve this issue, run the following PowerShell command:

```powershell
Set-AzStorageSyncCloudEndpointPermission -ResourceGroupName <string> -StorageSyncServiceName <string> -SyncGroupName <string> -Name <string>
```

> [!NOTE]
> The `-Name` parameter is the name of the cloud endpoint. It's a GUID, not the friendly name that's displayed in the Azure portal. To get the cloud endpoint name, run the [Get-AzStorageSyncCloudEndpoint](/powershell/module/az.storagesync/get-azstoragesynccloudendpoint) cmdlet.

### Files fail to sync with error 0x80c86063 (ECS_E_AZURE_AUTHORIZATION_PERMISSION_MISMATCH)

| Error | Code |
|-|-|
| **HRESULT** | 0x80c86063 |
| **HRESULT (decimal)** | -2134351773 |
| **Error string** | ECS_E_AZURE_AUTHORIZATION_PERMISSION_MISMATCH |
| **Remediation required** | Yes |

This issue occurs when the managed identity for the registered server doesn't have access to an Azure file share.

To resolve this issue, run the following PowerShell command:

```powershell
Set-AzStorageSyncServerEndpointPermission -ResourceGroupName <string> -StorageSyncServiceName <string> -SyncGroupName <string> -Name <string>
```

> [!NOTE]
> The `-Name` parameter is the name of the server endpoint. It's a GUID, not the friendly name that's displayed in the Azure portal. To get the server endpoint name, run the [Get-AzStorageSyncServerEndpoint](/powershell/module/az.storagesync/get-azstoragesyncserverendpoint) cmdlet.

### Test-NetworkConnectivity cmdlet fails with error 0x80190193 (HTTP_E_STATUS_FORBIDDEN)

This issue occurs when the managed identity for the registered server doesn't have access to an Azure file share.

To resolve this issue, run the following PowerShell command:

```powershell
Set-AzStorageSyncServerEndpointPermission -ResourceGroupName <string> -StorageSyncServiceName <string> -SyncGroupName <string> -Name <string>
```

> [!NOTE]
> The `-Name` parameter is the name of the server endpoint. It's a GUID, not the friendly name that's displayed in the Azure portal. To get the server endpoint name, run the [Get-AzStorageSyncServerEndpoint](/powershell/module/az.storagesync/get-azstoragesyncserverendpoint) cmdlet.

### Test-NetworkConnectivity cmdlet fails with error 0x80131500 (COR_E_EXCEPTION)

This issue occurs when the **Allow Azure services on the trusted services list to access this storage account** exception isn't enabled on a storage account. To resolve this issue, enable this exception by following instructions in [Grant access to trusted Azure services and restrict access to the storage account public endpoint to specific virtual networks](/azure/storage/file-sync/file-sync-networking-endpoints#grant-access-to-trusted-azure-services-and-restrict-access-to-the-storage-account-public-endpoint-to-specific-virtual-networks).

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
