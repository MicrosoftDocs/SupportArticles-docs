---
title: External users shown as Unknown in meeting details
description: Describes a by-design behavior that an external (federated) user is displayed as Unknown on the Overview page of a Teams meeting or call.
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
---
# External users appear as Unknown in meeting details

Consider the following scenario:

- An external (federated) user joins meetings and calls by using the Teams client.
- In the [Teams admin center](https://admin.teams.microsoft.com/), you open the Call Analytics for the external user. Under **Users** > **Manage Users**, you select the user,  and then select the **Meetings & calls** tab on the user's profile page.
- You select a meeting ID to view details.

In this scenario, the user name is displayed as **Unknown** on the **Overview** page. The following screenshot shows an example:

:::image type="content" source="media/external-user-shown-as-unknown/user-name-unknown.png" alt-text="Screenshot that shows the user name is displayed as Unknown.":::

This behavior is by design.
