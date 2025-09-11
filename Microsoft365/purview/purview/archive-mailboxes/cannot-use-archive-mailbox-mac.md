---
title: Can't set up Outlook for Mac 2011 to use the archive mailbox feature in Exchange Online
description: Describes how you can't use the archive mailbox feature in Exchange Online for Microsoft 365 with Outlook for Mac 2011. Outlook for Mac 2011 doesn't support archiving. Provides a workaround.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
ms.reviewer: MS aliases for tech reviewers and CI requestor, without @microsoft.com.
appliesto: 
  - Exchange Online
  - Outlook for Mac 2011
  - Outlook 2016 for Mac
search.appverid: MET150
ms.date: 05/05/2025
---
# Can't set up Outlook for Mac 2011 to use the archive mailbox feature in Exchange Online

_Original KB number:_&nbsp;2830042

## Problem

When you try to set up Microsoft Outlook for Mac 2011 to use the archive mailbox feature in Exchange Online for Microsoft 365, your attempt fails.

## Workaround

To work around this behavior, use Outlook Web App for mail, and apply retention policies in Exchange Online. Use the following settings when you apply the retention policies:

|Tag name|Tag type|Retention age limit (days)|Retention action|
|---|---|---|---|
|Personal 1-years move to archive|Personal|365|Move to archive|
|Personal 5-years move to archive|Personal|1825|Move to archive|
|*Personal never move to archive|Personal|No age limit|Move to archive|

*This tag is not enabled by default. Items that have this retention tag are either never moved or never deleted.

For more information about retention policies in Exchange Online, see [Retention tags and retention policies](/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies).

Whereas Outlook for Mac 2011 doesn't support the archive feature, Outlook 2016 for Mac does support the archive feature. When you use Outlook 2016 for Mac, you can access your archive and move mail items into your archive.

## More information

You can create an archive mailbox for a user's primary cloud-based mailbox. Users can use the archive mailbox (also known as a personal archive) to store historical messaging data by moving or copying messages from their primary mailbox to their archive mailbox. The archived messages reside in the cloud, and users can access the messages by using Outlook 2016 for Mac, Outlook 2013, Outlook 2010, or Outlook Web App.

For more information about the archive mailbox feature in Exchange Online, see [Enable or disable an archive mailbox in Exchange Online](/microsoft-365/compliance/enable-archive-mailboxes).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
