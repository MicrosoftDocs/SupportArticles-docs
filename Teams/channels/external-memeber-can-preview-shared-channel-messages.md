---
title: External member can see channel message previews of shared channels in search results
description: External members of a team who don't have access to a shared channel can see channel message previews in search results if the search query matches the content of the channel messages.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 165127
  - CSSTroubleshoot
ms.reviewer: jasonlewis, rramesan
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 07/15/2022
---

# Externally authenticated members can see channel message previews of shared channels in search results

## Symptoms

You share a channel with a team inside your organization that has externally authenticated members (B2B collaboration users that have a UserType of **Member**). These externally authenticated members don't have access to the shared channel. However, they can see a preview of the channel message in search results if the search query matches the content of the channel message.

## Resolution

To prevent externally authenticated members from seeing previews of channel messages, use one of the following options:

- Remove the users from the team with which the channel is shared.
- Don't share the channel with teams that have such users.

## More information

Externally authenticated B2B collaboration users (members and guests) don't automatically get access to shared channels. To learn more about externally authenticated members, see [Properties of an Azure Active Directory B2B collaboration user](/azure/active-directory/external-identities/user-properties).

To learn more about external collaboration in shared channels, see:

- [Guests and shared channels in Teams](https://support.microsoft.com/office/guests-and-shared-channels-in-teams-612de4ce-e7a3-4579-b086-bb8ff9f2d11e)
- [Collaborate with external participants in a shared channel](/microsoft-365/solutions/collaborate-teams-direct-connect?view=o365-worldwide&preserve-view=true)
