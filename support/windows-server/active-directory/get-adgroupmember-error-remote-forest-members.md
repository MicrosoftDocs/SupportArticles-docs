---
title: Fail to run Get-ADGroupMember for domain local group
description: Describes a problem that occurs when you run the Get-ADGroupMember cmdlet in a scenario where a group has a member from a remote forest. A resolution is provided.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Get-ADGroupMember returns error for domain local group to members from remote forests

This article helps fix an error that occurs when you run the `Get-ADGroupMember` cmdlet in a scenario where a group has a member from a remote forest.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3171600

## Symptoms

Assume that you use the `Get-ADGroupMember` cmdlet to identify the members of a group in Active Directory Domain Services (AD DS). However, when you run the cmdlet for a domain local group, the following error is returned:

> Get-ADGroupMember -verbose -identity "CN=Test-Local1,OU=Test Accounts,DC=contoso,DC=com"  
> Get-ADGroupMember : An unspecified error has occurred  
> At line:1 char:1  
> \+ Get-ADGroupMember -verbose -identity "CN=Test-Local1,OU=Test Accounts,DC=contoso ...  
> \+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> \+ CategoryInfo : NotSpecified: (CN=Test-Local1,...bertm-w7,DC=com:ADGroup) [Get-ADGroupMember], ADExceptionon + FullyQualifiedErrorId : ActiveDirectoryServer:0,Microsoft.ActiveDirectory.Management.Commands.GetADGroupMember

> [!NOTE]
> In a one-way trust, when using the `Get-ADGroupMember` cmdlet on a group from the trusting forest, you receive the following errors if the group contains members from the trusted forest:
>
> - "An unspecified error has occurred"
> - "The server was unable to process the request due to an internal error"
>
> As a workaround, use the Active Directory Users and Computers snap-in to view the members of the group, or convert the one-way trust into a two-way trust.

## Cause

This issue occurs if the group has a member from another forest whose account has been removed from the account forest. The member is represented in the local domain by a Foreign Security Principal (FSP). In the LDIFDE export of the group, a membership is shown as follows:

dn: CN=Test-Local1,OU=Test Accounts,DC=contoso,DC=com

member:

CN=S-1-5-21-3110691720-3620623707-1182478234-698540,CN=ForeignSecurityPrincipals,DC=contoso,DC=com

member:

CN=S-1-5-21-3110691720-3620623707-1182478234-695739,CN=ForeignSecurityPrincipals,DC=contoso,DC=com

When the source account with the SID is deleted, the FSP is not updated or removed to reflect this deletion. You must manually verify that these FSP references are removed.

## Resolution

To resolve this issue, enable logging for the resolution requests that concern these SIDs and that are performed by the Active Directory Webservice. In this way, you can identify the accounts that fail resolution. To do this, run the `Get-ADGroupMember` cmdlet on the domain controller of `contoso.com` (where the placeholder represents the domain in question).

To enable logging, run the following command lines:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LspDbgInfoLevel -Value 0x800 -Type dword -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LspDbgTraceOptions -Value 0x1 -Type dword -Force
```

Remember turning off the logging when you have the log:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LspDbgInfoLevel -Value 0x0 -Type dword -Force
```

You will see a file that's named *c:\windows\debug\lsp.log*, which tracks the SID-Name resolution attempts. When you rerun the cmdlet on the domain controller where the cmdlet was executed, the file will log the failures and will resemble the following:

> LspDsLookup - Entering function LsapLookupSidsLspDsLookup - LookupSids request for 1 SIDs with level=1, mappedcount=0, options=0x0, clientRevision=2 is being processed. SIDs are;LspDsLookup - Sids[ 0 ] = S-1-5-21-3110691720-3620623707-1182478234-698540LspDsLookup - Requestor details: Local Machine, Process ID = 1408, Process Name = C:\Windows\ADWS\Microsoft.ActiveDirectory.WebServices.exe LspDsLookup - Entering function LsapDbLookupSidsUsingIdentityCacheLspDsLookup - 1 sids remain unmappedLspDsLookup - Exiting function LsapDbLookupSidsUsingIdentityCache with status 0x0LspDsLookup - LookupSids chain request (using Netlogon) to \\`dc3.northwindtraders.com` for 1 sids will be made with level=6, mappedcount=0, options=0x0, serverRevision=0. Sids are;LspDsLookup - Sids[ 0 ] = S-1-5-21-3110691720-3620623707-1182478234-698540 LspDsLookup - Lookup request (using Netlogon) to \\`dc3.northwindtraders.com` returned with 0xc0000073  and mappedcount=0, serverRevision=0LspDsLookup - Exiting function LsapLookupSids with status 0xc0000073

Check for the following items to verify that this is the relevant section for this problem (in the preceding sample output):

- The process is C:\Windows\ADWS\Microsoft.ActiveDirectory.WebServices.exe.
- The request is sent to a domain controller in a different forest, for example, `northwindtraders.com`.
- The return code is 0xc0000073, which equals STATUS_NONE_MAPPED.

To find the FSP object, run the following command (replace domain names and SIDs):

```powershell
get-AdObject -Searchbase "CN=ForeignSecurityPrincipals,DC=contoso,DC=com" -ldapfilter "(cn=S-1-5-21-3110691720-3620623707-1182478234-698540)"
```

The original object for this FSP no longer exists, so you can safely delete it. Doing this will also remove it from all groups that it's a member of:

```powershell
get-AdObject -Searchbase "CN=ForeignSecurityPrincipals,DC=contoso,DC=com" -ldapfilter "(cn=S-1-5-21-3110691720-3620623707-1182478234-698540)" | Remove-AdObject -Confirm:$false
```

## References

[How SIDs and account names can be mapped in Windows](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff428139(v=ws.10))
