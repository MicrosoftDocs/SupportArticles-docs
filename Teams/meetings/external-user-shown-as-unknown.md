---
title: External users shown as Unknown in meeting details
description: An external (federated) user is displayed as Unknown on the Overview page of a Teams meeting or call. This behavior is by design.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CI 159415, CSSTroubleshoot
ms.reviewer: akhairnar
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# External users appear as Unknown in meeting details

Consider the following scenario:

- An external (federated) user joins meetings and calls by using the Teams client.
- In the [Teams admin center](https://admin.teams.microsoft.com/), you access the call analytics information for the user:
  
     1. Under **Users** > **Manage Users**, you select the user.
     1. On the user's profile page, you select the **Meetings & calls** tab.
- You select a meeting ID to view the details.

In this scenario, the username is displayed as **Unknown** on the **Overview** page. The following screenshot shows an example.

:::image type="content" source="media/external-user-shown-as-unknown/user-name-unknown.png" alt-text="Screenshot that shows the username displayed as Unknown.":::

This behavior is by design. On the meeting details page, the Teams admin center UI uses the Microsoft Graph API to query the Microsoft Entra tenant for user properties, such as **displayName**. Because external users aren't available for queries, the username is displayed as **Unknown**.

For more information about call analytics, see [Set up call analytics for Microsoft Teams](/microsoftteams/set-up-call-analytics).
