---
title: Troubleshoot Azure File Sync managed identity issues
description: Troubleshoot common issues when your Azure File Sync deployment is configured to use managed identities.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 10/30/2024
ms.author: kendownie
---
# Troubleshoot Azure File Sync managed identity issues
This article is designed to help you troubleshoot and resolve issues that you might encounter when using a managed identity with Azure File Sync. 

## How to check if the Storage Sync Service is using a system-assigned managed identity
To check if the Storage Sync Service is using a system-assigned managed identity, run the following command from an elevated PowerShell window:

```powershell
Get-AzStorageSyncService -ResourceGroupName <string> -StorageSyncServiceName <string>
```

Verify the value for the **UseIdentity** property is **True**. If the value is **False**, the Storage Sync Service is using shared keys to authenticate to the Azure file shares.

## How to check if a registered server is configured to use a system-assigned managed identity

To check if a registered server is configured to use a system-assigned managed identity, run the following command from an elevated PowerShell window:

```powershell
Get-AzStorageSyncServer -ResourceGroupName <string> -StorageSyncServiceName <string>
```

Verify the **ApplicationId** property has a GUID which indicates the server is configured to use the managed identity. The value for the **ActiveAuthType** property will be updated to **ManagedIdentity** once the server is using the system-assigned managed identity. If the value is **Certificate**, the server is using shared keys to authenticate to the Azure file shares. 

> [!NOTE]
> Once a server is configured to use a system-assigned managed identity, it can take up to one hour before the server uses the system-assigned managed identity to authenticate to the Storage Sync Service and Azure file shares.

## Set-AzStorageSyncServiceIdentity cmdlet does not configure a server to use a system-assigned managed identity

If the Set-AzStorageSyncServiceIdentity cmdlet does not configure a server to use a managed identity, it’s more than likely because the server does not have a system-assigned managed identity.

