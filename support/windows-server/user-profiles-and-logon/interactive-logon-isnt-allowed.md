---
title: Interactive logon isn't allowed
description: Provides a solution to an error that occurs when Domain Controller does not allow interactive logon.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, paulhut, nedpyle
ms.custom: sap:user-logon-fails, csstroubleshoot
---
# Domain Controller doesn't allow interactive logon, shows an error: The security database on the server does not have a computer account for this workstation trust relationship

This article provides a solution to an error that occurs when Domain Controller does not allow interactive logon.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 2015518

## Symptoms

After rebooting, a Windows Server 2012 R2 DC cannot be logged on to anymore. You see this with both a console logon or terminal services/remote desktop. The error shown is:

> The security database on the server does not have a computer account for this workstation trust relationship

If you restart the computer in Directory Services Restore Mode (DSRM) and examine the **System** event log, you see:

> Log Name:      System  
Source:        NETLOGON  
Date:          *\<DateTime>*  
Event ID:      5721  
Task Category: None  
Level:         Error  
Keywords:      Classic  
User:          N/A  
Computer:      *\<ComputerName>*  
Description:  
The session setup to the Windows NT or Windows 2000 Domain Controller `\\2008r2spn-01.northwindtraders.com` for the domain NWTRADERS failed because the Domain Controller did not have an account 2008R2SPN-02$ needed to set up the session by this computer 2008R2SPN-02.  
ADDITIONAL DATA  
If this computer is a member of or a Domain Controller in the specified domain, the aforementioned account is a computer account for this computer in the specified domain. Otherwise, the account is an interdomain trust account with the specified domain.

And

> Log Name:      System  
Source:        Microsoft-Windows-Security-Kerberos  
Date:          *\<DateTime>*  
Event ID:      3  
Task Category: None  
Level:         Error  
Keywords:      Classic  
User:          N/A  
Computer:      *\<ComputerName>*  
Description:  
A Kerberos Error Message was received:  
on logon session  
Client Time:
Server Time: 18:35:19.0000 1/27/2010 Z
Error Code: 0x7  KDC_ERR_S_PRINCIPAL_UNKNOWN
Extended Error: 0xc0000035 KLIN(0)
Client Realm:
Client Name:
Server Realm: `NORTHWINDTRADERS.COM`
Server Name: host/2008r2spn-02.northwindtraders.com
Target Name: host/2008r2spn-02.northwindtraders.com@NORTHWINDTRADERS.COM
Error Text:
File: 9
Line: efb
Error Data is in record data.

At every attempted logon, the **Security** event log will show:

> Log Name:      Security  
Source:        Microsoft-Windows-Security-Auditing  
Date:          *\<DateTime>*  
Event ID:      4625  
Task Category: Logon  
Level:         Information  
Keywords:      Audit Failure  
User:          N/A  
Computer:      *\<ComputerName>*  
Description:  
An account failed to log on.  
>
> Subject:  
Security ID:  SYSTEM  
Account Name:  2008SPN-02$  
Account Domain:  ADATUM  
Logon ID:  0x3e7  
>
>Logon Type:   2  
>
> Account For Which Logon Failed:  
Security ID:  NULL SID  
Account Name:  Administrator  
Account Domain:  ADATUM  
>
> Failure Information:  
Failure Reason:  An Error occurred during Logon.  
Status:   0xc000018b  
Sub Status:  0x0
>
> Process Information:  
Caller Process ID: 0x214  
Caller Process Name: C:\Windows\System32\winlogon.exe
>
> Network Information:  
Workstation Name: 2008SPN-02  
Source Network Address: 127.0.0.1  
Source Port:  0
>
> Detailed Authentication Information:  
Logon Process:  User32  
Authentication Package: Negotiate  
Transited Services: -  
Package Name (NTLM only): -  
Key Length:  0
>
> This event is generated when a logon request fails. It is generated on the computer where access was attempted.
>
> The Subject fields indicate the account on the local system which requested the logon. This is most commonly a service such as the Server service, or a local process such as Winlogon.exe or Services.exe.
>
> The Logon Type field indicates the kind of logon that was requested. The most common types are 2 (interactive) and 3 (network).
>
> The Process Information fields indicate which account and process on the system requested the logon.
>
> The Network Information fields indicate where a remote logon request originated. Workstation name is not always available and may be left blank in some cases.
>
> The authentication information fields provide detailed information about this specific logon request.
>
> - Transited services indicate which intermediate services have participated in this logon request.  
> - Package name indicates which sub-protocol was used among the NTLM protocols.  
> - Key length indicates the length of the generated session key. This will be 0 if no session key was requested.

You may also see a KDC 11 error for a duplicate SPN in the **System** event log:

> Log Name:      System  
Source:        Microsoft-Windows-Kerberos-Key-Distribution-Center  
Date:          *\<DateTime>*  
Event ID:      11  
Task Category: None  
Level:         Error  
Keywords:      Classic  
User:          N/A  
Computer:      *\<ComputerName>*  
Description:  
The KDC encountered duplicate names while processing a Kerberos authentication request. The duplicate name is host/2008spn-02.adatum.com (of type DS_SERVICE_PRINCIPAL_NAME). This may result in authentication failures or downgrades to NTLM. In order to prevent this from occurring remove the duplicate entries for host/2008spn-02.adatum.com in Active Directory.

## Cause

The DCs Service Principle Name (SPN) has been duplicated and now exists as an attribute on both the DC as well as some other user or computer.

## Resolution

Locate the duplicate SPN and remove it. This value can be found with SETSPN.EXE or LDIFDE.EXE. In this example, the duplicate name is 2008r2spn-02.

- `setspn.exe -x`
- `setspn.exe -q 2008r2spn-02*`
- `ldifde.exe -f spn.txt -d -l serviceprincipalname -r "(serviceprincipalname=*2008r2spn-02*)" -p subtree`

## More information

This behavior differs from Windows Server 2003 or Windows 2000. Those operating systems don't get the same errors and can still be logged into with duplicate DC SPNs. Starting in Windows Vista, failback to NTLM is disallowed with interactive logons - this is a security feature to prevent an attacker from somehow damaging Kerberos, thereby forcing a less secure protocol to be used.

In order to update an SPN on a user or computer, a user must be a member of Administrators, Domain Admins, Enterprise Admins, or have been granted permissions to modify the servicePrincipalName attribute on a user or computer. No standard user can modify SPN's - not even on themselves or computers they added to the domain. Only high privilege users can create this outage scenario.
