---
title: App permission error when updating user profile properties in SharePoint
description: Fix an access error and System.UnauthorizedAccessException when you use a Microsoft Entra app to update user profile properties in SharePoint Online by using app-only authentication.
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Permissions\Customize permissions
  - CSSTroubleshoot
  - CI 181203
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - SharePoint Online
---
# Error when using app to update user profile properties in SharePoint Online

## Symptoms

You use a Microsoft Entra app to update user profile properties in SharePoint Online by using app-only authentication. In this scenario, you receive **System.UnauthorizedAccessException** and the following error message:

> Access denied. You do not have permission to perform this action or access this resource.

## Cause

This issue occurs because the app doesn't have the required permissions to make the updates.

## Resolution

To fix this issue, [grant the User.ReadWrite.All permission](/sharepoint/dev/solution-guidance/security-apponly-azuread) to the app in the Azure portal. If you have to update taxonomic properties, also grant the `TermStore.Readwrite.All` permission.
