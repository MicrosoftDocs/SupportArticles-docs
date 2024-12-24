---
title: Your request couldn't be completed when searching audit log
description: Describes an error that occurs when a user tries to search the audit log in the Office 365 Security & Compliance Center. Provides a solution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Auditing
  - CSSTroubleshoot
ms.reviewer: neozhu
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 06/24/2024
---

# "Your request couldn't be completed. Please try again" error when you try to search the audit log in Microsoft 365

_Original KB number:_&nbsp;3193501

## Problem

When a user tries to search the audit log in the Office 365 Security & Compliance Center, the user receives the following error message:

> Your request couldn't be completed. Please try again, and if the problem persists, contact your administrator.

## Cause

The user isn't assigned to the View-Only Audit Logs role or the Audit Logs role in Exchange Online.

## Solution

Create a custom role group in the Exchange admin center, add the View-Only Audit Logs or Audit Logs role, and then add the user as a member of the new role group:

1. Open the Exchange admin center. For more information, see [Exchange admin center in Exchange Online](/exchange/exchange-admin-center).
2. Select **Permission** > **admin role**, and then select **New** (:::image type="icon" source="media/issue-search-audit-log/add-button.png":::) to create a new role group.
3. On the 'New role group' page:
   1. Specify a name for the role group.
   1. In the **Role** box, select **Add** (:::image type="icon" source="media/issue-search-audit-log/add-button.png":::), add the **View-Only Audit Log** or **Audit Log** role, and then select **OK**.
   1. In the **Member** box, select **Add** (:::image type="icon" source="media/issue-search-audit-log/add-button.png":::), add the user, and then select **Save**.

## More information

For more information, see [Search the audit log in the compliance portal](https://support.office.com/article/0d4d0f35-390b-4518-800e-0c7ec95e946c).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
