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
  - sap:Teams Admin\
  - CI 121615
  - CI 188843
  - CSSTroubleshoot
ms.reviewer: chunlli
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# External federated contacts don't appear in Teams search

If you have imported contacts from a federated partner tenant into Microsoft Entra ID or Exchange Online, the contacts might not appear in Microsoft Teams contact searches.

This problem occurs because Teams uses contacts in your organization's Active Directory and contacts that are added to your Outlook default folder.

Searching in Teams for external federated contacts is supported only under the following conditions:

- Your mailbox is hosted through Exchange Online, not Microsoft Exchange Server on-premises.
- The external contact phone number is included in the contact information.
- You search for the external contact by email address, not the contact name.

  **Note:** Although it isn't supported, searching for an external federated contact might work if the contact is currently cached on the client computer.

If these three conditions are met, external federated contacts will appear in searches.

## Run the Teams Federation diagnostic

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

1. Select the following button to populate the diagnostic in the Microsoft 365 admin center:

   > [!div class="nextstepaction"]
   > [Run Tests: Teams Federation](https://aka.ms/TeamsFederationDiag)
1. In the **Provide the username or email of the user reporting this issue** field, enter the email address of the affected user.
1. In the **What is the federated tenant's domain name** field, enter the federated tenant's domain name, and then select **Run Tests**.

This diagnostic returns the best next steps to address any setting or policy configurations that are preventing communication with the external Teams user.

## Run the Microsoft Remote Connectivity Analyzer test

> [!NOTE]
> Currently the Microsoft Remote Connectivity Analyzer tool doesn't support Microsoft 365 Government environments (GCC or GCC High).

1. Open a web browser, and then go to the [Teams Federation and Interoperability](https://testconnectivity.microsoft.com/tests/TeamsFederation/input) test.
1. Sign in by using the credentials of a Teams administrator.
1. Enter the SIP address of the internal Teams user and the SIP address of the external user.
1. Specify the client that the external user uses.
1. Enter the provided verification code.
1. Select **Verify**.

This test verifies that a Teams account within your organization meets the requirements for searching and engaging in a chat with an external account.

## More information

In Teams, you can communicate with anyone in your organization's Active Directory. You can add anyone as a contact in Teams by selecting **Calls**, selecting the **Contacts** tab, and then selecting **Add contact**.

For more information about how Teams and Exchange work together, see [How Exchange and Microsoft Teams interact](/microsoftteams/exchange-teams-interact).
