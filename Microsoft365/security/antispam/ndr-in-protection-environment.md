---
title: Users in an Exchange Online Protection environment receive NDRs when they send mail to a recipient environment that uses the China Anti-Spam Alliance service.
description: Discusses a scenario in which users in an Exchange Online Protection environment receive NDRs when they send email messages to a recipient whose messaging environment uses the China Anti-Spam Alliance (CASA) service for mail security.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: victwa, v-lanac
appliesto:
- Exchange Online
- Exchange Online Protection
search.appverid: MET150
---
# Users in an Exchange Online Protection environment receive NDRs when they send mail to a recipient environment that uses the China Anti-Spam Alliance service

_Original KB number:_&nbsp;2845046

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem  

Users in a Microsoft Exchange Online Protection environment receive a nondelivery report (NDR) when they send email messages to a recipient. This occurs when the recipient's messaging environment uses the China Anti-Spam Alliance (CASA) service for mail security.

The NDR may include a message that resembles the following, where *xxx.xxx.xxx.xxx* is an IP address that's in the range of Outgoing FOPE IP addresses:

> The IP address *xxx.xxx.xxx.xxx* was rejected by the Realtime Block List provider cblless.anti-spam.org.cn

## Cause

This issue occurs if an outgoing Exchange Online Protection IP address is added to the CASA China Black IP list (CBL).

## Solution

Contact CASA because the cause of the issue is rooted in the CASA CBL, and the resolution must be directed at CASA. Office 365 doesn't support CASA services. The following guidance is provided as-is and without any warranty to resolve unexpected mail rejections from recipient environments that use the CASA CBL service as a block list.

To resolve the issue, try the following:

- If the recipient messaging system uses the CASA CBL, contact the recipient mail administrator to have the following Exchange Online Protection outgoing edge server IP addresses added to an allow list to bypass the CASA CBL checks:
  > [Exchange Online Protection IP Addresses](/office365/enterprise/urls-and-ip-address-ranges)

## More information

The CASA CBL is a common real-time block list (RBL). RBLs are a list of IP addresses published through the Domain Name System (DNS) either as a zone file that can be used by DNS server software or as a live DNS zone that can be queried in real time. RBLs are most frequently used to publish the addresses of computers or networks that are linked to spamming. Most mail server software can be set up to reject or flag messages that were sent from a site that is listed on one or more such lists. The term "block list" is sometimes interchanged with the term "blocklist."

Microsoft is committed to enabling customers to have a secure email environment that is both spam-free and virus-free. As part of that commitment, Exchange Online Protection takes many steps to make sure that mail that is filtered through our network doesn't contain unsolicited commercial messages.  

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

The information and the solution in this document represent the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or a third-party provider. We do not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because we must respond to changing market conditions, this information should not be interpreted as a commitment by Microsoft. We cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.  

Still need help? Go to
 [Microsoft Community](https://answers.microsoft.com/).