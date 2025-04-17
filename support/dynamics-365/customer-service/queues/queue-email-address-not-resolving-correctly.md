---
title: Queue Email Address is Unresolved or Unrecognized In the To Field
description: Solves an issue where emails sent to a queue show the queue email address as unresolved or unrecognized in the To field in Microsoft Dynamics 365.
author: Yerragovula
ms.author: srreddy
ms.reviewer: courtser
ai-usage: ai-assisted
ms.date: 04/17/2025
ms.custom: sap:Queues, DFM
---
# Queue email address isn't resolved correctly in Dynamics 365

This article addresses an issue where emails sent to a queue show the queue email address as unresolved or unrecognized in the **To** field in Dynamics 365.

## Symptoms

When emails are sent to a [queue](/dynamics365/customer-service/administer/set-up-queues-manage-activities-cases) in Dynamics 365, the queue email address appears as unresolved or unrecognized in the **To** field within Dynamics 365. However, the system still processes the email and generates cases as expected.

## Cause

This issue occurs when multiple records within Dynamics 365 share the same email address. The system identifies multiple matches and may randomly resolve one of them. As a result, the email address appears as unresolved or unrecognized.

## Resolution

To resolve this issue, follow these steps:

1. Use the following [Open Data Protocol (OData) query](/power-apps/developer/data-platform/webapi/query/overview) to find duplicate email addresses in the system. This query will return all records (queues, accounts, contacts, leads, or custom records) that share the same email address.

    `https://contoso.api.crm.dynamics.com/api/data/v9.1/emailsearches?$filter=emailaddress eq 'email@example.com'`

   > [!NOTE]
   > Replace the organization URL and email address in the query to fit your environment.

2. Remove or update duplicate email addresses:

   1. Change the email addresses on duplicate records to ensure each email address is unique across all records.

   2. After updating the email addresses, verify the query results to ensure duplicates no longer appear.

      If duplicates persist in the query results, there may be a delay in the email search table refresh. Currently, there's no method to force an immediate refresh of the email search table.

3. Adjust Dynamics 365 system settings:

    1. Navigate to **Advanced Settings** > **Settings** > **Administration** > **Email** in Dynamics 365.
    2. Locate the **Set To, cc, bcc fields as unresolved values if multiple matches are found in Incoming Emails** setting.
    3. Set the setting to **No** to ensure the system correctly resolves email addresses when there's only one matching record.

   > [!IMPORTANT]
   > If the setting is set to **Yes**, the system won't resolve email addresses that have multiple matches. These email addresses will appear marked in red, requiring you to manually resolve them to a specific record.
