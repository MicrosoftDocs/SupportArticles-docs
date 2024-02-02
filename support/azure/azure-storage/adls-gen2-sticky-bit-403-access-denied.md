---
title: The sticky bit causes a 403 Access Denied authorization error
description: Helps you understand the sticky bit and describes how to check this setting when you configure it in Azure Data Lake Storage (ADLS) Gen2 and get the 403 Access Denied authorization error.
ms.date: 04/17/2023
ms.service: azure-storage
ms.custom: devx-track-azurecli
ms.reviewer: jiajwu, zhangjerry, azurestocic, v-weizhu
---
# 403 Access Denied authorization error when the sticky bit is enabled in ADLS Gen2

This article helps you understand the sticky bit and provides information about how to check this setting when you configure it in Azure Data Lake Storage (ADLS) Gen2 and get issues.

## What is the sticky bit in ADLS Gen2?

ADLS Gen2 users often need to manage permissions for different users, and one way to do this is by using an access control list (ACL). ACL is a POSIX-like access control system with a specific setting called the sticky bit that can cause authorization failures. For more information about the permission control mode and the sticky bit, see [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

The sticky bit is an advanced feature that isn't necessary in the ACL setting of the ADLS Gen2 storage account. Instead, you can use the [mask feature](/azure/storage/blobs/data-lake-storage-access-control#the-mask) to limit the maximum permissions for named users, named groups, and the owning group. This works similarly to the sticky bit and is easily configured in the Azure portal.

## 403 Access Denied authorization error

Consider the following scenario:

- An ADLS Gen2 storage account has a container called *container* and a folder path called *folder/child-folder*.
- You use ACL as an authorization method.
- In the ACL setting of the ADLS Gen2 storage account, you're configured with Execute (X) permission on the root directory and *folder* and with Write and Execute (WX) permission on *child-folder*.
- The sticky bit is enabled on *child-folder*.
- You try to create or upload a new file, for example, *test.txt*, into the ADLS Gen2 Storage Account folder path *container/folder/child-folder/*.

In this scenario, you get a 403 Access Denied authorization error.

This error occurs for two reasons:

- You don't have enough permissions to access the folder path.
- You have enough permissions, but enabling the sticky bit causes you not to be the owner of this folder path.

## Identify whether the sticky bit causes a 403 Access Denied error

Verify the ACL setting of the folder and the parent folders, and then compare it with the [Common scenarios related to ACL permissions](/azure/storage/blobs/data-lake-storage-access-control#common-scenarios-related-to-acl-permissions). If the permissions are enough, then the 403 error may be caused by the sticky bit.

## Verify the sticky bit setting by using Azure CLI

There are many ways to check this setting, such as a REST API call, PowerShell command, and Azure CLI. We recommend the Azure CLI option because it doesn't require any extra software to be installed, and the command is easy to understand.

To verify the sticky bit setting by using Azure CLI, follow these steps:

1. Sign in to the Azure portal with your account. Make sure that this account has the Storage Blob Data Owner role assignment on the ADLS Gen2 storage account.
1. Select **Cloud Shell** from the Azure portal.

    :::image type="content" source="media/adls-gen2-sticky-bit-403-access-denied/cloud-shell-button.png" alt-text="Screenshot of the Cloud Shell button in the Azure portal.":::

1. Use the following command to get the ACL and the sticky bit setting of the *container/folder* directory:

    ```azurecli
    az storage fs access show -p folder -f container --account-name account --auth-mode login
    ```

    To check the ACL and the sticky bit setting of the root directory, which is the container level ACL and the sticky bit setting, use the following command:

    ```azurecli
    az storage fs access show -p / -f container --account-name account --auth-mode login
    ```

    Here's a sample output:

    :::image type="content" source="media/adls-gen2-sticky-bit-403-access-denied/az-storage-fs-access-show-command-output.png" alt-text="Screenshot of the command output example.":::

    In the response JSON body, focus on `permissions`. It normally contains 9 or 10 bits with an extra "+" symbol. For more information about these letters, see [Users and identities](/azure/storage/blobs/data-lake-storage-access-control#users-and-identities).

    The previous example indicates that all user permissions are enabled, and the sticky bit is enabled. For more information about how to read this permission notation, see [Notation of traditional Unix permissions]( https://en.wikipedia.org/wiki/File-system_permissions#Notation_of_traditional_Unix_permissions).

    The ninth letter has four possible values: "-", "x", "t", and "T". If the value of this letter is "t" or "T", it means that the sticky bit is enabled. The "t" is "x" with the sticky bit enabled, and "T" is "-" with the sticky bit enabled.

    "rwxrwxrwt" can be explained by the following:

    - r,w, and x permissions are enabled for the Owner.
    - r,w, and x permissions are enabled for the Owning group.
    - r,w, and x permissions are enabled for Other users, and the sticky bit is enabled.

    To understand it better, here's another example for "rwxr-xr-T":

    - r,w, and x permissions are enabled for the Owner.
    - r and x permissions are enabled for the Owning group.
    - Only r permission is enabled for Other users, and the sticky bit is enabled.

    According to [Short forms for permissions](/azure/storage/blobs/data-lake-storage-access-control#short-forms-for-permissions), short form permission is calculated for every group of three letters ("r" as 4, "w" as 2, and "x "as 1). So, "rw-rwx--x" will be equal to 4+2+0, 4+2+1, 0+0+1, 671. Based on this calculation rule, you only need to add the fourth letter at the beginning. If the sticky bit is enabled, set it as 1. If the sticky bit is disabled, set it as 0.

    Here are some examples:

    - rwxrwxrwt => 1777
    - rwxr-xr-T => 1754
    - rw-rwx--x => 0671

## Disable/Enable the sticky bit setting

To disable/enable the sticky bit setting, set permissions to expected values.

The Azure account used to modify this setting must have the Storage Blob Data Owner role on the target ADLS Gen2 storage account.
There are many possible ways to modify the sticky bit setting. Here are the supported SDKs:

|SDK| Supported version | More information|
|---|---|---|
| REST API| 2019-12-12 and later API versions|[Path](/rest/api/storageservices/datalakestoragegen2/path/update)|
| Az PowerShell module| 5.6.0 and later versions|[Use PowerShell to manage ACLs in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-acl-powershell#set-an-acl)|
|Azure CLI| 2.38.0 and later versions|[Use Azure CLI to manage ACLs in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-acl-cli#update-an-acl)|
| .NET SDK| 12.14.0 and later versions|[Use .NET to manage ACLs in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-acl-dotnet)|
| Java SDK| 12.11.0 and later versions|[Use Java to manage ACLs in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-acl-java)|
| Python SDK| 12.8.0 and later versions|[Use Python to manage ACLs in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-acl-python)|
| JavaScript SDK| 12.11.0-beta.1 and later versions|[Use JavaScript SDK in Node.js to manage ACLs in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-acl-javascript)|
| HDFS CLI| 3.3.3 and later versions|[Using the HDFS CLI with Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-use-hdfs-data-lake-storage#change-the-permissions-of-files) and [Apache Hadoop 3.3.3 – HDFS Permissions Guide](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HdfsPermissionsGuide.html)|

Here's an example of disabling/enabling the sticky bit setting with Azure CLI.

1. Sign in to the Azure portal with your account that has the Storage Blob Data Owner role assignment on the target ADLS Gen2 storage account.
1. Select **Cloud Shell** from the Azure portal.

    :::image type="content" source="media/adls-gen2-sticky-bit-403-access-denied/cloud-shell-button.png" alt-text="Screenshot of the Cloud Shell button in the Azure portal.":::

1. To set the ACL and the sticky bit setting of the *container/folder* directory to the "rwxrwxrwt" permissions and to enable the sticky bit, use the following command:

    ```azurecli
    az storage fs access set --permissions rwxrwxrwt -p folder -f container --account-name account --auth-mode login
    ```

    To modify the setting of the root directory, which is the container level ACL and the sticky bit setting, use the following command:

    ```azurecli
    az storage fs access set --permissions rwxrwxrwt -p / -f container --account-name account --auth-mode login
    ```

    The `{permission notation}` in the previous command can accept both long and short-form notations. This means that the following command is also qualified:

    ```azurecli
    az storage fs access set --permissions 1776 -p folder -f container --account-name account --auth-mode login
    ```

    Here's an example output:

    :::image type="content" source="media/adls-gen2-sticky-bit-403-access-denied/az-storage-fs-access-set-command-output.png" alt-text="Screenshot of the command output sample.":::

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
