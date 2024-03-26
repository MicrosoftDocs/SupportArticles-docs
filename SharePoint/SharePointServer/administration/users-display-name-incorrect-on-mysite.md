---
title: User Display name is incorrect on MySite page
description: This article describes how a SharePoint MySite administrator can fix a user's incorrect MySite display name.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:User experience\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# A user's display name is incorrect on a company's SharePoint MySite page

## Symptoms

> [!NOTE]
> Although this article may apply to many different implementations of Microsoft SharePoint, it is especially applicable in a dedicated deployment of the Microsoft Business Productivity Online Suite.

As a site administrator for your company's MySite page on Microsoft SharePoint Server 2010, you find that a user's name is displayed incorrectly on the company's MySite page.

## Cause

The User Profile Sync service does not synchronize this user from the MySite Root.

## Resolution

Temporarily flag the user as active on the MySite Root to force the affected user's profile to synchronize from the MySite Root. To do this, follow these steps:


1. Access the MySite Root.   
2. Click **Site Actions**, and then click **Site Permissions**.   
3. Click **Grant Permissions**, and then grant Contribute permissions to the affected user.

   **Note** Make sure that you click to clear the **Send welcome e-mail to the new users** check box.   
4. Wait two hours for two cycles of the profile synchronization to run.

   **Note** The user's display name is now updated on the Profile page.   
5. Remove the Contribute permissions for this user.    

## More information  

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
