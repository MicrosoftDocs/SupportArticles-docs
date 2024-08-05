---
title: Can't create a domain-based DFS namespace
description: Describes how to resolve an issue in which you see an access denied error when you try to create a domain-based namespace.
ms.date: 02/27/2024
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:Network Connectivity and File Sharing\Access to file shares (SMB), csstroubleshoot
keywords: DFS namespace
---

# "The namespace cannot be queried. Access is denied" error when you try to create a domain-based DFS namespace 

This article describes how to resolve an issue in which you see an access denied error when you try to create a domain-based namespace.

_Applies to:_ &nbsp; Windows Server 2019

## Symptoms

When you sign in to Windows by using an account that belongs to the Domain Admins group, and then you try to create a domain-based namespace on any Distributed File System (DFS) namespace server, the operation fails. Windows returns an error message that resembles the following:

> \\contoso.com\Public The namespace cannot be queried. Access is denied.

However, when this error occurs, you can still successfully create a standalone namespace.

## Cause

When you create a new domain-based namespace, the computer queries the Domain Name System (DNS) server for domain information. The DNS server responds by sending a list of the A records of the domain controllers for that domain. The computer then contacts one of the domain controllers, and tries to use your account credentials to authenticate by using NTLM authentication.

If your account belongs to the Protected Users group, your account can't use NTLM authentication. In this situation, authentication fails and generates a STATUS_ACCOUNT_RESTRICTION error.

## Resolution

To resolve the issue, remove your account from the Protected Users group.

## More information

- [Protected Users Security Group](/windows-server/security/credentials-protection-and-management/protected-users-security-group)
- [Guidance about how to configure protected accounts](/windows-server/identity/ad-ds/manage/how-to-configure-protected-accounts)
