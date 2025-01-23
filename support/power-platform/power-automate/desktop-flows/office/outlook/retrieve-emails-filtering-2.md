---
title: Outlook retrieve emails filtering issues
description: Solves issues regarding the filtering email messages in outlook
ms.custom: sap:Desktop flows\UI or Browser automation issues
ms.date: 01/22/2025
ms.author: amitrou 
author: amitrou
---

# Outlook retrieve emails filtering issues 2

## Symptom(s)

When specifying the 'From' filter in Retrieve email messages action in Outlook, no results are returned.

## Cause

In some cases the email addresses of Exchange users have a x500 format (_something like: /o\=<organization-name\>/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=\<mailbox\>_) instead of the known mail format (_person@email.com_). In those cases when using the Retrieve email messages action in Outlook the 'From' filter will not work since filtering will be performed with the x500 format email.

You can retrieve the x500 format email using the 'Exchange powershell' using the below cmdlet:
Get-Mailbox -Identity username | ft legacyExchangeDN.
Alternatively you could look in %LocalAppData%\Microsoft\Outlook there they should find a an xml file that would have a section LegacyDn.

## Workaround

- Use other actions for email operations such as Exchange or Office 365 Outlook
- Perform the filtering by using a for each loop to iterate the returned messages