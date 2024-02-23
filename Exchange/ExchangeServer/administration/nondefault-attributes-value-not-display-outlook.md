---
title: Value for nondefault attribute isn't populated in Outlook in Exchange Server 2010
description: Fixes an issue in which the value for nondefault attribute added to the Outlook Details Template isn't displayed in Exchange Server 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: sens, exchblt, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# The value for nondefault attribute added to the Outlook Details Template isn't displayed in Exchange Server 2010

_Original KB number:_ &nbsp;2599330

## Symptoms

Consider the following scenario:

- You install Microsoft Exchange Server 2007 or an earlier version of Exchange Server.
- You create a mailbox user on the server that's running Exchange Server 2007.
- You add a `nondefault` attribute that's displayed in the Outlook Details Template.
- The mailbox user verifies that the `nondefault` attribute is populated in Microsoft Outlook.
- You install Exchange Server 2010 on a different server.
- You move the mailbox user to Exchange Server 2010.
- The mailbox user starts Outlook.

In this scenario, the `nondefault` attribute isn't populated in Outlook as expected.

## Cause

This issue occurs if the attribute isn't enabled for global catalog replication.

## Resolution

To enable an attribute for replication to the global catalog, follow these steps:

1. Start Microsoft Management Console (MMC).
1. Expand **Active Directory Schema**, and then click **Attributes**.
1. Right-click the attribute that you want, and then click **Properties**.
1. Click to select the **Replicate this attribute to the Global Catalog** check box, and then click **OK**.
1. Right-click **Active Directory Schema (domain.com)**, and then click **Reload the Schema**.
1. Force Active Directory replication.
1. Run the `Update-GlobalAddressList` cmdlet if it's necessary.

    > [!NOTE]
    > Microsoft Outlook clients that are running in cached mode have to wait for the Outlook Address Book to be updated.

## More information

In Exchange Server 2007 and earlier versions, global address list (GAL) requests from Outlook clients are referred to a domain controller. Because Outlook communicates directly with the domain controller, the attribute that was added in the Details Template is always available.

However, GAL requests from Outlook clients are handled by the Address Book service in Exchange Server 2010. The Address Book service runs on the Client Access server (CAS). The CAS server retrieves the details from the local global catalog and provides those details to the Outlook client. So an attribute must be replicated to the global catalog to be displayed in the Outlook client.

By default, most default attributes are enabled for replication to the global catalog. For example, the `givenName`, `Surname`, and `DisplayName` attributes.

However, some frequently used attributes aren't enabled by default for replication to the global catalog. For example, the `employeeNumber`, `employeeID`, and `personalTitle` attributes.

> [!IMPORTANT]
> Creating new attributes and then using the new attributes in the Outlook Details Template isn't supported in any version of Exchange. Instead, use custom attributes to add information about a recipient.

## References

For more information about how to install the Active Directory Schema snap-in, see [Install the Active Directory Schema Snap-In](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732110(v=ws.11)).

For more information about the `Update-GlobalAddressList` cmdlet, see [Procedures for address lists in Exchange Server](/Exchange/email-addresses-and-address-books/address-lists/address-list-procedures).

For more information about custom attributes in Exchange Server 2010 and Exchange Server 2007, see [Custom attributes](/Exchange/recipients/mailbox-custom-attributes).

For more information about how to administer the offline address book when Outlook clients are running in cached mode, see [KB 841273](https://support.microsoft.com/kb/841273).