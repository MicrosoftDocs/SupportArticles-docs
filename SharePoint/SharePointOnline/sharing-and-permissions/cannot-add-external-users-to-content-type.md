---
title: You can't add external users to a SharePoint Online External Content Type in the SharePoint admin center
description: Describes an issue in which you can't add external users to a SharePoint Online External Content Type in the SharePoint admin center.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:SharePoint Admin Center\Content Type Gallery
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Cannot add external users to a SharePoint Online External Content Type in the SharePoint admin center

## Problem

Assume that you try to grant an external user permission to an External Content Type in the Microsoft 365 SharePoint admin center. However, when you try to locate the user by using the Check Names feature or the **Select People and Groups** dialog box, the process doesn't work.

Specifically, when you try to add the external user, you may receive one of the following messages, depending on your specific scenario:

- No exact match was found. Click the item(s) that did not resolve for more options.

- No results were found to match your search item. Enter a new term or less specific term.

## Solution

To resolve this issue, grant access to the **Everyone** or **All Users (membership)** groups to the External Content Type, and then use list permissions to manage permissions to the external resource. To do this, follow these steps:

1. Browse to the SharePoint admin center.

2. Click **secure store**.

3. Select the **Target Application ID** that you use for the external list, and then on the ribbon, click **Edit**.

4. In the **Members** box, add the **Everyone** group, and then at the bottom of the screen, click OK.

5. In the SharePoint admin center, click **bcs**.

6. On the **bcs** menu, click **Manage BDC Models and External Content Types**.

   **NOTE** Make sure that **View** is set to **External Content Types**.

7. Select the **BDC Model** that's used for the external content, and then click **Set Metadata Store Permissions**.

8. In the **set Metadata Store permissions** dialog box, add **Everyone** to the permissions box, and then click Add.

   :::image type="content" source="media/cannot-add-external-users-to-sharepoint-online-external-content-type/set-metadata-store-permissions.png" alt-text="Screenshot of the set Metadata Store permissions dialog when you add Everyone to the permissions box." border="false":::
9. In the list of available accounts for the Metadata Store, select the **Everyone** group, and then make sure that the **Execute** check box is selected.

10. At the bottom of the dialog box, click to select the **Propagate permissions to all BDC Models, External Systems and External Content Types in the BDC Metadata Store** check box, and then click **OK**.

After you've completed these steps, manage access to the external list by using SharePoint permissions where the external content exists on the SharePoint site.

## More information

This is expected behavior in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
