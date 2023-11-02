---
title: Windows DNS registers duplicate SRV records for a DC if its computer name has uppercase letters
description: Fixes an issue in which Windows DNS records duplicate SRV records for domain controllers that run Windows Server 2016 or later if those DCs have uppercase characters in their computer names.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, Arrenc, Herbertm
ms.custom: sap:dns, csstroubleshoot
ms.technology: networking
---
# Windows DNS registers duplicate SRV records for a DC if its computer name has uppercase letters

This article helps fix an issue where Windows DNS registers duplicate server location (SRV) records for a domain controller if its computer name has uppercase letters.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4496901

## Symptoms

You have one or more Windows Server 2019-based or Windows Server 2016-based domain controllers (DCs) in a deployment that uses AD DS-integrated DNS zones. At least one of the DCs has a computer name that includes uppercase characters.

In this situation, you notice that the DNS records for the domain include duplicate server location (SRV) records for the DCs that have uppercase characters in their computer names. One record includes the computer name in the RDATA in all lowercase characters, and one record includes the computer name in the RDATA in the same character case as the computer name.

## Cause

This behavior occurs because of a change in how the Windows Server DNS functionality manages the RDATA segment of an SRV record. In Windows Server 2012 R2 and earlier versions, the RDATA segment contains only lowercase letters. If a computer name contains uppercase letters, the DNS functionality converts them to lowercase. However, the Windows Server 2016 (or later version) DNS functionality accepts uppercase and lowercase letters.

When the DNS server checks to see whether a computer name already has an associated SRV record, it does not account for changes in case. Therefore, it considers `winserv16.contoso.com` and `WinServ16.contoso.com` to be different addresses.

For this reason, you may see unexpected effects if you use the following configurations:

- All the DNS servers and DCs in the domain have been upgraded from Windows Server 2012 R2 (or an earlier version) to Windows Server 2016 (or a later version). The DNS database may generate extra SRV records for any DC that has uppercase characters in its computer name.

- All the DNS servers and DCs in the domain run Windows Server 2012 or earlier. You install the DNS server role on a Windows Server 2016 member server, and then you promote that member server to a DC in the same domain. If the Windows Server 2016 DC has uppercase characters in its computer name, it will have extra SRV records in DNS.

- You have a domain that contains DCs and DNS servers that run various versions of Windows Server. The primary DNS server is a DC that runs Windows Server 2012 or earlier, and the secondary DNS server is a Windows Server 2016 DC. The primary DNS server becomes unavailable, and you change the Windows Server 2016 DC to be the new primary DNS server. After this change, the DNS database may generate extra SRV records for any DC that has uppercase characters in its computer name.

## Resolution

Microsoft has released an update that mitigates this issue. The following table lists the relevant versions of the update for affected versions of Windows.

