---
title: Users Don't See Add-ins
description: Resolves issues that prevent your users from seeing add-ins in Microsoft 365 applications.
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom:
  - sap:Building and Debugging Add-Ins for Office 365 Web and Desktop Apps
  - CSSTroubleshoot
  - CI 5934
ms.collection: 
  - M365-subscription-management
  - Adm_O365
search.appverid: 
  - BCS160
  - MET150
  - MOE150
ms.assetid: 060e809d-8cb6-427b-9e2f-dab67138acae
ms.date: 06/02/2025
---

# Users don't see add-ins

After you [deploy add-ins](/microsoft-365/admin/manage/manage-deployment-of-add-ins) in Microsoft 365 applications, the add-ins should appear on all platforms that the add-ins support.

**For Word, PowerPoint, Excel**

If the add-in supports add-in commands, the commands appear on the ribbon. The commands can appear on any tab. In the following example, the command for the People Graph add-in appears on the **Insert** tab. 
  
:::image type="content" source="./media/user-not-seeing-add-ins/people-graph.png" alt-text="Screenshot of People Graph on the Insert tab." border="false":::
  
If the deployed add-in doesn't support add-in commands, you can view any or all add-ins by selecting **My Add-ins** on the **Insert** tab.
  
:::image type="content" source="./media/user-not-seeing-add-ins/my-add-ins.png" alt-text="Screenshot shows that you can view add-ins in My Add-ins on the Insert tab." border="false":::
  
Then, select the **Admin Managed** tab at the top of the Office Add-ins window. If the add-in doesn't appear there, select **Refresh**.
  
:::image type="content" source="./media/user-not-seeing-add-ins/refresh-if-your-add-in-is-not-present.png" alt-text="Screenshot of the Refresh command in the top-right corner." border="false":::
  
**For Outlook**

On the **Home** ribbon, select **Store** > **Admin-managed**.
  
:::image type="content" source="./media/user-not-seeing-add-ins/store-button.png" alt-text="Screenshot of the Store button." border="false":::

If users can't see add-ins, use one of the following methods:
  
- Use the Compatibility Checker.

   The Compatibility Checker outputs a status report for each user in your organization. The tool reports whether users have a valid Microsoft 365 License, are set up correctly in Exchange Server, and are ready for centralized deployment. For more information, see [Centralized Deployment Compatibility Checker](https://www.microsoft.com/download/details.aspx?id=55270).
- Check [Microsoft 365 requirements](/microsoft-365/admin/manage/centralized-deployment-of-add-ins?view=o365-worldwide&preserve-view=true#microsoft-365-requirements).
- Check [Exchange Online requirements](/microsoft-365/admin/manage/centralized-deployment-of-add-ins?view=o365-worldwide&preserve-view=true#exchange-online-requirements).
- See regulations regarding [minors using add-ins](/microsoft-365/admin/manage/minors-and-acquiring-addins-from-the-store?view=o365-worldwide&preserve-view=true).
- Check for nested groups.

  - Add-ins no longer appear to the user if the user is removed from a group that the add-in is assigned to.
  - Centralized deployment currently supports users in top-level groups or groups without parent groups. It doesn't support users in nested group assignments or groups that have parent groups.

  For more information, see [user and group assignments](/microsoft-365/admin/manage/centralized-deployment-of-add-ins?view=o365-worldwide&preserve-view=true#user-and-group-assignments).
