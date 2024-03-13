---
title: Service item cost and vendor do not show in outsourced purchase order 
description: Describes a problem that occurs if the functional currency is not configured correctly for the company. A resolution is provided.
ms.reviewer: lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The service item, the cost, and the vendor do not appear when you view an outsourced purchase order in Manufacturing in Microsoft Dynamics GP

This article provides a resolution to make sure the service item, the cost, and the vendor show when you view an outsourced purchase order in Manufacturing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 924540

## Symptoms

You release a manufacturing order in Manufacturing in Microsoft Dynamics GP. However, when you view the outsourced purchase order, the service item, the cost, and the vendor do not appear.

## Cause

This problem may occur if either of the following conditions is true:

- The functional currency is not correctly configured for the company.
- Access to the functional currency is not correctly configured for the company.

> [!NOTE]
> The functional currency is the currency ID that represents the currency that the company typically uses.

This problem is more likely to occur if either of the following conditions is true:

- The company was copied from a different company configuration. However, the functional currency has not been configured for the new company.
- The company information was restored from a backup. However, the functional currency has not been configured for the new company.

## Resolution

To resolve this problem, follow these steps:

1. Start Microsoft Dynamics GP.
2. On the **Tools** menu, point to **Setup**, point to **Financial**, and then select **Multicurrency**.
3. In the Multicurrency Setup window, verify that the currency that the company typically uses is displayed in the **Functional Currency** field. If the correct currency is not displayed in this field, select the correct currency, and then select **OK**.
4. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Multicurrency Access**.
5. If you are prompted, type the system password in the **Enter system password** box. Then, select **OK**.
6. In the Multicurrency Access Setup window, select the currency that is displayed in the **Functional Currency** field.

    > [!NOTE]
    > This is the currency that was displayed in step 3.

7. In the right pane, select the **Access** check box for the company with which you experience this problem.
8. Select **OK**.
