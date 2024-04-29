---
title: Content ingestion errors when adding a content provider
description: Lists common content ingestion errors when adding content providers for Viva Learning. Provides descriptions for these errors and next steps that you can take.
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

# Content ingestion errors when adding a content provider

You can add a content provider as a third-party content source in Microsoft Viva Learning by using the Microsoft 365 admin center. During the content ingestion process from the third-party provider to Viva Learning, you might experience errors.

The following table provides a list of the error codes or messages that you might see, a description for when they're displayed, and the next steps that you can take. This is not an exhaustive list. More error codes and messages might be added in the future.

> [!NOTE]
> The maximum number of active learning items supported in a tenant is 500,000 records. The maximum number of total learning items supported in a tenant is 1 million records.

|Content provider |Error code/Error message |Error description |
|:----------------|:----------|:----------------------|
|All providers |USR_ERROR_INVALID_RESOURCE_CREDENTIALS |The authentication credentials you provided are invalid. <br/><br/>**Next steps:** Make sure you enter the correct credentials. If they're correct, [contact Microsoft customer support](/viva/learning/help-support) for more details.|
|All providers |USR_ERROR_ACCESS_DENIED |Access denied by partner. <br/><br/>**Next steps:** Confirm that the credentials you entered are correct or contact the content provider's support team. |
|All providers |Changes not saved |**Next steps:** Make sure that you've entered the correct configuration details.|
