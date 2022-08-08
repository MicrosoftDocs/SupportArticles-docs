---
title: Office apps for iOS require HTTPS for server resources
description: Beginning in version 2.57, Office apps for iOS require an HTTPS connection to server resources.
author: helenclu
ms.reviewer: dereksn
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - CI 160526
  - CI 161252
appliesto: 
  - Office app for iOS
ms.date: 3/31/2022
---

# Office apps for iOS require HTTPS to connect to server resources

Beginning in Office apps for iOS version 2.57 and OneNote for iOS version 16.57, we enabled App Transport Security (ATS) to improve privacy and data integrity. This change requires that network connections are secured by the Transport Layer Security (TLS) protocol. For example, if you try to open a file from a SharePoint-based server that isn’t configured to use an HTTPS connection, Office apps won’t be able to open the file.

This follows Apple requirements, as described in the following excerpt from [this Apple Developer website](https://developer.apple.com/documentation/security/preventing_insecure_network_connections):

> “On Apple platforms, a networking security feature called App Transport Security (ATS) improves privacy and data integrity for all apps and app extensions. It does this by requiring that network connections made by your app are secured by the Transport Layer Security (TLS) protocol using reliable certificates and ciphers. ATS blocks connections that don’t meet minimum security requirements.”

Prior to Office apps for iOS version 2.57 and OneNote for iOS version 16.57, Office apps for iOS allowed connections that are not protected by TLS to create a smooth transition for our customers. Since the release of version 2.57 (and OneNote for iOS version 16.57), Office apps for iOS require an HTTPS connection to access server resources.

> [!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
