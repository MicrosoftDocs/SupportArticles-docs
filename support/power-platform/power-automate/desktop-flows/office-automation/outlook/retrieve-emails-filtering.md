---
title: Retrieve Email Messages From Outlook doesn't Work
description: Solves an issue related to the retrieving email messages from Outlook action in Microsoft Power Automate.
ms.custom: sap:Desktop flows\Office automation
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.date: 02/14/2025
---
# The Retrieve email messages from Outlook action doesn't work as expected

This article solves an issue where the **Retrieve email messages from Outlook** action doesn't return any results in Microsoft Power Automate.

## Symptoms

When you use the "From" filter in the **Retrieve email messages from Outlook** action in Power Automate, no results are returned.

## Cause

In some cases, the email addresses of Exchange users are in an x500 format (for example, /o\=<organization-name\>/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=\<mailbox\>) instead of the standard mail format (`person@email.com`). When you using the **Retrieve email messages** action in Outlook, the "From" filter doesn't work because the filtering is performed with the x500 format email.

You can retrieve the x500 format email using the Exchange PowerShell cmdlet:

```powershell
Get-Mailbox -Identity username | ft legacyExchangeDN.
```

Alternatively you could look in `%LocalAppData%\Microsoft\Outlook` for an XML file that contains a section called **LegacyDn**.

## Workaround

To work around this issue,

- Use other actions for email operations such as:

  1. [Exchange Server actions](/power-automate/desktop-flows/actions-reference/exchange).
  2. [Office 365 Outlook actions](/connectors/office365/#get-emails-(v3)).
  
- Perform the filtering by using a **For each** loop to iterate through the returned messages. For example,

  :::image type="content" source="media/retrieve-emails-filtering/loop_emails_filter.png" alt-text="An example of retrieving emails using a For each loop.":::

## More information

[Outlook actions](/power-automate/desktop-flows/actions-reference/outlook)
