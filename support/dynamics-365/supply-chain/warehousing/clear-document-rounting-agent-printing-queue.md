---
title: Many Printing Jobs Are Queued in Document Routing Agent
description: Provides resolutions on how to clear the printing queue within the Document Routing Agent (DRA) in Microsoft Dynamics 365 Supply Chain Management.
ms.date: 02/25/2025
# ms.search.form:
audience: Application User
ms.reviewer: kamaybac, ivanma
ms.search.region: Global
ms.author: mirzaab
ms.search.validFrom: 2025-02-10
ms.dyn365.ops.version: 10.0.39
ms.custom: sap:Warehouse management
---
# Many printing jobs might be queued in the Document Routing Agent (DRA)

This article provides resolutions on how to clear the printing queue within the Document Routing Agent (DRA) used in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

You might notice that many printing jobs are queued in the [Document Routing Agent (DRA)](/dynamics365/fin-ops-core/dev-itpro/analytics/install-document-routing-agent), causing delays or preventing new print jobs from being processed.

## Solution 1 - Clean up printing queue for one printer

Starting from [Dynamics 365 for Finance and Operations platform update 23](/dynamics365/fin-ops-core/dev-itpro/get-started/whats-new-platform-update-23#manage-access-to-network-printers-across-legal-entities), you can manually clear the printing queue for a specific printer by deleting it from the **System network printers** page. This action removes all pending documents for that printer. Follow these steps to delete and re-register the printer from the DRA client:

1. Navigate to the **Manage Network Printers** page by selecting **Organization administration** > **Setup** > **Network printers**.
2. Expand the **Options** menu and select the **System network printers** button in the **Preview** section.
3. Select the network printer and select the **Delete** button.

4. After deletion, pending printing jobs remain in the document routing status list for auditing purposes. However, the actual printing queue is already cleared for that printer.

5. [Re-register the same printer from the DRA client](/dynamics365/fin-ops-core/dev-itpro/analytics/install-document-routing-agent#register-network-printers), and try to print some documents.

   > [!NOTE]
   >
   > - Except for the first document, the rest should be printed responsively. The first document might be slow due to a one-time 3-minute cache refresh interval after a new printer is registered.
   > - If the same printer name is used again, there is no need to set up the document routing again.
   > - If a new printer name is used, you should set up the document routing with the new printer name for all relevant work order types. For more information, see [Set up license plate label routing](/dynamics365/supply-chain/warehousing/print-license-plate-labels-using-label-layouts#routing).

## Solution 2 - Clean up printing queue and job status for all printers

The [Document routing history cleanup](/dynamics365/fin-ops-core/dev-itpro/analytics/install-document-routing-agent#adjust-the-document-routing-history-cleanup-batch-job) batch job can be used to delete all the document routing jobs older than seven days (168 hours). By default, this batch job runs daily and is first created when a document is sent to the DRA.

Follow these steps to use the **Document routing history cleanup** batch job:

1. Change the document routing job history retention period length from seven days to one hour to delete all printing jobs older than one hour.
1. Copy the **Document routing history cleanup** batch job to a new batch job, and then update the copied batch job recurrence to run immediately.
1. Wait for the copied batch to complete, and then delete the copied batch job.
1. Restore the retention period from one hour to seven days.
