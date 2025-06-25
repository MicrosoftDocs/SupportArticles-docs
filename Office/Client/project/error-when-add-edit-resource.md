---
title: Error when you add or edit a resource in Enterprise Resource Pool
description: Explanation and resolution steps if you receive an error when you attempt to Add or Edit a resource in Project Enterprise Resource Pool.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Online
  - Project Server 2013
ms.date: 05/26/2025
---

# Error occurs when you add or edit a Resource in Enterprise Resource Pool

## Symptoms

When you attempt to Save a resource to the Enterprise Resource Pool, you may receive the following error message:

> "The resource could not be saved due to the following reasons: The resource account is already in use."

## Cause

You receive this message when all three conditions listed below are met:

1. The Project Web App site has been shared with the user (Sharepoint Permissions Mode) or a user account created for them (Project Server Permissions Mode).
2. They have logged into PWA successfully. 
3. The user name has been entered into the Enterprise Resource Pool without a User Logon Account.

This creates two different accounts in Project Web App (PWA), one as a Resource and one as a User. When you go to Delete Enterprise Objects you will see the account listed twice, once as a resource and once as a user, but you can't identify which is a user vs. a resource in this view.

## Resolution

You will delete the user and then modify the resource to include the User Logon Account. But first, you need to be able to identify which is the resource and which is the user. To do this follow the below steps:

1. Click Resources to take you to the Resource Center. Put a check mark next to the resource that has the issue (No User Logon Account).    
2. On the Resources ribbon click Edit. Select "Inactive" from the Account Status drop down menu, click OK and Save. This account you will keep and modify once we delete the user account.   
3. Go to Server Settings and click Delete Enterprise Objects.   
4. Select the radio button for Resource and Users. Check the box next to the duplicate resource name where the value is Yes for Active and clicks Delete. Click OK to verify you want to delete this user. You are deleting the active user and will then modify the inactive resource to also be a user.   
5. Click Resources, check the box next to the inactive resource if it is not already checked.    
6. On the Resources ribbon click Edit. Check the box for Associate resource with a user account.    
7. Change Account Status to "Active". Enter the user's name in the User logon account field. Click Save.    

## More Information

A related article that pertains to Project Server 2013: [Cannot enter User Logon Account for new resource"](https://support.microsoft.com/help/2816252).
