---
title: Exclude or remove sites from a SharePoint Online retention policy
description: Describes how to exclude or remove sites from your SharePoint Online retention policy.
author: PramodBalusu
ms.author: v-matham
manager: dcscontentpm
localization_priority: Normal
ms.date: 05/19/2021
audience: Admin
ms.topic: article
ms.service: sharepoint-online
ms.custom: 
- CSSTroubleshoot
- CI 149492
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online
---

# Exclude or remove sites from a SharePoint Online retention policy

There are several reasons you might want to exclude or remove a site from a retention policy. You can do so using the steps below.  

> [!NOTE]
>  - You must have the necessary permissions in the Compliance Admin center. See Permissions in the Microsoft 365 compliance center and Microsoft 365 security center.
> - The steps in this article apply to SharePoint sites, OneDrive storage sites, and Microsoft 365 groups locations.  
> - Changes to the retention policy might take up to 24 hours to complete.  

If the retention policy applies to all sites, you can exclude a site from the retention policy, but not remove it. If the retention policy applies to selected sites, you can remove the site, but not exclude it.

## Edit the retention policy

1. Go to the Security admin center at https://protection.office.com.

1. In the left navigation bar, find **Information Governance**, and then select **Retention**. You will then be presented with all the retention policies configured in your tenant.  

1. Select the policy you want to edit, and then select **Edit Policy**.

1. On the **Edit Retention Policy** window, navigate to **Locations Applied**, and then select **Let me choose specific locations** if it is not already selected.

1. Next to **SharePoint Sites**, select **Exclude sites**. Continue to **Exclude a site from the retention policy**, below.

    **Note:** If Exclude sites is grayed out (not selectable), it means the retention policy applies to a specific site. Skip to the **Remove a SharePoint site from the retention policy** section, below.

## Exclude a site from the retention policy

1. Select **Exclude Sites**.

1. Enter the URL of the site you wish to exclude and select the plus (+) button.

1. Select the site by checking the checkbox. You can add other sites now if you want to.

1. After you have entered all the sites you want to exclude, select **Exclude** at the bottom of the window to confirm the changes.

1. Select **Save**.

## Remove a SharePoint site from the retention policy

1. Next to **SharePoint Sites**, select **Choose sites**.

1. Select **X** for the site you want to remove from the policy.  

1. Select **Done**, and then **Save**.