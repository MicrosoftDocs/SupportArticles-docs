---
title: Assessable value is incorrect
description: Provides mitigation steps that can help when the assessable value is incorrect.
author: lingshf
ms.date: 09/13/2024
audience: Application user
ms.reviewer:
ms.search.region: India 
ms.custom: sap:Tax - India tax\Issues with India goods and service tax (IN GST)
ms.author: shaoling
ms.search.validFrom: 2021-04-01
ms.dyn365.ops.version: 10.0.1
---
# Assessable value is incorrect

The assessable value is typically updated automatically based on the transaction value. If the value doesn't appear as expected, you can manually update the assessable value on the UI form. If this method isn't feasible (for example, the control isn't editable, there's no such UI, or it's too tedious to update many lines), you can follow the following mitigation steps together with a code extension to resolve the issue.

## Mitigation with a code extension

This section provides guidance on investigating the root cause and adding a [code extension](/dynamics365/fin-ops-core/dev-itpro/extensibility/writing-extensible-code), using a purchase order as an example.

1. Get the table field of the assessable value from UI:

   Go to **Accounts payable** > **Purchase order** > **All purchase orders**. Right-click the **Assessable value** column. Then, go to **Form information** > **Form Name: PurchTable**.

   :::image type="content" source="media/apac-ind-gst-troubleshooting-assessable-value-incorrect/assessable-value-table-field.png" alt-text="Screenshot that shows how to get the table field of the assessable value from UI." lightbox="media/apac-ind-gst-troubleshooting-assessable-value-incorrect/assessable-value-table-field.png":::

   The table field is the **AssessableValueTransactionCurrency** of the **PurchLine_IN** table that's extended from the main table **PurchLine** via [table extension framework](https://daxonline.org/9-table-extension-framework.html).

   :::image type="content" source="media/apac-ind-gst-troubleshooting-assessable-value-incorrect/assessablevaluetransactioncurrency-field.png" alt-text="Screenshot that shows the AssessableValueTransactionCurrency field of the PurchLine_IN table." lightbox="media/apac-ind-gst-troubleshooting-assessable-value-incorrect/assessablevaluetransactioncurrency-field.png":::

2. Use the [Development tools](/dynamics365/fin-ops-core/dev-itpro/dev-tools/development-tools-overview) to check the following methods of the main table (the **PurchLine** table for the purchase order) to ensure they update the assessable value accordingly. You can set breakpoints and debug the process. If an issue occurs, add a code extension to solve the issue.

    - `update`
    - `insert`
    - `modifiedField`

    For example, in `PurchLine.modifiedField`, there's code logic to update the assessable value. Review and update the code as needed to update the assessable value.

    :::image type="content" source="media/apac-ind-gst-troubleshooting-assessable-value-incorrect/purchline-modifiedfield.png" alt-text="Screenshot that shows a code logic example about updating the assessable value." lightbox="media/apac-ind-gst-troubleshooting-assessable-value-incorrect/purchline-modifiedfield.png":::
