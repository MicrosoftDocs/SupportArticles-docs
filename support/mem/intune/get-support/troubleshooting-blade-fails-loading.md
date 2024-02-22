---
title: No permissions to load Intune Troubleshooting pane
description: Provides a solution for the issue when the Microsoft Intune Troubleshoot pane fails to load for help desk operators.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:User logon or authentication
ms.reviewer: kaushika, joelste, intunecic
---
# Intune troubleshooting portal fails to load for help desk operators

This article helps Intune Administrators resolve an issue in which the Intune **Troubleshoot** pane fails to load for help desk operators.

## Symptoms

When a user signs in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431) as a **Help Desk Operator** role member, and goes to the Intune troubleshooting portal, the **Troubleshoot** pane displays a banner that states **Account status You do not have enough permissions**, and no user or device data is displayed.

:::image type="content" source="media/troubleshooting-blade-fails-loading/troubleshooting-blade.png" alt-text="Screenshot of troubleshooting blade showing the Account status You do not have enough permissions message.":::

## Cause

The user is not licensed for Intune.

## Solution

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431) as an Intune Administrator.
2. On the **Intune** pane, go to **Users** > **All Users**.
3. Select the user for whom the **Troubleshoot** pane fails to load.
4. On the **Licenses** tab, select **+Assign**, and follow the wizard to assign an Intune license.
5. Advise **Help Desk Operator** role members to access the Intune troubleshooting portal in a new browser session.

## More information

- [Use the troubleshooting portal to help users at your company](/mem/intune/fundamentals/help-desk-operators)
- [Role-based access control (RBAC) with Microsoft Intune](/mem/intune/fundamentals/role-based-access-control)
