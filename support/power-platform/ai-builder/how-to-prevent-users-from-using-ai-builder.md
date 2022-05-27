---
title: Prevent users from using AI Builder
description: This article provides steps on how to prevent users from using AI Builder.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 5/26/2022
ms.subservice: 
---

# Prevent users from using AI Builder

This article provides steps to restrict access and usage of AI Builder to certain users.

_Applies to:_ AI Builder

## Symptoms

Users can access AI Builder when they should be prohibited.

## Cause

Users have rights to create AI models.

## Resolution

You need to be Administrator of your organization ID to perform this action.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments).
1. On the left pane, select **Environments**.
1. On the right pane, select your environment, and then select **Settings**.
1. Select **Users + permissions** > **Security roles**.
1. Select **Environment Maker** > **Edit**.
1. In the **Custom Entities** tab, select **AI Model** and then uncheck the option in the **Create** column. (See the below screenshot for this step.)

:::image type="content" source="media/how-to-prevent-users-from-using-ai-builder/security-role-environment-maker.png" alt-text="Screenshot of the unchecked Create option in the table AI Model.":::

## Resources

For more information, see [Roles and security in AI Builder](/ai-builder/security).
