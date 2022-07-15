---
title: External team members can see channel message previews of shared channels in search results
description: Describes an issue that external users who don't have access to a shared channel can see channel message previews in search results if the search query matches the content of the channel messages.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 165127
  - CSSTroubleshoot
ms.reviewer: jasonlewis
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 07/15/2022
---

# External team members can see channel message previews of shared channels in search results

## Symptoms

You share a channel with a team inside your organization that has external members. These external users don't have access to the shared channel. However, they can see a preview of the channel message in search results if the search query matches the content of the channel message.

## Resolution

To prevent external users from seeing previews of channel messages, use one of the following options:

- Remove the users from the team with which the channel is shared.
- Don't share the channel with teams that have external members.

## More information

Externally authenticated users (members and guests) don't automatically get access to shared channels. To give people outside your organization access to a shared channel, admins must set up cross-tenant trust, and users must be added through Azure AD B2B direct connect. For more information, see the following articles:

- [Guests and shared channels in Teams](https://support.microsoft.com/office/guests-and-shared-channels-in-teams-612de4ce-e7a3-4579-b086-bb8ff9f2d11e)
- [Collaborate with external participants in a shared channel](/microsoft-365/solutions/collaborate-teams-direct-connect?view=o365-worldwide&preserve-view=true)