---
title: You cannot view "RemoteApp" programs on an RD Session Host server by using RD Web Access
description: Provides a resolution for the issue that you cannot view "RemoteApp" programs on an RD Session Host server by using RD Web Access
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, nedpyle
ms.custom: sap:rdweb, csstroubleshoot
ms.subservice: rds
---
# You cannot view "RemoteApp" programs on an RD Session Host server by using RD Web Access

This article provides a resolution for the issue that you cannot view "RemoteApp" programs on an RD Session Host server by using RD Web Access.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 978322

## Symptoms

When you use a domain user account to log on to Remote Desktop Web Access (RD Web Access), you cannot view the list of **RemoteApp** programs that are on an RD Session Host server that is running Windows Server 2008 R2. However, the local accounts can view the **RemoteApp** programs.

Additionally, RD Web Access tracing logs an error that resembles the following error:

>[Error] App Filtering:Error starting filtering: Could not initialize context from SID. SID: S-1-5-21-1997477047-1508330638-219632125-223304, Error: 0x80070005

## Cause

This issue occurs when a domain is created by using the option **Permissions compatible only with Windows 2000 or Windows Server 2003 operating systems**. When this option is selected, the built-in Everyone group is not made a member of the "Pre-Windows 2000 Compatible Access" group. This issue also occurs if the membership of the group is later changed to no longer include the Everyone group as part of a domain security hardening procedure.

## Resolution

To resolve this problem, add the RD Web Access machine account to the Windows Authorization Access Group on the domain controller.

## More information

The AuthzInitializeContextFromSid function reads the tokenGroupsGlobalAndUniversal attribute of the SID that is specified in a function call. This is done to determine the group memberships of the current user. If the object of the user is in Active Directory Domain Services (AD DS), the calling context must have read access to the tokenGroupsGlobalAndUniversal attribute in the user object. Read access to the tokenGroupsGlobalAndUniversal attribute is granted to the "Pre-Windows 2000 Server Compatible Access" group. However, new domains contain an empty "Pre-Windows 2000 Server Compatible Access" group. This is by default, because the default setup selection is permissions compatible with Windows 2000 Server and with Windows Server 2003. Therefore, applications may not have access to the tokenGroupsGlobalAndUniversal attribute. In this case, the AuthzInitializeContextFromSid function fails together with an ACCESS_DENIED error. Applications that use this function should correctly handle this error and should provide supporting documentation. To simplify granting accounts permission for querying the group information about a user, add accounts that need the ability to look up group information to the Windows Authorization Access Group.
