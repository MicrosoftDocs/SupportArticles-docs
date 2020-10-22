---
title: Outlook Customer Manager group creation in admin portal
description: Once you assign required license to users for the Outlook Customer Manager feature to be available, make sure that the Outlook Customer Manager group is created in the Office 365 admin portal automatically and make sure that Groups creation setting is enabled for users.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article 
ms.prod: office 365
localization_priority: Normal
search.appverid: 
- MET150
ms.custom: 
- CI 105558
- CSSTroubleshoot
ms.reviewer: sulobr
appliesto:
- Exchange Online
- Office 365
---

# "Can't add you to the Outlook Customer Manager group" error after you assign licenses to users

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

After you assign Microsoft Office 365 Business licenses that include the Outlook Customer Manager (OCM) feature, the OCM feature is still not available to users. Additionally, you receive the following error message when you try to click the OCM icon:

**Something went wrong. We can't add you to the Outlook Customer Manager group right now. Please close this pane and try again later.**

## Resolution

When you assign appropriate licenses to users, you should follow these steps:

1. Make sure that a group that's named **Outlook Customer Manager** is created in the Office 365 admin portal automatically. In this case, users who are assigned the appropriate licenses should also see this group under their list of **Groups** from Outlook on the web or Outlook.

   > [!NOTE]
   > The group creation should occur automatically in the back end. You don't have to create any group manually.

1. Make sure that the Office 365 Groups creation setting is enabled for users. To check the creation setting, you can use one of the following methods:

   - In the tenant level, run the following cmdlet:

     ```powershell
     Get-OrganizationConfig|fl GroupsCreationEnabled
     ```

     In the output, the **GroupsCreationEnabled** property is set to **True**.
   - If you disable the groups creation in the tenant level, you can set a security group in the tenant for users who can create groups, and then set the users as members of this security group. For more information about how to do this, see [Manage who can create Office 365 Groups](https://docs.microsoft.com/office365/admin/create-groups/manage-creation-of-groups?view=o365-worldwide&preserve-view=true).

For more information about Outlook Customer Manager, see the following articles:

- [Get started with Outlook Customer Manager](https://support.microsoft.com/office/ab120d0e-f5f6-4a7d-b4d1-9b93997e5c67)
- [Outlook Customer Manager FAQ](https://techcommunity.microsoft.com/t5/outlook-customer-manager/faq-frequently-asked-questions-about-outlook-customer-manager/m-p/29680)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).