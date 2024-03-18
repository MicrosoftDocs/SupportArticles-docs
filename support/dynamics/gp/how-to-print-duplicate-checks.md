---
title: How to print duplicate checks
description: Provides two methods for printing duplicate checks in Microsoft Dynamics GP and in Microsoft Great Plains.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to print duplicate checks in Microsoft Dynamics GP and in Microsoft Great Plains

This article discusses how to print duplicate checks in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 905639

> [!NOTE]
> The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.
>
> Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.

To print duplicate checks in Microsoft Dynamics GP and in Microsoft Great Plains, use one of the following methods.

## Method 1 - Change the printer settings

To print duplicate checks by changing the printer settings, follow these steps:

> [!IMPORTANT]
> The order in which duplicate checks are printed depends on the collation settings of the printer. By default, most printers print duplicate checks in the following order:  
> 1, 1, 2, 2, 3, 3, ...
>
> However, on HP Mopier printers, collation can be turned off so that duplicate checks are printed without being collated. That is, duplicate checks can be printed in the following order:  
> 1, 2, 3, ..., 1, 2, 3, ...

For more information about Mopier printers and settings, visit the HP Web site: [HP Support](https://www8.hp.com/sg/en/home.html).

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.  

1. On the **File** menu, select **Print Setup**.
2. Select the printer, and then select **Properties**.
3. Select **Advanced**, select the **Copy Count** option, type *2* in the **Copy Count** box, and then clear the **Collated** check box.
4. Type *1* in the **Copy Count** box, and then type *2* in the **Number of copies** box.
5. Print the checks.

## Method 2 - Reprint the checks in Microsoft Dynamics GP or in Microsoft Great Plains

To print duplicate checks by reprinting the checks in Microsoft Dynamics GP or in Microsoft Great Plains, follow these steps:

1. Verify that your checkbook allows for duplicate check numbers. To do this, follow these steps:

   1. On the **Cards** menu, point to **Financial**, and then select **Checkbook**.
   2. In the **Checkbook ID** box, type your purchasing checkbook ID.
   3. In the **Payables Options** area, select the **Duplicate Check Numbers** check box.

2. Print your payables checks as you ordinarily would, but stop when the Post Payables Checks window appears.
3. In the **Process** list, select **Reprint Checks**.
4. In the **Starting Check Number** box, type the number of the first check that you printed.
5. Change the paper in the paper tray from check stock to white paper, and then select **Process**.
6. When the Post Payables Checks window appears, post the checks, or process the checks later.

> [!NOTE]
> The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
