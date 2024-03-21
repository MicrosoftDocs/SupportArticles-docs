---
title: Fail to delete orphaned NTDS Settings
description: Resolves an issue where you fail to delete an orphaned NTDS Settings from Active Directory Sites and Services.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, RKWON
ms.custom: sap:Active Directory\User, computer, group, and object management, csstroubleshoot
---
# Error Message: DSA Object Cannot Be Deleted

This article provides a solution to an issue where you fail to delete an orphaned NTDS Settings from Active Directory Sites and Services.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 318698

## Symptoms

When you try to delete an orphaned NTDS Settings from Active Directory Sites and Services, you may receive the following error message: DSA object cannot be deleted.

Only one NTDS Settings ordinarily exists under each server in the Servers folder in Active Directory Sites and Services. If two NTDS Settings are shown, the one that doesn't have connection objects associated with it (in the right pane) is probably the orphaned NTDS Settings.

## Cause

The Dcpromo.exe demotion process must delete NTDS Settings from a server. However, the Dcpromo.exe process may not delete NTDS Settings even if connection objects are deleted. If you have multiple domain controllers, the Active Directory replication process may not delete NTDS Settings from this domain controller.

## Resolution

To work around this problem, complete the following procedure on a domain controller that has an orphaned NTDS Settings:

1. Start ADSI Edit, and then expand the following branches:

    - Configuration NC 
    - CN=Configuration,DC=domain, DC=com 
    - CN=Sites 
    - CN= **your site name**  
    - CN=Servers 
2. Locate the server that has an orphaned NTDS Settings. Right-click the orphaned NTDS Settings, and then click Delete.
3. If you have multiple domain controllers, make sure that this change is replicated to all domain controllers.

An orphaned NTDS Settings object may also be found in the LostAndFoundConfig Container under the Configuration Container in ADSI Edit. You can use the analogous procedure to delete this object. To do this:

1. Start ADSI Edit, and then expand the following branches:

    - Configuration NC 
    - CN=Configuration,DC=domain, DC=com 
    - CN=LostAndFoundConfig 
2. Right-click the orphaned NTDS Settings object, and then click **Delete**. Make sure that the related server object doesn't exist before deleting the NTDS Settings object.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.  

## More information

ADSIEDIT is part of the Windows 2000 Support Tools.
