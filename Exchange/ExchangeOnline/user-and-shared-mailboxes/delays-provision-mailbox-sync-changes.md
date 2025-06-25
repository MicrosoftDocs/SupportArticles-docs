---
title: Delays in provisioning a user or mailbox
description: Provides a resolution for an issue in which there are delays when provisioning a user or mailbox, or synchronizing changes in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Recipients management
  - Exchange Online
  - CI 120630
  - CSSTroubleshoot
ms.reviewer: rroddy, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# Delays in provisioning of user/mailbox or synchronizing changes in Exchange Online

## Symptoms

When a user is created or changed in Microsoft 365, or synced to Microsoft Entra ID from the on-premises environment, either no mailbox is provisioned for the user, or the change isn't reflected in Exchange Online.

## Resolution

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select the button below to launch a diagnostic in the Microsoft 365 admin center. The diagnostic will guide you to resolve various error conditions that can cause mailboxes to not be created.

>[!div class="nextstepaction"]
>[Run Tests: EXO Recipient Object Failures](https://aka.ms/PillarEXORecipients)

The service typically takes less than 30 minutes to provision a user or to sync changes for a user. However, in some situations these processes can take up to 24 hours.

If the diagnostic doesn't resolve the issue, use the following steps:

1. Verify that the user is assigned a valid Exchange Online license in the Microsoft 365 admin center.
2. [Resolve](https://support.microsoft.com/help/2741233) any validation errors that the user receives.
3. Check whether a Service Health notification in the Microsoft 365 admin center applies to your environment.

If the issue persists after 24 hours, contact [Microsoft Support](https://support.microsoft.com/contactus/).
