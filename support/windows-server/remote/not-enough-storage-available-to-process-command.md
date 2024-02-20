---
title: New user fails to log on through RDP
description: Describes an issue in which a new user receives an error message after the user types a new password.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# "Not enough storage is available to process this command" error when a new user tries to log on through RDP in Windows Server 2008 R2

This article provides a solution to an error that occurs when a new user connects to the server through Remote Desktop Protocol (RDP).

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2877056

## Symptoms

You have a Windows Server 2008 R2-based computer that is not a member of a domain. An administrator of the server creates a new user who is also an administrator, sets a password for the new user, and selects the option to require a password change at the next logon. When the new user connects to the server through Remote Desktop Protocol (RDP) for the first logon, he or she is prompted to enter a new password. When the user types the new password and tries to continue, he or she receives the following error message:  

> Not enough storage is available to process this command.

The password is not changed, and the user receives the same error message when he or she tries to log on again.

## Cause

This issue occurs because the RPC runtime receives an error.

Specifically, the scenario that occurs is as follows:

The password change request process is put into an anonymous access token by Local Security Authority (LSA). This occurs because the password is not valid and the user is therefore not authenticated. Using this token, the password change request is passed to the local Security Accounts Manager (SAM) through RPC. (RPC is used because the request might also be sent remotely at this point.) The RPC runtime reads a system policy to determine the correct configuration. (The configuration is "Server2003NegotiateDisable" in key `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Rpc.`)

In this scenario, the RPC runtime receives error 5 "ACCESS_DENIED" for this request and maps this to RPC error 15 "RPC_S_OUT_OF_MEMORY."

## Resolution

To resolve this issue, use one of the following methods:  

1. Use the facility to remotely change the password of a user to set the password before he or she connects through RDS.  
2. Change the registry permissions on the following registry key to enable read access for ANONYMOUS LOGON, and then inherit that down the registry tree:   `HKEY_LOCAL_MACHINE\SOFTWARE\Policies`  
In Windows Server 2012, the server rejects the logon of a user whose password expired or is set to be changed at the next logon. In this case, you have to use method 1 to set the password.
