---
title: Authentication failed when signing in to Microsoft Flow
description: You receive the Authentication failed error when trying to sign in to Microsoft Flow.
ms.reviewer: trbaratc
ms.date: 03/31/2021
ms.custom: sap:Authentication or Sign-in\Licensing
---
# You can't sign in to Microsoft Flow and you receive an "Authentication failed" error

This article provides a resolution for the issue that you receive the **Authentication failed** error when trying to sign in to Microsoft Flow.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4316891

## Symptoms

When you try to sign in to Microsoft Flow, you receive an **Authentication Failed** error message that resembles the following:

:::image type="content" source="media/cannot-sign-in-to-microsoft-flow-due-to-authentication-failed/authentication-failed-error.png" alt-text="Screenshot of the error page when signing in to Flow.":::

The URL in the message might resemble the following:

`https://flow.microsoft.com/AuthenticationFailed/?message=AADSTS50001%3a+Resource+%27https%3a%2f%2fservice.flow.microsoft.com%2f%27+is+disabled`

This URL indicates that your tenant is affected by this issue.

## Cause

This issue occurs when the last Flow license (or Office license that includes Flow) expires in your tenant. In this situation, the Flow service is disabled in Microsoft Entra ID.

Although this behavior is appropriate for most applications, it also blocks access to Flow if a relevant license exists in the tenant, even though Flow can be used for free without a license.

Flow is now excluded from the list of applications for which access is automatically disabled because of an expired license. However, tenants that were already disabled aren't reverted to a non-disabled state. In such cases, access to Flow remains blocked.

## Resolution

To resolve this problem, follow these steps.

> [!NOTE]
> These steps can be performed only by the tenant administrator.

1. Open the [Azure portal](https://portal.azure.com)), and sign in.
2. In the navigation bar, open Microsoft Entra Settings.

3. Navigate to **Enterprise applications** > **All applications**.

4. Paste **7df0a125-d3be-4c96-aa54-591f83ff541c** into the filter input.

    > [!NOTE]
    > This is the application ID for the Flow service. You may have to select **All applications** in the **Show** list.

    :::image type="content" source="media/cannot-sign-in-to-microsoft-flow-due-to-authentication-failed/filter-input.png" alt-text="Screenshot to paste 7df0a125-d3be-4c96-aa54-591f83ff541c into the filter input.":::

5. Select **Microsoft Flow Service**, and then select **Properties**.
6. Make sure that the **Enabled for users to sign-in?** option is set to **Yes**.

    :::image type="content" source="media/cannot-sign-in-to-microsoft-flow-due-to-authentication-failed/enabled-for-users-to-sign-in.png" alt-text="Screenshot to check the Enabled for users to sign-in field is set to Yes.":::

7. Select **Save**.

All users should now be able to sign in to the Flow portal again.

## More information

For more information, or to contact the Flow team about issues regarding these steps, see [Known Issue: Login Troubles](https://flow.microsoft.com/blog/known-issue-login-troubles/).
