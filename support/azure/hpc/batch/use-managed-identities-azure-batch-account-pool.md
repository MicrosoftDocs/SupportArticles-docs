---
title: Use managed identities in an Azure Batch account or pool
description: Use managed identities in an Azure Batch account or pool. Download application packages or retrieve blobs from a batch pool.
ms.date: 11/15/2022
editor: v-jsitser
ms.reviewer: biny, v-leedennis
ms.service: batch
ms.topic: how-to
#Customer intent: As an Azure Batch user, I want to learn how to use managed identities so that I can understand the differences in managed identity usage between a Batch account and a Batch pool.
---
# Use managed identities in an Azure Batch account or pool

This article explains how to use managed identities in a Microsoft Azure Batch account or a batch pool. The article discusses when you should configure managed identities in a batch account versus a batch pool. It also outlines different behavior scenarios because managed identity use can cause confusion in some failure situations.

## Prerequisites

- An [Azure Batch account](/azure/batch/accounts#batch-accounts).
- An [Azure Storage account](/azure/batch/accounts#azure-storage-accounts).
- [Postman](https://www.postman.com/downloads/).

## Set up your storage account to use with your batch account

If you want to set up managed identities in your batch account, you must first set up your storage account so that it's used as your batch account autostorage. This autostorage is used to store the application packages and task resource files. To configure for autostorage, you have to link the storage account to your batch account. You also have to set the autostorage account to use batch account managed identities as its authentication mode.

To complete this setup, follow these steps:

  1. In the [Azure portal][azure-portal], search for and select **Batch accounts**.

  1. In the list of batch accounts, select the name of your batch account.

  1. In the navigation pane of the batch account, locate the **Settings** heading, and then select **Storage account**.

  1. Under the **STORAGE ACCOUNT INFORMATION** section, select **Select a storage account**.

  1. After you finish selecting your storage account, return to the **STORAGE ACCOUNT INFORMATION** section, and change the **Authentication mode** field to **Batch Account Managed Identity**.

## Set up managed identity in your batch account

> [!NOTE]
>
> The interaction that's discussed in this section is between a batch account and Azure Storage or Azure Key Vault. For interaction between batch nodes and other Azure resources, see the next section ([Set up managed identity in your batch pool](#set-up-managed-identity-in-your-batch-pool)).

By configuring managed identity on a batch account, you grant permission for the batch account to authenticate only to other services. This configuration doesn't let you authenticate to batch nodes or batch pool virtual machines (VMs).

You have two options when you configure managed identity in your batch account: enable the system-assigned managed identity or [create a separate user-assigned managed identity](/azure/batch/managed-identity-pools) for the batch account.

To set up managed identity in your batch account, follow these steps:

1. In the [Azure portal][azure-portal], search for and select **Batch accounts**.

1. In the list of batch accounts, select the name of your batch account.

1. In the navigation pane of the batch account, locate the **Settings** heading, and then select **Identity**.

1. In the **Identity type** heading, select either **System assigned** (for a system-assigned managed identity) or **User assigned** (for a user-assigned managed identity).

1. After you finish this configuration, return to the overview page of your batch account. In the **Essentials** section of the page, select **JSON View**. The JSON representation of the managed identity will appear in one of the following formats:

   <details>
   <summary>System-assigned managed identity</summary>

   ```json
       "identity": {
           "principalId": "<principal-guid>",
           "tenantId": "<tenant-guid>",
           "type": "SystemAssigned"
       }
   ```

   </details>

   <details>
   <summary>User-assigned managed identity</summary>

   ```json
       "identity": {
           "type": "UserAssigned",
           "userAssignedIdentities": {
               "/subscriptions/<subscription-guid>/resourceGroups/<resource-group-name>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<user-assigned-identity-name>": {
                   "principalId": "<principal-guid>",
                   "clientId": "<client-guid>"
               }
           }
       }
   ```

   </details>

### Use a managed identity to access your autostorage account

The managed identity feature of your batch account will be used for certain tasks, such as uploading an application package to your batch account. To upload the application package, go to your batch account overview page in the Azure portal, select **Applications** > **Add**, and then follow the portal directions to complete the upload. Azure Batch stores the application package in its autostorage account. Because you previously set the authentication mode of the batch account to **Batch Account Managed Identity**, the system retrieves the credential from the managed identity of your batch account to access the autostorage account.

You might have to check whether the managed identity has enough permissions on the autostorage account. To check for these permissions, follow these steps:

1. In the [Azure portal][azure-portal], search for and select **Storage accounts**.

1. In the list of storage accounts, select the name of your autostorage account.

1. In the navigation pane of the storage account, select **Access Control (IAM)**.

1. On the **Access Control (IAM)** page, select the **Check access** button.

1. In the **Check access** pane, select the **Managed identity** option.

1. In the **Managed identity** field, select the managed identity that you want to view permissions for.

1. In the **Current role assignments** tab, check whether there's an assigned role that has sufficient permissions to upload an application package. If there isn't such a role assignment, the following error message appears in your Azure portal notifications when you try to upload the application package to your batch account:

   > **Upload Error for \<package-name>.zip**
   >
   > File Upload encountered an unexpected error during upload.

If you experience this upload error, check the HTTP Archive (.har) file of the upload request. There will be a POST request that contains a name prefix of `batch` (for example, `batch?api-version=2020-06-01`), and you'll see an HTTP status of **200**. In the payload, you'll notice the actual PUT request that's sent to your batch account. The response to the PUT request will show an HTTP status of **409**. The full error response will resemble the following text:

```http
{responses: [{name: "<response-guid>", httpStatusCode: 409,...}]}
  {responses: [{name: "<response-guid>", httpStatusCode: 409,...}]}
    0: {name: "<response-guid>", httpStatusCode, 409,...}
      content: {error: {code: "AutoStorageNoPermission",...}}
        error: {code: "AutoStorageNoPermission",...}
          code: "AutoStorageNoPermission"
          message: "The managed identity does not have permission to access auto storage account. Please use Azure RBAC to assign the managed identity access to auto storage."
          target: "BatchAccount"
        contentLength: 318
```

This error means that your system-assigned or user-assigned managed identity in your batch account doesn't have enough permission to take actions on the autostorage account.

### Use a managed identity to access your key vault

For information about how to use a managed identity to access an Azure Key Vault, see [Configure customer-managed keys for your Azure Batch account with Azure Key Vault and Managed Identity](/azure/batch/batch-customer-managed-key).

## Set up managed identity in your batch pool

> [!NOTE]
>
> The interaction that's discussed in this section is between a batch node and other Azure resources. For interaction between a batch account and either Azure Storage or Azure Key Vault, see the previous section ([Set up managed identity in your batch account](#set-up-managed-identity-in-your-batch-account)).

If you want to allow Azure Batch nodes to access other Azure resources, use a managed identity that's configured in the Azure Batch pool.

If the authentication mode of the autostorage account is set to **Batch Account Managed Identity**, the Azure Batch nodes receive the managed identity tokens. The nodes use the managed identity tokens to authenticate through Microsoft Entra authentication by using the Azure Instance Metadata Service (IMDS).

The Azure batch pool supports only the user-assigned version of managed identity. Therefore, you'll have to [create a user-assigned managed identity][manage-user-assigned-managed-identities] in the same tenant as your Azure Batch account. Also, you'll have to grant permission in the [storage data plane](/azure/azure-resource-manager/management/control-plane-and-data-plane#data-plane) (for example, through the [Storage Blob Data Owner](/azure/role-based-access-control/built-in-roles#storage-blob-data-owner)) to the user-assigned managed identity.

### Associate managed identity to the node that accesses the autostorage account

For the user-assigned identity that the compute nodes use to access autostorage, you must assign this identity reference to pools that have compute nodes that need access to autostorage. (Details about this requirement are described in the REST API for the [Batch Account - Update's AutoStorageBaseProperties][AutoStorageBaseProperties], in the `nodeIdentityReference` property.) Therefore, you have to configure your node identity reference in two places on the Azure portal:

- The **Node identity reference** in the batch account autostorage account

- The **User assigned managed identity** in the batch pool

> [!IMPORTANT]
>
> You can define more than one user-assigned managed identity in the pool identity. However, the one that's defined in the node identity reference must also be defined in the pool identity.

#### Set up the autostorage account's node identity reference

To set up the node identity reference in your autostorage account, follow these steps:

1. In the [Azure portal][azure-portal], search for and select **Batch accounts**.

1. In the list of batch accounts, select the name of your batch account.

1. In the navigation pane of the batch account, locate the **Settings** heading, and then select **Storage account**.

1. Under the **STORAGE ACCOUNT INFORMATION** section, select **Select a storage account**, and then select your autostorage account.

1. Go to the **Node identity reference** heading, and then select **Add**.

1. Complete the process for adding your new user-assigned node identity reference.

#### Set up the batch pool's user-assigned managed identity

To set up the user-assigned managed identity in your batch pool, follow these steps:

1. In the [Azure portal][azure-portal], search for and select **Batch accounts**.

1. In the list of batch accounts, select the name of your batch account.

1. In the navigation pane of the batch account, locate the **Features** heading, and then select **Pools**.

1. In the batch pool page, select **Add**.

1. In the **Add pool** page, enter a **Pool ID**. In the **Identity** field, select **User assigned**.

1. Locate the **User assigned managed identity** heading, and then select **Add**.

1. Complete the process for adding the node identity reference that you previously created to the batch pool.

### Use cases for managed identity in a batch node

You can use managed identity within a batch node in different ways, such as for the following features:

- Download application packages from a batch pool
- Download task resource files from a batch pool

### Download application packages from a batch pool

When you create a batch pool, you can specify application packages at the pool level. The application packages will be downloaded from the autostorage account and installed in all nodes in this pool. For more information, see [Upload and manage applications][upload-manage-apps]. Upload the application packages to the batch account before you refer to them during the creation of the batch pool. To add application packages to your batch pool, go to the **Add pool** page of your batch account, locate the **OPTIONAL SETTINGS** heading, and then select **Application packages**.

#### Behavior scenarios

This section outlines the node operational status and the status of the application package download for the following managed identity parameters:

- Whether the managed identity is given in the node identity reference

- Whether the managed identity has sufficient permissions in the autostorage account

- Whether the batch pool was created by using the same managed identity or a different managed identity

In the Azure portal, you can find the node and package download states in the overview page of the batch node. To get to this page, locate the **General** heading of the batch pool's navigation pane, select **Nodes**, and then select the name of the node that you want to see.

The following table outlines four behavior scenarios that involve managed identity and application packages within a batch pool.

| Scenario number | Managed identity usage | Managed identity permissions in the autostorage account | Pool creation specification | Node status | Package download status |
|---|---|---|---|---|---|
| 1 | Given in node identity reference | Sufficient permissions | Created in pool by using the same managed identity | Started successfully | Downloaded to the node in the *root/applications* directory |
| 2 | Given in node identity reference | Insufficient permissions | Created in pool by using the same managed identity | Started successfully, but in the **Idle** state | Not downloaded to the node |
| 3 | Not given in node identity reference | Sufficient or insufficient permissions | Created in pool by using the same or a different managed identity | Stuck indefinitely in the **Starting** state | Not downloaded to the node |
| 4 | Given in node identity reference | Sufficient or insufficient permissions | Created in pool by using a different managed identity | **Unusable** state | Not downloaded to the node |

In Scenario 3, when the Azure Batch service tries to start the node, the node identity reference becomes null. This causes the node to remain stuck in a **Starting** state. To verify this status, go to the batch pool node **Overview** page, and then select **Upload batch logs** to upload the batch logs to a storage container. In the **Upload batch logs** pane, select your Azure Storage container, select the **Pick storage container** button, and then select and download the *agent-debug.log* file from your storage container. The log file will contain multiple entries that have the "pool not fully joined yet, health=Status.TvmJoinPoolInProgress" message.

In Scenario 4, you can define more than one managed identity when you create the batch pool. What if the managed identity that you define in the node identity reference isn't added to the pool identity? In that case, the Azure Batch service can't find the correct managed identity that matches the one that's defined in the node reference. Instead, the service will display the following node error message:

> Node has 1 error(s).
>
> There was an error encountered on the node
>
> **Code:** ApplicationPackageError
>
> **Message:**  
> One or more application packages specified for the pool are invalid

### Download task resource files from a batch pool

While you create a task, you can specify resource files to use in the task. These files are downloaded automatically to the node from the autostorage account before the task command is run. For more information, see [Tasks in Azure Batch][azure-batch-tasks]. To specify task resource files, follow these steps:

1. In the [Azure portal][azure-portal], search for and select **Batch accounts**.

1. In the list of batch accounts, select the name of your batch account.

1. In the navigation pane of your batch account, locate the **Features** heading, and select **Jobs**.

1. In the **Jobs** page, select **Add**.

1. Fill out the required fields in the **Add jobs** pane, and then select **OK**.

1. In the navigation pane of your batch job, locate the **General** heading, and then select **Tasks**.

1. On the **Tasks** page, select **Add**.

1. In the **Add Tasks** pane, fill out any required fields. Then, locate the **ADVANCED SETTINGS** heading, and select **Resource files**.

   :::image type="content" source="./media/use-managed-identities-azure-batch-account-pool/add-task.png" alt-text="Azure portal screenshot of the Add task pane in an Azure Batch account Jobs page.":::

You can specify the resource files by using the methods that are described in the following table.

| Method | Notes |
|---|---|
| Autostorage container | The identity reference appears as **None**, and it can't be modified. The node accesses the autostorage account to retrieve resource files. |
| Container URL or HTTP URL | You can define another Azure Storage account's URL if enough permissions were configured in that Azure Storage account for the identity reference, and the identity was added to the batch pool. |

If you need access to the autostorage account, the identity must be defined in both the node identity reference and the pool identity.

When you specify the resource file definitions, the **Blob prefix** and **File path** parameters are optional. The blob prefix is used to filter specific blobs. The file path is used to create a subfolder in the node for storing the blob files. If the file path isn't defined, the files will be stored in the path for each task (*root/wd*).

| Resource file type | Value | Blob prefix | File path | File mode (Linux only) | Identity reference |
|---|---|---|---|---|---|
| AutoStorageContainerName | \<name-of-app> |  | mypath1 |  |  |
| StorageContainerUrl | https://\<account-name>.blob.core.windows.net/con |  | mypath2 |  | /subscriptions/\<subscription-guid>/resourceGroups/\<resource-group-name>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/\<user-assigned-identity-name> |
| HttpUrl | https://\<account-name>.blob.core.windows.net/con/api.crt |  | mypath3 |  | /subscriptions/\<subscription-guid>/resourceGroups/\<resource-group-name>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/\<user-assigned-identity-name> |

#### Behavior scenarios

The following table outlines four behavior scenarios that might occur when you use managed identity to create a batch pool and then create a task that has resource files to retrieve a blob from an autostorage container.

| Scenario number | Managed identity usage | Managed identity permissions in the autostorage account | Pool creation specification | Result |
|---|---|---|---|---|
| 1 | Given in node identity reference | Sufficient permissions | Created in pool by using the same managed identity | Blob file is successfully downloaded to the node in the *root/wd/\<file-path>* directory, as shown in the task overview page |
| 2 | Given in node identity reference | Insufficient permissions | Created in pool by using the same managed identity | Task fails because of a **ResourceContainerAccessDenied** error, error message "Access for one of the specified Azure Blob container(s) is denied" |
| 3 | Not given in node identity reference | Sufficient or insufficient permissions | Created in pool by using the same or a different managed identity | Task fails because of a **ResourceContainerAccessDenied** error, error message "Access for one of the specified Azure Blob container(s) is denied" |
| 4 | Given in node identity reference | Sufficient or insufficient permissions | Created in pool by using a different managed identity | Task fails because of a **ResourceContainerListMiscError** error, error message "Miscellaneous error encountered while listing one of the specified Azure Blob container(s)" |

In scenarios in which the blob retrieval task fails, go to the **Tasks** page of the Azure portal, and then select the name of the task that appears next to the error code. Then, in the task page's navigation pane, locate the **General** heading, select **Properties**, and then select **Json View**. The JSON display of properties will show the corresponding error message and other details about the failed task. For example, in scenario 4, the **ResourceContainerListMiscError** error fails because of an "HTTP 400 Bad Request" error. This is because the managed identity that's defined in the node identity reference doesn't match any of the managed identities that are defined in the pool identity configuration.

## Verify that your managed identity can access Azure resources

To verify in Windows that a managed identity that's assigned an Azure Batch node has enough permissions to access Azure resources (such as a storage account), follow these steps:

> [!NOTE]
>
> This procedure emulates the last step that you need to do to get a token that has a valid identity ID to access the storage account and check for sufficient permissions. If the identity isn't defined in the node identity reference, the node can't get the identity ID. In that case, the whole process is already blocked before you can execute the last step. Before you do this procedure, verify that the identity is defined in the node identity reference.

1. Use Remote Desktop Protocol (RDP) to connect to the node.

1. In Postman, send a GET request that contains the `Metadata: true` header to the following URL:

   > http\://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https\://storage.azure.com/&mi_res_id=**/subscriptions/\<subscription-guid>/resourceGroups/\<resource-group-name>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/\<user-assigned-identity-name>**

   The `169.254.169.254` IP address is also known as the [Azure Instance Metadata Service][azure-instance-metadata-service] (IMDS). IMDS provides information about the VM instance. If you have this VM instance information, you can use the VM to request tokens for managed identity.

   The `mi_res_id` parameter value in the URL is bolded. This is the resource ID of the user-assigned managed identity that you defined in the pool identity. To find that resource ID, together with the client ID and the principal ID, follow these steps:

   1. In the [Azure portal][azure-portal], search for and select **Batch accounts**.
   1. In the list of batch accounts, select the name of your batch account.
   1. In the navigation pane of the batch account, locate the **Features** heading, and then select **Pools**.
   1. In the list of batch pools, select the name of your batch pool.
   1. In the navigation pane of the batch pool, locate the **General** heading, and then select **Properties**.
   1. On the pool properties page, select **Json view**.
   1. In the JSON text, locate the `identity`/`userAssignedIdentities` list. For the user-assigned managed identity that you're using, copy the values for the following properties:

      - `resourceId`
      - `clientId` (a GUID)
      - `principalId` (a GUID)

   After you send the URL in Postman, the **Body** of the JSON response will contain entries for `access_token` (a long text string, also known as the bearer token) and `client_id` (a GUID). The `client_id` response value should match the `clientId` value that you copied from the batch pool properties page.

   > [!WARNING]
   >
   > Did you define more than one managed identity in the pool identity, but not specify a managed identity in the URL? In that case, Postman displays a **400 Bad Request** status:
   >
   > :::image type="content" source="./media/use-managed-identities-azure-batch-account-pool/postman-400-bad-request.png" alt-text="Postman screenshot of a 400 Bad Request status if you have defined many managed identities in the pool identity but didn't specify one." lightbox="./media/use-managed-identities-azure-batch-account-pool/postman-400-bad-request.png":::

1. Copy the full bearer token, and then test it in Postman by retrieving the blob from your autostorage account. In this example, the managed identity doesn't have permission to access the storage. Therefore, the autostorage account responds by returning an HTTP 403 error (AuthorizationPermissionMismatch error, message "This request is not authorized to perform this operation using this permission").

   > [!NOTE]
   >
   > The **x-ms-version** header is required to retrieve the blob. For more information, see the [Azure Storage Get Blob API][get-blob-rest-api].

   :::image type="content" source="./media/use-managed-identities-azure-batch-account-pool/postman-403-not-authorized.png" alt-text="Postman screenshot of a 403 AuthorizationPermissionMismatch status if your managed identity isn't authorized to access the autostorage account." lightbox="./media/use-managed-identities-azure-batch-account-pool/postman-403-not-authorized.png":::

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[azure-portal]: https://portal.azure.com
[manage-user-assigned-managed-identities]: /azure/active-directory/managed-identities-azure-resources/how-manage-user-assigned-managed-identities
[AutoStorageBaseProperties]: /rest/api/batchmanagement/batch-account/update#autostoragebaseproperties
[upload-manage-apps]: /azure/batch/batch-application-packages#upload-and-manage-applications
[azure-batch-tasks]: /azure/batch/jobs-and-tasks#tasks
[azure-instance-metadata-service]: /azure/virtual-machines/windows/instance-metadata-service
[get-blob-rest-api]: /rest/api/storageservices/get-blob
