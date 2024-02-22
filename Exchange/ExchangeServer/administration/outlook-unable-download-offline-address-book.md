---
title: Outlook can't download offline address book in an Exchange coexistence environment
description: Describes an issue that Outlook is unable to download or update OAB in an Exchange coexistence environment (Exchange 2013 and 2010). A workaround is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Offline address book is unavailable to Outlook in an Exchange coexistence environment

_Original KB number:_ &nbsp;3047178

## Symptoms

Consider the following scenario:

- Your organization has Microsoft Exchange Server 2013 and Exchange Server 2010 coexistence.
- The offline address book (OAB) isn't configured for the Exchange 2010 mailbox database.
- Outlook Anywhere isn't enabled for Exchange 2010.

In this scenario, the Outlook client can't download or update the OAB.

## Cause

This issue occurs because the Autodiscover response to the client doesn't include the OAB URL.

During the Exchange 2013 installation process, a new offline address book (Default Offline Address Book [Ex2013]) is created and set as the default address book. When there's no offline address book assigned to a mailbox database, the default is used. In this scenario, Exchange 2010 mailboxes use the new Exchange 2013 offline address book.

Here's a sample Autodiscover response that displays the missing OAB URL:

```console
<Protocol>
        <Type>EXCH</Type>
        <Server>casarray1.tailspintoys.com</Server>
        <ServerDN>/o=ToysExchOrg/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Configuration/cn=Servers/cn=casarray1.tailspintoys.com</ServerDN>
        <ServerVersion>7383807B</ServerVersion>
        <MdbDN>/o=ToysExchOrg/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Configuration/cn=Servers/cn=casarray1.tailspintoys.com/cn=Microsoft Private MDB</MdbDN>
        <PublicFolderServer>MBX1.tailspintoys.com</PublicFolderServer>
        <AD>DC3.tailspintoys.com</AD>
        <ASUrl>https://outlook.tailspintoys.com/ews/exchange.asmx</ASUrl>
        <EwsUrl>https://outlook.tailspintoys.com/ews/exchange.asmx</EwsUrl>
        <SharingUrl>https://outlook.tailspintoys.com/ews/exchange.asmx</SharingUrl>
        <EcpUrl>https://mbx1.tailspintoys.com/ecp/</EcpUrl>
        <EcpUrl-um>?p=customize/voicemail.aspx&amp;exsvurl=1</EcpUrl-um>
        <EcpUrl-aggr>?p=personalsettings/EmailSubscriptions.slab&amp;exsvurl=1</EcpUrl-aggr>
        <EcpUrl-mt>PersonalSettings/DeliveryReport.aspx?exsvurl=1&amp;IsOWA=&lt;IsOWA&gt;&amp;MsgID=&lt;MsgID&gt;&amp;Mbx=&lt;Mbx&gt;</EcpUrl-mt>
        <EcpUrl-ret>?p=organize/retentionpolicytags.slab&amp;exsvurl=1</EcpUrl-ret>
        <EcpUrl-sms>?p=sms/textmessaging.slab&amp;exsvurl=1</EcpUrl-sms>
        <EcpUrl-publish>customize/calendarpublishing.slab?exsvurl=1&amp;FldID=&lt;FldID&gt;</EcpUrl-publish>
        <OOFUrl>https://outlook.tailspintoys.com/ews/exchange.asmx</OOFUrl>
        <UMUrl>https://outlook.tailspintoys.com/ews/UM2007Legacy.asmx</UMUrl>
</Protocol>
```

## Workaround

To work around this issue, assign the original OAB to the Exchange 2010 mailbox database as follows:

1. Open the Exchange Management Shell.
1. Run the `Get-OfflineAddressBook` cmdlet to obtain a list of available offline address books.
1. Run the `Set-MailboxDatabase` cmdlet to configure the offline address book for the database.

## More information

If Outlook Anywhere is enabled for Exchange 2010, the client receives the external URL for the OAB and may try to download address book contents by using this URL. In this scenario, users may be repeatedly prompted for their password, depending on the network topology.

For more information, see the following resources:

[Get-OfflineAddressBook](/powershell/module/exchange/get-offlineaddressbook)

[Set-MailboxDatabase](/powershell/module/exchange/set-mailboxdatabase)