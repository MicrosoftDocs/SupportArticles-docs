---
title: Inventory journal workflow never completes and the journal can't be processed
description: Provides resolutions for the issue that workflow processing stops responding and you can't edit or process your journals after you submit a journal approval workflow.
author: sherry-zheng
ms.date: 05/16/2024
ms.topic: troubleshooting
ms.search.form: 
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: chuzheng
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.16
ms.custom: sap:Inventory management\Issues with the inventory journal
---


# Inventory journal workflow never completes and the journal can't be processed

## Symptoms

After you submit a journal approval workflow, workflow processing stops responding, and you can't edit or process your journals.

## Resolution

There are several reasons why workflow processing might not be completed. Check for the following issues:

- Go to **Inventory management** > **Setup** > **Inventory management workflows**, and review the configuration of the affected workflow. For more information, see [Inventory journal approval workflows](/dynamics365/supply-chain/inventory/inventory-journal-workflow).
- The workflow might be encountering an exception or error. Review the work item history of the affected workflow to see whether it includes an application error that terminates the workflow.
- The inventory journal can be updated or edited only if it's approved. If recall is active, you can try to recall the journal. Execution of the workflow batch job might be suspended for multiple reasons. Some of these reasons might be caused by the workflow framework issue.
