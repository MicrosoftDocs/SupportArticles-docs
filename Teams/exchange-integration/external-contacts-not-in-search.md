---
title: External federated contacts don't appear in Teams search
description: Describes why external federated contacts might not appear in Teams searches.
author: helenclu
ms.author: luche
manager: dcscontentpm
editor: v-jesits
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 121615
  - CSSTroubleshoot
ms.reviewer: chunlli
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# External federated contacts don't appear in Teams search

Microsoft 365 admin users have access to diagnostic tools that they can run within the tenant to verify possible issues that affect federation.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select the **Run Tests** link. This will populate the diagnostic in the Microsoft 365 admin center.

> [!div class="nextstepaction"]
> [Run Tests: Teams Federation](https://aka.ms/TeamsFederationDiag)

If you have imported contacts from a federated partner tenant into Microsoft Entra ID or Exchange Online, the contacts might not appear in Microsoft Teams contact searches.

This problem occurs because Teams uses contacts in your organization's Active Directory and contacts that are added to your Outlook default folder.

Searching in Teams for external federated contacts is supported only under the following conditions:

- Your mailbox is hosted through Exchange Online, not Microsoft Exchange Server on-premises.

- The external contact phone number is included in the contact information.

- You search for the external contact by email address, not the contact name.

    **Note** Although it is not supported, searching for an external federated contact might work if the contact is currently cached on the client computer.

If these three conditions are met, external federated contacts will appear in searches.

In Teams, you can communicate with anyone in your organization's Active Directory. You can add anyone as a contact in Teams by selecting **Calls**, selecting the **Contacts** tab, and then selecting **Add contact**.

For more information about how Teams and Exchange work together, see [How Exchange and Microsoft Teams interact](/microsoftteams/exchange-teams-interact).
