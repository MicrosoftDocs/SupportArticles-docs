---
title: Content ingestion errors when adding an LMS
description: Lists common content ingestion errors when adding LMSs for Viva Learning. Provides descriptions for these errors and next steps that you can take.
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.reviewer: chrisarnoldmsft
ms.date: 08/09/2022
audience: ITPro
ms.topic: troubleshooting
ms.service: viva-learning
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
localization_priority: Normal
---

# Content ingestion errors when adding an LMS

You can add a Learning Management System (LMS) as a content source in Microsoft Viva Learning by using the Microsoft 365 admin center. During the content ingestion process from the LMS to Viva Learning, you might experience errors.

The following table provides a list of the error codes or messages that you might see, a description for when they're displayed, and the next steps that you can take. This is not an exhaustive list. More error codes and messages might be added in the future.

> [!NOTE]
> The maximum number of active learning items supported in a tenant is 500,000 records. The maximum number of total learning items supported in a tenant is 1 million records.

|Learning management system |Error code/Error message|Error description|
|----------|-----------|------------|
|All LMSs |USR_ERROR_INVALID_RESOURCE_CREDENTIALS |The authentication credentials you provided are invalid. <br/><br/>**Next steps:** Make sure you enter the correct credentials. If they're correct, [contact Microsoft customer support](/viva/learning/help-support) for more details.|
|All LMSs |USR_ERROR_ACCESS_DENIED |Access denied by partner. <br/><br/>**Next steps:** Confirm that the credentials you entered are correct or contact the content provider's support team. |
|All LMSs |Your changes couldn't be saved. Make sure you've entered the correct field name. |Your changes won't be saved if you've entered any fields incorrectly. <br/><br/>**Next steps:** Close and reopen the flyout to view and correct any invalid fields.|
|SuccessFactors |USR_ERROR_SF_INITIAL_PACKAGE_NOT_FOUND |No new content ingested as the required package was not found in the SuccessFactors SFTP server. <br/><br/>**Next steps:** Make sure that the [SuccessFactors package](/viva/learning/configure-successfactors-content-source#configure-in-your-successfactors-portal) is available. It may take up to seven working days to generate this package the first time you sync. If you can't find the package, contact your SuccessFactors support team. |
|SuccessFactors |USR_ERROR_SF_DELTA_PACKAGE_NOT_FOUND |No new content was ingested as the required package was not found in the SuccessFactors SFTP server. <br/><br/>**Next steps:** Make sure that SF package is available in the configured folder path on your SF portal. If you can't find the package, contact your SuccessFactors support team. |
|SuccessFactors |USR_ERROR_SFTP_NO_FILES_FOUND |No new content ingested because there were no files present in the SuccessFactors SFTP server. <br/><br/>**Next steps:** Make sure that you can find the files in the [SuccessFactors package](/viva/learning/configure-successfactors-content-source#configure-in-your-successfactors-portal). If you can't find the files, contact your SuccessFactors support team. |
|SuccessFactors |USR_ERROR_SF_COMPRESSED_PACKAGE_SIZE_EXCEEDED |No new content was ingested because the compressed package size exceeded 2 GB. <br/><br/>**Next steps:** [Contact Microsoft customer support](/viva/learning/help-support) for more details. |
|SuccessFactors |USR_ERROR_SF_UNCOMPRESSED_PACKAGE_SIZE_EXCEEDED |No new content was ingested because the uncompressed package size exceeded 25 GB. <br/><br/>**Next steps:** [Contact Microsoft customer support](/viva/learning/help-support) for more details.|
|Cornerstone OnDemand |USR_ERROR_INVALID_RESOURCE_CREDENTIALS |The authentication credentials you provided are invalid. <br/><br/>**Next steps:** Make sure the credentials are being copied from Microsoft Viva Learning in Cornerstone OnDemand portal.|
