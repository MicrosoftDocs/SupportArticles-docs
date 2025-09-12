---
title: Cannot add new apps to Outlook Web App
description: Describes an issue that occurs because the icon to add a new app from the Office Marketplace is unavailable.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: rrajan, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Microsoft 365 users can't add new apps to Outlook Web App

_Original KB number:_ &nbsp; 3016787

## Symptoms

When a Microsoft 365 user tries to install a new app for Microsoft Outlook Web App on the Installed App page, the **New** icon to add an app from the Microsoft Office Marketplace is not available. Therefore, the user can't add the app.

## Cause

The My Marketplace Apps role is not enabled in the role-assignment policy that's assigned to the user.

> [!NOTE]
> By default, the name of the role assignment policy is **Default Role Assignment Policy**.

## Resolution

Update the role assignment policy to enable the My Marketplace Apps role for the user. To do this, follow these steps:

1. Sign in to Microsoft 365 as an admin.
2. Select **Admin**, and then select **Exchange**.
3. Select **permissions**, and then select **user roles**.
4. Double-click **Default Role Assignment Policy**, or double-click the custom policy that's assigned to the user (as appropriate for your situation).
5. Select the **My Marketplace Apps** check box, and then select **save**.

## More information

When you set roles in a role assignment policy, you should remember that the change affects all users who are assigned that policy. Admins may want to create custom user role assignment policies that have different roles to assign to different users.

For more information about role-assignment policies, see [Understanding Role Based Access Control](/exchange/understanding-role-based-access-control-exchange-2013-help).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
