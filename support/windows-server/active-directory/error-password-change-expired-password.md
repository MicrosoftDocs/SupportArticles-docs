---
title: Password change for expired password failing
description: Fixes an error that occurs when processing the password change for a user where the password is expired or set to change at next logon.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\User, computer, group, and object management, csstroubleshoot
---
# Password change for expired password failing for workgroup scenario

This article helps fix an error that occurs when processing the password change for a user where the password is expired or set to change at next logon.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2879424

## Symptoms

You have a server in a DMZ that's not member of a domain. For administration, you have a series of local users that are administrators.

When you add a new user on the server for administration, you set an initial password and set "User must change password at next logon". The user logs on to the server through Remote Desktop Services. The user is prompted to change the password, and after entering it, the user receives an error message "Not enough storage is available to process this command":

:::image type="content" source="media/error-password-change-expired-password/error-pwd-change.png" alt-text="Screenshot of the error message which is Not enough storage is available to process this command.":::

If the RDS server has NLA enabled the attempt to log on to the server fails with the expired password showing the error:

> [Window Title]  
Remote Desktop Connection[Content]  
>
> An authentication error has occured.  
The Local Security Authority cannot be contacted
>
> Remote computer: \<Computer Name>  
This could be due to an expired password.  
Please update your password if it has expired.  
For assistance, contact your administrator or technical support.  
>
>[OK]  

The error dialog looks like this:

:::image type="content" source="media/error-password-change-expired-password/error-nla.png" alt-text="Screenshot of the Remote Desktop Connection window  which shows the error message with NLA enabled.":::

## Cause

When processing the password change for a user where the password is expired or set to change at next logon, Winlogon uses an anonymous token to process the password change request.

The password change dialog allows changing passwords against remote computers as well, so the API calls use remotable interfaces through RPC over Named Pipes over SMB. For this protocol sequence, the RPC runtime reads a policy setting "Server2003NegotiateDisable" from the key `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Rpc`.

This fails in the context of the anonymous token as the default permissions allow only authenticated users, administrators, and LocalSystem to read the key.

When NLA is enabled, the user session request doesn't validate and thus fails.

## Resolution

The approaches to avoid this problem are:

1. Change the password remotely. Note that currently the user in the context you run the remote password change needs to be able to log on to the target server with the default credentials (or already connected using SMB to the server at the time of the password change already).
2. Change the permissions of the key `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Rpc` to allow anonymous to read the key. If the key doesn't exist, you may create it and then add the read permissions for the anonymous account.

> [!NOTE]
> For approach 2, in an attempt to recover from an error, it might happen that the group policy service deletes the keys and recreates them using default permissions. In this case, you have to reapply the permissions.

You can automate setting the permissions on using Registry Security Policy when the machine is member of the domain. For workgroup machines you can import this text as rpc-pol.inf file:

```inf
---------------------------  
[Unicode]  
Unicode=yes  
[Version]  
signature="$CHICAGO$"  
Revision=1  
[Registry Keys]  
"MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\rpc",0,"D:PAR(A;CIIO;KA;;;CO)(A;CI;KA;;;SY)(A;CI;KA;;;BA)(A;CI;KR;;;S-1-5-7)(A;CI;KR;;;BU)"  
------------------------------
```

You can apply it using:

secedit /configure /db C:\Windows\security\database\rpc-pol.sdb/cfg rpc-pol.inf /log rpc-pol.log
Note the key must exist so this is successful.

## More information

The functionality to change workgroup or remote member machine passwords needs to take a number of compatibility requirements into account. The scenario is very much a borderline topic by today.

For RDS sessions secured with NLA, it's not allowing starting a remote session with an expired password to begin with. If you want to use NLA, you have to change the password remotely up-front in a session authenticated with another user.
