---
title: New address lists do not contain all recipients
description: Describes a problem in which new address lists that you create in Exchange Online don't contain all the recipients that you expect. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: svincent, timothyh, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# New address lists that you create in Exchange Online don't contain all the expected recipients

_Original KB number:_ &nbsp; 2955640

## Symptoms

When you create a new address list in Microsoft Exchange Online, it doesn't contain all the expected recipients. Additionally, if you delete and then re-create the address list by using the same recipient filter, different recipients may be added to the list.

For example, you run the following command to create an address list for all users who have Exchange Online mailboxes in which the `CustomAttribute15` parameter is set to **CPandL**:

```powershell
New-AddressList -Name "CPandL" -RecipientFilter {(RecipientType -eq 'UserMailbox') -and (CustomAttribute15 -like *CPandL*)}
```

However, not all the expected recipients are added to the address list.

## Cause

New address lists aren't automatically updated in Exchange Online. Additionally, the `Update-AddressList` and `Update-GlobalAddressList` cmdlets aren't currently available in Exchange Online. This behavior is by design.

## Workaround

After you create the address list, make a change to each object that the recipient filter applies to. To do this, use one of the following procedures, as appropriate for your situation.

### If you have an on-premises and cloud environment that's using Active Directory synchronization

1. Set or change an attribute for all users in the local installation of Active Directory Domain Services (AD DS) who correspond to the filter objects. For example, specify a value for the `CustomAttribute1` parameter. To do this, follow these steps:

   1. Open the Exchange Management Shell.
   2. Run the following commands. The following set of commands specifies a value of **temp value** for the `CustomAttribute1` parameter.

        ```powershell
        $mbxs = Get-Mailbox -ResultSize Unlimited
        ```

        ```powershell
        $RemoteMBX = Get-RemoteMailbox -ResultSize Unlimited
        ```

        ```powershell
        $mbxs | Set-Mailbox -CustomAttribute1 "temp value"
        ```

        ```powershell
        $RemoteMBX | Set-RemoteMailbox -CustomAttribute1 "temp value"
        ```

        > [!NOTE]
        > Alternatively, you can run a command to make a change to only those mailboxes that are included in the address list.

2. Wait for directory synchronization to run. Or, force directory synchronization.

   After directory synchronization runs, the users should be added to the address list.

3. If you want to undo the changes that you made in step 1, remove the value that you specified for the attribute. To do this, follow these steps:

    1. Open the Exchange Management Shell.
    2. Run the following commands. The following set of commands removes the **temp value** that you previously set for the `CustomAttribute1` parameter:

        ```powershell
        $mbxs = Get-Mailbox -ResultSize Unlimited
        ```

        ```powershell
        $RemoteMBX = Get-RemoteMailbox -ResultSize Unlimited
        ```

        ```powershell
        $mbxs | Set-Mailbox -CustomAttribute1 $null
        ```

        ```powershell
        $RemoteMBX | Set-RemoteMailbox -CustomAttribute1 $null
        ```

4. Wait for directory synchronization to run. Or, force directory synchronization.

### If you have a cloud-only environment

1. Connect to Exchange Online by using PowerShell. For more info about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following commands. The following set of commands specifies a value of **temp value** for the `CustomAttribute1` parameter and then reverses the change.

    ```powershell
    $mbxs = Get-Mailbox -ResultSize Unlimited
    ```

    ```powershell
    $mbxs | Set-Mailbox -CustomAttribute1 "temp value"
    ```

    ```powershell
    $mbxs | Set-Mailbox -CustomAttribute1 $null
    ```

    > [!NOTE]
    > Alternatively, you can run a command to make a change to only those mailboxes that are included in the address list.

## More information

For more information, see [Address Book Policies, Jamba Jokes and Secret Agents](https://techcommunity.microsoft.com/t5/exchange-team-blog/address-book-policies-jamba-jokes-and-secret-agents/ba-p/595749).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
