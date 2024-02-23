---
title: PowerPivot Configuration Tool shows The user is not a farm administrator error
description: Fixes the error of the user is not a farm administrator when you run the PowerPivot Configuration Tool.
author: helenclu
ms.author: luche
ms.reviwer: zakirh
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: sap:spsexperts, CSSTroubleshoot
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# PowerPivot Configuration Tool shows "The user is not a farm administrator" error

This article was written by [Zakir Haveliwala](https://social.technet.microsoft.com/profile/Zakir+H+-+MSFT), Senior Support Escalation Engineer.

## Symptoms

When you run the PowerPivot Configuration Tool on a SharePoint application server that's running PowerPivot for SharePoint, you may receive the following error:

:::image type="content" source="media/powerpivot-configuration-tool-shows-user-not-farm-administrator/system-validation-error.png" alt-text="Screenshot of the System Validation error message that the user isn't assigned to a farm administrator." border="false":::

## Cause

The user is required to be both a farm administrator and a site collection administrator in the SharePoint Central Administration site. The error may occur if the user isn't assigned to one of these groups.

## Resolution

To fix this issue, add the user as both a farm administrator and a site collection administrator.

**Add the user as a farm administrator**

Go to **SharePoint Central Administration** > **Security** > **Manage the farm administrators group**. On the People and Groups-Farm Administrators page, select **New** > **Add Users**, type the user, and then click **Share**.

:::image type="content" source="media/powerpivot-configuration-tool-shows-user-not-farm-administrator/add-users-farm-administrators.png" alt-text="Screenshot of the People and Groups-Farm Administrators page, adding users to the Farm Administrators group." border="false":::

**Add the user as a site collection administrator**

Go to **SharePoint Central Administration**, click the gear icon on the upper-right, and then select **Site settings**. Then, go to **Users and Permissions** > **Site collection administrators**, type the user and then click **OK**.

:::image type="content" source="media/powerpivot-configuration-tool-shows-user-not-farm-administrator/add-users-site-collection-administrators.png" alt-text="Screenshot of the Users and Permissions-Site Collection Administrators page, adding users to the Site Collection Administrators group." border="false":::