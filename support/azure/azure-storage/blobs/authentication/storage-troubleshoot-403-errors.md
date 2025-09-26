---
title: Troubleshoot 403 Errors (Azure Blob Storage)
description: A comprehensive troubleshooting guide for resolving HTTP 403 errors when accessing Azure Blob Storage, covering authentication, authorization, network restrictions, and configuration issues.
ms.date: 09/24/2025
ms.service: azure-blob-storage
author: JarrettRenshaw
ms.author: jarrettr
ms.custom: sap:Authentication and Authorization
ms.reviewer: normesta, v-ryanberg
---

# Troubleshoot 403 errors in Azure Blob Storage

When accessing Azure Blob Storage, you might encounter HTTP 403 errors that prevent clients from reading, writing, or managing data. These errors can result from a variety of configuration or authorization issues, including role assignments, token settings, network restrictions, encryption policies, and more. This article provides a comprehensive checklist and troubleshooting guidance to help you identify the root cause of 403 errors and resolve them efficiently.

## About 403 errors

A *403 error* is an HTTP status code that includes the string `403` (for example, `Forbidden (403)`). Each 403 error is accompanied by a more specific error code, such as `UnauthorizedBlobOverwrite` or `QueryParameterSasMandatory`. These detailed error codes can help you narrow down the cause of the issue. The following articles describe the most common types of 403 errors:

- [Azure Blob Storage error codes](/rest/api/storageservices/blob-service-error-codes)

- [Common REST API error codes](/rest/api/storageservices/common-rest-api-error-codes)

- [Common Error Codes for Storage Resource Provider](/rest/api/storagerp/srp_error_codes_common)

- [Shared access signature error codes](/rest/api/storageservices/SAS-Error-Codes)

A 403 error can result from either *Control Plane* or *Data Plane* operations. Control plane operations are Azure Resource Manager requests, such as creating a storage account or updating its properties. Data plane operations involve requests to the storage service endpoint, such as uploading or downloading blobs. You can use Azure resource logs to find error details, including information about the security principal, key, or SAS used for authorization.

## Common errors related to authentication failures

Authentication failures occur when there are issues with credentials, tokens, or authentication methods.  

| Error | Causes and solutions |
|--------------|----------|
| **Error message**<br>Server failed to authenticate the request. Make sure the value of Authorization header is formed correctly including the signature.<br><br>**Error code**<br>AuthenticationFailed<br><br>**Error detail**<br>Signed expiry time `<date>` has to be after signed start time `<date>` | **Expired token**: The SAS token has passed its expiration time. Generate a new SAS token with a future expiration time.<br><br>**Clock skew**: Time differences between systems can make tokens appear expired early. Consider adding buffer time to expiration.<br><br>**Start time in future**: Avoid setting a start time if the SAS is for immediate use.|
| **Error message**<br>Server failed to authenticate the request. Make sure the value of Authorization header is formed correctly including the signature.<br><br>**Error code**<br>AuthenticationFailed<br><br>**Error detail**<br>The MAC signature found in the HTTP request 'xyz...' is not the same as any computed signature.| **Wrong account key**: Verify you're using the correct primary or secondary key for the storage account.<br><br>**Regenerated keys**: If storage access keys were recently regenerated, update your application with the new key.<br><br>**Encoding issues**: Ensure the account key is properly encoded and formatted.|
| **Error message**<br>Server failed to authenticate the request. Make sure the value of Authorization header is formed correctly including the signature.<br><br>**Error code**<br> AuthenticationFailed<br><br>**Error detail**<br>SAS field 'sv' is not well formed. | **Invalid SAS format**: Use official Azure SDKs or tools like Storage Explorer to generate SAS tokens.<br><br>**Manual construction errors**: If constructing SAS tokens manually, verify all required fields and their formats.<br><br>**Version mismatch**: Ensure the `sv` (version) parameter matches your Storage Client Library version.|
| **Error message**<br>Server failed to authenticate the request. Make sure the value of Authorization header is formed correctly including the signature.<br><br>**Error code**<br>AuthenticationFailed<br><br>**Error detail**<br>The specified signed resource is not allowed for the this resource level | **Service vs Account SAS**: You're using a service SAS (for specific blobs/containers) for account-level operations.<br><br>**Scope mismatch**: Generate the appropriate SAS type for your operation. Use an account SAS for account-level operations (list containers), and use a service SAS for specific blob/container operations. |
| **Error message**<br>Key based authentication is not permitted on this storage account.<br><br>**Error code**<br>KeyBasedAuthenticationNotPermitted | **Policy restriction**: The storage account has been configured to disallow shared key authentication.<br><br>**Switch to Azure AD**: Use Azure Active Directory (Entra ID) authentication instead of account keys.<br><br>**Enable shared key**: If needed, re-enable shared key access in the storage account configuration. |

