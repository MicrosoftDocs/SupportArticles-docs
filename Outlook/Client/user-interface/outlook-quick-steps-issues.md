---
title: The Calendar folder cannot be found or The Tasks folder cannot be found error when you use Quick Steps in Outlook
description: When you use an IMAP or POP account that's added as a secondary account to the Outlook profile and try to use Quick Steps, you would receive error messages.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: gabesl
ms.custom: 
  - sap:User Interface features and Configuration\Quick Steps
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook 2016
ms.date: 01/30/2024
---

# "The Calendar folder cannot be found" or "The Tasks folder cannot be found" error when you use Quick Steps in Outlook

## Symptoms

When you use an IMAP or POP account that's added as a secondary account to the Outlook profile and try to use any of the following **Quick Steps**, you receive one of two error messages:

```
"The Calendar folder cannot be found" or "The Tasks folder cannot be found".
```

:::image type="content" source="media/outlook-quick-steps-issues/folders-not-found.png" alt-text="Screenshot of two error messages. When using an IMAP or POP account added as a secondary account to the Outlook profile and trying to use Quick Steps, you receive one of the errors.":::

**Quick Steps**:

* Create a task with attachment
* Create a task with text of message
* Create an appointment with attachment
* Create an appointment with text of message

## Cause

This is a known limitation in Outlook.

Outlook does not synchronize the **Calendar** or **Tasks** folder with the server for IMAP or POP accounts. If the primary account is configured as an IMAP or POP email account, a **Calendar** or **Tasks** folder is created locally so that these features can still be used within Outlook. However, non-primary IMAP or POP accounts don't have these folders created, and any attempt to interact with these folders by using **Quick Steps** will generate this error.

## More information

For more information about **Quick Steps**, see the following Microsoft Support article:

[Automate common or repetitive tasks with Quick Steps](https://support.office.com/article/automate-common-or-repetitive-tasks-with-quick-steps-b184f89f-3738-4562-96de-c0244ea830f2?ui=en-US&rs=en-001&ad=US)
