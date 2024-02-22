---
title: Edge Transport servers reject messages
description: Describes a problem in which Edge Transport servers reject email messages sent to valid recipients. Provides workarounds.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Edge Transport servers reject messages sent to valid recipients

_Original KB number:_ &nbsp; 3152396

## Symptoms

Exchange Server 2016 Edge Transport servers reject messages that are sent to valid internal recipients when the following conditions are true:

- Exchange Server 2016 Cumulative Update 1 (CU1) is installed on the server.
- Recipient validation is enabled on the server.

When an Edge Transport server rejects a message because of this problem, the sender receives a non-delivery report (NDR) that has the status code 5.1.10. Additionally, the sender receives the following error message:

> Recipient not found by SMTP address lookup.

> [!NOTE]
> The recipient doesn't receive the message that was sent.

## Workaround

To work around this problem, do one of the following:

- Disable recipient validation on the affected Edge Transport servers by running the following command:

    ```powershell
    Set-RecipientFilterConfig -RecipientValidationEnabled $False
    ```  

- Configure your firewall or external mail exchanger (MX) DNS record to send mail to an Edge Transport server that doesn't have Exchange 2016 CU1 installed. You might have to configure your firewall to let TCP port 25 connect to the new Internet-facing server.

- Configure your firewall or external MX DNS record to send mail to an Exchange 2016 Mailbox server. You might have to configure your firewall to let TCP port 25 to connect to the new Internet-facing server.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in **Applies to**.

## More information

For more information about how to successfully deploy Exchange Server 2016, see the [Release notes for Exchange Server](/Exchange/release-notes) topic on the TechNet website.
