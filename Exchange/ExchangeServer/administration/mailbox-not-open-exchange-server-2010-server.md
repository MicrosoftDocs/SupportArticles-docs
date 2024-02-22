---
title: Can't open mailbox on Exchange Server 2010
description: Describes an issue in which you can't open your mailbox on an Exchange Server 2010 server by using Outlook. This occurs when the RpcClientAccessServer property of your Exchange 2010 mailbox isn't set to the FQDN of the Exchange 2010 CAS.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: batre, batre, wduff, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
---
# You can't open your mailbox on an Exchange Server 2010 server by using Outlook

_Original KB number:_ &nbsp; 982678

## Symptoms

When you try to open your mailbox on a Microsoft Exchange Server 2010 server by using Outlook, you receive one of the following error messages:

- Error message 1:

    > Cannot open your default email folders. The attempt to log on to Microsoft Exchange has failed.

- Error message 2:

    > Outlook cannot log on. Verify that you are connected to the network and are using the proper server and mailbox name.

- Error message 3:

    > Cannot open your default e-mail folders. The file path_to_OST is not an offline folder file.

## Cause

This issue occurs when one of the following conditions is true:

- The Exchange Server 2010 Mailbox role and the Exchange Server 2010 Client Access Server (CAS) role are installed on the same server. Therefore, the address of this server is referenced by the RpcClientAccessServer mailbox database property. When you uninstall the Exchange Server 2010 CAS role from this server, the RpcClientAccessServer property isn't changed. The mailbox database property still references the original Exchange Server 2010 server address, even though Exchange Server 2010 CAS isn't installed on that server.

- You uninstall the Exchange 2010 CAS role from the server. However, the uninstall process doesn't completely remove all the settings. The RpcClientAccessServer mailbox database property still references this server address.

- The `LegacyExchangeDN` attribute in the database is changed to an incorrect value.

## Resolution

To resolve this issue and to change the `RpcClientAccessServer` mailbox database property to the correct value, follow these steps:

> [!NOTE]
> During this process, the `LegacyExchangDN` attribute is updated to the correct value for the Exchange Server server.

1. Click **Start**, point to **All Programs**, point to **Exchange Server 2010**, and then click **Exchange Management Shell**.
2. At the command prompt, type the `Get-MailboxDatabase <database_name> | fl Name, RpcClientAccessServer` cmdlet and then press ENTER.
3. The returned value may not be the Full Qualified Domain Name (FQDN) of the Exchange Server 2010 CAS server or of the Exchange Server 2010 CAS array. If this behavior occurs, type the `Set-MailboxDatabase <database_name> -RpcClientAccessServer <FQDN_of_CAS>` cmdlet and then press ENTER.

    > [!NOTE]
    > The <FQDN_of_CAS> placeholder is the FQDN of either the Exchange Server 2010 CAS server or of the Exchange Server 2010 CAS array.
