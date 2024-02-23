---
title: Domain controller configuration error (The server is not operational) when you configure a server by using Server Manager
description: Describes an issue that occurs when you configure a server that is running Windows Server 2012 from a workgroup as a domain controller.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nedpyle
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Domain controller configuration error (The server is not operational) when you configure a server by using Server Manager

This article helps fix an error (The server is not operational) that occurs when you configure a server from a workgroup as a domain controller by using Server Manager.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 2738697

## Symptoms

Consider the following scenario. You configure a server that is running Windows Server 2012 from a workgroup as a domain controller by using Server Manager. Then, you click the **Select** button on the **Deployment Configuration** page. In this scenario, your receive the following error message:

> Encountered an error contacting domain contoso.  
The server is not operational.

> [!NOTE]
> You have LDAP, RPC, and DNS connectivity and can contact all existing domain controllers without issue for other operations.

## Cause

This issue occurs because NTLM authentication is disabled either in the domain or on the domain controllers.

## Resolution

To resolve this issue, join the server to the domain, and then configure the server to be a domain controller. After you join the server to the domain, the Active Directory Domain Services (AD DS) Wizard in Server Manager uses Kerberos authentication instead of NTLM authentication to browse the AD DS forest.

## More information

For more information about how to disable NTLM authentication in domains in Windows Server 2008 R2 and later versions, go to the following websites:

- [Introducing the Restriction of NTLM Authentication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd560653(v=ws.10))

- [NTLM Blocking and You: Application Analysis and Auditing Methodologies in Windows 7](/archive/blogs/askds/ntlm-blocking-and-you-application-analysis-and-auditing-methodologies-in-windows-7)
