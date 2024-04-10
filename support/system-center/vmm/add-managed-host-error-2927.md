---
title: Can't add a managed host with error 2927
description: Fixes an issue in which error 2927 occurs when you add a managed host in Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Error 2927 (0x8033809d): Unable to add a managed host in VMM 2012

This article helps you fix an issue in which error 2927 occurs when you add a managed host in System Center 2012 Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 970923

## Symptom

When you add a managed host in System Center 2012 Virtual Machine Manager, it may fail with the following error messages:

From the VMM console:

> Error (2927)  
> A Hardware Management error has occurred trying to contact server \<server>.  
> (Unknown error 0x8033809d))
>
> Recommended Actions  
> Check that WinRM is installed and running on server \<server>. For more information use the command "winrm helpmsg hrresult".

The following event may also be logged in the System event log:

> Log Name: System  
> Source: Microsoft-Windows-Security-Kerberos  
> Date: 23/04/2009 2:08:30 PM  
> Event ID: 4  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<server>  
> Description: The Kerberos client received a KRB_AP_ERR_MODIFIED error from the server \<server>. The target name used was HTTP/\<server>. It indicates that the target server failed to decrypt the ticket provided by the client. Which can occur when the target server principal name (SPN) is registered on an account other than the account the target service is using. Ensure that the target SPN is registered on, and only registered on, the account used by the server. This error can also happen when the target service is using a different password for the target service account than what the Kerberos Key Distribution Center (KDC) has for the target service account. Ensure that the service on the server and the KDC are both updated to use the current password. If the server name is not fully qualified, and the target domain (*DOMAIN.COM*) is different from the client domain (*DOMAIN.COM*), check if there are identically named server accounts in these two domains, or use the fully-qualified name to identify the server.

## Cause

This problem occurs because two or more computer accounts have the same service principal name (SPN) registered. Event ID 11 is logged when the Key Distribution Center (KDC) receives a ticket request, and the related SPN exists more than one time when it's checked on the global catalog (GC) for forest-wide verification.

## Resolution

To resolve this problem, locate the computer or user accounts that have the duplicate SPNs. When you've located the computers that have the duplicate SPNs, you can delete the computer account from the domain, disjoin, and rejoin the computer to the domain, or you can use ADSI Edit (Active Directory Service Interface Editor) to correct the SPN on the computer that has the incorrect SPN.

On Windows Server 2008 and later versions, to locate the computer accounts that have the duplicate SPNs, use `setspn -x` to automatically detect duplicate SPNs.
