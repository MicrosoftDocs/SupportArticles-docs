---
title: Fail to log on to a local administrator account
description: Works around an issue that occurs after you log on to a local administrator domain account.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.subservice: active-directory
---
# You receive access denied errors after you log on to a local administrator domain account

This article helps solve access denied errors that occur after you log on to a local administrator domain account.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 2738746

## Symptoms

Consider the following scenario:

- You create a local administrator account on a computer this is running Windows Server 2003 or later operating system.
- You log on by using the local administrator account instead of the built-in Administrator account and then configure the server to be the first domain controller in a new domain or forest. As expected, this local account becomes a domain account.
- You use this domain account to log on.
- You try to perform various Active Directory Domain Services (AD DS) operations.

In this scenario, you receive access denied errors.

## Cause

When you configure the first domain controller in a forest or a new domain, the user's local account is converted to a domain security principal and is added to matching domain built-in groups, such as Users and Administrators. Because there are no built-in local Schema Admins, Domain Admins, or Enterprise Admins groups, these memberships are not updated in the domain groups, and you are not added to the Domain Admins group.

## Workaround

To work around this behavior, use Dsa.msc, Dsac.exe, or the Active Directory Windows PowerShell module to add the user to the Domain Admins and Enterprise Admins groups as necessary. We do not recommend that you add the user to the Schema Admins group unless you are currently performing a schema upgrade or modification.

After you log off and then log back on, the group membership changes will take effect.

## More information

This behavior is expected and is by design.

Although this behavior has always been present in AD DS, improved security procedures in business networks have exposed the behavior to customers who follow Microsoft best practices for using the built-in Administrator account.

The built-in Administrator account makes sure that at least one user has full administrative group membership in a new forest.
