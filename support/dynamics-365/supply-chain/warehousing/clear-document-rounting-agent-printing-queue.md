---
title: Clear document rounting agent (DRA) printing queue
description: Introduces a by-design behavior where only one label is printed for multiple work headers on a single receipt.
author: ivanma
ms.date: 10/02/2025
ms.topic: troubleshooting
# ms.search.form:
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: ivanma
ms.search.validFrom: 2025-02-10
ms.dyn365.ops.version: 10.0.39
ms.custom: sap:Warehouse management
---

# Clear document rounting agent (DRA) printing queue

## Symptoms

There are many printing jobs queued in the document rounting agent (DRA).

## Resolution

The are two options to resolve this issue:

### Option 1 - Clean up printing queue for one printer

Starting from PU23, users can do this by themselves by deleting the printer in the **System network printers** page. When a printer is deleted, all of the pending documents to that printer will be deleted too. After that, the user can register the printer back again from document rounting agent (DRA) client.

To delete network printers, use the following steps:
1. Navigate to the **Manage Network Printers form**: **Organization admin** > **Setup** > **Network printers**.
2. Expand the **Options** menu and in the **Preview** section click *System network printers* button.
3. Select the network printer and click on the **Delete** button.
4. After deletion, the pending printing jobs still exist in the document routing status list. However, these data are just for auditing purpose. The actual printing queue was already cleaned up for that printer.

User can re-register the same printer from the DRA client, and try to print some documents. Except the first document, the rest documents should be printed in a responsive manner. The reason that the first document is slow because there is an one-time 3 minutes cache refresh interval after a new printer is printed.

In the same printer name is used again, there should not be a need to setup the **Document routing** again.
However, if a new printer name was used, then the user must setup **Document routing** with the new printer name for all the relevant **Work order types**.

### Option 2 - Clean up printing queue and job status for all printers

There is a batch job called **Document routing history cleanup** which deletes all the document routing jobs that were created over 7 days (168 hours) ago. By default, the batch job runs daily. It is first created when a document is sent to the DRA.

For this mitigation, use the following steps:
1. Change the document routing job history retention length from 7 days to 1 hour, so that all the printing jobs over 1 hour will be deleted.
2. Copy the **Document routing history cleanup** batch job to a new batch job, and then update the copied batch job recurrence so that it will run immediately.
3. Wait for the copied batch to complete, and then delete the copied batch job.
4. Restore the retention period from 1 hour to 7 days.