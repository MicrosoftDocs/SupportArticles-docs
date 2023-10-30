---
title: Troubleshoot problems with AzCopy (Azure Storage)
description: Provides workarounds to common issues with AzCopy v10.
ms.service: azure-storage
ms.subservice: storage-common-concepts
ms.date: 10/30/2023
ms.reviewer: normesta, azurestocic, jarrettr, v-weizhu
---

# Troubleshoot problems with AzCopy v10

This article describes common issues you might encounter while using AzCopy, helps you identify the causes of those issues, and then suggests ways to resolve them.

## Identifying problems

You can determine whether a job succeeds by looking at the exit code.

If the exit code is `0-success`, the job completed successfully.

If the exit code is `1-error`, examine the log file. Once you understand the exact error message, it becomes much easier to search for the right keywords and figure out the solution. To learn more, see [Find errors and resume jobs by using log and plan files in AzCopy](/azure/storage/common/storage-use-azcopy-configure).

If the exit code is `2-panic`, check that the log file exists. If the file doesn't exist, file a bug or reach out to support.

If the exit code is any other non-zero exit code, it may be an exit code from the system. For example, `OOMKilled`. Check your operating system documentation for special exit codes.

## 403 errors

It's common to encounter 403 errors. Sometimes they're benign and don't result in a failed transfer. For example, in AzCopy logs, you might see that a `HEAD` request received 403 errors. Those errors appear when AzCopy checks whether a resource is public. In most cases, you can ignore those instances.

In some cases, 403 errors can result in a failed transfer. If this happens, other attempts to transfer files will likely fail until you resolve the issue. 403 errors can occur as a result of authentication and authorization issues. They can also occur when requests are blocked due to the storage account firewall configuration.

### Authentication/Authorization issues

403 errors that prevent data transfer occur because of issues with SAS tokens, role-based access control (Azure RBAC) roles, and access control list (ACL) configurations.

#### SAS tokens

If you're using a shared access signature (SAS) token, verify the following:

- The expiration and start times of the SAS token are appropriate.

- You selected all the necessary permissions for the token.

- You generated the token by using an official SDK or tool. Try Storage Explorer if you haven't already.

#### Azure RBAC

If you're using Azure RBAC roles via the `azcopy login` command, verify that you have the appropriate Azure roles assigned to your identity (for example, the Storage Blob Data Contributor role).

To learn more about Azure roles, see [Assign an Azure role for access to blob data](/azure/storage/blobs/assign-azure-role-data-access).

#### ACLs

If you're using access control lists (ACLs), verify that your identity appears in an ACL entry for each file or directory you intend to access. Also, make sure that each ACL entry reflects the appropriate permission level.

To learn more about ACLs and ACL entries, see [Access control lists (ACLs) in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).

To learn more about how to incorporate Azure roles together with ACLs and how the system evaluates them to make authorization decisions, see [Access control model in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control-model).

### Firewall and private endpoint issues

If the storage firewall configuration isn't configured to allow access from the machine where AzCopy is running, AzCopy operations will return an HTTP 403 error.

#### Transfer data from or to a local machine

If you're uploading or downloading data between a storage account and an on-premises machine, make sure that the machine that runs AzCopy is able to access either the source or destination storage account. You might have to use IP network rules in the firewall settings of either the source or destination accounts to allow access from the public IP address of the machine.

#### Transfer data between storage accounts

403 authorization errors can prevent you from transferring data between accounts by using the client machine where AzCopy is running.

If you're copying data between storage accounts, make sure that the machine that runs AzCopy is able to access both the source and the destination account. You might have to use IP network rules in the firewall settings of both the source and destination accounts to allow access from the public IP address of the machine. The service will use the IP address of the AzCopy client machine to authorize the source to destination traffic. To learn how to add a public IP address to the firewall settings of a storage account, see [Grant access from an internet IP range](/azure/storage/common/storage-network-security#grant-access-from-an-internet-ip-range).

In case your VM doesn't or can't have a public IP address, consider using a private endpoint. See [Use private endpoints for Azure Storage](/azure/storage/common/storage-private-endpoints).

#### Use Private Link

[Private Link](/azure/private-link/private-link-overview) is at the virtual network (VNet)/subnet level. If you want AzCopy requests to go through Private Link, then AzCopy must make those requests from a VM running in that VNet/subnet. For example, if you configure Private Link in VNet1/Subnet1 but the VM on which AzCopy runs is in VNet1/Subnet2, AzCopy requests won't use Private Link, and they're expected to fail.

## Proxy-related errors

If you encounter TCP errors such as "dial tcp: lookup proxy.x.x: no such host," it means that your environment isn't configured to use the correct proxy or you're using an advanced proxy AzCopy doesn't recognize.

