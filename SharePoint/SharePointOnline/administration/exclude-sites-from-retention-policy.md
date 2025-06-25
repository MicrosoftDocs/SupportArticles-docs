---
title: Exclude or Remove Sites From a SharePoint Online Retention Policy
description: Describes how to exclude or remove sites from your SharePoint Online retention policy.
author: helenclu
ms.reviewer: PramodBalusu
ms.author: luche
manager: dcscontentpm
ms.date: 02/16/2025
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Compliance and Auditing\Retention policies
  - CSSTroubleshoot
  - CI 149492
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
---

# Exclude or remove sites from a SharePoint Online retention policy

This article describes how to exclude or remove a website from a retention policy.

> [!NOTE]
> - You must have the necessary permissions in the Compliance Admin center to do this. See [Permissions in the Microsoft Purview compliance portal and Microsoft 365 security center](/microsoft-365/security/office-365-security/permissions-microsoft-365-compliance-security).
> - The steps in this article apply to SharePoint sites, OneDrive storage sites, and Microsoft 365 Groups locations.  
> - Changes to the retention policy might take up to 24 hours to take effect.  

If the retention policy applies to all sites, you can exclude a site from the retention policy, but not remove it. If the retention policy applies to selected sites, you can remove the site, but not exclude it.

When you remove a site from a retention policy, the site remains subject to a [30-day retention grace period](/purview/retention?tabs=table-overriden#releasing-a-policy-for-retention). However, excluding a site from a retention policy bypasses this 30-day grace period.

## Edit the retention policy

1. Go to the [Microsoft Purview compliance portal](https://go.microsoft.com/fwlink/p/?linkid=2077149). 

1. Select **Data lifecycle management** > **Microsoft 365** > **Retention Policies**. You'll be shown all the retention policies that are configured in your tenant.  

1. Select the policy that you want to edit, and then select **Edit Policy**.

1. In the **Edit Retention Policy** window, navigate to **Locations Applied**, and then select **Let me choose specific locations**, if it isn't already selected.

1. Next to **SharePoint Sites**, select **Exclude sites**. Then, go to the [Exclude a SharePoint site from the retention policy](#exclude-a-sharepoint-site-from-the-retention-policy) section.

    **Note:** If **Exclude sites** isn't available (grayed out), this means that the retention policy applies to a specific site. In this case, go to the [Remove a SharePoint site from the retention policy](#remove-a-sharepoint-site-from-the-retention-policy) section.

## Exclude a SharePoint site from the retention policy

1. Select **Exclude Sites**.

1. Enter the URL of the site that you want to exclude, and then select the Plus sign (+) button.

1. Select the checkbox for the site. You can add other sites, if you want.

1. After you enter all the sites that you want to exclude, select **Exclude** at the bottom of the window to confirm the changes.

1. Select **Save**.

## Remove a SharePoint site from the retention policy

1. Next to **SharePoint Sites**, select **Choose sites**.

1. Select the "X" character for the site URL that you want to remove from the policy.  

1. Select **Done** > **Save**.
