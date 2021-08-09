---
title: No permissions to load Intune troubleshooting blade
description: Provides a solution for the issue where Intune troubleshooting blade fails to load for help desk operators.
ms.date: 05/18/2020
ms.prod-support-area-path: User logon or authentication
ms.reviewer: joelste, intunecic
---
# Intune troubleshooting blade fails to load for help desk operators

This article fixes an issue in which Intune troubleshooting blade fails to load for help desk operators.

_Original product version:_ &nbsp; Microsoft Intune, Commerce Intune  
_Original KB number:_ &nbsp; 4487946

## Symptoms

When a user signs in to Microsoft Intune as a **Help Desk Operator** role member, and goes to the Intune troubleshooting portal, the **Troubleshooting** blade displays a banner that states **Account status You do not have enough permissions**, and no user or device data is displayed.

:::image type="content" source="./media/troubleshooting-blade-fails-loading/troubleshooting-blade.png" alt-text="Screenshot of troubleshooting blade.":::

## Cause

The user is not licensed for Intune.

## Resolution

1. Sign in to [https://portal.azure.com](https://portal.azure.com/) as an Intune Administrator.
2. On the **Intune** blade, go to **Users** > **All Users**.
3. Select the user for whom the **Troubleshooting** blade fails to load.
4. On the **Licenses** tab, select **+Assign**, and follow the wizard to assign an Intune license.
5. Advise **Help Desk Operator** role members to access the Intune troubleshooting portal in a new browser session.

## More information

- [Use the troubleshooting portal to help users at your company](/mem/intune/fundamentals/help-desk-operators)
- [Role-based access control (RBAC) with Microsoft Intune](/mem/intune/fundamentals/role-based-access-control)
