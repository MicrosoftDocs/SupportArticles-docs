---
title: Default promoted sites appear on the SharePoint Online Sites page after you delete them
description: Describes an issue in which default promoted sites appear on the SharePoint Online Sites page after you delete them.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# Default promoted sites appear on the SharePoint Online Sites page after you delete them

## Problem

After you delete the default promoted sites from the Sites page in Microsoft SharePoint Online, the sites continue to appear on the Sites page. This issue occurs after you use either of the following methods to delete the sites:

- You click Sites on the Microsoft Office 365 ribbon, click **Manage**, click a link, and then click **Remove link**.

- You browse to the SharePoint admin center, click **user profiles**, click **Manage Promoted Sites**, and then change the promoted sites.

When you open the Sites page again, you see that the default sites are still displayed.

**NOTE** This issue does not apply to Office 365 Small Business.

## Solution/Workaround

To work around this issue, use audience targeting to filter out the promoted sites that you don’t want displayed on the users' Sites page. To do this, follow these steps:

1. Browse to the SharePoint admin center, and then click **user profiles**.

2. In the **People** section, click **Manage Audiences**, and then click **New Audience**.

3. Provide a name for the new audience, and then assign an **Owner**.

4. For the **Include users who setting**, select **Satisfy all the rules**, and then click **OK**.

5. On the next page, configure the following settings:

   - **Operand**: Click **Property**. Then, in the **Property** drop-down list, click **First name**.

   - **Operator**: In the **Operator** drop-down list, select the = character.

   - **Value**: Enter a value that doesn't match the first name of any users. For example, enter a random string of characters.

6. At the bottom of the page, click **OK**.

7. In the SharePoint admin center, click **user profiles**.

8. In the **My Site Settings** section, click **Manage Promoted Sites**.

9. The promoted sites page will display all the default promoted sites. For each promoted site that you want to delete from the Sites page for all users, follow these steps:

   - Click the **edit** icon for the site.

   - In the **Target Audiences** field, select the audience name that you created in step 3, and then click **OK**.

   **NOTE** You must complete the actions that are described in step 9 for each site that you want to remove from the users' Sites page.

## More information

This is a known issue in SharePoint Online.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
