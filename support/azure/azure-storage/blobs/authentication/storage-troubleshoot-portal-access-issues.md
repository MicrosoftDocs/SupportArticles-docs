---
title: Troubleshoot Azure Blob Storage access issues in the Azure portal
description: Troubleshoot common authorization, networking, and browser-related errors that occur when accessing Azure Blob containers and blobs in the Azure portal.
ms.date: 06/22/2026
ms.service: azure-blob-storage
author: jeffpatt24
ms.author: jeffpatt
ms.custom: sap:Authentication and Authorization
---

# Troubleshoot Azure Blob Storage access issues in the Azure portal

When accessing Azure Blob Storage through the Azure portal, you may encounter errors when performing operations on containers or blobs. This article describes common error messages, their causes, and steps to resolve them.

## General troubleshooting

When accessing blob containers or blobs in the Azure portal, requests are authorized using either your Microsoft Entra ID account or the storage account access key.

### Verify required permissions

- If using **Microsoft Entra ID**:
  - You must have at least the **Reader** role for control plane access.
  - You must also have a data access role such as:
    - **Storage Blob Data Reader**
    - **Storage Blob Data Contributor**
    - **Storage Blob Data Owner**

- If using **Access Key**:
  - You must have an Azure Resource Manager role that includes the following control plane permission:

    ```azurecli
    Microsoft.Storage/storageAccounts/listkeys/action
    ```

  - Built-in roles that include this permission include:
    - **Reader and Data Access**
    - **Storage Account Contributor**
    - **Contributor**
    - **Owner**

