---
title: Error when remote IP address limit for Exchange Receive connector is exceeded
description: Provides a workaround for an error that occurs when you try to assign remote IP addresses to an Exchange Server Receive connector.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 169978
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: janogu, arindamt, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: MET150
ms.date: 01/24/2024
---

# Error when remote IP address limit for Exchange Receive connector is exceeded

## Symptoms

When you try to assign remote IP addresses to an Exchange Server Receive connector by using the `RemoteIPRanges` parameter for the [Set-ReceiveConnector](/powershell/module/exchange/set-receiveconnector) or [New-ReceiveConnector](/powershell/module/exchange/new-receiveconnector) cmdlets, you receive an error message that resembles the following message:

> The administrative limit for this request was exceeded.
>
> \+ CategoryInfo : NotSpecified: (:) [\<cmdlet name\>], AdminLimitExceededException

If you use the Exchange admin center (EAC) to add remote IP addresses, you see the following error message.

:::image type="content" source="media/connector-remote-ip-address-limit-exceeded/error-eac.png" alt-text="Screenshot of the administrative limit exceeded error." border="true":::

## Cause

For each Receive connector, Exchange Server limits the number of remote IP entries that you can assign. The limit is between 1,200 and 1,300 entries. Entries are counted according to the following criteria:

- A single IP address counts as one entry. For example, `192.168.1.1` or `2002:c0a8:101::`.

- An IP address range counts as one entry. For example, `192.168.1.1-192.168.1.254` or `2002:c0a8:101::-2002:c0a8:1fe::`.

- A classless inter-domain routing (CIDR) IP address range counts as one entry. For example, `192.168.1.1/24` or `2002:c0a8:101::/40`.

- Multiple entries that are comma-separated count as separate entries. For example, `10.0.0.1,10.0.0.2,10.0.0.3,192.168.1.1-192.168.1.254,192.168.3.1/24` counts as five entries.

## Workaround

Use either of the following workarounds:

- Whenever possible, assign IP address ranges instead of single addresses to a Receive connector. For example, instead of `10.0.0.1,10.0.0.2,10.0.0.3,10.0.0.4,10.0.0.5,10.0.0.6`, assign either `10.0.0.1-10.0.0.6` or `10.0.0.0/29`.

- Create a new Receive connector that has a similar configuration to the one that triggers the error. Assign to the new connector any remote IP addresses that exceed the quota for the current Receive connector.

## More information

- To get the number of remote IP address entries for a Receive connector, run the following command in Exchange Online PowerShell:

  ```powershell
  (Get-ReceiveConnector "<connector name>").RemoteIPRanges.count
  ```

- The remote IP address limit is controlled by an Active Directory multi-valued attribute that's not linked. The attribute name is `ms-Exch-Smtp-Receive-Remote-Ip-Ranges`. The limit value isn't exact because several factors affect it. You can't edit the limit value. For more information about the size limitations of the Active Directory schema attribute, see [Active Directory: non-linked multi-valued attribute size limits](https://social.technet.microsoft.com/wiki/contents/articles/31919.active-directory-non-linked-multi-valued-attribute-size-limits.aspx).
