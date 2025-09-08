---
title: 554 5.4.14 Hop Count exceeded
description: Describes a scenario in Exchange Online in which primary SMTP addresses are displayed incorrectly or secondary SMTP addresses are missing.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jchenau, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Primary SMTP addresses are displayed incorrectly or secondary SMTP addresses are missing

_Original KB number:_ &nbsp; 3173405

## Problem

When you sync users to Exchange Online, the primary SMTP address is shown incorrectly as *user@contoso.onmicrosoft.com* or the secondary SMTP address is missing. Depending on your configuration, this may cause mail routing issues and generate non-delivery reports (NDRs) for these recipients.

For example, you receive an NDR that contains the following error message:

> 554 5.4.14 Hop Count exceeded - possible mail loop ATTR34

## Cause

This behavior occurs by design when you have one or more unverified domains in Microsoft 365.

## Solution

To resolve this behavior, add and verify the missing domains. For the steps, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

If this fix doesn't fit or work for your business needs, contact Support for further assistance.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
