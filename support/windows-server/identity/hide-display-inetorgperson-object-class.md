---
title: Hide or display InetOrgPerson object class
description: Describes how to Hide or Display the InetOrgPerson object class in Active Directory Users and Computers.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, TIMTHO
ms.custom: sap:active-directory-lightweight-directory-services-ad-lds-and-active-directory-application-mode-adam, csstroubleshoot
ms.subservice: active-directory
---
# Hide or Display the InetOrgPerson Object Class in Active Directory Users and Computers

This article describes how to Hide or Display the InetOrgPerson object class in Active Directory Users and Computers.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 311555

## Summary

In Windows Server 2003-and-later versions of Active Directory, an additional object class is introduced. The InetOrgPerson object class. InetOrgPerson is defined in RFC 2798, and it has been accepted as the de facto standard in other Lightweight Directory Access Protocol (LDAP) directory implementations.

Active Directory has been modified to support the InetOrgPerson class, and with the addition of the User class definition, you can now create InetOrgPerson as security principals in Active Directory. This greatly enhances an administrator's capabilities to migrate user accounts from third-party directories into the Active Directory.

However, this change may introduce problems with third-party programs (third-party programs are defined as any programs that use Active Directory as an authentication method). Microsoft recommends that you perform complete program compatibility testing before you use the InetOrgPerson class.

For this reason, and also to avoid confusion, you may want to disable the visible references to the InetOrgPerson object type in Active Directory Users and Computers. This will prevent administrators from mistakenly creating InetOrgPerson users instead of the more accepted User type.

## More information

To enable or disable the InetOrgPerson user type in Active Directory Users and Computers, follow these steps:

1. Log on to the Windows Server 2003 domain controller that holds the Schema Master FSMO role as an account with Schema Administrator permissions.
2. Open the Adsiedit Microsoft Management Console (MMC) snap-in.
3. In the Schema folder, locate the CN=InetOrgPersonClass object. Right-click this object, and then click Properties.
4. Locate the defaultHidingValue attribute, and then modify its value based on your expected outcome. If you set this value to True, this hides the InetOrgPerson object type in Active Directory Users and Computers. If you set this value to False, this displays the object type.
5. After you set the value, click **Apply**, and then click **OK**. Allow for standard replication latency, and then restart any instances of Active Directory Users and Computers.If you set the defaultHidingValue attribute to False, you can create new users of the InetOrgPerson type. With DefaultHidingValue set to True, this functionality is removed.

> [!NOTE]
> This is true only of Active Directory Users and Computers. You can still create the InetOrgPerson user types through other means, regardless of this setting.
