---
title: Unable to add guest users in M365 admin center
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 3/25/2020
audience: Admin
ms.topic: article
ms.prod: microsoft-365
localization_priority: High
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft 365
ms.custom: 
- CI 115922
- CSSTroubleshoot 
ms.reviewer: alhopper
description: Describes a workaround for adding guest users to the Microsoft 365 admin center. 
---

# Enabling guest users to access resources through the Microsoft 365 admin center

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

Administrators can make a change in Settings to allow team leaders and users who are not admins to add other guest users who work remotely. 


## Resolution

### Non-admins

For non-admins (team leaders and other end users) to add guest users, follow these steps:

1. Have the administrator sign into the [Azure portal](https://portal.azure.com/).
2. Go to the **Dashboard**, and then select **Users**. 
3. Select **User settings**. 
4. Under **External collaboration settings**, set **Members can invite** to **Yes**.

:::image type="content" source="media/cannot-add-guest-users-in-m365-admin-center/cannot-add-guest-users-in-m365-admin-center.png" alt-text="Set Members can invite to Yes. ":::

Non-admins will then be able to add guest users without admin approval.

**Microsoft recommends that admins make this change to alleviate the number of requests they may receive for remote access.**

For more detailed instructions, see [Step 2: Configure Azure AD business-to-business settings](https://docs.microsoft.com/microsoftteams/guest-access-checklist#step-2-configure-azure-ad-business-to-business-settings) in the article [Microsoft Teams guest access checklist](https://docs.microsoft.com/microsoftteams/guest-access-checklist#step-2-configure-azure-ad-business-to-business-settings). 

### Admins

For admins to directly add a guest user, go to **All users** in the [Azure Active Directory (AAD) admin center](https://aad.portal.azure.com/), and then select **New guest user**. 

## More information

For more information about how to add new users, see the following Microsoft articles:

- [Quickstart: Add guest users to your directory in the Azure portal](https://docs.microsoft.com/azure/active-directory/b2b/b2b-quickstart-add-guest-users-portal)
- [Microsoft Teams guest access checklist](https://docs.microsoft.com/microsoftteams/guest-access-checklist#step-2-configure-azure-ad-business-to-business-settings)


Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).