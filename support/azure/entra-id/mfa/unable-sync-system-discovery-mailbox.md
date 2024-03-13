---
title: You can't sync the SystemMailbox or DiscoveryMailboxSearch accounts by using the Azure Active Directory Sync tool
description: Describes an issue in which you receive errors when you try to use the Azure Active Directory Sync tool to synchronize the SystemMailbox and DiscoverySearchMailbox user accounts. Provides a resolution.
ms.date: 07/06/2020
ms.reviewer: roberg, jhayes
ms.service: active-directory
ms.subservice: enterprise-users
---
# Can't sync SystemMailbox or DiscoveryMailboxSearch accounts using Azure Active Directory Sync tool

This article provides information about resolve a problem in which you receive errors when trying to use the Azure Active Directory Sync tool to synchronize the SystemMailbox and DiscoverySearchMailbox user accounts.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2804688

## Symptoms

When you use the Microsoft Azure Active Directory Sync tool to sync the following user accounts, you receive directory synchronization errors:

- SystemMailbox{1f05a927-beed-480c-b962-da8d1d7e16a8}@\<DomainNameName>
- SystemMailbox{e0dc1c29-89c3-4034-b678-e6c29d823ed9}@\<DomainName>
- DiscoverySearchMailbox{D919BA05-46A6-415f-80AD-7E09334BB852}@\<DomainNameName>

## Cause

This issue occurs if the three user accounts that were created during Microsoft Exchange Server 2010 installation are missing the attribute data. In this case, the attribute data is used by the Azure Active Directory Sync tool to filter out these user accounts and stop them from being synced to the cloud.

## Resolution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Method 1

On the domain controller or a computer on which the Active Directory Domain Services Administration Tools are installed, follow these steps:

1. Open Active Directory Users and Computers.
2. On the **View** menu, select **Advanced Features**.
3. Select the **Users** container.
4. Double-click each **SystemMailbox** user account, and then follow these steps for each account:

   1. Select **Attribute Editor**.
   2. Find the **mailNickName** attribute, and then populate the attribute by using the value that's included in the **mail** attribute.
   3. Select **OK**.

5. Double-click each **DiscoverySearchMailbox** user account, and then follow these steps for each account:

   1. Select **Attribute Editor**.
   2. Find the **mailNickName** attribute, and then populate the attribute by using the value that is included in the **mail** attribute.
   3. Find the **msExchRecipientTypeDetails** attribute, and then set the value of the attribute to 536870912.
   4. Select **OK**.

#### Method 2

On the computer on which the Directory Sync tool is installed, follow these steps:

1. Open an elevated command prompt.
2. Open Windows PowerShell, type `Import-Module DirSync` , and then press Enter.
3. After the Windows PowerShell session starts, run the following cmdlet:

    ```powershell
    Start-OnlineCoexistenceSync
    ```

If the methods did not work, see [Recreate missing arbitration mailboxes](/exchange/architecture/mailbox-servers/recreate-arbitration-mailboxes#re-create-an-arbitration-mailbox).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
