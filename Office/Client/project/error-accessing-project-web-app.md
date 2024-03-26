---
title: Error occurs when accessing Project Web App
description: Introduces how to give access to PWA and permissions.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Server 2013
  - Project Online
ms.date: 03/31/2022
---

# Error occurs when accessing Project Web App

## Symptoms

When you attempt to navigate to a PWA site, you may receive one of the following error messages:

> Sorry this site has not been shared with you  
> Access denied  
> Let us know why you need access to this site

Subsequently, you cannot access Project Web App.

## Cause

You do not have permissions to the root PWA site and/or you do not have group permissions.

## Resolution

In order for a user name to appear in the available users' list, the user must already have permissions on the PWA root site or they are a Global administrator. To Share the root PWA site using SharePoint Permissions mode:

1. As the PWA Admin, log into the PWA site that the user is having access issues.   
2. In the upper right-hand corner, underneath the account name click on the SHARE icon.    
3. Add the user (user@domain.com). The user will receive the Contribute permissions and be added to the group called "Team Members for Project Web App" on the root PWA site. You can change the default by clicking the SHOW OPTIONS link in the dialog.    
4. Give the synchronization about 2 minutes and then test access to the PWA site. 

Resolution when using Project Server Permissions mode:


1. As the PWA Admin, log into the PWA site that the user is having access issues.    
2. Go to Server Settings and click Manage Groups. Click on the group that you wish to modify.   
3. User accounts can be added by synchronizing with an Active Directory Group or added manually from the available users' list   

## More Information

This is by design for both Project Online (and Project Server 2013) regardless of the permissions mode on the PWA site.

SharePoint Permissions mode details - The PWA Admin must Share the root site with users, the user is given a specific set of permissions at the same time the root site is shared. This determines what they can see and do within just the PWA site.  Access to Project Sites is done in the same way, the individual site must be shared with individual user. 

Project Server Permissions mode details - Users can be added manually or synchronized using Active Directory groups (not SharePoint groups). If users are added manually, the PWA root site must be shared first in order for the users to be listed on the Available Users list in Manage Groups.  

Using Active Directory group synchronization, users are added to the Project Server group and the root PWA site is shared with them at the same time.  

To check which permissions mode your PWA site is using:

Visual Check - as PWA Admin click the gear in the upper right corner of the PWA home page and click PWA Settings. If you see the Security section heading, then you are in Project Server permissions mode. If you do not see this section, then you are in SharePoint permissions mode. 

SharePoint Admin Check - The SharePoint Admin can go to the Admin menu and click SharePoint. Then click the check box to the left of the Project Web App instance you want to investigate. On the ribbon, click Project Web App and click Settings. The current permissions mode in use is displayed.

Project Web App can use either Project Server permission mode or SharePoint permission mode to control user access. New Project Web App instances use the SharePoint permission mode by default. SharePoint permissions mode does not synchronize users with the root site or the project sites, this is only done when Project Server permissions mode is in use and configured to synchronize. 

**Warning**

Switching between Project Server permission mode and SharePoint permission mode deletes all security-related settings. 

**Group Names**

When using SharePoint Permissions mode the group name is appended with For Project Web App. When using Project Server permission mode the group name is appended with (Project Web App Synchronized)

Enterprise Resource Pool - User accounts added to the Enterprise Resource Pool are not automatically given permissions to log into the Project Web App home page. This is new behavior in 2013 from earlier versions of Project Server, regardless of security mode. This prevents users from having access to Project Web App home page automatically. The PWA Admin must "Share" the site with specific users or groups for users to have access. To get more information and best practices see the following article:

- [Best practices to configure Active Directory groups for Enterprise Resource Pool synchronization in Project Server 2013](https://technet.microsoft.com/library/jj819449.aspx). 
- [Manage connected SharePoint sites in Project Server 2013](https://technet.microsoft.com/library/gg982977.aspx)
