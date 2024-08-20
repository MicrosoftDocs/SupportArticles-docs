---
title: Guests can't access Files tab for shared files in Teams
description: Fixes an issue in which guest users can't use the Files tab to access shared files in Teams. This issue occurs because the sharing settings aren't configured correctly.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Files\Files Tab
  - CI 157397
  - CSSTroubleshoot
ms.reviewer: prbalusu; meerak
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# "Attempted to perform an unauthorized operation" error when accessing Files tab in Teams

## Symptoms

When guest users try to use the **Files** tab to access shared files in Microsoft Teams, they receive the following error message:

> Something went wrong  
> Attempted to perform an unauthorized operation.

## Cause

In Teams chat and channels, the file sharing settings are based on the sharing settings for SharePoint and OneDrive in the SharePoint admin center. This issue occurs because these settings are not made correctly in the SharePoint admin center.

## Resolution

To fix this issue, configure the sharing settings in Teams and SharePoint as follows:

- Enable group owners to add people outside the organization as guests.

    When you create a team, a Microsoft 365 group is created to manage team membership. To let the group owners add people outside the organization to the group as guests, select the **Let group owners add people outside the organization to groups** check box from
[Microsoft 365 Groups guest settings](/microsoft-365/solutions/collaborate-as-team#microsoft-365-groups-guest-settings).

- Enable guest sharing from SharePoint admin center:

    1. Sign in to the [SharePoint admin center](https://admin.microsoft.com/sharepoint?page=sharing&modern=true) as an administrator.
    1. In the left navigation pane, select **Policies** > **Sharing**.
    1. Specify the sharing level for SharePoint and OneDrive to one of the following options:

        - **Existing guests**
        - **Anyone**
        - **New and existing guests**

### Run a self-diagnostics tool

Microsoft 365 admin users have access to diagnostic tools that they can run within the tenant. These tools can help users identify issues that might prevent guest users from accessing files in Teams.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select the **Run Tests** link. This will populate the diagnostic in the Microsoft 365 admin center.

> [!div class="nextstepaction"]
> [Run Tests: Teams Files Guest Access](https://aka.ms/TeamsFilesGuestAccessDiag)

The diagnostic runs a large range of verification checks.
