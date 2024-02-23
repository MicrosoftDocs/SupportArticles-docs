---
title: Junk emails are permanently deleted
description: Provides a resolution for the issue that junk emails are permanently deleted in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Junk e-mail messages are permanently deleted

_Original KB number:_ &nbsp; 2697941

## Symptoms

E-mail that you receive may be unexpectedly moved to the Dumpster in your Exchange mailbox or permanently deleted for other e-mail accounts.

## Cause

This problem can occur when both of the following items are true:

1. The e-mail message was considered *junk* by Outlook.
2. You've the **Permanently delete suspected junk e-mail instead of moving it to the Junk E-mail folder** option enabled in Microsoft Outlook.

## Resolution

If you do not want Outlook to permanently delete the e-mail messages considered to be *junk*, make the following configuration change in Outlook.

1. Open the **Junk E-mail Options** dialog box.

   - Outlook 2010 and later versions:

     On the **Home** tab on the Ribbon, select **Junk**, and then select **Junk E-mail Options**.

   - Outlook 2007 or Outlook 2003

     On the **Tools** menu, select **Options**, and then select **Junk E-mail**.

2. On the **Options** tab, clear the **Permanently delete suspected junk e-mail instead of moving it to the Junk E-mail folder** option.
3. Select **OK**.
