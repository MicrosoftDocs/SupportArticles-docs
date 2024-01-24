---
title: UserAccountControl property flags
description: Describes information about using the UserAccountControl attribute to manipulate user account properties.
ms.date: 07/17/2023
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
# Use the UserAccountControl flags to manipulate user account properties

This article describes information about using the **UserAccountControl** attribute to manipulate user account properties.

_Applies to:_ &nbsp; Windows Server 2012 R2 , Windows Server 2016, Windows Server 2019, Windows Server 2022  
_Original KB number:_ &nbsp; 305144

## Summary

When you open the properties for a user account, click the **Account** tab, and then either select or clear the check boxes in the **Account options** dialog box, numerical values are assigned to the **UserAccountControl** attribute. The value that is assigned to the attribute tells Windows which options have been enabled.

To view user accounts, click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.

## List of property flags

You can view and edit these attributes by using either the Ldp.exe tool or the Adsiedit.msc snap-in.

The following table lists possible flags that you can assign. You can't set some of the values on a user or computer object because these values can be set or reset only by the directory service. Ldp.exe shows the values in hexadecimal. Adsiedit.msc displays the values in decimal. The flags are cumulative. To disable a user's account, set the **UserAccountControl** attribute to **0x0202** (0x002 + 0x0200). In decimal, it's **514** (2 + 512).

> [!NOTE]
> You can directly edit Active Directory in both Ldp.exe and Adsiedit.msc. Only experienced administrators should use these tools to edit Active Directory. Both tools are available after you install the Support tools from your original Windows installation media.

|Property flag|Value in hexadecimal|Value in decimal|
|---|---|---|
|SCRIPT|0x0001|1|
|ACCOUNTDISABLE|0x0002|2|
|HOMEDIR_REQUIRED|0x0008|8|
|LOCKOUT|0x0010|16|
|PASSWD_NOTREQD|0x0020|32|
|PASSWD_CANT_CHANGE<br/><br/>You can't assign this permission by directly modifying the UserAccountControl attribute. For information about how to set the permission programmatically, see the [Property flag descriptions](#property-flag-descriptions) section.|0x0040|64|
|ENCRYPTED_TEXT_PWD_ALLOWED|0x0080|128|
|TEMP_DUPLICATE_ACCOUNT|0x0100|256|
|NORMAL_ACCOUNT|0x0200|512|
|INTERDOMAIN_TRUST_ACCOUNT|0x0800|2048|
|WORKSTATION_TRUST_ACCOUNT|0x1000|4096|
|SERVER_TRUST_ACCOUNT|0x2000|8192|
|DONT_EXPIRE_PASSWORD|0x10000|65536|
|MNS_LOGON_ACCOUNT|0x20000|131072|
|SMARTCARD_REQUIRED|0x40000|262144|
|TRUSTED_FOR_DELEGATION|0x80000|524288|
|NOT_DELEGATED|0x100000|1048576|
|USE_DES_KEY_ONLY|0x200000|2097152|
|DONT_REQ_PREAUTH|0x400000|4194304|
|PASSWORD_EXPIRED|0x800000|8388608|
|TRUSTED_TO_AUTH_FOR_DELEGATION|0x1000000|16777216|
|PARTIAL_SECRETS_ACCOUNT|0x04000000|67108864|
  
> [!NOTE]
> In a Windows Server 2003-based domain, LOCK_OUT and PASSWORD_EXPIRED have been replaced with a new attribute called ms-DS-User-Account-Control-Computed. For more information about this new attribute, see [ms-DS-User-Account-Control-Computed attribute](/windows/win32/adschema/a-msds-user-account-control-computed).

## Property flag descriptions

- SCRIPT - The logon script will be run.

- ACCOUNTDISABLE - The user account is disabled.

- HOMEDIR_REQUIRED - The home folder is required.

- PASSWD_NOTREQD - No password is required.

