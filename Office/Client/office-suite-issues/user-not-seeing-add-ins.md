---
title: Users Don't See Add-ins
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
description: Resolves issues that your users don't see add-ins in Microsoft 365 application.
ms.date: 05/29/2025
---

# Users don't see add-ins

After you [deploy add-ins](/microsoft-365/admin/manage/manage-deployment-of-add-ins?view=o365-worldwide), your end users can start using them in their Microsoft 365 applications. The add-in appears on all platforms that the add-in supports.
  
## For Word, PowerPoint, Excel

If the add-in supports add-in commands, the commands appear on the ribbon. In the following example, the command appears for the People Graph add-in in the **Insert** tab. The add-in command can appear on any tab.
  
:::image type="content" source="./media/user-not-seeing-add-ins/people-graph.png" alt-text="Screenshot of People Graph in the Insert tab." border="false":::
  
If the deployed add-in doesn't support add-in commands or if you want to view all deployed add-ins, you can view them by selecting **My Add-ins** from the **Insert** tab.
  
:::image type="content" source="./media/user-not-seeing-add-ins/my-add-ins.png" alt-text="Screenshot shows you can view add-ins in My Add-ins from the Insert tab." border="false":::
  
Then select the **Admin Managed** tab along the top in the Office Add-ins window. If add-in isn't there, select **Refresh**.
  
:::image type="content" source="./media/user-not-seeing-add-ins/refresh-if-your-add-in-is-not-present.png" alt-text="Screenshot of Refresh in the top right corner." border="false":::
  
## For Outlook

On the **Home** ribbon, select **Store**, and then select **Admin-managed**.
  
:::image type="content" source="./media/user-not-seeing-add-ins/store-button.png" alt-text="Screenshot of the Store button." border="false":::
  
If users can't see add-in, try one of the following methods:
  
- **Use the compatibility checker**

  - It outputs a status report for each user in your organization, whether they have a valid Microsoft 365 License, are set up correctly on Exchange, and are ready for centralized deployment. For more information, see [deployment compatibility checker](https://www.microsoft.com/download/details.aspx?id=55270).  
- **Check [Microsoft 365 requirements](/microsoft-365/admin/manage/centralized-deployment-of-add-ins?view=o365-worldwide&preserve-view=true#microsoft-365-requirements)**  
- **Check [Exchange Online requirements](/microsoft-365/admin/manage/centralized-deployment-of-add-ins?view=o365-worldwide&preserve-view=true#exchange-online-requirements)**
- **See regulations regarding [minors using add-ins](/microsoft-365/admin/manage/minors-and-acquiring-addins-from-the-store?view=o365-worldwide&preserve-view=true)**
- **Check for nested groups**

  - Add-ins no longer appear to the user if the user is removed from a group that the add-in is assigned to.
  - Centralized deployment currently doesn't support nested group assignments. It supports users in top-level groups or groups without parent groups, but not users in nested groups or groups that have parent groups.

  For more information, see [user and group assignments](/microsoft-365/admin/manage/centralized-deployment-of-add-ins?view=o365-worldwide&preserve-view=true#user-and-group-assignments).
