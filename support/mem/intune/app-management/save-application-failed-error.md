---
title: Insufficient permissions to update an application in Intune
description: Helps resolve an issue in which you can't save an application in Microsoft Intune when you have a custom Intune role assigned.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:AppDeployment - Windows\Win32
ms.reviewer: kaushika
---
# Save application failed error in Intune

This article helps you fix an issue where you receive the **Save application failed** error message when you try to update an application in Microsoft Intune.

## Symptoms

You have a custom Intune role assigned. The custom role includes permissions that are required to manage an application. When you update the application and try to save the change, you receive the following error message:

> Save application failed.  
> You don't have enough permissions to update this application, contact your administrator.

:::image type="content" source="media/save-application-failed-error/save-application-failed-error.png" alt-text="Screenshot of the Save application failed error.":::

## Cause

This problem occurs if the application's targeted groups aren't included in **Scope (Groups)** of the custom role assignment.

## Solution

To fix this problem, add the application's targeted groups to **Scope (Groups)** in the custom role assignment.
