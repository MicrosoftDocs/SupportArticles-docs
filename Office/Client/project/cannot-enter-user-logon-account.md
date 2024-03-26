---
title: Cannot enter User Logon Account for new resource
description: Describes an issue in which users cannot edit the User Logon Account field. Provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Project Server 2013
  - Project Online
ms.date: 03/31/2022
---

# Cannot enter User Logon Account for new resource

## Symptoms

When you open the Enterprise Resource Pool from Project Server 2013 or Project Online, into Project Professional 2013 or Project Pro for Microsoft 365 respectively, you cannot edit the **User Logon Account** field, the field is unavailable or grayed out. 

## Cause

This is by design. Microsoft Project Server 2013 and Project Online use the SharePoint platform for identity management, user management and authentication. This gives Project Server access to more types of authentication providers via SharePoint Server 2013, such as claims-based authentication as well as Google, Yahoo, or Facebook, which requires a specific process for adding resources/users. 

## Resolution

> [!NOTE]
> The resources and users that are created will have Log On permission, but no other permissions are granted and no group memberships are automatically applied.  In SharePoint Permissions mode, when you **Share** the top-level Project Web App (PWA) site with these users, you will select their group membership at the same time. Using ProjectServer Permissions mode you sync or add users to a specific security group.

**Resolution 1:** Use Active Directory Synchronization to add user login accounts to the Enterprise Resource Pool.  This is the preferred method and works for both SharePoint or ProjectServer permissions modes.

**Resolution 2** for SharePoint permissions mode only:

You will create a SharePoint Tasks list and assign Active Directory or Microsoft 365 users to tasks in the list by following these steps:

1. Create a **SharePoint Tasks List** either on a SharePoint Project site or within Project Web App (PWA).   
2. Create tasks and using the people picker assign users that you want to be resources with PWA and **Save** the list.   
3. Switch to PWA Resources.  You will now see the resources you added to the SharePoint Tasks List within the PWA Enterprise Resource Pool.  You still need to Share the top-level PWA site with these resources.    

**Resolution 3:** for Project Server permissions mode: 

> [!NOTE]
> This method will be phased out over time. 

This regkey will allow you to edit the **User logon Account** field when the Enterprise Resource Pool is opened in Project Professional 2013.

> [!IMPORTANT]
> This method contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Steps to add the registry key in order to edit User Logon Accounts in Project Professional: 

1. Launch the Registry editor by typing "Regedit" without quotes in the run line.   
2. Expand the following hive and add the following new **String Value** "WindowsAccountEditable" without quotes and set the value to "yes".   

   HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\MS Project\Profiles\\[ProfileName].

> [!NOTE]
> [ProfileName] implies that the registry key must be applied to each server profile configured in Project Pro 2013 for which you want to re-enable the User Logon Account field. The server profile would need to be set up first to ensure the full registry path exists.

Back in PWA Resource Center, select at least one resource, then click **Open** to open the Enterprise Resource Pool in Project Professional. You can now insert the **User Logon Account** field in the resource sheet and edit the field. Save and Close the Enterprise Pool and the resources are saved to PWA.  You still need to **Share** the top-level PWA site with these users for them to access PWA.