## Common errors related to authorization failures

Authorization failures occur when a client has valid credentials, but insufficient permissions for the requested operation.

| Error                                                                    | Causes and solutions                                                                          |
|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| **Error message**<br>This request is not authorized to perform this operation using this permission.<br><br>**Error code**<br>AuthorizationPermissionMismatch | **Missing permissions**: The SAS token doesn't include the required permission (read, write, delete, list).<br><br>**Operation requirements**: Some operations require multiple permissions (e.g., overwriting a blob requires both write and delete).<br><br>**Check SAS permissions**: Verify the `sp` (permissions) field in your SAS token includes all necessary permissions.<br><br>**Insufficient Azure RBAC role**: The user or service principal lacks the required role for the operation.<br><br>For read operations, use Storage Blob Data Reader.<br>For write operations, use Storage Blob Data Contributor.<br>For management operations, use Storage Blob Data Owner.<br><br>**Role assignment scope**: Ensure roles are assigned at the appropriate scope (subscription, resource group, storage account, or container). |
| **Error message**<br>This request is not authorized to perform this operation using this service.<br><br>**Error code**<br>AuthorizationServiceMismatch    | **Wrong service type**: The SAS token was created for a different Azure Storage service.<br><br>**Service field mismatch**: Check the `ss` (services) field in your SAS token.<br>Use `b` for Blob service<br>Use `f` for File service<br>Use `q` for Queue service<br>Use `t` for Table service. |
| **Error message**<br>This request is not authorized to perform this operation<br><br>**Error code**<br>AuthorizationFailure | **Public network access disabled**: The storage account doesn't allow public network access.<br><br>**IP address restrictions**: Your IP address isn't included in the allowed IP ranges.<br><br>**Virtual network restrictions**: Access is restricted to specific virtual networks or subnets.<br><br>**Firewall rules**: Storage account firewall is blocking your request.|

## Comprehensive diagnostic checklist

If you receive an error other than those described in the previous sections or the causes and solutions described in those sections hasn't helped you to resolve your error, then use this checklist as a guide to identify the cause and to find a solution.

