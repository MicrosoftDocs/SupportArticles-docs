---
title: Troubleshooting Relationship Intelligence
description: Provides resolutions for the limitations with Relationship Intelligence.
author: roraisin
ms.author: roraisin
ms.topic: troubleshooting
ms.date: 03/28/2023
ms.subservice: d365-sales-sales
---
# Troubleshooting Relationship Intelligence

This article helps you troubleshoot and resolve issues related to Relationship Intelligence.

## Issue: You notice that the no insights from Exchange data, even though you've [enabled "Relationship Intelligence"](/dynamics365/sales/enable-ri) and [consented](/dynamics365/sales/provide-consent-office365) to the use of Exchange data.

### Cause

This issue could occur due to one of the two reasons:- 
1. A "Customer Key" is configured to encrypt your data at rest at Microsoft's data centers.
2. REST API isn't yet supported for this mailbox. This issue could occur if the mailbox is on a dedicated Microsoft Exchange Server and isn't a valid Microsoft 365 mailbox.

### Resolution

To solve this issue
- Ensure that your organization has a valid Microsoft 365 mailbox. Exchange data can't be collected if you have a dedicated Microsoft Exchange Server. For more information about the underlying issue and resolution, see [this article](https://learn.microsoft.com/en-us/exchange/troubleshoot/user-and-shared-mailboxes/rest-api-is-not-yet-supported-for-this-mailbox-error).
- Ensure that your organization isn't encrypting Microsoft 365 data with its own encryption keys. Exchange data can't be collected if your data is encrypted. For more information, see [this article](https://learn.microsoft.com/en-us/microsoft-365/compliance/customer-key-set-up?view=o365-worldwide).