---
title: Prevent users from creating AI Builder custom models
description: This article provides steps on how to prevent users from creating AI Builder custom models.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 07/21/2022
ms.subservice: 
ms.author: angieandrews
author: v-aangie
---

# Prevent users from creating AI Builder custom models

This article provides steps to restrict the creation of AI Builder custom models.

_Applies to:_ AI Builder

## Symptoms

Users can create AI Builder custom models when they should be prohibited.

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

## Resources

For more information, see [Roles and security in AI Builder](/ai-builder/security).