- PASSWD_CANT_CHANGE - The user can't change the password. It's a permission on the user's object. For information about how to programmatically set this permission, see [Modifying User Cannot Change Password (LDAP Provider)](/windows/win32/adsi/modifying-user-cannot-change-password-ldap-provider).

- ENCRYPTED_TEXT_PASSWORD_ALLOWED - The user can send an encrypted password.

- TEMP_DUPLICATE_ACCOUNT - It's an account for users whose primary account is in another domain. This account provides user access to this domain, but not to any domain that trusts this domain. It's sometimes referred to as a local user account.

- NORMAL_ACCOUNT - It's a default account type that represents a typical user.

- INTERDOMAIN_TRUST_ACCOUNT - It's a permit to trust an account for a system domain that trusts other domains.

- WORKSTATION_TRUST_ACCOUNT - It's a computer account for a computer that is running Microsoft Windows NT 4.0 Workstation, Microsoft Windows NT 4.0 Server, Microsoft Windows 2000 Professional, or Windows 2000 Server and is a member of this domain.

- SERVER_TRUST_ACCOUNT - It's a computer account for a domain controller that is a member of this domain.

- DONT_EXPIRE_PASSWD - Represents the password, which should never expire on the account.

- MNS_LOGON_ACCOUNT - It's an MNS logon account.

- SMARTCARD_REQUIRED - When this flag is set, it forces the user to log on by using a smart card.

- TRUSTED_FOR_DELEGATION - When this flag is set, the service account (the user or computer account) under which a service runs is trusted for Kerberos delegation. Any such service can impersonate a client requesting the service. To enable a service for Kerberos delegation, you must set this flag on the userAccountControl property of the service account.

- NOT_DELEGATED - When this flag is set, the security context of the user isn't delegated to a service even if the service account is set as trusted for Kerberos delegation.

- USE_DES_KEY_ONLY - (Windows 2000/Windows Server 2003) Restrict this principal to use only Data Encryption Standard (DES) encryption types for keys.

- DONT_REQUIRE_PREAUTH - (Windows 2000/Windows Server 2003) This account doesn't require Kerberos pre-authentication for logging on.

- PASSWORD_EXPIRED - (Windows 2000/Windows Server 2003) The user's password has expired.

- TRUSTED_TO_AUTH_FOR_DELEGATION - (Windows 2000/Windows Server 2003) The account is enabled for delegation. It's a security-sensitive setting. Accounts that have this option enabled should be tightly controlled. This setting lets a service that runs under the account assume a client's identity and authenticate as that user to other remote servers on the network.

- PARTIAL_SECRETS_ACCOUNT - (Windows Server 2008/Windows Server 2008 R2) The account is a read-only domain controller (RODC). It's a security-sensitive setting. Removing this setting from an RODC compromises security on that server.

## UserAccountControl values

Here are the default UserAccountControl values for the certain objects:

- Typical user: 0x200 (512)
- Domain controller: 0x82000 (532480)
- Workstation/server: 0x1000 (4096)
- Trust: 0x820 (2080)

> [!NOTE]
> A Windows trust account is exempt from having a password through PASSWD_NOTREQD UserAccountControl attribute value because trust objects don't use the traditional password policy and password attributes in the same way as user and computer objects.
>
> Trust secrets are represented by special attributes on the interdomain trust accounts, indicating the direction of the trust.  Inbound trust secrets are stored in the trustAuthIncoming attribute, on the "trusted" side of a trust. Outbound trust secrets are stored in the trustAuthOutgoing attribute, on the "trusting" end of a trust.
>
> - For two-way trusts the INTERDOMAIN_TRUST_ACCOUNT object on each side of the trust will have both set.
> - Trust secrets are maintained by the domain controller which is the primary domain controller (PDC) emulator Flexible Single Master Operation (FSMO) role in the trusting domain.
> - For this reason the PASSWD_NOTREQD UserAccountControl attribute is set on INTERDOMAIN_TRUST_ACCOUNT accounts by default.
