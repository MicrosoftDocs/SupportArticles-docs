---
title: Content distribution to a CMG or cloud DP fails 
description: Describes an issue in which content distribution to a Configuration Manager CMG or cloud DP fails with error 80070070 when the BranchCache feature is enabled.
ms.date: 12/05/2023
ms.custom: sap:Content Management\Content Distribution to Distribution Points
ms.reviewer: kaushika
---
# Error 80070070 during content distribution to a CMG or cloud DP in Configuration Manager

This article helps you fix an issue where content distribution to a cloud management gateway (CMG) or cloud distribution point fails when the BranchCache feature is enabled.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4509484

## Symptoms

When you have the BranchCache feature installed on the Configuration Manager site server, content distribution to a CMG or cloud distribution point fails. The following error messages are logged in PkgXferMgr.log on the site server:

> About to upload files from package source directory E:\SMSPKGSIG\C0101B18~~  
> WARNING: Caught exception System.Runtime.InteropServices.COMException - **There is not enough space on the disk. (Exception from HRESULT: 0x80070070)** ~~  
> Call stack:  
> at Microsoft.ConfigurationManager.AzureRoles.ContentManager.BranchCacheContentInfoStreamClass.Complete()~~  
> at Microsoft.ConfigurationManager.AzureRoles.ContentManager.ContentInfoStream.Close()~~  
> at Microsoft.ConfigurationManager.AzureRoles.ContentManager.CryptoUtilities.EncryptAndUploadFileAndSaveContentInfo(String fileName, String contentInfoFullPath, CloudBlockBlob blob, EncryptionParams encryptionParams, IsCanceledCallback isCanceledDelegate)~~  
> at Microsoft.ConfigurationManager.AzureRoles.ContentManager.ContentManager.RecursiveUpload(String packageId, ContentRouter contentRouter, CloudBlobContainer container, String sourceDir, String contentInfoDir, String relativeTargetPath, EncryptionParams encryptionParams, Int32& fileCounter)~~  
> at Microsoft.ConfigurationManager.AzureRoles.ContentManager.ContentManager.UploadContent(String packageId, String contentId, String contentSource, String contentInfoPath, Boolean uploadFiles, EncryptionParams encryptionParams, ContentRouter contentRouter, String& contentInfoFile)~~  
> at Microsoft.ConfigurationManager.AzureRoles.ContentManager.ContentManager.UploadPackageToCloudWithContentInfo(String packageId, String contentSource, String contentInfoPath, String cloudDP, String encryptionKey, String algName, Int32 keySize, Int32 blockSize, String& contentInfoFile)~~

## Cause

When the BranchCache feature is installed on the site server, the default cache location (`%windir%\ServiceProfiles\NetworkService\AppData\Local\PeerDistPub`) and maximum cache size (1% of the total hard disk space) are used for the BranchCache publication cache.

This issue occurs if the BranchCache publication cache size exceeds the default maximum cache size.

To view the publication cache size, run the following command:

```console
netsh branchcache show publicationcache
```

## Resolution

To fix this issue, flush the content of the BranchCache publication cache by running the following command on the site server:

```console
netsh branchcache flush
```

Additionally, you can change both the default cache location and maximum cache size by running the following commands on the site server:

```console
netsh branchcache set publicationcache directory=<New Location>
netsh branchcache set publicationcachesize size=<New Value> percent=TRUE
```

For example, the following commands set the BranchCache publication cache location to *E:\BranchCache\PublicationCache* and the maximum cache size to *10%* of the total hard disk space:

```console
netsh branchcache set publicationcache directory=E:\BranchCache\PublicationCache
netsh branchcache set publicationcachesize size=10 percent=TRUE
```

> [!NOTE]
> BranchCache publication cache contains the metadata that's required for clients to take advantage of BranchCache when they download content from the distribution point. This metadata is generated when a content item is first downloaded from a BranchCache-enabled distribution point, and is required by successive clients to download the content item by using BranchCache. After the publication cache is flushed, the metadata is regenerated when the distribution point receives download requests for content items. Therefore, after you flush the publication cache, the first client to download a unique content item won't be able to use BranchCache to download the content.
