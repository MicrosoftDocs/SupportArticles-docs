---
title: Contacts folder empty and contacts in another folder
description: Provides a workaround for an issue in which your contacts folder is empty and your contacts are contained in a different folder in Outlook for Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: cuturn, carlzern
appliesto: 
  - Outlook for Microsoft 365
  - Exchange Online
search.appverid: MET150
ms.date: 10/30/2023
---
# Contacts folder empty and contacts are in a different folder in Outlook for Microsoft 365

_Original KB number:_ &nbsp; 4058701

## Symptoms

You may notice that your contacts folder is empty. However, if you have another folder that has the same name or a localized version of the name, all your contacts may be in that folder.

For example, you may have two folders that are named **Contacts**. In this case, your contacts may be in the wrong contacts folder. If this is the case, you cannot access your contacts when you use Microsoft Outlook or another email application.

## Cause

This issue may occur during migration or localization. A code change in Microsoft Exchange Server that was intended to validate the Contacts folder may cause the folder to become invalid. When this occurs, Exchange Server creates a new Contacts folder and assigns it as the contacts folder that is to be used by Outlook and other email applications.

## Workaround

To work around this issue, drag your contacts from the contacts folder that contains your contacts (this folder has as a folder icon in Outlook Desktop) to the new Contacts folder (this folder has a contact card icon in Outlook Desktop).
