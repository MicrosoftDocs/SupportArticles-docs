---
title: You receive an error when accessing Project Web App
description: Explains errors when accessing PWA Online if you have no permissions
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Online
  - Project Server 2013
ms.date: 03/31/2022
---

# Project Online, You receive an error when accessing Project Web App

## Symptom 

After you successfully sign into your Online tenant and click the Projects link or navigate to a PWA site, you may receive one of the following error messages:

"Sorry this site has not been shared with you".

Or

"Access denied"

Or

"Let us know why you need access to this site." 


Subsequently, you cannot access Project Web App.

## Cause 

1. You have not been granted permissions to the root PWA site or given group permissions.   
2. Project Online was added to your tenant after SharePoint Online was already provisioned, in which case no one has access to PWA.   

## Resolution 

Cause 1 resolution when using SharePoint Permissions mode: 

1. The PWA Admin needs to log into the online tenant.    
2. Navigate to the PWA home page that the user needs access too.    
3. In the upper right-hand corner, underneath the account name click on the SHARE icon.    
4. Add the user (user@domain.com). The user will receive the Contribute permissions and be added to the group called "Team Members for Project Web App" on the root PWA site. You can change the default by clicking the SHOW OPTIONSlink in the dialog.    
5. Give the synchronization about 2 minutes and then test access to the PWA site.   

Cause 1 resolution when using Project Server Permissions mode:

1. The PWA Admin needs to log into the online tenant.
1. Navigate to the PWA home page that the user needs access too.
1. Go to Server Settings and click Manage Groups.  Click on a group that you wish to modify.
1. User accounts can be added by synchronizing with an Active Directory Group or added manually from the available user's list.  

   In order for a user name to appear in the available user's list, the user must already have permissions on the PWA root site or they are a Global administrator. Refer to the SharePoint Permissions mode steps above to Share the root PWA site.

Cause 2 resolution:

1. Log in your online tenant as the tenant Administrator.    
2. From the Admin menu dropdown, select SharePoint to go to the SharePoint admin center.    
3. Check the box next to the PWA site where you want to add an Administrator.  
4. On the Site Collections ribbon click on Owners and select Manage Administrators.    
5. In the Site collection Administrators box add the user and click OK.   

## More Information 

This is by design for Project Online (and Project Server 2013) regardless of the permissions mode on the PWA site.

SharePoint Permissions mode details - The PWA Admin must share the root site with users, the user is given a specific set of permissions at the same time the root site is shared. This determines what they can see and do within just the PWA site.  Access to Project Sites is done in the same way, the individual site must be shared with individual user. 

Project Server Permissions mode details - Users can be added manually or synchronized using Active Directory groups (not SharePoint groups). If users are added manually, the PWA root site must be shared first in order for the users to be listed on the Available Users list in Manage Groups.  

Using Active Directory group synchronization, users are added to the Project Server group and the root PWA site is shared with them at the same time.  

To check which permissions mode your PWA site is using:

Visual Check- as PWA Admin click the gear in the upper right corner of the PWA home page and click PWA Settings. If you see the Security section heading, then you are in Project Server permissions mode. If you do not see this section, then you are in SharePoint permissions mode. 

SharePoint Admin Check- The SharePoint Admin can go to the Admin menu and click SharePoint. Then click the check box to the left of the Project Web App instance you want to investigate. On the ribbon, click Project Web App and click Settings. The current permissions mode in use is displayed.

Project Web App can use either Project Server permission mode or SharePoint permission mode to control user access. New Project Web App instances use the SharePoint permission mode by default. SharePoint permissions mode does not synchronize users with the root site or the project sites, this is only done when Project Server permissions mode is in use and configured to synchronize. 

> [!WARNING]
> Switching between Project Server permission mode and SharePoint permission mode deletes all security-related settings. 

Group Names:
When using SharePoint Permissions mode the group name is appended with For Project Web App.  when using Project Server permission mode the group name is appended with (Project Web App Synchronized)

Enterprise Resource Pool - User accounts added to the Enterprise Resource Pool are not automatically given permissions to log into the Project Web App home page. This is new behavior in 2013 from earlier versions of Project Server, regardless of security mode. This prevents users from having access to Project Web App home page automatically. The PWA Admin must "Share" the site with specific users or groups for users to have access. To get more information and best practices see the following article: 

[https://technet.microsoft.com/en-us/library/jj819449.aspx](https://technet.microsoft.com/library/jj819449.aspx)
