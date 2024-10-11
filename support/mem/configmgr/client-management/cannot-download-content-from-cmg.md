---
title: Can't download content from a CMG
description: Describes an issue in which content can't be downloaded from a CMG that functions as a cloud DP, and you receive an WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID error message.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Cloud Services\Cloud Management Gateway (CMG) as DP
---
# WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID using a CMG as a cloud DP with a third-party certificate

This article describes an issue in which content can't be downloaded from a cloud management gateway (CMG) that functions as a cloud distribution point (DP), and you receive an **WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID** error message.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4495265

## Symptoms

Consider the following scenario:

- You create a CMG, and you enable the **Allow CMG to function as a cloud distribution point and serve content from Azure storage** setting.
- You use a CMG server authentication certificate from a third-party provider. The CMG service FQDN is configured as \<*CMGname*>.\<*your domain*>.

In this scenario, you experience the following issues:

- Existing clients can't download content from the CMG. Errors entries that resemble the following are logged in DataTransferservice.log:

  > 12-28-2018 16:06:39.334 &nbsp; &nbsp;DataTransferService &nbsp; &nbsp;3544 (0xdd8) &nbsp; &nbsp;Target URL scheme is HTTPS: https://\<CMGname>.cloudapp.net:443/downloadrestservice.svc/getcontentxmlsecure?pid=XXX00052&cid=XXX00052&tid=GUID:\<GUID>&iss=\<MPserver>.Internal.fqdn&alg=1.2.840.113549.1.1.11&st=2018-12-28T22:06:39&et=2018-12-29T06:06:39  
  > [CCMHTTP] AsyncCallback(): WINHTTP_CALLBACK_STATUS_SECURE_FAILURE Encountered  
  > 12-28-2018 16:06:39.391 &nbsp; &nbsp;DataTransferService &nbsp; &nbsp;3544 (0xdd8)  
  > [CCMHTTP] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID is set

- Client files can't be downloaded from CMG to set up new clients. Errors entries that resemble the following are logged in Ccmsetup.log:

  > Found a valid online MP 'https://\<CMGname>.\<your domain>.com/CCM_PROXY_MUTUALAUTH/72057594037938216'. 19/02/2019 13:49:33 ccmsetup 8548 (0x2164)  
  > Found remote location 'https://\<CMGname>.cloudapp.net/downloadrestservice.svc/getcontentxmlsecure?pid=XXX002B9&cid=XXX002B9' 19/02/2019 13:49:35 ccmsetup 8548 (0x2164)  
  > The location 'https://\<CMGname>.cloudapp.net/downloadrestservice.svc/getcontentxmlsecure?pid=XXX002B9&cid=XXX002B9' is on Azure 19/02/2019 13:49:35 ccmsetup 8548 (0x2164)  
  > No local DP locations found but is upgrading client on the co-lcated pull DP or Client is on Internet, continue with remote locations. 19/02/2019 13:49:35 ccmsetup 8548 (0x2164)  
  > [CCMHTTP] ERROR: URL=https://\<CMGname>.cloudapp.net/downloadrestservice.svc/getcontentxmlsecure?pid=XXX002B9&cid=XXX002B9, Port=0, Options=224, Code=0, Text=CCM_E_NO_CLIENT_PKI_CERT 19/02/2019 13:49:35 ccmsetup 8548 (0x2164)  
  > GetDirectoryList failed with a non-recoverable failure, 0x87d00454 19/02/2019 13:49:35 ccmsetup 8548 (0x2164)  
  > Failed to get directory list from 'https://\<CMGname>.cloudapp.net/downloadrestservice.svc/getcontentxmlsecure?pid=XXX002B9&cid=XXX002B9'. Error 0x87d00454 19/02/2019 13:49:35 ccmsetup 8548 (0x2164)  
  > Failed to correctly receive a WEBDAV HTTPS request.. (StatusCode at WinHttpQueryHeaders: 0) and StatusText: '' &nbsp;19/02/2019 13:49:35 ccmsetup 8548 (0x2164)  
  > Failed to check url https://\<CMGname>.cloudapp.net/downloadrestservice.svc/getcontentxmlsecure?pid=XXX002B9&cid=XXX002B9. Error 0x80004005 19/02/2019 13:49:35 ccmsetup 8548 (0x2164)  
  > [CCMHTTP] AsyncCallback(): WINHTTP_CALLBACK_STATUS_SECURE_FAILURE Encountered 19/02/2019 13:49:36 ccmsetup 8548 (0x2164)  
  > [CCMHTTP] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID is set

> [!NOTE]
> **WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID** means that the host name in the certificate common name is incorrect.

## Cause

This issue occurs because the clients try to access the CMG cloud service by looking for the default FQDN of \<*CMGname*>.CloudApp.net, and this name doesn't match the actual FQDN of \<*CMGname*>.\<*your domain*>. Therefore, the **WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID** error is reported.

> [!NOTE]
> When you enable CMG as a cloud distribution point, the globally unique CMG service name that you choose must also be a globally unique Azure storage account name. An Azure storage account name is always created under the CloudApp.net subdomain. Because the CloudApp.net domain is owned by Microsoft, a third-party certificate provider can't create a certificate for CloudApp.net.

## Resolution

To fix this issue, update to Configuration Manager current branch version 1902.
