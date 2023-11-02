---
title: Resolve Azure Synapse Analytics Apache Spark pool storage access issues
description: Provides solutions to common storage issues encountered in Azure Synapse Analytics Apache Spark pools
ms.date: 02/21/2023
author: scott-epperly
ms.author: goventur
ms.reviewer: scepperl
---

# Resolve Azure Synapse Analytics Apache Spark pool storage access issues

_Applies to:_ &nbsp; Azure Synapse Analytics

Apache Spark is a parallel processing framework that supports in-memory processing to boost the performance of big data analytic applications. Apache Spark in Azure Synapse Analytics is one of the Microsoft implementations of Apache Spark in the cloud. Azure Synapse makes it easy to create and configure a serverless Apache Spark pool in Azure. Spark pools in Azure Synapse are compatible with Azure Storage and Azure Data Lake Generation 2 Storage. Therefore, you can use Spark pools to process your data stored in Azure.

If you're experiencing pool storage access issues, such as "403" errors or the failure of the Synapse workspace to find linked services, use the provided guidance to help resolve your issues.

## Unsupported scenarios

The following use cases aren't supported when you connect to a Storage account from a Synapse Spark pool:

- Connecting to ADLS Gen 1 Storage account  
- Connecting to ADLS Gen 2 Storage account with User-assigned Managed Identity  
- Connecting to ADLS Gen 2 Storage account that has:  
  - Shared VNET Synapse Workspace
  - Firewall-enabled Storage account

## Common issues and solutions

| Error | Solution |
|---|---|
| "errorMessage":"LSRServiceException is \[{\"StatusCode\":400,\"ErrorResponse\":{\"code\":\"LSRLinkedServiceFailure\",\"message\":\"Could not find Linked Service AzureDataLakeStorage1; | This error is generated if a Synapse workspace is associated with a Git repository, Azure DevOps Services, or GitHub. It's also generated when an artifact such as a notebook or linked service isn't published. <br><br>Manually publish your [code changes](/azure/synapse-analytics/cicd/source-control#publish-code-changes) in the collaboration branch to the Synapse service. |
| stdout: Exception in thread "main" org.apache.hadoop.fs.FileAlreadyExistsException: Operation failed: "This endpoint does not support BlobStorageEvents or SoftDelete. Disable these account features if you would like to use this endpoint.", 409, HEAD, https://\<storageaccountname\>.dfs.core.windows.net/scripts/?upn=false&action=getAccessControl&timeout=90 | Verify that ADLS Gen 2 storage is configured as [primary storage](/azure/synapse-analytics/security/how-to-grant-workspace-managed-identity-permissions#step-1-navigate-to-the-adls-gen2-storage-account-in-azure-portal).<br><br>To disable **SoftDelete**, clear the [Enable blob soft delete](/azure/storage/blobs/soft-delete-blob-enable?tabs=azure-portal#enable-blob-soft-delete) checkbox for the storage account. |

## Troubleshooting '403' issues

**Storage access and the account accessing**

- To write to storage through a pipeline, Synapse Workspace MSI is the security principal that runs any operations such as Read, Write, and Delete on the storage.
  - Make sure that the Workspace MSI account has the Storage Blob Data Contributor role to perform all actions.
- If you use Azure Notebooks to access storage account, use the logged-in account, unless you access storage through linked services.
  - The logged-in user account should have the Storage Blob Data Contributor role to have full access and permissions.
- To connect to storage, use linked service and service principal authentication. Then, the application that's registered at Azure Active should be assigned "Storage Blob Data Contributor" on the Azure storage.

For role-based access control (RBAC) implementation in storage, details are controlled at the container level. For more information, see [Access control model in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control-model).

### Azure role-based access control

Azure role-based access control uses role assignments to apply sets of permissions to security principals such as the Synapse Workspace MSI, Logged-in User, or Application register in the Microsoft Entra ID. Roles such as Owner, Contributor, Reader, and Storage Account Contributor enable a security principal to manage a storage account.

### Access control lists

Use access control lists (ACLs) to apply detailed levels of access to directories and files.

- If data access roles such as Storage Blob Data Reader or Storage Blob Data Contributor are found for the security principal, a check is run to verify if the role has the permissions to perform actions such as Write, Read, and Delete. If so, the security principal might access all files and folders, based on the container role.
  - There are no extra ACL checks on the files or folders.
- If a data access role isn't found for the security principal at the storage container level, ACL checks are run on the files and folders.

## Resources

- [Troubleshoot connectivity between Azure Synapse Analytics Synapse Studio and storage](/azure/synapse-analytics/troubleshoot/troubleshoot-synapse-studio-and-storage-connectivity)
- [Grant permissions to workspace managed identity](/azure/synapse-analytics/security/how-to-grant-workspace-managed-identity-permissions)
- [Synapse workspace managed identity](/azure/synapse-analytics/security/synapse-workspace-managed-identity)
- [Security baseline](/azure/synapse-analytics/security-baseline)
- [How permissions are evaluated](/azure/storage/blobs/data-lake-storage-access-control-model#how-permissions-are-evaluated)