For more information, see [Data access from the Azure portal](/azure/storage/blobs/authorize-access-azure-active-directory#data-access-from-the-azure-portal).

### Validate browser and network configuration

If you're using **Microsoft Edge** or **Google Chrome** to access storage through a **private endpoint**, configure the `LocalNetworkAccessAllowedForUrl` browser policy to allow the Azure portal: `https://portal.azure.com`

For more information, see:

- [Microsoft Edge policy: LocalNetworkAccessAllowedForUrls](/deployedge/microsoft-edge-policies/localnetworkaccessallowedforurls)
- [Chrome policy: LocalNetworkAccessAllowedForUrls](https://chromeenterprise.google/policies/local-network-access-allowed-for-urls/)

### Use the Connectivity check tool

Use the built-in connectivity diagnostics in the Azure portal:

1. Go to your storage account in the Azure portal.
2. Expand **Help**.
3. Select **Connectivity check**.

This tool can help identify whether an issue is related to permissions, network security configuration, or other causes.

## Error: This request is not authorized to perform this operation

You may see the following error when accessing a blob container or blob in the Azure portal:

```output
This request is not authorized to perform this operation
Error code: 403
```
### Cause

Common causes include:

- Public network access is disabled.
- Your client IP address is not included in the allowed IP ranges.
- Access is restricted to selected virtual networks or subnets.

### Solution

- Verify the storage account network configuration. For more information, see [Azure Storage network security overview](/azure/storage/common/storage-network-security-overview).
- If public network access is disabled and you are using a private endpoint, verify that DNS is configured correctly. For more information, see [Use private endpoints for Azure Storage](/azure/storage/common/storage-private-endpoints).

## Error: This request is not authorized to perform this operation using this permission

You may see the following error when accessing a blob container or performing an operation on a blob in the Azure portal:

```output
This request is not authorized to perform this operation using this permission
Error code: 403
```
### Cause

Your Microsoft Entra identity doesn't have sufficient permissions for the requested operation.

### Solution

#### If the error occurs when viewing containers

The following control plane permissions are required at the storage account level:

```azurecli
Microsoft.Storage/storageAccounts/read
Microsoft.Storage/storageAccounts/blobServices/read
Microsoft.Storage/storageAccounts/blobServices/containers/read
```

The built-in **Reader** role includes these permissions.

#### If the error occurs when creating, deleting, or modifying blob data

Your identity must be assigned a role that includes the required data plane permissions.

| Role | Description |
|---|---|
| **Storage Blob Data Reader** | Read access to blob containers and blob data. |
| **Storage Blob Data Contributor** | Read, write, and delete access to blob containers and blob data. |
| **Storage Blob Data Owner** | Full access to blob containers and blob data, including assigning POSIX ACLs. |

For more information, see [Data access from the Azure portal](/azure/storage/blobs/authorize-access-azure-active-directory#data-access-from-the-azure-portal).

## Error: You do not have permissions to list the data using your user account with Microsoft Entra ID

You may see the following error when accessing a blob container or blob in the Azure portal:

```output
You do not have permissions to list the data using your user account with Microsoft Entra ID. Click to learn more about authenticating with Microsoft Entra ID. This request is not authorized to perform this operation using this permission.
```
### Cause

Your Microsoft Entra identity is missing the following data plane permission:

```azurecli
Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read
```

### Solution

Assign a role that includes the required permission, such as:

| Role | Description |
|---|---|
| **Storage Blob Data Reader** | Read access to blob containers and blob data. |
| **Storage Blob Data Contributor** | Read, write, and delete access to blob containers and blob data. |
| **Storage Blob Data Owner** | Full access to blob containers and blob data, including assigning POSIX ACLs. |

For more information, see [Data access from the Azure portal](/azure/storage/blobs/authorize-access-azure-active-directory#data-access-from-the-azure-portal).

## Error: You do not have permissions to use the access key to list data

You may see the following error when accessing a blob container or blob in the Azure portal:

```output
You do not have permissions to use the access key to list data.
```
### Cause

This error can occur when:

- Your Microsoft Entra identity doesn't have sufficient control plane permissions.
- Your browser blocks local network access when you use a private endpoint. A network trace may show the following error: `ERR_BLOCKED_BY_LOCAL_NETWORK_ACCESS_CHECKS`.

### Solution

#### If you're using Access Key

Assign a role that includes the following permission:

```azurecli
Microsoft.Storage/storageAccounts/listkeys/action
```

Built-in roles that include this permission include:

- **Reader and Data Access**
- **Storage Account Contributor**
- **Contributor**
- **Owner**

#### If you're using Microsoft Entra ID

Verify that you have the following control plane permissions at the storage account scope:

```azurecli
Microsoft.Storage/storageAccounts/read
Microsoft.Storage/storageAccounts/blobServices/read
Microsoft.Storage/storageAccounts/blobServices/containers/read
```
#### If you're using a private endpoint

Verify that the `LocalNetworkAccessAllowedForUrl` browser policy allows the Azure portal URL: `https://portal.azure.com`

For more information, see:

- [Data access from the Azure portal](/azure/storage/blobs/authorize-access-azure-active-directory#data-access-from-the-azure-portal)
- [Microsoft Edge policy: LocalNetworkAccessAllowedForUrls](/deployedge/microsoft-edge-policies/localnetworkaccessallowedforurls)
- [Chrome policy: LocalNetworkAccessAllowedForUrls](https://chromeenterprise.google/policies/local-network-access-allowed-for-urls/)

## Error: You don't have access

You may see the following error when accessing a blob container in the Azure portal:

```output
You don't have access
Error code: 403
```
### Cause

Your Microsoft Entra identity doesn't have the required control plane permissions.

### Solution

The following control plane permissions are required at the storage account level:

```azurecli
Microsoft.Storage/storageAccounts/read
Microsoft.Storage/storageAccounts/blobServices/read
Microsoft.Storage/storageAccounts/blobServices/containers/read
```

The built-in **Reader** role includes these permissions.

For more information, see [Data access from the Azure portal](/azure/storage/blobs/authorize-access-azure-active-directory#data-access-from-the-azure-portal).

## Error: Network request failed – cannot access storage endpoint

You may see the following error when accessing a blob container or blob in the Azure portal:

```output
Network request failed – cannot access storage endpoint
Your firewall settings may be preventing network access from this client to the storage data endpoint.
CORS settings on your storage account may be preventing network access from this client.
```
### Cause

Common causes include:

- Public network access is disabled.
- Your client IP address is not included in the allowed IP ranges.
- Access is restricted to selected virtual networks or subnets.
- CORS rules are blocking access.

### Solution

- Verify the storage account network configuration. For more information, see [Azure Storage network security overview](/azure/storage/common/storage-network-security-overview).
- If public network access is disabled and you are using a private endpoint, verify that DNS is configured correctly. For more information, see [Use private endpoints for Azure Storage](/azure/storage/common/storage-private-endpoints).
- If CORS rules are configured on the storage account, verify they are correct. For more information, see [Cross-origin resource sharing (CORS) support for Azure Storage](/rest/api/storageservices/cross-origin-resource-sharing--cors--support-for-the-azure-storage-services).
