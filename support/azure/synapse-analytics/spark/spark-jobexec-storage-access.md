---
title: Resolve Azure Synapse Analytics Apache Spark pool storage access issues
description: Provides solutions to common storage issues encounterd on Azure Synapse Analytics Apache Spark pools
ms.date: 01/31/2023
author: scott-epperly
ms.author: kjacobkurian
ms.reviewer: scepperl
---

# Resolve Azure Synapse Analytics Apache Spark pool storage access issues

_Applies to:_ &nbsp; Azure Synapse Analytics

Apache Spark is a parallel processing framework that supports in-memory processing to boost the performance of big data analytic applications. Apache Spark in Azure Synapse Analytics is one of Microsoft's implementations of Apache Spark in the cloud. Azure Synapse makes it easy to create and configure a serverless Apache Spark pool in Azure. Spark pools in Azure Synapse are compatible with Azure Storage and Azure Data Lake Generation 2 Storage. So you can use Spark pools to process your data stored in Azure.

If you're experiencing pool storage access issues, such as the Synapse workspace being unable to find linked services, 403 issues, and more, use the provided guidance to help resolve your issues.


## Unsupported Scenarios

The following use cases aren't supported when connecting to a Storage account from a Synapse Spark pool:

- Connecting to ADLS Gen 1 Storage account.  
- Connecting to ADLS Gen 2 Storage account with User-assigned Managed Identity.  
- Connecting to ADLS Gen 2 Storage account with:  
    - Shared VNET Synapse Workspace
    - Firewall-enabled Storage account

## Common issues and solutions

| Error | Solution|
|-------|---------|
|"errorMessage":"LSRServiceException is \[{\"StatusCode\":400,\"ErrorResponse\":{\"code\":\"LSRLinkedServiceFailure\",\"message\":\"Could not find Linked Service AzureDataLakeStorage1;| This error appears when a Synapse workspace is associated with a Git repository, Azure DevOps Services, or GitHub and if the artifact (notebook, linked service) isn't published. <br><br>Manually publish your [code changes](/azure/synapse-analytics/cicd/source-control#publish-code-changes) in the collaboration branch to the Synapse service |
| stdout: Exception in thread "main" org.apache.hadoop.fs.FileAlreadyExistsException: Operation failed: "This endpoint does not support BlobStorageEvents or SoftDelete. Disable these account features if you would like to use this endpoint.", 409, HEAD, https://<storageaccountname>.dfs.core.windows.net/scripts/?upn=false&action=getAccessControl&timeout=90| Confirm ADLS Gen 2 storage is configured as [primarily storage](/azure/synapse-analytics/security/how-to-grant-workspace-managed-identity-permissions#step-1-navigate-to-the-adls-gen2-storage-account-in-azure-portal).<br><br>To disable SoftDelete, uncheck [Enable blob soft delete](/azure/storage/blobs/soft-delete-blob-enable?tabs=azure-portal#enable-blob-soft-delete) for the storage account.|

## Troubleshooting 403 issue 

### Storage access and the account accessing it
    
1.  If writing to storage via pipeline, Synapse Workspace MSI is the security principal performing any operation (Read, Write, Delete) on the storage.
    -   Ensure the Workspace MSI account has the Storage Blob Data Contributor role to perform all action.  

1.  If Azure Notebooks is used to access storage account, the logged in account is used unless accessing storage via linked services.
    -   The logged in user account should have the Storage Blob Data Contributor role in order to have full access and permissions. 

1.  If connecting to storage using linked service and Service Principal authenticates, then application registered at Azure Active Directory should be assigned "Storage Blob Data Contributor" on the Azure Storage.

## Role-based access control implementation in storage
    
For role-based access control (RBAC) implementation in storage, details are controlled at the container level. Refer to, [Access control model in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control-model). 
 
### Azure role-based access control

Azure role-based access control uses role assignments to apply sets of permissions to security principals like the Synapse Workspace MSI, Logged in User, or Application register in Azure Active Directory. Roles such as Owner, Contributor, Reader, and Storage Account Contributor permit a security principal to manage a storage account.  

### Access control lists
    
Use Access control lists (ACLs) to apply detailed levels of access to directories and files.

- If data access roles, such as Storage Blob Data Reader or Storage Blob Data Contributor, are found for the security principal, there's a check to confirm the role has the permissions to perform actions (Write, Read, Delete). If so, then according to the container role, the security principal has access to all files and folders. 
  - There are no extra ACL checks on the files or folders.
- If data access role isn't found for the security principal at the storage container level, ACL checks on the files and folders are performed. 

## Resources

- [Troubleshoot connectivity between Azure Synapse Analytics Synapse Studio and storage](/azure/synapse-analytics/troubleshoot/troubleshoot-synapse-studio-and-storage-connectivity)
- [Grant permissions to workspace managed identity](/azure/synapse-analytics/security/how-to-grant-workspace-managed-identity-permissions)
- [Synapse workspace managed Identity](/azure/synapse-analytics/security/synapse-workspace-managed-identity)
- [Security baseline](/azure/synapse-analytics/security-baseline)
- [How permissions are evaluated](/azure/storage/blobs/data-lake-storage-access-control-model#how-permissions-are-evaluated)

