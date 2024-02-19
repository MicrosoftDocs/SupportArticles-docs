---
title: KFSO doesn't work in external trust
description: Describes a situation in which Kerberos Forest Search Order may not work in an external trust. In this situation, Kerberos authentication is not offered.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jaml
ms.custom: sap:active-directory-topology-sites-subnets-and-connection-objects, csstroubleshoot
---
# Kerberos Forest Search Order may not work in an external trust and event ID 17 is returned

This article discusses a situation where Kerberos Forest Search Order (KFSO) doesn't work in an external trust.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2977475

## Symptoms

In Windows Server 2008 R2 and later versions of Windows Server, the following Group Policy settings can be used to configure KFSO:

**Computer Configuration** \ **Administrative Templates** \ **System** \ **Kerberos** \ **Use Forest Search Order**  

**Computer Configuration** \ **Administrative Templates** \ **System** \ **KDC** \ **Use Forest Search Order**  

With these settings configured, Kerberos authentication may work in external trusts in a single-domain forest environment. However, it may fail when the specified forest contains multiple domains.

In this situation, InitializeSecurityContext may return "SEC_E_TARGET_UNKNOWN." Additionally, the following event may be logged.

## Cause

The KFSO feature offers the convenience of allowing for short name (host name) service principal name (SPN) resolution in a forest trust environment instead of offering the support of Kerberos authentication over external trusts. 

If Kerberos authentication is required, then a forest trust is necessary. On an external trust, you have to change the application to use FQDN server names and three-part SPNs. For more information, see [Technologies for Federating Multiple Forests](https://technet.microsoft.com/library/dd560679%28ws.10%29.aspx).

When FQDN names are used, the forest trust object can offer SPN routing according to the UPN/SPN suffix provided in the request so that the Key Distribution Center (KDC) knows the next hop in the Kerberos referral procedure.

## More information

In an external trust environment that has KFSO configured, the KDC, or the Kerberos client tries to append the specified suffix to search, and then it issues a DsCrackNames request against the target forest in order to resolve the requested SPN. However, the DsCrackNames request may try to connect to any global catalog in the target forest. If the request contacts the domain controller in the directly trusted domain, Kerberos authentication may be successful. If the request contacts a domain controller in another domain, Kerberos authentication may be unsuccessful.

This behavior is expected, because KFSO is not designed to offer Kerberos authentication support over external trusts. To use a Kerberos trust between forests, create a forest trust instead.
