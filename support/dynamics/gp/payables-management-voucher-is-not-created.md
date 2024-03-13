---
title: Payables Management voucher isn't created
description: Provides a solution to an issue where Payables Management voucher isn't created from service call billing in Service Call Management.
ms.reviewer: theley, beckyber 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Payables Management voucher isn't created from service call billing in Service Call Management in Microsoft Dynamics GP 2010

This article provides a solution to an issue where Payables Management voucher isn't created from service call billing in Service Call Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2490212

## Symptoms

When you try to create a voucher for a subcontractor from a service call in Service Call Management in Microsoft Dynamics GP, the voucher doesn't get created in Payables Management when you do Service Call Billing.

## Cause

This problem occurs if you don't select the **V** checkbox in the Service Call Entry - Labor window.

## Resolution

1. Verify the **Use Payables Management** checkbox is marked. To do it, follow these steps:
    1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **Project**, and then select **Service Setup**.
    1. In the **Options** section, mark **Use Payables Management**.

2. Make sure there's technician to vendor relationship. To do it, follow these steps:
    1. On the **Cards** menu, point to **Service Call Management**, and then select **Technician**.
    1. Enter the tech ID of the technician to be used on the service call.
    1. In the **Employee ID** field, enter the employee ID who will be linked to the technician.

        > [!NOTE]
        > The Employee ID must be using an hourly pay code or a pay code based on an hourly pay code.
    1. Select **Save**.

3. Make sure the service type is set up as a subcontractor type. To do it, follow these steps:
    1. On the **Cards** menu, point to **Service Call Management**, and then select **Service Type**.
    1. In the **Service Type** field, select the **Service Type** that will be used for subcontractor service calls.
    1. Mark the **Subcontractor** checkbox.
    1. In the Payables Batch ID field, enter the batch ID to be used for the vouchers created for this service type.

4. Mark the **V** box when you enter the service call.
    1. Open the service call for the subcontractor.
    1. Select **Labor**.
    1. Add a labor line for the technician linked to the employee.
    1. Select the **V** checkbox.
