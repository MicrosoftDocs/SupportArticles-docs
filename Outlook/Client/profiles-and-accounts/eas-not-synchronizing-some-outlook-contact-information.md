---
title: EAS not synchronizing Outlook contact information
description: Describes an issue that can occur when you synchronize a Windows Mobile 7.5-based device or an iPhone over-the-air.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: wduff, sudhakr
appliesto: 
  - Exchange Server 2010
  - Exchange Server 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Exchange ActiveSync does not synchronize some Outlook contact information as expected

_Original KB number:_ &nbsp; 2692134

## Symptoms

Consider the following scenario:

- Your mailbox is hosted on a server that is running Microsoft Exchange Server 2010 or Exchange Server 2007.
- You create a new contact in Microsoft Office Outlook 2007.
- Under **Phone numbers**, you type a telephone number in the **Home** and **Mobile** fields.
- You select **Business**, select **Other**, and then type a telephone number in the **Other** field.
- You synchronize your mobile device that uses Exchange ActiveSync over-the-air.

In this scenario, the information in the **Home** and **Mobile** fields is synchronized as expected. However, the information in the **Other** field does not synchronize as expected.

## Cause

This issue occurs because the EAS protocol does not support synchronizing some contact information.

## More information

The behavior that is mentioned in the Symptoms section can occur if you change the field name for any of the default fields. For example, if you select **Business**, **Home**, **Business FAX**, or **Mobile**, and then change the field name to **Other**, the data is not synchronized as expected.

The following table summarizes the field names that will synchronize and that will not synchronize as expected:

|Field names that will synchronize|Field names that will not synchronize|
|---|---|
|Company|Assistant|
|Pager|Callback|
|Business|Car|
|Business 2|ISDN|
|Business Fax|Other Fax|
|Home|Primary|
|Home 2|Other|
|Home Fax|Radio|
|Mobile|Telex|

## References

For more information about the elements in the Contact class, see [Elements of the Contact class](/openspecs/exchange_server_protocols/ms-ascntc/a006c688-6d5f-4aed-a9ac-d70019d3c67b).
