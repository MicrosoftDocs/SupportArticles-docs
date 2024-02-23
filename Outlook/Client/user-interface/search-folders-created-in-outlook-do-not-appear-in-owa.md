---
title: Search Folders do not show in OWA
description: Describes that the Search Folders you created in Outlook with an Exchange account do not appear in Outlook Web Access or Outlook Web App. Requires you to turn off the Cached Exchange Mode option to resolve the problem.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: chrislin
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 10/30/2023
---
# Search Folders created in Outlook do not appear in Outlook Web Access

_Original KB number:_ &nbsp; 831400

## Symptoms

When you create Search Folders in Microsoft Office Outlook 2003, Microsoft Office Outlook 2007, or Microsoft Outlook 2010 using a Microsoft Exchange email account, the Search Folders do not appear in Exchange Server 2007 Outlook Web Access (OWA) or Exchange Server 2010 Outlook Web App (OWA).

## Cause

This behavior occurs when you use Outlook in Cached Exchange Mode. The local copy of your mailbox maintains a Finder folder. This folder is not synchronized with the Finder folder that is in your Microsoft Exchange mailbox.

> [!NOTE]
> The Finder folder is a Outlook system folder that is not visible in Outlook. This folder provides the list of folders that are in a mailbox.

## Resolution

To make the Search Folders available in your OWA Search Folders list, you must connect to the same mailbox in Outlook with the Cached Exchange Mode option turned off. To turn off Cached Exchange Mode for the current or the new profile, follow these steps:

1. Close Outlook.
2. Select **Start** > **Control Panel**.
3. Double-click the **Mail** icon.
4. Select **Show Profiles**.
5. Select your current profile, and then select **Properties**.
6. Select **E-mail Accounts**.
7. Select **View or change existing e-mail accounts** > **Next**.
8. Select your Exchange account, and then select **Change**.
9. Clear the **Use Cached Exchange Mode** check box, and then select **Next**.
10. Select **Finish** > **Close** > **OK**.
11. Start Outlook.
12. In the **Folder List**, expand **Search Folders**. As soon as all the Search Folders have updated, they can be viewed from OWA.

## More information

If you later change the settings in Outlook to use Cached Exchange Mode again, any new Search Folders that are added in Microsoft Outlook are not visible in OWA until you repeat the steps that are described in the Resolution section of this article.

For more information about Cached Exchange Mode, press the F1 key, type *cached exchange mode* in the **Search** box in the **Help** window, and then SELECT **Search** to view the topic.
