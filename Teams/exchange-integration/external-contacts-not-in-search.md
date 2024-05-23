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

If you've imported contacts from a federated partner tenant into Microsoft Entra ID or Exchange Online, the contacts might not appear when you search for them in Microsoft Teams.

The following requirements must be met for external federated contacts to display in a search on Teams:

- Your mailbox must be hosted on Exchange Online, not Microsoft Exchange Server on-premises.
- A phone number must be included in the contact information for every external federated contact.
- You must search for the external contact by email address, not the name.

> [!NOTE]
> An external federated contact might display in the search results if the contact’s information is currently cached on your computer.

To identify the cause of the issue, an administrator can use one of the following options to check the requirements for external federated contacts to display in a search on Teams.

## Option 1: Run a connectivity test

Teams administrators can run the [Teams Federation and Interoperability](https://testconnectivity.microsoft.com/tests/TeamsFederation/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test verifies whether a user account meets the requirements to search for and chat with an external federated account.

> [!NOTE]
> The Microsoft Remote Connectivity Analyzer tool isn’t available for the GCC and GCC High Microsoft 365 Government environments.

Use the following steps:

1. Open a web browser and navigate to the [Teams Federation and Interoperability](https://testconnectivity.microsoft.com/tests/TeamsFederation/input) connectivity test.
1. Sign in by using the credentials of a Teams administrator.
1. Enter the SIP address of the affected Teams user.
1. Enter the SIP address of the external federated contact.
1. Select the app that the external federated contact is using.
1. Enter the verification code that’s displayed and select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test is complete, the screen will display details about the checks that were performed and whether the test succeeded, failed, or was successful with a few warnings. Select the links provided for more information about the warnings and failures, and how to resolve them.

## Option 2: Run a self-help diagnostic

If you're an administrator, you can run the [Teams Federation](https://aka.ms/TeamsFederationDiag) diagnostic in the Microsoft 365 admin center to validate the requirements for a Teams user to communicate with an external federated user by using Teams.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Use the following steps:

1. Select the **Run Tests** button to populate the diagnostic in the Microsoft 365 admin center:

   > [!div class="nextstepaction"]
   > [Run Tests: Teams Federation](https://aka.ms/TeamsFederationDiag)
1. In the **Provide the username or email of the user reporting this issue** field, enter the email address of the affected Teams user.
1. In the **What is the federated tenant's domain name** field, enter the appropriate information, and then select **Run Tests**.

After the diagnostic is complete, select the links provided to resolve the issues that are found.
