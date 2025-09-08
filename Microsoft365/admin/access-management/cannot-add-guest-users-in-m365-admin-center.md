---
title: Unable to add guests in Microsoft 365 admin center
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 10/20/2023
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft 365
ms.custom: 
  - CI 115922
  - CSSTroubleshoot
ms.reviewer: alhopper
description: Describes a workaround for adding guests to the Microsoft 365 admin center.
---

# Enabling guest users to access resources through the Microsoft 365 admin center

## Summary

Administrators can make a change in Settings to allow team leaders and users who aren't admins to add other guests who work remotely. 

## Resolution

### Non-admins

For non-admins (team leaders and other end users) to add guests, follow these steps:

1. Have the administrator sign into the [Azure portal](https://portal.azure.com/).
2. Go to the **Dashboard**, and then select **Users**. 
3. Select **User settings**. 
4. Under **External collaboration settings**, set **Members can invite** to **Yes**.

:::image type="content" source="media/cannot-add-guest-users-in-m365-admin-center/members-can-invite.png" alt-text="Screenshot shows steps to set the Members can invite option to Yes.":::

Non-admins will then be able to add guests without admin approval.

**Microsoft recommends that admins make this change to alleviate the number of requests they may receive for remote access.**

For more detailed instructions, see [Step 2: Configure Microsoft Entra business-to-business settings](/microsoftteams/guest-access-checklist#step-2-configure-azure-ad-business-to-business-settings) in the article [Microsoft Teams guest access checklist](/microsoftteams/guest-access-checklist#step-2-configure-azure-ad-business-to-business-settings). 

### Admins

For admins to directly add a guest, go to **All users** in the [Microsoft Entra admin center](https://aad.portal.azure.com/), and then select **New guest user**. 

## More information

For more information about how to add new users, see the following Microsoft articles:

- [Quickstart: Add guests to your directory in the Azure portal](/azure/active-directory/b2b/b2b-quickstart-add-guest-users-portal)
- [Microsoft Teams guest access checklist](/microsoftteams/guest-access-checklist#step-2-configure-azure-ad-business-to-business-settings)


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