|Version|Release|
|---|---|
|Windows Server 2019, version 1903| [March 24, 2020-KB4541335 (OS Builds 18362.752 and 18363.752)](https://support.microsoft.com/help/4541335/windows-10-update-kb4541335) |
|Windows Server 2019, version 1809| [March 17, 2020-KB4541331 (OS Build 17763.1131)](https://support.microsoft.com/help/4541331/windows-10-update-kb4541331) |
|Windows Server 2016| [March 17, 2020-KB4541329 (OS Build 14393.3595)](https://support.microsoft.com/help/4541329/windows-10-update-kb4541329) |
  
The update introduces a new Group Policy policy setting in the NETLOGON.ADMX file, as described in the following table.

|Policy name|Use lowercase DNS host names when registering domain controller SRV records |
|---|---|
|Policy path| Computer Configuration\\Policies\\Administrative Templates\\System\Net Logon\\DC Locator DNS Records\\|
|Policy values|<ul><li>**1** (default). The policy is enabled. The policy purges duplicate DNS SRV records. When you install the update on a DC, this becomes part of that DC's default local configuration.</li> <li>**0**. The policy is disabled. Under this setting, the problematic behavior continues, and DCs that have computer names that include uppercase characters continue to register SRV records that include those uppercase characters. The value of **0** is supported for only emergency or testing use. It should not be used under typical conditions. </li> </ul> If the policy is not configured or the value is missing, the DC falls back to the new default local configuration and treats the policy as enabled.|
  
The update adds the following registry entry that is associated with this policy. (This information is provided for reference only.)

- Registry subkey: `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Netlogon\Parameters`
- Registry entry: DnsSrvRecordUseLowerCaseHostNames
- Data type: REG_DWORD

### After you install the update

> [!NOTE]
> You do not have to restart or disable the Netlogon service when you install the update, manually clean up records, or disable the policy. You do not have to restart the computer after you install the update.

When you install the update (or enable the policy in an environment in which it has been disabled), the Netlogon service makes a best-effort attempt to remove existing DNS records that have uppercase characters.

We recommend that you install this fix (or enable the policy), and then wait a day or two to allow time for Netlogon to acquire and apply the new setting. Then, wait long enough for the changes to replicate throughout the environment. After that time, examine the DNS records for any remaining duplicates. It is likely that the policy will miss some duplicate records. In that case, you would have to manually remove those records.

You can use the following Windows PowerShell command to review records:

```powershell
Get-DnsServerResourceRecord -ZoneName "contoso.com" -RRType Srv
```

> [!NOTE]
> In this command, `contoso.com` is a placeholder domain name.

To remove the remaining duplicate records, run the following PowerShell command:

```powershell
Remove-DnsServerResourceRecord -ZoneName "contoso.com" -RRType Srv -Name "<hostname of record to delete>" -RecordData "<recorddata of record to delete>"​
```

Disabling the policy does not require any cleanup.

> [!IMPORTANT]
> Microsoft has released an update to resolve this problem and prevent it from recurring. We recommend that you install the update instead of working around the problem.

## Workaround 1: Prevent duplicate SRV records

You can use the following methods to prevent Windows DNS from creating duplicate SRV records:

- Before you promote a member server to a DC or before you upgrade a DC to Windows Server 2016 or a later version, make sure that its computer name contains only lowercase characters.

- Make sure that all internal build processes, tools, and scripts that create, modify, or use computer names also use lowercase characters.

- If you cannot rename your DCs (or if it will take a long time to do so), configure your DNS topology so that DCs that run Windows Server 2016 or later use DNS servers that run Windows Server 2016 or later. Similarly, configure DCs that run Windows Server 2012 R2 or earlier to use DNS servers that run Windows Server 2012 R2 or earlier.

## Workaround 2: Remove duplicate SRV records

To work around this issue after you encounter it, you have to rename your DCs by using all lowercase characters. Depending on the details of your deployment, you may have to manually reconfigure settings or remove files. This section provides the following workaround methods, in order of complexity:

- [Method 1: Rename a DC in a single-DC domain](#method-1-rename-a-dc-in-a-single-dc-domain)
- [Method 2: Rename DCs in a multi-DC domain](#method-2-rename-dcs-in-a-multi-dc-domain)
- [Method 3: Rename DCs and remove all stored SRV records](#method-3-rename-dcs-and-remove-all-stored-srv-records)

> [!IMPORTANT]
> Before using any of these methods, review the following articles. These articles provide detailed steps to follow to rename a DC. They also  provide information about additional cleanup tasks that you may have to perform after you demote or rename a DC.
>
> - [Renaming a Domain Controller](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc794951%28v=ws.10%29)  and its subtopics
> - [Demoting Domain Controllers and Domains](/windows-server/identity/ad-ds/deploy/demoting-domain-controllers-and-domains--level-200-)
> - [AD Forest Recovery - Cleaning metadata of removed writable domain controllers](/windows-server/identity/ad-ds/manage/ad-forest-recovery-cleaning-metadata)

> [!NOTE]
> If you encounter any issues after you rename a DC, revert the DC name to its original content.

### Method 1: Rename a DC in a single-DC domain

If you have one DC, use the steps in [Renaming a Domain Controller](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc794951%28v=ws.10%29) to change the DC's computer name to a new name that contains only lowercase characters. In the case of a single DC, you do not have to demote and repromote it.

> [!IMPORTANT]
> We strongly recommend that any domain contain at least two DCs. If you have only one DC, any time that DC experiences an issue, your domain may become unavailable.

### Method 2: Rename DCs in a multi-DC domain

If you have more than one DC in your domain, follow these steps for each affected DC:

1. Demote the DC, and clean up the related metadata. For more information, see [Demoting Domain Controllers and Domains](/windows-server/identity/ad-ds/deploy/demoting-domain-controllers-and-domains--level-200-) and [AD Forest Recovery - Cleaning metadata of removed writable domain controllers](/windows-server/identity/ad-ds/manage/ad-forest-recovery-cleaning-metadata).

2. Rename the computer, giving it a name that contains only lowercase characters.

3. Promote the computer to a DC again.

By the time all the DCs are back online, the duplicate (mixed-case) SRV records should be gone.

### Method 3: Rename DCs and remove all stored SRV records

If Method 1 and Method 2 do not provide satisfactory results, follow these steps for each affected DC:

1. Demote the DC, and clean up the related metadata. For more information, see [Demoting Domain Controllers and Domains](/windows-server/identity/ad-ds/deploy/demoting-domain-controllers-and-domains--level-200-)  and [AD Forest Recovery - Cleaning metadata of removed writable domain controllers](/windows-server/identity/ad-ds/manage/ad-forest-recovery-cleaning-metadata).

2. On the demoted computer, follow these steps:

    1. Rename the computer, giving it a name that contains only lowercase characters.
    2. Stop the netlogon service. To do this, open an elevated Command Prompt window, and then run `net stop netlogon`.
    3. Delete the following files in the C:\\Windows\\System32\config\\ folder:
        - netlogon.dnb
        - netlogon.dns

3. On one of the other DCs, open Server Manager, select **Tools**, and then select **DNS**.

4. In DNS Manager, inspect the containers under **Forward Lookup Zones** and then delete the SRV records for the DC that you demoted.

5. On the renamed computer, start the netlogon service. To do this, open an elevated Command Prompt window, and then run `net start netlogon`.

6. Promote the renamed computer to a DC again.
