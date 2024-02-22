---
title: Can't create a domain-based DFS namespace
description: Describes how to resolve an issue where you see an access denied error when you try to create a domain-based namespace.
ms.date: 02/27/2024
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:access to file shares (SMB), csstroubleshoot
ms.subservice: networking
keywords: DFS namespace
---

# Can't create a domain-based DFS namespace (The namespace cannot be queried. Access is denied)

This article describes how to resolve an issue where you see an access denied error when you try to create a domain-based namespace.

_Applies to:_ &nbsp; 

## Symptoms

You sign in to Windows by using an account that belongs to the Domain Admins group, and then try to create a domain-based namespace on any Distributed File System (DFS) namespace server. However, the operation fails. Windows generates an error that resembles the following:

> \\contoso.com\Public The namespace cannot be queried. Access is denied.

At the same time, you can successfully create a stand-alone namespace.

## Cause

When creating a new domain-based namespace, the computer queries the DNS server for domain information. The DNS server responds by sending a list of the A records of the domain controllers for that domain. The computer then contacts one of the domain controllers, and attempts to use your account credentials authenticate by using NTLM authentication.

If your account belongs to the Protected Users group, your account cannot use NTLM authentication. Authentication fails, and generates a STATUS_ACCOUNT_RESTRICTION.

## Resolution

To resolve the issue, remove your account from the Protected Users group.

## More Information

- [Protected Users Security Group](/windows-server/security/credentials-protection-and-management/protected-users-security-group)
- [Guidance about how to configure protected accounts](/windows-server/identity/ad-ds/manage/how-to-configure-protected-accounts)
