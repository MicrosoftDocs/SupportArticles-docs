---
title: Insufficient permissions to update an application
description: Describes an issue in which you can't save an application in Intune when you have a custom Intune role assigned. Provides a resolution.
ms.date: 07/24/2020
ms.prod-support-area-path: Add apps
---
# Save application failed error when you try to update an application in Intune

This article helps you fix an issue where you receive the **Save application failed** error message when you try to update an application in Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4537088

## Symptoms

You have a custom Intune role assigned. The custom role includes permissions that are required to manage an application. When you update the application and try to save the change, you receive the following error message:

> Save application failed.  
> You don't have enough permissions to update this application, contact your administrator.

:::image type="content" source="media/save-application-failed-error/save-application-failed-error.png" alt-text="Save application failed error.":::

## Cause

This problem occurs if the application's targeted groups aren't included in **Scope (Groups)** of the custom role assignment.

## Resolution

To fix this problem, add the application's targeted groups to **Scope (Groups)** in the custom role assignment.
