---
title: Error "A compliance policy is currently blocking this site deletion" when deleting a site
description: This article describes how to resolve an issue when there's an error when trying to delete a SharePoint site.
author: helenclu
ms.author: prbalusu
manager: dcscontentpm
localization_priority: Normal
ms.date: 02/03/2021
audience: Admin
ms.topic: troubleshooting
ms.service: sharepoint-online
ms.custom: CSSTroubleshoot
search.appverid:
- SPO160
- MET150
ms.assetid: 
appliesto:
- SharePoint Online
---

# "A compliance policy is currently blocking this site deletion" when deleting a SharePoint site

## Symptoms

When you try to delete a SharePoint site, the following message appears:

**Can't delete site.**

**A compliance policy is currently blocking this site deletion.**

:::image type="content" source="media/compliance-policy-blocking-site-deletion/cant-delete-site.png" alt-text="Screenshot of the error message stating that a site can't be deleted." border="false":::

## Cause

There are several reasons for this error to occur:

- There might be a compliance policy that is currently invalid.
- A valid policy can be present, and the SharePoint site shouldn't be deleted. In this situation, contact your administrator to determine whether you can exclude or remove this site from the policy.

## Resolution

To remove the **Invalid retention hold**, try one of the following methods, depending on your level of permissions.

### Non-administrators

If you receive the **Compliance policy** error message, contact your [Microsoft 365 Administrator](/microsoft-365/admin/add-users/about-admin-roles).

### Administrators

> [!NOTE]
> This feature is not available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

If you're an administrator, and you're unable to delete the site:

1. Select **Run Tests** below, which will populate the diagnostic in the Microsoft 365 Admin Center. 

   > [!div class="nextstepaction"]
   > [Run Tests: Invalid Retention Hold](https://aka.ms/PillarInvalidRetention)

2. In the Run diagnostic section, type or paste the **SharePoint site URL**, and then select **Run Tests**.

   :::image type="content" source="media/compliance-policy-blocking-site-deletion/run-diagnostics.png" alt-text="Screenshot of the Run diagnostics window asking for SharePoint URL information.":::

3. If the test finds an **Invalid retention policy**, and the policy is blocking the site deletion, you may choose to remove the policy.

   :::image type="content" source="media/compliance-policy-blocking-site-deletion/invalid-retention-policies-on-tenant.png" alt-text="Screenshot of the Run diagnostics window asking to update settings." border="false":::

## More information

Still need help? Go to the [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
