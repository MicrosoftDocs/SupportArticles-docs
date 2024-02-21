---
title: LDAP to Active Directory is disabled
description: Provides some information about the issue that anonymous LDAP operations to Active Directory are disabled on domain controllers.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-lightweight-directory-services-ad-lds-and-active-directory-application-mode-adam, csstroubleshoot
---
# Anonymous LDAP operations to Active Directory are disabled on domain controllers

This article provides some information about the issue that anonymous LDAP operations to Active Directory are disabled on domain controllers.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 326690

## Summary

By default, anonymous Lightweight Directory Access Protocol (LDAP) operations to Active Directory, other than rootDSE searches and binds, are not permitted in Microsoft Windows Server 2003.

## More information

Active Directory in earlier versions of Microsoft Windows-based domains accepts anonymous requests. In these versions, a successful result depends on having correct user permissions in Active Directory.

With Windows Server 2003, only authenticated users may initiate an LDAP request against Windows Server 2003-based domain controllers. You can override this new default behavior by changing the seventh character of the dsHeuristics attribute on the DN path as follows:  
CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration, **Root domain in forest**  
The DsHeuristics setting applies to all Windows Server 2003-based domain controllers in the same forest. The value is realized by domain controllers upon Active Directory replication without restarting Windows. Microsoft Windows 2000-based domain controllers do not support this setting and do not restrict anonymous operations if they are present in a Windows Server 2003-based forest.

Valid values for the dsHeuristic attribute are 0 and 0000002. By default, the DsHeuristics attribute does not exist, but its internal default is 0. If you set the seventh character to 2 (0000002), anonymous clients can perform any operation that is permitted by the access control list (ACL), as can Windows 2000-based domain controllers.

> [!NOTE]
> If the attribute is already set, do not modify any characters in the DsHeuristics string other than the seventh character. If the value is not set, make sure that you provide the leading zeros up to the seventh character. Also, you can use Adsiedit.msc to make the change to the attribute.

The dsHeuristics string on a domain controller in the
 **Forest_Name**.com forest appears as follows when you view it by using Ldp.exe. Only selected attributes are shown.

>\>> Dn: CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=<forest_name>,DC=com  
 2> objectClass: top; nTDSService;  
 1> cn: Directory Service;  
 1> dSHeuristics: 0000002; <-2 in the seventh character = anonymous  
    access allowed. Note the leading zeros.  
 1> name: Directory Service;
