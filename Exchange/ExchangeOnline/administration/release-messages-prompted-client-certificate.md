---
title: Can't release a message for a certificate
description: Describes an issue that returns a website 'na01-quarantine.dataservice.protection.outlook.com' requires a client certificate error when a Mac user tries to release a message from Exchange Online Protection quarantine.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Online Protection
search.appverid: MET150
ms.date: 01/24/2024
---
# Mac users can't release messages from Exchange Online Protection quarantine

_Original KB number:_ &nbsp; 2909418

## Problem  

When a user tries to release a message from the Exchange Online Protection quarantine when using the Safari browser on a Mac, the user is prompted for a certificate as follows:

> The website "na01-quarantine.dataservice.protection.outlook.com" requires a client certificate.

## Solution

To resolve this issue, follow these steps:

1. Locate the Keychain Access program on the Mac. To do this, open **Finder**, and then open the Applications folder. The Applications folder contains a folder that's named Utilities. The Keychain Access program is in the Utilities folder.
2. Open Keychain Access, and then locate all certificates in the Safari dialog box that show as **This client requires a certificate**.
3. Select the certificates that you located in step 2, and then delete them from Keychain Access.
4. Restart Safari.

## More information

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
