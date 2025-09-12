---
title: Can't move mailboxes to Exchange Online
description: This article fixes an issue in which you cannot move mailboxes from on-premises to Exchange Online in a hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Error when you move mailboxes from on-premises to Exchange Online in a hybrid deployment: User is already being moved‎

_Original KB number:_ &nbsp; 4502865

## Symptoms

Assume that you have a hybrid deployment of Exchange Server and Exchange Online in Microsoft 365. When you try to move mailboxes from on-premises to Exchange Online, you receive an error message that resembles one of the following:

> Error: UserAlreadyBeingMigratedException: The user ‎'Name‎' already has a pending request. Please remove the existing request and resume the current batch or start a new batch for this user. --> Mailbox ‎'Name' is already being moved to ‎'Cloud Database Name‎'.
>
> Error: MigrationPermanentException: The onboarding move could not be created because user ‎'Name' is already being moved. --> The onboarding move could not be created because user ‎'Name‎' is already being moved.

## Cause

This issue may occur if one of the following conditions is true:

- You already have a move request (active or orphaned) in Exchange Online for that user. In this scenario, the error message most likely is as follows:

    > Mailbox 'Name' is already being moved to '\<Cloud Database Name>'.

- You already have a move request (active or orphaned) in on-premises Exchange Server for that user. In this scenario, the error message is most likely as follows:

  > The onboarding move could not be created because user 'Name' is already being moved.

## Resolution

To fix this issue, use the following steps.

### Step 1: Identify the move request for the affected user

- In [Exchange Management Shell](/powershell/exchange/exchange-server/open-the-exchange-management-shell?view=exchange-ps&preserve-view=true), run the following command: 

    ```powershell
    Get-MoveRequest -Identity 'user@contoso.com'
    ```

- In [Exchange Online PowerShell](/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true), run the following command:

    ```powershell
    Get-MoveRequest -Identity 'user@contoso.com'
    ```

> [!NOTE]
> If you're unsure about the identity of the user, you can output all move requests by running the `Get-MoveRequest` command to find the affected user.

### Step 2: Verify and delete the move request or move references

You can check the status of a user move request that you find in either on-premises or Exchange Online. The status will most likely be in a **Completed** or **Failed** state. You have to remove this move request in order to be able to create a new move request to migrate the user to Exchange Online.

If the move request that has to be deleted isn't associated with a migration batch or a migration user, you can run `Remove-MoveRequest` directly in PowerShell. Otherwise, we recommend that you remove the corresponding migration batch or corresponding migration user from that batch. This should also take care of the move request removal.

If you don't find a move request for the user in the on-premises or Exchange Online organizations, and you still receive an error message (user is already being moved), you will have to manually clean up the move references for that user from your on-premises Active Directory container.

To do this, follow these steps:

> [!WARNING]
> If you use the Attribute Editor, ADSI Edit snap-in, LDP utility, or any other LDAP version 3 client, and you incorrectly change the attributes of Active Directory objects, you can cause serious problems. Microsoft cannot guarantee that problems that occur if you incorrectly change Active Directory object attributes can be solved. Change these attributes at your own risk. Always make a note of the value that was there before you remove or change these attributes so that you can undo the changes.

1. Open **Active Directory Users and Computers** in Domain Controller (DC) server.

2. Locate the affected user, click **View**, select the **Advanced Features** check box, and then open the **Attribute Editor** tab.

3. Look for **msExchMailboxMove** attributes, and check whether any value is set for that user.

    For example, **msExchMailboxMoveRemoteHostName** is populated by the `<tenant.onmicrosoft.com>` value if there was at least one attempt to move the user to Exchange Online.

    If the move request was successfully removed from Exchange Online (that is, you don't find it by running `Get-MoveRequest` in Exchange Online PowerShell) but the **msExchMailboxMoveRemoteHostName** attribute is set, this suggests that the move reference was not cleared up correctly from on-premises Active Directory. In this scenario, you have an orphaned move request for that user.

    Another example for an orphaned local move request for a primary or archived mailbox would be if there's no move request on-premises for it, but there are attributes set, such as the following:

    - **msExchMailboxMoveSourceMDBLink**  
    - **msExchMailboxMoveTargetMDBLink**  
    - **msExchMailboxMoveSourceArchiveMDBLink**  
    - **msExchMailboxMoveTargetArchiveMDBLink**

4. Manually clear the value in Active Directory, and then create another move request in Exchange Online for that user.
