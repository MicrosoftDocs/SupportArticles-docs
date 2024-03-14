---
title: Could not find stored procedure
description: Provides a solution to an error that occurs when you try to print the FUTA or SUTA report from Greenshades.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# "Could not find stored procedure 'XXXX.dbo. GSDELETEFUTARANGE'" Error message when you try to print the FUTA or SUTA report from Greenshades

This article provides a solution to an error that occurs when you try to print the FUTA or SUTA report from Greenshades.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950710

## Symptoms

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

When you've Greenshades installed and try to print the FUTA or SUTA report from Greenshades, you receive the following error message:

> Unhandled script exception: [Microsoft][ODBC SQL Server Driver][SQL Server] Could not find stored procedure 'XXXX.dbo. GSDELETEFUTARANGE'

> Unhandled script exception: [Microsoft][ODBC SQL Server Driver][SQL Server] Could not find stored procedure 'XXXX.dbo. GSDELETESUTARANGE'

> Unhandled script exception: [Microsoft][ODBC SQL Server Driver][SQL Server] Could not find stored procedure 'XXXX.dbo. smDEX_Clear_Locks'

## Cause

This problem may occur because the Greenshades version has to be updated to be compatible with Microsoft Dynamics.

## Resolution

This error message isn't related to Microsoft Dynamics GP. If you've a third-party product installed called Greenshades, contact Greenshades Software, Inc. to resolve the issue.

Greenshades Software, Inc.

7800 Belfort Parkway, Suite 220

Jacksonville, FL 32256

Tel 888.255.3815

Fax 904.807.0165

Web site: `http://www.greenshades.com`

## Workaround

To work around this problem, disable the third-party product. To do it, use one of the following methods.

### Method 1: Disable and then re-enable the extra product

When you use Method 1, you don't have to exit Microsoft Dynamics GP. To disable and then re-enable the extra product, follow these steps.

#### Disable the extra product

1. Use the appropriate method:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Customization Status**.
   - In Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then select **Customization Status**.

2. Select the appropriate product, such as Greenshades.
3. Select **Disable**.
4. Close the Customization Status window.
5. Do the necessary tests to troubleshoot or reproduce the issue.

#### Re-enable the extra product

1. Use the appropriate method:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Customization Status**.
   - In Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then select **Customization Status**.

2. Select the appropriate product, such as Greenshades.
3. Select **Enable**.
4. Close the Customization Status window.

> [!NOTE]
> You can also enable the additional product if you exit Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0, and then restart the program.

### Method 2: Remove the third-party product from the Dynamics.set file

For more information about how to disable third-party products in the Dynamics.set file in Microsoft Dynamics GP, see [KB - Steps to disable third-party products or temporarily disable extra products in the Dynamics.set file in Microsoft Dynamics GP](https://support.microsoft.com/help/872087).

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
