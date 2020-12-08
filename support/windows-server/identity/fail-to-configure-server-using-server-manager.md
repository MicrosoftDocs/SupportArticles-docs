---
title: 
description: Describes an issue that occurs when you configure a server that is running Windows Server 2012 from a workgroup as a domain controller.
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: nedpyle
---
# "The server is not operational" domain controller configuration error when you configure a server by using Server Manager

_Original product version:_ &nbsp; Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2016, Windows Server 2019, all editions  
_Original KB number:_ &nbsp; 2738697

## Symptoms

Consider the following scenario. You configure a server that is running Windows Server 2012 from a workgroup as a domain controller by using Server Manager. Then, you click the Select button on the Deployment Configuration page. In this scenario, your receive the following error message:

Encountered an error contacting domain contoso.
The server is not operational.

> [!NOTE]
>  You have LDAP, RPC, and DNS connectivity and can contact all existing domain controllers without issue for other operations.

## Cause

This issue occurs because NTLM authentication is disabled either in the domain or on the domain controllers.

## Resolution

To resolve this issue, join the server to the domain, and then configure the server to be a domain controller. After you join the server to the domain, the Active Directory Domain Services (AD DS) Wizard in Server Manager uses Kerberos authentication instead of NTLM authentication to browse the AD DS forest. 

## More Information

For more information about how to disable NTLM authentication in domains in Windows Server 2008 R2 and later versions, go to the following Microsoft TechNet websites:

[Introducing the Restriction of NTLM Authentication](https://technet.microsoft.com/library/dd560653%28v=ws.10%29.aspx) 

[NTLM Blocking and You: Application Analysis and Auditing Methodologies in Windows 7](http://blogs.technet.com/b/askds/archive/2009/10/08/ntlm-blocking-and-you-application-analysis-and-auditing-methodologies-in-windows-7.aspx)