You need to update the proxy settings to reflect the correct configurations. See [Configure proxy settings](/azure/storage/common/storage-ref-azcopy-configuration-settings?toc=/azure/storage/blobs/toc.json#configure-proxy-settings).

You can also bypass the proxy by setting the environment variable `NO_PROXY="*"`.

Here are the endpoints that AzCopy needs to use:

| Log in endpoints | Azure Storage endpoints |
|---|---|
| `login.microsoftonline.com` (global Azure) | `(blob | file | dfs).core.windows.net` (global Azure) |
| `login.chinacloudapi.cn` (Azure China) | `(blob | file | dfs).core.chinacloudapi.cn` (Azure China) |
| `login.microsoftonline.de` (Azure Germany) | `(blob | file | dfs).core.cloudapi.de` (Azure Germany) |
| `login.microsoftonline.us` (Azure US Government) | `(blob | file | dfs).core.usgovcloudapi.net` (Azure US Government) |

## x509: certificate signed by unknown authority

This error is often related to the use of a proxy, which is using a Secure Sockets Layer (SSL) certificate that isn't trusted by the operating system. Verify your settings and make sure that the certificate is trusted at the operating system level.

We recommend adding the certificate to your machine's root certificate store, as that's where the trusted authorities are kept.

## Unrecognized parameters

If you receive an error message stating that your parameters aren't recognized, make sure that you're using the correct version of AzCopy. AzCopy V8 and earlier versions are deprecated. [AzCopy V10](/azure/storage/common/storage-use-azcopy-v10?toc=/azure/storage/blobs/toc.json) is the current version, and it's a complete rewrite that doesn't share any syntax with the previous versions. Refer to [AzCopy Migration Guide for v8 to v10](https://github.com/Azure/azure-storage-azcopy/blob/main/MigrationGuideV8toV10.md).

Also, make sure to utilize built-in help messages by using the `-h` switch with any command (For example: `azcopy copy -h`). See [Get command help](/azure/storage/common/storage-use-azcopy-v10?toc=/azure/storage/blobs/toc.json#get-command-help). To view the same information online, see [azcopy copy](/azure/storage/common/storage-ref-azcopy-copy?toc=/azure/storage/blobs/toc.json).

To help you understand commands, we provide an education tool located in [AZCOPY COMMAND GUIDE](https://azcopyvnextrelease.z22.web.core.windows.net/). This tool demonstrates the most popular AzCopy commands along with the most popular command flags. Our examples are [here](/azure/storage/common/storage-use-azcopy-v10?toc=/azure/storage/blobs/toc.json#transfer-data). If you have a question, try searching through existing [GitHub issues](https://github.com/Azure/azure-storage-azcopy/issues) first to see if it was answered already.

## Conditional access policy error

You can receive the following error when you invoke the `azcopy login` command:

> Failed to perform login command:
failed to login with tenantID "common", Azure directory endpoint "https://login.microsoftonline.com", autorest/adal/devicetoken: -REDACTED- AADSTS50005: User tried to log in to a device from a platform (Unknown) that's currently not supported through Conditional Access policy. Supported device platforms are: iOS, Android, Mac, and Windows flavors.
Trace ID: -REDACTED-
Correlation ID: -REDACTED-
Timestamp: 2021-01-05 01:58:28Z

This error means that your administrator has configured a conditional access policy that specifies what type of device you can log in from. AzCopy uses the device code flow, which can't guarantee that the machine where you're using the AzCopy tool is also where you're logging in.

If your device is among the list of supported platforms, then you might be able to use Storage Explorer, which integrates AzCopy for all data transfers (it passes tokens to AzCopy via the secret store) but provides a login workflow that supports passing device information. AzCopy itself also supports managed identities and service principals, which could be used as an alternative.

If your device isn't on the list of supported platforms, contact your administrator for help.

## Server busy, network errors, or timeouts

If you see a large number of failed requests with the "503 Server Busy" status, your requests are being throttled by the storage service. If you see network errors or timeouts, you might be attempting to push through too much data across your infrastructure, and that infrastructure is having difficulty handling it. In all cases, the workaround is similar.

If you see a large file repeatedly failing due to certain chunks failing each time, try to limit the concurrent network connections or throughput limit depending on your specific case. We suggest you lower the performance drastically at first, observe whether it solved the initial problem, then ramp up the performance again until an overall balance is achieved.

For more information, see [Optimize the performance of AzCopy with Azure Storage](/azure/storage/common/storage-use-azcopy-optimize).

If you're copying data between accounts by using AzCopy, the quality and reliability of the network from where you run AzCopy, might impact the overall performance. Even though data transfers from server to server, AzCopy does initiate calls for each file to copy between service endpoints.

## Known constraints with AzCopy

- Copying data from government clouds to commercial clouds isn't supported. However, copying data from commercial clouds to government clouds is supported.

- Asynchronous service-side copy isn't supported. AzCopy performs synchronous copy only. In other words, by the time the job finishes, the data has been moved.

- When copying to an Azure File share, if you forgot to specify the flag `--preserve-smb-permissions` and don't want to transfer the data again, consider using Robocopy to bring over the permissions.

- Azure Functions has a different endpoint for MSI authentication, which AzCopy doesn't yet support.

## See also

- [Get started with AzCopy](/azure/storage/common/storage-use-azcopy-v10)
- [Find errors and resume jobs by using log and plan files in AzCopy](/azure/storage/common/storage-use-azcopy-configure)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

