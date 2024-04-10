---
title: KDC service on an RODC can't start and generates error 1450
description: This article resolves an issue in which the KDC service on a read-only domain controller (RODC) cannot start, and you receive an error message that refers to insufficient system resources.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
keywords: ad, security,KDC service, RODC, error 1450, handle invalid
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:Windows Security Technologies\Kerberos authentication, csstroubleshoot
---

# KDC service on an RODC can't start and generates error 1450

This article resolves an issue in which the KDC service on a read-only domain controller (RODC) cannot start, and you receive an error message that refers to insufficient system resources.

_Applies to:_ &nbsp; Windows Server 2016

## Symptoms

The Kerberos Key Distribution Center (KDC) service does not start on a read-only domain controller (RODC), and the service generates the following error message:

> Windows could not start the Kerberos Key Distribution Center service on Local Computer. Error 1450: Insufficient system resources exist to complete the requested service.

If you use a command such as **repadmin /replicate** to trigger inbound replication to the RODC from a source domain controller, the command fails and generates the following error message:

> DsReplicaSync() failed with status 6 (0x6):  
> The handle is invalid.

## Cause

The **krbtgt_*#####*** account for the RODC was removed.

Every RODC has its own **krbtgt_*#####*** account in Active Directory. In the account name, *#####* represents a number that identifies the RODC. The RODC uses this account to provide cryptographic isolation for the tickets that it issues. Typically, you don't have to interact with the **krbtgt_*#####*** accounts. When you promote or demote an RODC, Windows automatically manages the accounts. However, if an RODC fails and the metadata isn't cleaned up, an "orphan" **krbtgt_*#####*** account may remain in Active Directory.

If an administrator tries to manually clean up orphan accounts, the issue that's mentioned in the "Symptoms" section may occur. This issue typically means that a non-orphan **krbtgt_*#####*** account was deleted instead of an orphan account.

For information about how to identify orphan **krbtgt_*#####*** accounts, see [MailBag: RODCs – krbtgt_#####, Orphans, and Load Balancing RODC Connection Objects](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/mailbag-rodcs-krbtgt-orphans-and-load-balancing-rodc-connection/ba-p/256064).

## Resolution

The procedure that you use to resolve this issue depends on whether you have enabled the [AD Recycle Bin](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379542(v=ws.10)) feature in Active Directory. Select one of the following methods:

- [Recovery Method 1 (AD Recycle Bin feature not enabled)](#recovery-method-1-ad-recycle-bin-feature-not-enabled)
- [Recovery Method 2 (AD Recycle Bin feature enabled)](#recovery-method-2-ad-recycle-bin-feature-enabled)

### Recovery Method 1 (AD Recycle Bin feature not enabled)

If the AD Recycle Bin feature wasn't enabled, follow these steps on a writeable domain controller (RWDC) or global catalog server (GC).

1. Restart the server. During the startup process, press F8, and then select **Directory Services Restore Mode**.
2. Use a system state backup from before the account was removed to restore the system state of the server. This operation returns the account to the local copy of Active Directory on the server.
3. Open an elevated Command Prompt window, and use the ntdsutil tool to do an [authoritative restore](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc732211(v=ws.11)) of the account. This operation makes sure that the restored account can replicate to the other domain controllers.

   For example, to restore an account that has the name **krbtgt_23530**, you would open an elevated Command Prompt window, and run the following command:

   ```cmd
   ntdsutil restore object "CN=krbtgt_23530,CN=Users,DC=EMEA,DC=Contoso,DC=com"
   ```

   > [!NOTE]  
   > The authoritative restore operation creates an LDAP Data Interchange Format (LDIF) file that contains information from the restored account. You will need this file in later steps.

4. Restart the server to return to normal Active Directory mode.
5. Populate the backlink attributes for the restored account by importing the LDIF file that was created in the previous step. To do this, run the following command at a command prompt:

   ```cmd
   ldifde -i -f <filename>.ldf
   ```

   In this command, \<*filename*> is the file name and path of the LDIF file that was created previously. This operation links the RODC computer object in Active Directory to its corresponding account.

After you finish these steps, you may have to reset the password of the RODC computer account (also known as the "machine account"). To do this, follow the steps in [Use Netdom.exe to reset machine account passwords of a Windows Server domain controller](use-netdom-reset-domain-controller-password.md).

### Recovery Method 2 (AD Recycle Bin feature enabled)

If the AD Recycle Bin feature is enabled, follow these steps.

1. On an RWDC or GC, in an elevated Command Prompt window, run the following commands to restore the account:

   ```ps
   import-module ActiveDirectory
   Get-ADObject -Filter {displayName -eq "krbtgt_<xxxxx>"} -IncludeDeletedObjects | Restore-ADObject
   ```

   In the second command, \<*xxxxx*> is the ID number of the RODC.

2. On the affected RODC, open an elevated Command Prompt window and then run the following command to replicate the account information to the RODC:

   ```cmd
   repadmin /replsingleobj <RODC_Name> <RWDC_Name> <DN>
   ```

   This command contains the following placeholders:
   - \<*RODC_Name*> represents the server name of the RODC
   - \<*RWDC_Name*> represents the RWDC, on which you restored the account
   - \<*DN*> represents the distinguished name of the RODC account (**krbgt_*xxxxx***)

3. Clear the RODC Kerberos cache by running the following commands:

   ```cmd
   klist purge
   klist -li 0x3e7 purge
   ```

4. Reset the password of the RODC computer account (also known as the "machine account") by running the following command:

   ```cmd
   netdom resetpwd /server: <RWDC_Name> /USERD: administrator /PasswordD:*
   ```

   In this command, \<*RWDC_Name*> represents the server name of the RWDC.

   > [!NOTE]  
   > This command prompts you for the password of the Administrator account.
5. Restart the RODC.

## References

- [authoritative restore](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc732211(v=ws.11))
- [How to restore deleted user accounts and their group memberships in Active Directory](../identity/retore-deleted-accounts-and-groups-in-ad.md)
- [klist](/windows-server/administration/windows-commands/klist)
- [LDIFDE - Export / Import data from Active Directory - LDIFDE commands](https://support.microsoft.com/help/555636)
- [MailBag: RODCs – krbtgt_#####, Orphans, and Load Balancing RODC Connection Objects](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/mailbag-rodcs-krbtgt-orphans-and-load-balancing-rodc-connection/ba-p/256064)
- [Notes on Kerberos kvno in Windows RODC environment](/archive/blogs/openspecification/notes-on-kerberos-kvno-in-windows-rodc-environment)
- [Repadmin /replsingleobj](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc742123(v=ws.11))
- [Repadmin /showobjmeta](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc742104(v=ws.11))
- [RODC Frequently Asked Questions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc754956(v=ws.10))
- [Use Netdom.exe to reset machine account passwords of a Windows Server domain controller](use-netdom-reset-domain-controller-password.md)
