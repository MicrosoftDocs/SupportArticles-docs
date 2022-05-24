---
title: How to prevent users from using AI Builder
description: this article provides steps on How to prevent users from using AI Builder
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 5/24/2022
ms.subservice: 
---

# AI Builder actions are disabled/deactivated

This article provides steps to restrict access and usage of AI Builder to certain users

_Applies to:_ AI Builder

## Prerequisite

You need to be Administrator of your organization ID to perform this action.


## Resolution

1.Sign in to the Power Platform admin center > Environments
2.Select your environment> Settings
3.Select Users + permissions > Security Roles
4.Select Environment Maker > Edit

5.Select Custom Entities Tab> AI Model > uncheck Create

:::image type="content" source="media/how-to-prevent-users-from-using-AI-Builder/security_role_environment_maker.png" alt-text="Uncheck create in the table AI Model." border="false":::

## Resources

For more information, see [Roles and security in AI Builder](https://docs.microsoft.com/ai-builder/security).