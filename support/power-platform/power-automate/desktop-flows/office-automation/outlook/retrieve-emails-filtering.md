---
title: Retrieve Email Messages from Outlook Doesn't Work
description: Solves an issue related to the Retrieve email messages from Outlook action in Microsoft Power Automate.
ms.custom: sap:Desktop flows\Office automation
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.date: 03/03/2025
---
# The "Retrieve email messages from Outlook" action doesn't work as expected

This article solves an issue where the [Retrieve email messages from Outlook](/power-automate/desktop-flows/actions-reference/outlook) action doesn't return any results in Microsoft Power Automate.

## Symptoms

When you use the **From contains** filter in the **Retrieve email messages from Outlook** action in Power Automate, no results are returned.

## Cause

In some cases, the email addresses of Exchange users are in an X500 format (for example, /o\=<organization-name\>/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=\<mailbox\>) instead of the standard mail format (`person@email.com`). When you use the **Retrieve email messages from Outlook** action in Power Automate, the **From contains** filter might not work if the filtering is performed with the X500 format email.

If that's the case, use the X500 format email in the **From contains** filter.

You can retrieve the X500 format email using the Exchange PowerShell cmdlet:

```powershell
Get-Mailbox -Identity username | ft legacyExchangeDN.
```

Alternatively, you can look in `%LocalAppData%\Microsoft\Outlook` for an XML file that contains a section called **LegacyDn**.

## Workaround

To work around this issue:

- Use other actions for email operations, such as:

  - [Exchange Server actions](/power-automate/desktop-flows/actions-reference/exchange).
  - [Microsoft 365 Outlook actions](/connectors/office365/#get-emails-(v3)).
  
- Perform the filtering by using a **For each** loop to iterate through the returned messages. For example:

  :::image type="content" source="media/retrieve-emails-filtering/loop-emails-filter.png" alt-text="Screenshot of an example of retrieving emails using a For each loop." lightbox="media/retrieve-emails-filtering/loop-emails-filter.png":::

## More information

[Outlook actions](/power-automate/desktop-flows/actions-reference/outlook)
