---
title: Can't use Autodiscover to connect to mailbox
description: Error message may occur when you use Autodiscover to connect to a mailbox in Exchange Server 2010 Service Pack 1.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Issue with autodiscover
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: ninob, opereira, wirall, v-six
appliesto: 
  - Exchange Server 2010 Service Pack 1
search.appverid: MET150
---
# Unable to open your default e-mail folders error when using Autodiscover if user is moved cross forest

_Original KB number:_ &nbsp; 2387770

## Symptoms

When you use Autodiscover to connect to an Exchange Server 2010 SP1 mailbox, an Outlook client may present one or both of the following error messages repeatedly:

- > Unable to open your default e-mail folders. The Microsoft Exchange Server computer is not available.
- > Microsoft Exchange administrator has made a change that requires you quit and restart Outlook.

The following conditions should also be true:

- The mailbox in question was moved across Active Directory forests in the past (a move from one Exchange organization to the other).
- The mailbox was, or still is enabled for personal Archive.
- If you run the **Test e-mail Auto Configuration** test for the Outlook client, you might see the discrepancy in the following two lines of test results (on the XML tab):

    ```console
    <AutoDiscoverSMTPAddress>alias@domain1.com</AutoDiscoverSMTPAddress>
    <Server>servername.domain2.com</Server>
    ```

  > [!NOTE]
  > The domains don't match.

## Cause

When a mailbox is being moved across different Exchange forests, the mailbox-enabled user in the original forest is converted to a mail-enabled user. If that mailbox is also enabled for personal Archive, one of the attributes that the original forest object (a mail-enabled user) can have is called `msExchArchiveDatabaseLink`. If present on the mail-enabled user, the attribute will likely point to a database in the **wrong** forest - as the user's mailbox is now in the forest where it was newly moved.

The conflicting information will then confuse an Outlook client during the Autodiscover process, causing it to report errors as mentioned above.

Exchange Server 2010 SP1 cross-forest move doesn't create this problem, as the attribute is cleared properly during the mailbox move.

## Resolution

If you have moved archive-enabled mailboxes cross-forest before installing Exchange Server 2010 SP1, we recommend that you clear the value of the `msExchArchiveDatabaseLink` attribute on any mail-enabled users that might have them populated. You can use a tool such as ADSIEdit to remove the value of this attribute.

## More information

To run the **Test e-mail Auto Configuration** test:

1. Press and hold the Ctrl key and then right-click the Outlook icon in the system tray.
2. Select **Test e-mail Auto Configuration**.
3. In the **E-mail Address** box, type the alias of the affected user.
4. In the **Password** box, type the user's password.
5. Select the **Use Autodiscover** check box, and then select **Test**.
