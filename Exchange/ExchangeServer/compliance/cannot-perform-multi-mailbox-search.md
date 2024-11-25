---
title: Error when you do a multi-mailbox search in Exchange Server 2010
description: Describes an issue that can occur when there's no value for the HomeMDB attribute on an Exchange Server 2010 mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Messaging Policy and Compliance\Issues with eDiscovery, import/export of mailbox
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: charray, exchblt, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you perform a multi-mailbox search in Exchange Server 2010: The user does not have an exchange mailbox

_Original KB number:_ &nbsp;2702446

## Symptoms

Consider the following scenario:

- You start the Exchange Control Panel (ECP) in Microsoft Exchange Server 2010 Enterprise or in Exchange Server 2010 Standard.
- You do a multi-mailbox search.
- The multi-mailbox search uses a System mailbox, the Discovery Search mailbox, or the Federated mailbox as the target for the search.

In this scenario, you may get the following error message:

> The user does not have an exchange mailbox

Additionally, the following event is logged in the Application log:

```console
Log Name: Application
Source: MSExchange Configuration Cmdlet - Remote Management
Event ID: 5
Task Category: General
Level: Error
Keywords: Classic
Description:
(PID 6268, Thread 53) Task New-MailboxSearch throwing terminating exception at stage Microsoft.Exchange.Data.Storage.UserHasNoMailboxException: The user does not have an Exchange mailbox.
at Microsoft.Exchange.Data.Storage.ExchangePrincipal.InternalFromADUser(ADUser user, ADObjectId mdb, DatabaseLocationInfo databaseLocationInfo, Boolean ignoreSiteBoundary)
at Microsoft.Exchange.Data.Storage.Infoworker.MailboxSearch.MailboxDataStore.OpenMailboxSession(ADUser adUser)
at Microsoft.Exchange.Data.Storage.Infoworker.MailboxSearch.MailboxDataStore..ctor(ADUser adUser)
at Microsoft.Exchange.Data.Storage.Infoworker.MailboxSearch.MailboxDataProvider.OpenMailboxStore()
at Microsoft.Exchange.Data.Storage.Infoworker.MailboxSearch.MailboxDataProvider.Exists[T](String name)
at Microsoft.Exchange.Management.Tasks.NewMailboxSearch.PreSaveValidate(SearchObject savedObject)
at Microsoft.Exchange.Management.Tasks.NewMailboxSearch.InternalEndProcessing(). Exception: {4c1ab22a-bd1d-41e9-b178-5e75ffd14563}
```

## Cause

This issue can occur if one or more of the following mailboxes are in an inconsistent state because no value is set for the `HomeMDB` attribute:

- One or more System mailboxes
- The Federated mailbox
- The Discovery Search mailbox

## Resolution

To resolve this issue, follow these steps:

1. Start the ECP.
1. Verify that one or more mailboxes are in an inconsistent state. To do this, type the following cmdlet, and then press Enter:

    ```powershell
    Get-Mailbox -Arbitration |fl name, alias
    ```

    > [!NOTE]
    > You may receive an error message that resembles the following. This error message confirms that one or more System mailboxes or the Federated mailbox is in an inconsistent state:
    >
    > WARNING: The object SystemMailbox{1f05a927-9daf-4003-9bf7-036822f96290} has been corrupted, and it's  
    in an inconsistent state. The following validation errors happened:  
    WARNING: Database is mandatory on UserMailbox.  
    WARNING: Database is mandatory on UserMailbox.

1. Verify that the value for the `HomeMDB` attribute is missing for a mailbox. To do this, type the following cmdlet in the ECP, and then press Enter:

    ```powershell
        Get-Mailbox |fl name, alias
    ```

    > [!NOTE]
    > The following error message indicates that the value for the `HomeMDB` attribute is missing:  
    > Database is mandatory on UserMailbox

1. Copy the `HomeMDB` attribute value for a mailbox in the same database as the System mailbox, the Federated mailbox, or the Discovery Search mailbox. To do this, follow these steps:
    1. Click **Start**, type *Adsi Edit* in the **Search programs and files** box, and then press Enter.
    1. On the **Action** menu, click **Connect to**.
    1. Click **Select or type a domain or server**, select the server that you want, and then click **OK**.
    1. Expand **Default naming context**, and then click the following item:

        **DC=domain,DC=com**
    1. Double-click **CN=Users**.
    1. Right-click a user mailbox, and then click **Properties**.
    1. Under **Attribute**, click **homeMDB** > **Edit**.
    1. Copy the value for the `HomeMDB` attribute, and then click **OK** two times.
1. Set the `HomeMDB` attribute value on the System mailbox, the Federated mailbox, or the Discovery Search mailbox account. To do this, follow these steps:
    1. In ADSI Edit, right-click the account for the System mailbox, the Federated mailbox, or the Discovery Search mailbox, and then click **Properties**.
    1. Under **Attribute**, click **homeMDB** > **Edit**.
    1. Type or paste the `HomeMDB` attribute value that you copied in step 4.
    1. Click **OK** two times.
1. On the **File** menu, click **Exit**.
1. Replicate the forest. To do this, type the following cmdlet at an elevated command prompt, and then press Enter:

    ```console
    repadmin /syncall /e
    ```

## More information

For more information about the `HomeMDB` attribute, see [HomeMDB Property](/previous-versions/office/developer/exchange-server-2003/aa487565(v=exchg.65)).

For more information about an issue that can occur when the value for the `HomeMDB` attribute is missing on the System Attendant mailbox, see [The System Attendant homeMDB attribute is missing](/previous-versions/office/exchange-server-analyzer/dd535374(v=exchg.80)).
