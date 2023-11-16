---
title: Set roaming profile path for all users
description: Describes the behavior where the Set roaming profile path for all users logging onto this computer Group Policy setting applies to all user accounts including local user accounts because Group Policy will override the local computer policy.
ms.date: 01/17/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
ms.technology: windows-server-group-policy
---
# The Set roaming profile path for all users logging onto this computer Group Policy setting also applies to local user accounts

This article describes the behavior where the **Set roaming profile path for all users logging onto this computer** Group Policy setting applies to all user accounts including local user accounts because Group Policy will override the local computer policy.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 958736

## Symptoms

You apply the **Set roaming profile path for all users logging onto this computer** Group Policy setting in a domain for member servers. In this case, the Group Policy setting applies to all user accounts, and this includes the local user accounts.

## Cause

This behavior is expected because the **Set roaming profile path for all users logging onto this computer** Group Policy setting is present under the Computer Configuration node in Group Policy. Even if you specify a local computer policy, Group Policy overrides the local computer policy. So the Group Policy setting applies to all users, and this includes the local users.

## More information

> [!IMPORTANT]
> Consider the following scenario. You set up a profile on a member server. The profile includes some important settings. In this scenario, if you apply the Set roaming profile path for all users logging onto this computer Group Policy setting, you lose your current profile. Additionally, you are assigned a default temporary profile.

This behavior occurs because the Group Policy setting sets a roaming profile for all users even though the users are local to the member server. In the Windows registry, a registry value that is named CentralProfile in the following registry subkey is used to set the share path of the roaming profile that is mentioned in the Group Policy for local users:  

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows  NT\CurrentVersion\ProfileList\<userSID>\CentralProfile`  

> [!NOTE]
> The \<userSID> placeholder specifies the security identifier (SID) of the user.

So you're assigned a default temporary profile because you don't have access to the remote share.

The following roaming profile policy settings are currently available in Windows Server:

- **Set path for Remote Desktop Services Roaming User Profile**
- **Set roaming profile path for all users logging onto this computer**

### Set path for Remote Desktop Services Roaming User Profile

The **Set path for Remote Desktop Services Roaming User Profile** Group Policy setting lets you specify the network path that Remote Desktop Services (RDS) uses for roaming user profiles.

By default, RDS stores all user profiles locally on the RDS server. You can use the **Set path for Remote Desktop Services Roaming User Profile** Group Policy setting to specify a network share where user profiles can be centrally stored. When profiles are centrally stored, users can access the same profile for sessions on all RDS servers that are configured to use the network share for user profiles.

> [!NOTE]
>
> - The roaming user profiles that are enabled by the **Set path for Remote Desktop Services Roaming User Profile** Group Policy setting apply only to RDS connections. You may also have a Windows roaming user profile that is configured. The RDS roaming user profile always takes precedence in a RDS session.
> - If you configure the **Set path for Remote Desktop Services Roaming User Profile** Group Policy setting, each user who logs on by using a RDS session uses the path that is specified as the roaming profile location.

### Set roaming profile path for all users logging onto this computer

To use the **Set roaming profile path for all users logging onto this computer** Group Policy setting, type the path of the network share in the following form:

\\\\**Computername**\\**Sharename**\

If you enable the **Set roaming profile path for all users logging onto this computer** Group Policy setting, all users who log on to the computer use the roaming profile path that is specified in the Group Policy setting. This behavior is by design.

> [!Note]  
>
> - You have to make sure that you have set the appropriate security on the folder to let all users access the profile.
> - If you use a local user account, the profile path may fail because of lack of permissions.
> - There are four ways to configure a roaming profile for a user. Windows reads profile configuration in the following order, and Windows uses the first configured setting that it reads:  
>
>   - The RDS roaming profile path that is specified by RDS policy  
>   - The RDS roaming profile path that is specified by the user object  
>   - A per-computer roaming profile path that is specified in the **Set roaming profile path for all users logging onto this computer** Group Policy setting  
>   - A per-user roaming profile path that is specified in the user object
> - If you configure the **Set roaming profile path for all users logging onto this computer** Group Policy setting, each user who logs on to the member server uses the path that is specified as the roaming profile location.