> [!div class="checklist"]
>
> - **Secure file transfer** - If secure transfer is required, make sure that requests are made over HTTPS. (**[Learn more](/azure/storage/common/storage-require-secure-transfer)**).
>
> - **Azure role-based access control**: Verify the security principal has the correct Azure RBAC role. (**[Learn more](/azure/storage/blobs/assign-azure-role-data-access)**).
>
> - **Shared access signature (SAS) tokens**: Check token expiration, permissions, and generation method. (**[Read more](#sas-tokens)**).
>
> - **User delegation SAS**: Confirm required fields, permissions, and key status for user delegation SAS. (**[Read more](#user-delegation-sas-tokens)**).
>
> - **Stored access policies**: Review stored access policy settings and the propagation delay. (**[Read more](#stored-access-policies)**).
>
> - **Access control lists (ACLs)**: Ensure ACL entries and permissions are correct for the client. (**[Read more](#access-control-lists-acls)**).
>
> - **Shared Key authorization**:  If using an account key, confirm that Shared Key authorization is allowed. (**[Learn more](/azure/storage/common/shared-key-authorization-prevent)**).
>
> - **Public network endpoint**: Check public endpoint access, firewall rules, and network security perimeter. (**[Read more](#public-network-endpoint)**).
>
> - **Private endpoints**: Validate private endpoint subnet and resource configuration. (**[Read more](#private-endpoints)**).
>
> - **Encryption scopes**: Review encryption scope settings and customer-managed key status. (**[Read more](#encryption-scopes)**).
>
> - **Disabled accounts**: Confirm the storage account or subscription is not disabled. (**[Read more](#disabled-accounts)**).
>
> - **Azure DataBricks and Azure RBAC**: Scope roles to the resource group, account, or container. (**[Read more](#azure-databricks-and-azure-rbac-role-assignments)**).
>
> - **Check scope of copy operations**: Check if the account settings restrict the scope of copy operations. (**[Learn more](/azure/storage/common/security-restrict-copy-operations)**).

### SAS tokens

Common causes of 403 errors when using SAS tokens include:

- **Inappropriate SAS token expiration or start time:** The SAS token's expiration and start times aren't set correctly for the intended usage.

- **Missing permissions:** Not all necessary permissions are selected for the SAS token.

- **Insufficient permissions:** The client attempts an operation that isn't permitted by the SAS token. For example, the client attempts to write to a blob with a SAS that permits only read operations. Some actions require extra permission. For example, for a client to overwrite a blob, the SAS token must permit both write and delete permission.

- **Token generation method:** The SAS token wasn't generated using an official SDK or tool (such as Storage Explorer). To avoid errors in the signature string, consider using official SDKs to generate SAS tokens. If you construct SAS tokens manually, use the latest storage service version and libraries. See [Delegating Access with a Shared Access Signature](/rest/api/storageservices/delegate-access-with-shared-access-signature).

- **Expired SAS token:** The client is using a SAS token that is expired.

- **Clock skew:** There are small time differences between the host generating the SAS and the storage service, causing the SAS to be invalid or expire earlier than expected.

- **Incorrect SAS start time:** Avoid setting a start time if the SAS is for immediate use, as clock differences can make the SAS not yet valid.

- **Short expiry time:** Setting a short expiry time can result in premature expiration due to clock differences.

- **Version mismatch:** The `sv` (version) parameter in the SAS token should match the version of the Storage Client Library in use. Always use the latest library version.

- **Regenerated access keys:** If storage access keys are regenerated, any existing SAS tokens might be invalidated, especially those with long expiry times.

- **Malformed signature:** The SAS or shared key signature is incorrectly formed, encoded, or contains invalid parameters.

- **Unauthorized IP address:** The request originates from an IP not authorized by the SAS token. Verify the "sip" field matches the client's IP address.

- **Interference by a storage access policy** Container with stored access policies can override the permission given by a SAS. For example, a stored access policy on a container might revoke permission earlier than the SAS expiry date and time.

See [Best practices when using SAS](/azure/storage/common/storage-sas-overview#best-practices-when-using-sas).

### User delegation SAS tokens

Common causes of 403 errors when associated with user delegation SAS tokens include:

- **Required fields missing:** Ensure all mandatory fields specific to User delegation SAS are present: `skoid`, `sktid`, `skt`, and `ske`. If any are missing, authentication fails.

- **Unsupported API version:** Only REST API versions later than "2018-11-09" are supported for User delegation SAS.

- **Invalid token:** The SAS token's start (`st`) and end (`se`) times must be within the delegation key's start (`skt`) and end (`ske`) times.

- **Request timing:** The request start time must be within the SAS token's valid time window.

- **Signature mismatch:** The SAS signature provided by the client must match the signature generated by the storage service. For example, a SAS created for container X fails if used to access container Y.

- **Insufficient SAS permission:** The SAS token must permit the requested operation. For example, a "Read" permission can't be used for a "Write" request. Check the "sp" field.

- **Insufficient Azure RBAC role:** The user must have the necessary Azure role for the requested operation. For example, a write operation requires the Storage Blob Data Contributor role.

- **OAuth authentication:** Ensure OAuth (Azure RBAC) authorization passes for the requested operation.

- **Revoked key** - The request is made after the User delegation key is revoked or has expired.

See [Create a user delegation SAS](/rest/api/storageservices/create-user-delegation-sas).

### Stored access policies

When using stored access policies, review the following items:

- **Policy settings** The permissions, start time, and expiration time defined in the stored access policy are correct for your scenario.

- **SAS token** The SAS token associated with the policy matches the intended permissions and time window.

After applying or updating a stored access policy, allow up to 30 seconds for the policy to take effect. During this interval, any SAS associated with the policy might fail with a 403 (Forbidden) error until the policy becomes active.

To learn more, see [Define a stored access policy](/rest/api/storageservices/define-stored-access-policy).

### Access control lists (ACLs)

When using ACLs to authorize access to files and directories, review the following items:

- **Security principal membership** The security principal used by the client must appear in an ACL entry for the target file or directory. If the ACL entry includes only security groups, the principal must be a member of one of those groups.

- **Correct permissions** The ACL entry associated with the security principal grants the appropriate permission level for the intended operation.

- **Sticky bit is not set** ACLs have a setting called the sticky bit, which can also cause 403 errors. If the sticky bit is enabled on a directory, only the child item's owner, the directory's owner, or the Superuser ($superuser) can delete or rename child items. To learn more, see [403 Access Denied authorization error when the sticky bit is enabled in ADLS Gen2](adls-gen2-sticky-bit-403-access-denied.md).

For more information about ACLs, see [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

### Public network endpoint

If the client receives a 403 error when accessing a storage account through its public endpoint, review the following items.

- **Firewall rules** If firewall rules are enabled, ensure the client is making requests from an allowed IP address or subnet. If the storage account allows traffic only from a specific virtual network subnet, any attempt to access data from a public network is forbidden. For example, if a user tries to access the storage account from the Azure portal (which uses the browser's network) or from a local machine, a 403 error appears unless you add the IP address of the browser network or local machine to the IP address rules. See [Azure Storage firewall rules](/azure/storage/common/storage-network-security).

- **Source and destination access** For operations that copy data between storage accounts, the client must have network access to both the source and destination accounts.

- **Azure service access** If the 403 error originates from other services which need to interact with your storage account's backend, confirm the service is added as an allowed [resource instance](/azure/storage/common/storage-network-security-resource-instances) or that a network security exception for trusted Azure services is configured. See [Trusted Azure services](/azure/storage/common/storage-network-security-trusted-azure-services).

- **Network security perimeter rules** If the storage account is part of a network security perimeter, those rules override firewall settings. Even if the client is allowed by the firewall, a restrictive network security perimeter rule can still result in a 403 error. Enable resource logs to identify which rule is causing the issue. See [Diagnostic logs for Network Security Perimeter](/azure/private-link/network-security-perimeter-diagnostic-logs).

- **Service endpoint policies** If a service endpoint policy is defined for the resource group, subscription, or storage account, review the policy rules. Either remove the policy or ensure the storage account is included. Changes to service endpoint policies can take up to 15 minutes to take effect. See [Virtual network service endpoint policies for Azure Storage](/azure/virtual-network/virtual-network-service-endpoint-policies-overview).

### Private endpoints

If the client receives a 403 error when accessing a storage account through a private endpoint, review the following items.

- **Domain Name System (DNS) settings** Make sure that the DNS resolution of the storage account name resolves to a private IP address. It's possible that a DNS configuration might be resolving the storage account to the public endpoint. Update the DNS configuration so that clients in the network actually get to the private endpoint. See [DNS changes for private endpoints](/azure/storage/common/storage-private-endpoints#dns-changes-for-private-endpoints).

- **Hub virtual network connectivity** For copying blobs between storage accounts with private endpoints in different spoke virtual networks from a VM in a Hub virtual network, ensure network connectivity and review error logs for `CannotVerifyCopySource`. See [Copy blobs between storage accounts in a Hub-spoke architecture using private endpoints](../connectivity/copy-blobs-between-storage-accounts-network-restriction.md).

- **Private endpoints for each storage resource** Ensure the storage account has private endpoints for both the Data Lake Storage resource and the Blob Storage resource. Some operations might be redirected between endpoints, requiring both to be present.

- **Source and destination access** When copying blobs between storage accounts, the client must have network access to both accounts. If using private link for only one account, ensure network access to the other account as well.

For general troubleshooting, see [Troubleshoot Azure Private Endpoint connectivity problems](/azure/private-link/troubleshoot-private-endpoint-connectivity).

### Encryption scopes

When using encryption scopes, review the following items.

- **Encryption scope override setting** If a container enforces a default encryption scope and overrides are prohibited, uploading a blob with a different encryption scope results in a 403 error. The override prohibition can only be set when the container is created. To learn more, see [Create a container with a default encryption scope](/azure/storage/blobs/encryption-scope-manage#create-a-container-with-a-default-encryption-scope). To check if overrides are prohibited, examine the container properties. See [Manage blob containers using PowerShell](/azure/storage/blobs/blob-containers-powershell) or [Manage blob containers using Azure CLI](/azure/storage/blobs/blob-containers-cli).

- **Disabled key** If an encryption scope is protected by a customer-managed key and the key is disabled, all access attempts to data in that container fail with a 403 error. See [Revoke access to a storage account that uses customer-managed keys](/azure/storage/common/customer-managed-keys-overview#revoke-access-to-a-storage-account-that-uses-customer-managed-keys).

### Disabled accounts

A 403 error can occur if you attempt to access data in a storage account or subscription that is disabled. Common reasons for a disabled subscription include expired credit, reaching a spending limit, overdue bills, exceeding your credit card limit, or the Account Administrator canceling the subscription.

### Azure Databricks and Azure RBAC role assignments

A 403 error can occur if your subscription includes an Azure Databricks namespace. Roles scoped to the subscription don't grant access to blob and queue data. Assign roles at the resource group, storage account, container, or queue level instead.

## See also

- [Auditing control plane operations](/azure/storage/blobs/blob-storage-monitoring-scenarios#auditing-control-plane-operations)
- [Auditing data plane operations](/azure/storage/blobs/blob-storage-monitoring-scenarios#auditing-data-plane-operations)
