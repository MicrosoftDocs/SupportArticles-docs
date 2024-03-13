---
title:  Company doesn't have access to currency error when using Multicurrency with any module
description: Describes steps to resolve the message Company XXX doesn't have access to currency that occurs when you try to use Multicurrency with any module in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Company XXX doesn't have access to currency" error when using Multicurrency with any module in Microsoft Dynamics GP

This article provides a resolution for the **Company XXX doesn't have access to currency** error that occurs when you use Multicurrency with any module in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850921

## Symptom

You receive the following error message when performing processes in any sub-module using Microsoft Dynamics GP:

> Company xxx doesn't have access to currency.

> [!NOTE]
> You may still receive this error is you are not registered for Multicurrency.

## Resolution

To resolve this message, you need to set up a functional currency and give the company access to the currency.

- On Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0

  1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Currency**. If the existing currencies that are set up fit your needs, you may use them and skip this step.

  2. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Multicurrency Access**. Select the currency ID you will be using as a functional currency and mark the Access box for every company that is receiving this error. (This is the step that should specifically resolve the error message above.)

  3. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **Financial**, and select **Multicurrency**. Select the currency ID as the Functional Currency and Reporting Currency. You will also need to populate the Default Transaction Rate Types.

  4. Select **OK** to close the window. You will receive a message stating you will need to run check links on the Multicurrency Setup Files. Select **OK** to this message. Use these steps to run check links:

     1. On the Microsoft Dynamics GP menu, point to **Maintenance** and select **Check Links**.
     2. Select Financial as the Series and insert the Multicurrency Setup Files from the Logical Tables section to the Selected Tables section.
     3. Select **OK** and print the report to the destination you choose.

- On Microsoft Dynamics GP 9.0

  1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Currency**. If the existing currencies that are set up fit your needs, you may use them and skip this step.

  2. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Multicurrency Access**. Select the currency ID you will be using as a functional currency and mark the Access box for every company that is receiving this error.

  3. On the **Tools** menu, point to **Setup**, point to **Financial**, and select **Multicurrency**. Select the currency ID as the Functional Currency and Reporting Currency. You will also need to populate the Default Transaction Rate Types.

  4. Select **OK** to close the window. You will receive a message stating you will need to run check links on the Multicurrency Setup Files, select **OK** to this message.

        1. On the **Files** menu, point to **Maintenance** and select **Check Links**.
        2. Select **Financial** as the Series and insert the Multicurrency Setup Files from the Logical Tables section to the Selected Tables section.
        3. Select **OK** and print the report to the destination you choose.
