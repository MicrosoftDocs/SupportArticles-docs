---
title: Delegate feature in mixed versions of Outlook
description: Describes a recommendation for Outlook scenarios in which you use delegates. These recommendations cover both Outlook for Windows clients and Entourage and Outlook 2011 for Mac.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook delegate feature in mixed versions of Microsoft Outlook and Outlook for Mac

_Original KB number:_ &nbsp; 924470

## Summary

When you use the delegate feature in Microsoft Outlook, we recommend that the manager and all the delegates use Microsoft Office Outlook 2007 Service Pack 2 (SP2) or a later version, and this includes Microsoft Outlook 2010, Outlook 2013 and Outlook 2016. Additionally, if Macintosh clients are used, then Microsoft Outlook for Mac 2011 or Outlook 2016 for Mac should be used. The manager and the delegate are not prevented from running earlier versions of Outlook or Entourage. However, we strongly recommend that such an overlapping period that combines versions that are earlier than Outlook 2007 SP2 or Entourage 2008 be kept as brief as possible.

## More information

Although Outlook and Outlook for Mac cannot detect whether the manager and delegate use earlier versions of the email clients, we recommend that the manager and all delegates use Outlook 2016, Outlook 2013, Outlook 2010, Outlook 2007 SP2 (or a later version), Outlook 2016 for Mac, or Outlook for Mac 2011. By doing this, you improve calendar reliability. We recognize that users who cannot upgrade to the same version of Outlook at the same time may have to run in a mixed environment that combines older versions of Outlook or Entourage. However, you should limit such a mixed-version topology to a short time during an upgrade period (approximately two months). As your first troubleshooting step if you encounter calendar reliability issues, deploy the newer, supported versions of the clients for the manager and for all their delegates. Then, determine whether the issue continues to occur before you take additional troubleshooting steps.

> [!NOTE]
> Support for Microsoft Entourage 2004 for Mac ended on January 10, 2012 and support for Microsoft Entourage 2008 for Mac ended on April 9, 2013. For more information about Microsoft Office 2004 for Mac and Microsoft Office 2008 for Mac, see the [Microsoft Support Lifecycle policy](/lifecycle).

In earlier versions of Outlook, such as Outlook 2003 and Outlook 2002, the manager and the delegates can use different versions of Outlook. For example, the delegates can use Outlook 2002, and the manager can use Outlook 2003. However, we do not recommend this configuration.

### Mac email client requirements based on Exchange Server versions

If the manager or the delegate is using Microsoft Exchange Server 2003, then Entourage 2008 is required. If both the manager and delegates have mailboxes on Exchange Server 2007 or later versions, then Outlook for Mac 2011 is supported.

> [!IMPORTANT]
> Entourage clients cannot connect with a mailbox on Exchange Server 2007 or Exchange Server 2010 for delegate rights assignment unless public folders exist in the Exchange organization. If public folders do not exist in the Exchange 2007 organization, use one of the following workarounds:

- Add a public folder store to Exchange Server.
- Move both the delegate and the manager to Outlook 2016, Outlook 2013, Outlook 2010 or Outlook 2007 SP2 (or later versions). Outlook 2013, Outlook 2010, and Outlook 2007 do not require public folders in order to access a mailbox on Exchange Server 2007 (or a later version).
