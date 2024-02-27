---
title: The Mailbox Cleanup Wizard doesn't start
description: Describes an issue in which the Mailbox Cleanup Wizard doesn't start when you reach the mailbox size limit.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, sercast
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# The Mailbox Cleanup Wizard doesn't start in Outlook 2010 or Outlook 2013 when the mailbox is full

_Original KB number:_ &nbsp; 2632283

## Symptoms

When you run Microsoft Outlook 2010 or Microsoft Outlook 2013, the Mailbox Cleanup Wizard doesn't start when the mailbox is full. That is, the wizard doesn't start when you reach or exceed the Microsoft Exchange Server size limit for the mailbox. Outlook 2010 introduced other visual cues in the user interface to warn you of the "mailbox full" state. One of the new visual cues is the **Quota Information**. The **Quota Information** feature is discussed in this article.

## More information

Outlook 2010 and Outlook 2013 have a feature called **Quota Information**. This feature displays the mailbox size and quota information.

To display quota information on the Outlook Status Bar, right-click the status bar, and then make sure that the **Quota Information** item is set to **On**. You can also view quota information by clicking the **File** tab of the Outlook ribbon.

### Dependencies

For quota information to be displayed, your mailbox must be located on Microsoft Exchange Server 2007 or on Microsoft Exchange Server 2010. Additionally, you must have both of the following mailbox or store limits configured:

If your Outlook profile is configured in cached mode, you will need to have the following three properties configured for your mailbox:

- **Issue warning at**
- **Prohibit send at**
- **Prohibit send and receive at**

If your Outlook profile is configured in online mode, you will want to have the following two properties configured for your mailbox:

- **Prohibit send at**
- **Prohibit send and receive at**  

For more information about these requirements, see [Mailbox Quota Information is not displayed on the Status bar in Outlook](../user-interface/mailbox-quota-information-not-displayed.md).

### Exchange Server 2003

If your mailbox is located on an Exchange 2003 server, Quota Information is not displayed in Outlook 2010. Additionally, the Outlook 2010 release (RTM) version in Cached Exchange Mode doesn't automatically start the Mailbox Cleanup Wizard when your mailbox is full.

A hotfix package that changes the Mailbox Cleanup Wizard behavior is available. After you install this hotfix, when you run Outlook 2010 in Cached Exchange Mode, the Mailbox Cleanup Wizard starts when the mailbox is full. For more information, see [Description of the Outlook 2010 hotfix package (Outlook-x-none.msp): July 11, 2011](https://support.microsoft.com/help/2544027).

> [!NOTE]
> When Outlook 2010 is running in Online mode, the Mailbox Cleanup Wizard still appears when you reach or exceed your mailbox size limit.
