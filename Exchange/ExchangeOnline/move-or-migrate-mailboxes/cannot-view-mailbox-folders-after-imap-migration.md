---
title: Cannot view mailbox folders after IMAP migration
description: Describes an issue in which folders are missing from a user's mailbox on an Exchange ActiveSync or Outlook client after the mailbox is migrated from an IMAP messaging system to Microsoft 365 or on-premises Exchange Server. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: santoshp, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/24/2024
---
# You can't view mailbox folders on an Exchange ActiveSync or Outlook client after an IMAP migration

_Original KB number:_ &nbsp; 3050475

## Symptoms

You can't view one or more folders in a user's mailbox on a Microsoft Exchange ActiveSync client or in Microsoft Outlook after the user's mailbox is migrated from an Internet Mail Access Protocol (IMAP) messaging system to Microsoft 365 or on-premises Microsoft Exchange Server.

## Cause

This issue occurs if the folders in the Exchange mailbox were created by using an unrecognized class of type `IPF.Imap`. An analysis of the folder properties shows the following results:

```console
<property tag = "0x3613001E" type = "PT_STRING8">
<ExactNames>PR_CONTAINER_CLASS, PR_CONTAINER_CLASS_A, ptagContainerClass</ExactNames>
<PartialNames>PR_CONTAINER_CLASS_W, PidTagContainerClass</PartialNames>
<Value><![CDATA[IPF.Imap]]></Value>
<AltValue>cb: 8 lpb: 4950462E496D6170</AltValue>
</property>
```

## Resolution

Use Microsoft Exchange Server MAPI Editor (MFCMAPI) to change the `PR_CONTAINER_CLASS` property of the folder to **IPF.Note**. To do this, follow these steps.

> [!NOTE]
> Although the MFCMAPI editor is supported, you should use caution when you use this tool to change mailboxes. Using the MFCMAPI editor incorrectly can cause permanent damage to a mailbox.

1. Download [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/), and then run it.
2. On the **Tools** menu, select **Options**.
3. Select the **Use the MDB_ONLINE flag when calling OpenMsgStore** check box and the **Use the MAPI_NO_CACHE flag** when calling OpenEntry check box.
4. On the **Session** menu, select **Logon**.
5. Select the Outlook profile for the mailbox.
6. Double-click the mailbox to open it.
7. Expand the **Root** container, expand **Top of Information Store**, and then locate the missing folder.
8. Select the folder that's missing from the Exchange ActiveSync client to view the properties.
9. Double-click the property that contains the tag value **0x3613001E**.
10. Change the value from **IPF.Imap** to the appropriate class. (For example, change the value to **IPF.Note** for an email folder.)
11. Exit MFCMAPI.
12. Create a profile on the Exchange ActiveSync client.
