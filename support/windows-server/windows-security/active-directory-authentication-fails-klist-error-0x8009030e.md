---
title: Active Directory authentication fails with klist error 0x8009030e
description: This article introduces several issues.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 5/8/2023
ms.prod: windows-server
ms.technology: windows-server-security
ms.custom: sap:kerberos-authentication, csstroubleshoot, ikb2lmc
ms.reviewer: kaushika
---
# Active Directory authentication fails with klist error 0x8009030e

Active Directory authentication issues occur and you receive 0x8009030e when running the `klist tgt` command. This article introduces how to fix the issues.

_Applies to:_ Supported versions of Windows Server  
_Original KB number:_ 4619950

## Active Directory authentication issues

You encounter one or more of the following issues:

- You receive the following error message when you try to sign into a Remote Desktop Service \(RDS\) Server:

  > Windows needs your current credentials  
  > Please lock this computer, then unlock it using your most recent password or smart card

- You receive the following error message when you open the **Active Directory Users and Computers** or any Active Directory snap-in:

  > Naming information cannot be located because: the logon attempt failed.

- You receive the following error message when you try to open the *gpmc* snap-in:

  > The specified domain controller could not be contacted: "Access is denied"

- When you try to access the Sysvol directory by using command prompt, you receive the following error message:

  ```console
  dir \\contoso.com\sysvol
  Account restrictions are preventing this user from signing in. For example: blank passwords aren't allowed, sign-in times are limited, or a policy restriction has been enforced.
  ```

- When you Run `klist tgt`, it returns the following error message:

  > klist failed with 0x8009030e/-2146893042: No credentials are available in the security package

## Cause

This issue occurs because the user account is a member of the **Protected Users** security group, so the following protections are applied:

- Credential delegation (CredSSP) doesn't cache the user's plain text credentials even when the **Allow delegating default credentials** group policy setting is enabled.

- Beginning with Windows 8.1 and Windows Server 2012 R2, Windows Digest doesn't cache the user's plain text credentials even when Windows Digest is enabled.

- Windows New Technology LAN Manager \(NTLM\) doesn't cache the user's plain text credentials or NT one-way function (NTOWF).

- Kerberos no longer creates Data Encryption Standard \(DES\) or Rivest Cipher 4 \(RC4\) keys. Also, it will not cache the user's plain text credentials or long-term keys after the initial Ticket Granting Ticket \(TGT\) is acquired.

- A cached verifier isn't created at sign-in or unlocks, so offline sign-in is no longer supported.

## Resolution

Remove the impacted user accounts from the **Protected Users** groups in Active Directory. Follow these steps:

1. Open **Active Directory Users and Computers**.
2. Go to **Users** container.
3. On the right panel,  Find the **Protected Users** group.
4. Remove the user accounts from the group.

## Reference

For more information, see the following articles:

- [Protected Users Security Group](/windows-server/security/credentials-protection-and-management/protected-users-security-group)

- [Configured Protected accounts](/windows-server/identity/ad-ds/manage/how-to-configure-protected-accounts)
