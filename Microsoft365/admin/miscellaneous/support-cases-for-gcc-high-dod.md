---
title: Open Support cases for GCC High and DoD
description: Describes that how to open Support cases for GCC High and DoD.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft 365
ms.date: 10/20/2023
---

# How to open Support cases for GCC High and DoD

## Summary

Microsoft 365 Support is available only to users with Administrator roles associated with a valid email address. Therefore, only user accounts marked in the Microsoft 365 admin center as an administrator are able to contact support and/or create a support incident.  Visit your Microsoft 365 admin center to manage your user accounts and define who has permissions to contact support.

If a user doesn't need any specialized administrative access, you can grant them the role of Service Administrator, which provides them with view-only access and the ability to contact support to create an incident.

To create a new service request, browse to the [Microsoft 365 Admin Portal](https://portal.office365.us/adminportal). After login, navigate to **Show all** > **Support** > **New Service Request**, and use the subject to briefly describe the problem for the new service request.

> [!NOTE]
> Users can't change their own account permissions and their account needs to be updated by another administrator.

For more details and step-by-step guidance on how to assign administrative roles to users, see [Assign admin roles](/office365/admin/add-users/assign-admin-roles).

For more details on administrator roles, see [About admin roles](/office365/admin/add-users/about-admin-roles).  

For more information on how to populate a valid email address for a user account, see the "More Information" section. A valid email address is necessary for the following situations: 

1. You're informed of support incident progress and updates through email. 
2. Your identity might be challenged/verified through email or a valid phone number listed in your user's properties. 

## More information

Options and steps to populate a valid email address for a Microsoft 365 user account -

**Option 1 - Update the UserPrincipalName/Username value in the Microsoft 365 admin center** 

1. Log into the Microsoft 365 admin center and look up the user.

   :::image type="content" source="media/support-cases-for-gcc-high-dod/look-up-o365-user.png" alt-text="Screenshot to look up the user after logging into the Microsoft 365 admin center.":::

1. Next to Username select Edit. 

   :::image type="content" source="media/support-cases-for-gcc-high-dod/edit-o365-user.png" alt-text="Screenshot to select the Edit option to edit the Microsoft 365 Username.":::

1. Under Aliases, type in a new email address and use the drop-down to select the desired domain. Click Add. Then select Set as primary. 

   :::image type="content" source="media/support-cases-for-gcc-high-dod/primary-address.png" alt-text="Screenshot to set the new email address as primary address.":::

1. This action may bring up the following message for your confirmation.

   > You're about to change this user's sign-in information.

   :::image type="content" source="media/support-cases-for-gcc-high-dod/warning-message-appear.png" alt-text="Screenshot shows the warning message for your confirmation.":::

1. A summary of changes may be provided. 

   :::image type="content" source="media/support-cases-for-gcc-high-dod/summary-change-provided.png" alt-text="Screenshot shows a summary of changes may be provided.":::

1. The desired address is shown here. 

   :::image type="content" source="media/support-cases-for-gcc-high-dod/desired-address-show.png" alt-text="Screenshot of the desired address in the Admin center.":::

**Option 2 - Add an alternate email address to the existing administrator user** 
1. Log into the Microsoft 365 admin center and look up the user.  
1. Edit the user and go to the Roles section. Select Edit. 

    :::image type="content" source="media/support-cases-for-gcc-high-dod/edit-role.png" alt-text="Screenshot shows steps to edit the roles for a Microsoft 365 user.":::

1. Scroll down and under Alternative email address, input the desired address. 

   :::image type="content" source="media/support-cases-for-gcc-high-dod/type-desired-address.png" alt-text="Screenshot to input the desired address under the Alternative email address.":::

1. The address added won't be listed on the Active user's page, but it will appear in Microsoft's system as an alternate email address, which can used to validate the caller during the creation of a support case.
