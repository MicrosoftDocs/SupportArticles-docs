---
title: Exchange data can't be collected to generate insights
description: Provides a resolution for the issue where no insights are generated based on Exchange data even if relationship intelligence is enabled.
author: roraisin
ms.author: roraisin
ms.topic: troubleshooting
ms.date: 03/28/2023
ms.custom: sap:Sales Insights

---
# Troubleshooting issues with relationship intelligence

This article helps you troubleshoot and resolve the issue where insights can't be generated using Exchange data when you use [relationship intelligence](/dynamics365/sales/ri-overview) in Dynamics 365 Sales.

## Symptoms

No insights are generated from Exchange data even though you've [enabled relationship intelligence](/dynamics365/sales/enable-ri) and [consented](/dynamics365/sales/provide-consent-office365) to the use of Exchange data.

## Cause

This issue could occur due to one of two reasons:

1. A "Customer Key" is configured to encrypt your data at rest in Microsoft's data centers.
2. REST API isn't yet supported for this mailbox. This issue could occur if the mailbox is on a dedicated Microsoft Exchange Server and isn't a valid Microsoft 365 mailbox.

## Resolution

To solve this issue:

- Ensure that your organization has a valid Microsoft 365 mailbox. Exchange data can't be collected if you have a dedicated Microsoft Exchange Server. For more information about the underlying issue and resolution, see [REST API is not yet supported for this mailbox error for request to a mailbox](/exchange/troubleshoot/user-and-shared-mailboxes/rest-api-is-not-yet-supported-for-this-mailbox-error).
- Ensure that your organization isn't encrypting Microsoft 365 data with its own encryption keys. Exchange data can't be collected if your data is encrypted. For more information, see [Set up Customer Key](/microsoft-365/compliance/customer-key-set-up).
