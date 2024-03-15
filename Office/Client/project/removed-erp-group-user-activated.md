---
title: Users removed from Enterprise Resource Pool group sync are not inactivated
description: Provides solutions for the issue where users removed from Enterprise Resource Pool group sync are not inactivated.
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
author: helenclu
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Project Online
  - Project Server 2013
ms.date: 03/31/2022
---

# Users removed from the Enterprise Resource Pool group sync are not inactivated

## Symptoms

After removing users from an Active Directory security group used to synchronize user accounts in Project Web App's (PWA) 2013 Enterprise Resource Pool, resources are not inactivated.  Previous behavior in Project Web App 2010 the users were inactivated.

## Cause

This is by design in Project Online and new behavior in Project Server 2013 when using the default SharePoint permissions mode. When synchronizing security groups with the Enterprise Resource Pool (ERP), the users added to the ERP are not automatically inactivated if their account has been removed from the Active Directory group used to synchronize.

The new behavior assumes that even when a user account is removed from an active directory group they may still be a valid resource that can be used in project plans by Project Managers and should not be marked as inactive.

This is only true when using SharePoint permissions mode. Project Server 2013 and Project Online use SharePoint permissions mode by default in all new instances.  Project Server permissions mode will be in use on an upgraded Project Server 2010 site.  An Administrator can also set Project Server permissions mode on specific instances of PWA if more granular control of permissions are needed.  For more information about Project Online or Project Server 2103 permissions modes, see [Plan user access in Project Server 2013](https://technet.microsoft.com/library/fp161361.aspx).  

## Resolution

To remove a user's access to log into PWA, use one of the following options:

**Remove the user's Project Online license**

1. As the Tenant Administrator log into your online tenant    
2. Navigate to the Microsoft 365 admin center and click users and groups    
3. Select one or multiple user accounts and click the edit icon    
4. Click next until you come to the licenses or assign licenses page.    
5. Click the radio button next to **Replace existing license assignments** and then select the licenses that apply to your users making sure to leave **Project Online Plan 1** unselected.    
6. Click **submit** and click **finish**.    

**Remove the user's account from any groups with access to the PWA home page**

1. Navigate to the Project Web App home page with PWA Administrator permissions.    
2. Click on the gear icon to the right of your user account and click Shared With.    
3. Click ADVANCED to show all security groups.    
4. Click a group, then select the user and under the Actions menu click Remove users from Group and click OK    

## More Information

Additionally, users added or synchronized to the Enterprise Resource Pool are not added to the Team Members security group on the Project Web App home page. Users must be manually added to a group on the PWA home page in order to log in. For more information, see [Plan SharePoint groups in Project Server](https://technet.microsoft.com/library/fp161360.aspx).
