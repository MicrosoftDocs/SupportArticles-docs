---
title: Guests can't access Files tab for shared files in Teams
description: Fixes an issue in which guest users can't use the Files tab to access shared files in Teams. This issue occurs because the sharing settings aren't configured correctly.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 157397
- CSSTroubleshoot
ms.reviewer: prbalusu; meerak
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# "Attempted to perform an unauthorized operation" error when accessing Files tab in Teams

## Symptoms

When guest users try to use the **Files** tab to access shared files in Microsoft Teams, they receive the following error message:

> Something went wrong  
> Attempted to perform an unauthorized operation.

## Cause

In Teams chat and channels, the settings of files sharing are based on the sharing setting of SharePoint and OneDrive in the SharePoint admin center. This issue occurs because the settings are not configured correctly in the SharePoint admin center.

## Resolution

To fix this issue, configure the sharing settings in Teams and SharePoint as follows:

- Enable group owners to add people outside the organization as guests.

    When you create a team, a Microsoft 365 group is created to manage team membership. To let the group owners add people outside the organization to the group as guests, check the **Let group owners add people outside the organization to groups** option from
[Microsoft 365 Groups guest settings](/microsoft-365/solutions/collaborate-as-team?view=o365-worldwide#microsoft-365-groups-guest-settings).

- Enable guest sharing from SharePoint admin center:

    1. Sign in [SharePoint admin center](https://admin.microsoft.com/sharepoint?page=sharing&modern=true) as an administrator.
    1. In the left navigation pane, select **Policies** > **Sharing**.
    1. Specify the sharing level for SharePoint and OneDrive to one of the following options:

        - **Existing guests**
        - **Anyone**
        - **New and existing guests**

If the issue persists, Microsoft 365 administrators can run a [self-diagnostic tool](https://aka.ms/TeamsFilesGuestAccessDiag) within the tenant to verify possible issues with guest users accessing files in Teams.

**Note:** This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.
