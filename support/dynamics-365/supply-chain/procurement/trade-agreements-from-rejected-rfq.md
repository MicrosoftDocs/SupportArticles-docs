---
title: Trade agreements can be created from rejected RFQs
description: Introduces a by-design behavior where you can create trade agreements from rejected RFQs.
author: Henrikan
ms.date: 05/31/2021
ms.search.form: PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: henrikan
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
---
# Trade agreements can be created from rejected RFQs

## Symptoms

Trade agreements can be created from rejected request for quotations (RFQs). Therefore, the system doesn't prevent trade agreement journals from being created if the RFQ line hasn't been accepted.

## Resolution

This is the expected behavior. You can create trade agreements for any replies for a request for quotation (RFQ), regardless of whether they were accepted or rejected. For more information, see [Requests for quotation (RFQs) overview](/dynamics365/supply-chain/procurement/request-quotations).
