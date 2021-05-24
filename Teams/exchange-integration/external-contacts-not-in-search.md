---
title: External federated contacts don’t appear in Teams search 
description: Describes why external federated contacts might not appear in Teams searches.
author: v-matham
ms.author: v-matham
manager: dcscontentpm
editor: v-jesits
audience: ITPro 
ms.topic: article 
ms.prod: microsoft-teams
ms.technology: microsoft-graph
localization_priority: Normal
ms.custom: 
- CI 121615
- CSSTroubleshoot
ms.reviewer: chunlli
appliesto:
- Microsoft Teams
search.appverid: 
- MET150 
---

# External federated contacts don’t appear in Teams search

If you have imported contacts from a federated partner tenant into Azure Active Directory (AAD) or Exchange Online, the contacts might not appear in Microsoft Teams contact searches.

This is because Teams uses contacts in your organization’s Active Directory (AD) and contacts added to your Outlook default folder.

Searching in Teams for external federated contacts is only supported under the following conditions:

- Your mailbox is hosted through Exchange Online, not on-premises.

- The external contact’s phone number is included in the contact information.

- You search for the external contact by email address, not the contact’s name.

    **Note** Although it is not supported, searching for an external federated contact might work if the contact is currently cached on the client machine.

If those three conditions are met, external federated contacts will appear in search.

In Teams, you can communicate with anyone in your organization’s AD. You can add anyone as a contact in Teams by selecting **Calls**, selecting the **Contacts** tab, and then selecting **Add contact**.

For more information about the way Teams and Exchange work together, see [How Exchange and Microsoft Teams interact](/microsoftteams/exchange-teams-interact).