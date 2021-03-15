---
title: Error (Something went wrong and your search couldn't be completed) when searching from an additional mailbox in Outlook
description: When you perform a search from a secondary mailbox that you have Full Access permissions in Outlook, the operation will fail. This is a known limitation of the Exchange Online search service. 
author: helenclu
ms.author: aruiz
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: o365-proplus-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CI 114104
- CSSTroubleshoot
ms.reviewer: aruiz
appliesto:
- Outlook for Office 365
- Exchange Online
search.appverid: 
- MET150
---

# "Something went wrong and your search couldn't be completed" error message when searching from an additional mailbox in Outlook

## Symptoms

Consider the following scenario:

- You are granted Full Access permissions to a secondary mailbox.
- You add the mailbox as an additional Exchange account to your Microsoft Outlook for Office 365 profile.
- You run a search from that mailbox.

In this scenario, you receive an error message that resembles the following:

*Something went wrong and your search couldn't be completed.*

*It looks like there's a problem with your network connection.*

When this error occurs, clicking the **Let's look on your computer instead** option may display the expected search results.

## Cause

This is a known limitation of the Exchange Online search service. The issue occurs if an Outlook client uses the primary mailbox user's credentials to run a search from a secondary mailbox.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, use any of the following methods:

- Select **Let's look on your computer instead** to start a local Windows Desktop Search after every error.
- Change Outlook settings to stop using the search function on the service. To do this, create a DisableServerAssistedSearch registry key. For more information, see this [Outlook Global Customer Service & Support Team Blog article](https://techcommunity.microsoft.com/t5/outlook-global-customer-service/how-outlook-2016-utilizes-exchange-server-2016-fast-search/ba-p/381195).

|Type | Value|
|---------|---------|
|Group Policy Registry Path|`HKEY_CURRENT_USER\software\policies\Microsoft\office\16.0\outlook\search`|
|Value Name|DisableServerAssistedSearch|
|Value Type|REG_DWORD|
|Value Data|1|

> [!NOTE]
> The OCT registry path will be `HKEY_CURRENT_USER\software\microsoft\office\16.0\outlook\search`.

- Set the additional mailbox to stop using Cached Exchange Mode, see this [Microsoft Support article](https://support.office.com/article/Turn-on-Cached-Exchange-Mode-7885AF08-9A60-4EC3-850A-E221C1ED0C1C).
- Create a shared mailbox as an additional mailbox. For more information, see [Create a shared mailbox](https://docs.microsoft.com/office365/admin/email/create-a-shared-mailbox?view=o365-worldwide).