To enable a system-assigned managed identity on a registered server that has the Azure File Sync v19 agent installed, perform the following steps:
- If the server is hosted outside of Azure, it must be an **Azure Arc-enabled server** to have a system-assigned managed identity. For more information on Azure Arc-enabled servers and how to install the Azure Connected Machine agent, see: [Azure Arc-enabled servers Overview](/azure/azure-arc/servers/overview)
- If the server is an Azure virtual machine, **enable the system-assigned managed identity setting on the VM**. For more information, see: [Configure managed identities on Azure virtual machines](/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities?pivots=qs-configure-portal-windows-vm#enable-system-assigned-managed-identity-on-an-existing-vm).

### How to check if your registered servers have a system-assigned managed identity

To check if your registered servers have a system-assigned managed identity, run the following PowerShell command:

```powershell
Get-AzStorageSyncServer -ResourceGroupName <string> -StorageSyncServiceName <string>
```

Verify the **LatestApplicationId** property on has a GUID which indicates the server has a system-assigned managed identity but is not currently configured to use the managed identity. 

Once the **LatestApplicationId** property has a GUID, run the **Set-AzStorageSyncServiceIdentity** cmdlet again to configure your server to use a system-assigned managed identity.

Once the server is configured to use a system-assigned managed identity, verify the **ApplicationId** property has a GUID which indicates the server is configured to use the managed identity. The value for the **ActiveAuthType** property will be updated to **ManagedIdentity** once the server is using the system-assigned managed identity.

## Permissions required to access storage account and Azure file share

When Azure File Sync is configured to use managed identities, your cloud and server endpoints need the following permissions to access the storage account and Azure file share:

**Cloud Endpoint**
- **Storage Sync Service** managed identity must be a member of the **Storage Account Contributor** role on the **Storage Account**. 
- **Storage Sync Service** managed identity must be a member of the **Storage File Data Privileged Contributor** role on the **Azure file share**.

**Server Endpoint**
- **Register Server** managed identity must be a member of the **Storage File Data Privileged Contributor** role on the **Azure file share**.

These permissions are granted when using the Set-AzStorageSyncServiceIdentity cmdlet or when creating new cloud and server endpoints. If these permissions are removed, operations will fail with the errors listed in the section below.

## Common Errors
This section covers errors that can occur if permissions or configuration settings are incorrect. 

### Sync fails with error 0x80c8305f (ECS_E_EXTERNAL_STORAGE_ACCOUNT_AUTHORIZATION_FAILED)

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8305f |
| **HRESULT (decimal)** | -2134364065 |
| **Error string** | ECS_E_EXTERNAL_STORAGE_ACCOUNT_AUTHORIZATION_FAILED |
| **Remediation required** | Yes |

This issue occurs if the managed identity for the Storage Sync Service does not have access to the storage account.

To resolve this issue, run the following PowerShell command:

```powershell
Set-AzStorageSyncCloudEndpointPermission -ResourceGroupName <string> -StorageSyncServiceName <string> -SyncGroupName <string> -Name <string>
```

> [!NOTE]
> The -Name parameter is a GUID, not the friendly name that's displayed in the portal. To get the CloudEndpointName, use the [Get-AzStorageSyncCloudEndpoint](/powershell/module/az.storagesync/get-azstoragesynccloudendpoint) cmdlet.

### Sync fails with error 0x80c86053 (ECS_E_AZURE_FILE_SHARE_NOT_ACCESSIBLE)

| Error | Code |
|-|-|
| **HRESULT** | 0x80c86053 |
| **HRESULT (decimal)** | -2134351789 |
| **Error string** | ECS_E_AZURE_FILE_SHARE_NOT_ACCESSIBLE |
| **Remediation required** | Yes |

This issue occurs if the managed identity for the Storage Sync Service does not have access to the Azure file share.

To resolve this issue, run the following PowerShell command:

```powershell
Set-AzStorageSyncCloudEndpointPermission -ResourceGroupName <string> -StorageSyncServiceName <string> -SyncGroupName <string> -Name <string>
```

> [!NOTE]
> The -Name parameter is a GUID, not the friendly name that's displayed in the portal. To get the CloudEndpointName, use the [Get-AzStorageSyncCloudEndpoint](/powershell/module/az.storagesync/get-azstoragesynccloudendpoint) cmdlet.

### Files fail to sync with error 0x80c86063 (ECS_E_AZURE_AUTHORIZATION_PERMISSION_MISMATCH)

| Error | Code |
|-|-|
| **HRESULT** | 0x80c86063 |
| **HRESULT (decimal)** | -2134351773 |
| **Error string** | ECS_E_AZURE_AUTHORIZATION_PERMISSION_MISMATCH |
| **Remediation required** | Yes |

This issue occurs if the managed identity for the registered server does not have access to the Azure file share.

To resolve this issue, run the following PowerShell command:

```powershell
Set-AzStorageSyncServerEndpointPermission -ResourceGroupName <string> -StorageSyncServiceName <string> -SyncGroupName <string> -Name <string>
```

> [!NOTE]
> The -Name parameter is a GUID, not the friendly name that's displayed in the portal. To get the ServerEndpointName, use the [Get-AzStorageSyncServerEndpoint](/powershell/module/az.storagesync/get-azstoragesyncserverendpoint) cmdlet.

### Test-NetworkConnectivity cmdlet fails with error 0x80190193 (HTTP_E_STATUS_FORBIDDEN)
This issue occurs if the managed identity for the registered server does not have access to the Azure file share.

To resolve this issue, run the following PowerShell command:

```powershell
Set-AzStorageSyncServerEndpointPermission -ResourceGroupName <string> -StorageSyncServiceName <string> -SyncGroupName <string> -Name <string>
```

> [!NOTE]
> The -Name parameter is a GUID, not the friendly name that's displayed in the portal. To get the ServerEndpointName, use the [Get-AzStorageSyncServerEndpoint](/powershell/module/az.storagesync/get-azstoragesyncserverendpoint) cmdlet.

### Test-NetworkConnectivity cmdlet fails with error 0x80131500 (COR_E_EXCEPTION)
This issue occurs if the **Allow Azure services on the trusted services list to access this storage account** exception is not enabled on the storage account. This exception must be enabled for preview. [Learn more](/azure/storage/file-sync/file-sync-networking-endpoints?tabs=azure-portal#grant-access-to-trusted-azure-services-and-restrict-access-to-the-storage-account-public-endpoint-to-specific-virtual-networks).
