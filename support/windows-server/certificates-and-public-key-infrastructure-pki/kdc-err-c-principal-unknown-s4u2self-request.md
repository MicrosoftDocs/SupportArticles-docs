---
title: KDC_ERR_C_PRINCIPAL_UNKNOWN in S4U2Self request
description: Provides a solution to an issue where S4U2Self requests fail with the error KDC_ERR_C_PRINCIPAL_UNKNOWN.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:Windows Security Technologies\Kerberos authentication, csstroubleshoot
---
# KDC_ERR_C_PRINCIPAL_UNKNOWN Returned in S4U2Self Request

This article provides help to solve an issue where S4U2Self requests fail with the error KDC_ERR_C_PRINCIPAL_UNKNOWN.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2009157

## Symptoms

You are running an application server that needs to authorize users that do not have a logon with the server, for role-based checks using Active Directory security group memberships. You are using the AuthZ API to do this work. Another scenario where this problem can happen is a server that accepts user certificates for logon, for example a web server such as Internet Information Server (IIS). To retrieve information needed for access checks on local resources, LSASS performs a S4U2Self Kerberos transaction. But that fails and the user cannot logon or you cannot verify the user's role.

In a network trace, you may see multiple requests with PaData Type **PA-PAC-REQUEST** (type 128) which fail with errors **KDC_ERR_C_PRINCIPAL_UNKNOWN** (error code 6) or **KDC_ERR_PREAUTH_REQUIRED** (25). But these are not fatal. Error code 6 for these means that the domain controller to which the request was made does not host the account and the client should choose a different domain controller. Error code 25 means that the client cannot retrieve the user's privilege attribute certificate (PAC) without proper validation. The client then gets a proper ticket for the user's domain key distribution center (KDC).

Next, the last request is sent with the PaData type **PA-FOR-USER** (type 129) with the application server host service principal name (SPN) as the SName and the user's user principal name (UPN) in the PaForUser branch of the frame. The client on the request is the application server.

This request now also fails with error **KDC_ERR_C_PRINCIPAL_UNKNOWN** (error code 6). This is a fatal error.

> [!Note]
> It will be helpful to run the network trace through frame reassembly in Network Monitor 3.x.

## Cause

The Kerberos error is actually an **Access is Denied** error for reading this attribute.
The S4U2Self request is accessing the **TokenGroupsGlobalAndUniversal** user-constructed attribute and requires permissions to do so. By default, authenticated users have these permissions.

## Resolution

If these permissions have been changed or otherwise revoked, you need to add the requesting accounts to the **Windows Authorization Access Group**. By default, this group has the required access on all user and computer accounts.
If you have also changed the permissions of **Windows Authorization Access Group**, you need to construct the permissions or use a custom group to grant the permissions.

## More information

This behavior is independent of how the public key infrastructure (PKI) is set up for the certificate logon case. It is also independent of whether both the server and user are in the same forest or in different forests. If they are in different forests, it would work with or without selective authentication enabled. The user needs "allowed to authenticate" access for the server if selective authentication is enabled.

In the certificate logon case, the server application would get a handle to an access token when the Kerberos transaction is successful. This access token is not good for Kerberos delegation.

You can get KDC warning Event ID 25 when the S4U2Self request fails. You need to set **KdcExtraLogLevel** to **0x08**. For more information about this registry entry, click the following article number to view the article in the Microsoft Knowledge Base:  
[837361](https://support.microsoft.com/kb/837361)  Kerberos protocol registry entries and KDC configuration keys in Windows Server 2003
