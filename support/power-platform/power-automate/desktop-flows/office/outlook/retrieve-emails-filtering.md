---
title: Outlook retrieve emails filtering issues
description: Solves issues regarding the filtering email messages in outlook
ms.custom: sap:Desktop flows\UI or Browser automation issues
ms.date: 01/22/2025
---

# Outlook retrieve emails filtering issues

## Symptoms

No results are returned when the 'From' filter is specified in the Retrieve email messages action in Outlook.

## Cause

In some cases, the email addresses of Exchange users have a x500 format (_something like: /o\=<organization-name\>/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=\<mailbox\>_) instead of the known mail format (_person@email.com_). In those cases, when using the Retrieve email messages action in Outlook the 'From' filter doesn't work since filtering is performed with the x500 format email.

You can retrieve the x500 format email using the 'Exchange powershell' using this cmdlet:
Get-Mailbox -Identity username | ft legacyExchangeDN.
Alternatively you could look in %LocalAppData%\Microsoft\Outlook there they should find an xml file that would have a section LegacyDn.

## Workaround

- Use other actions for email operations such as:
  1. [Exchange Server actions](/power-automate/desktop-flows/actions-reference/exchange).
  2. [Office 365 Outlook actions](/connectors/office365/#get-emails-(v3)).
  
- Perform the filtering by using a for each loop to iterate the returned messages. An example is shown below:

  :::image type="content" source="media/retrieve-emails-filtering/loop_emails_filter.png" alt-text="Retrieve emails using a loop.":::
