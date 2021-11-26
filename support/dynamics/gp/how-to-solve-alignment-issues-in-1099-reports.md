---
title: How to solve alignment problems in 1099 reports
description: Describes how to correct alignment problems when you print 1099 reports on preprinted forms in Payables Management in Microsoft Dynamics GP.
ms.reviewer: kriszree
ms.topic: how-to
ms.date: 04/22/2021
---
# How to solve alignment problems in 1099 reports in Payables Management in Microsoft Dynamics GP

This article describes how to realign the fields in the 1099 reports so that the fields are put in the correct locations on preprinted forms in Payables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 853929

When you print the 1099 reports, the alignment of the fields is incorrect on the preprinted forms in Microsoft Dynamics GP. To resolve this issue, use one or more of the following methods.

## Method 1

When you print the report to a printer, the Print window opens. Enter values in the **Horizontal** field and in the **Vertical** field, and then select **OK** to print the report to blank paper. Hold the alignment form and the preprinted form together to determine whether the alignment is correct. If the alignment is incorrect, repeat this step. Use different values in the alignment fields until the alignment is accurate.

> [!NOTE]
>
> - The **Horizontal** field: A negative value moves the alignment to the right on the paper. A positive value moves the alignment to the left on the paper.
> - The **Vertical** field: A negative value moves the alignment up on the paper. A positive value moves the alignment down on the paper.

## Method 2

Reinstall the printer driver. For more information about how to reinstall the printer driver, visit the printer manufacturer's Web site.

## Method 3

Use a different workstation and printer to print the 1099 reports.

## Method 4

Use Report Writer to change the 1099 report. To do this, follow these steps:

1. Follow the appropriate step:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then select **Report Writer**.

2. Select **Reports**.
3. In the **Original Reports** box, select the 1099 report that you want to change. The following 1099 reports are available:

    - 1099 Dividend
    - 1099 Interest
    - 1099 Miscellaneous
    - 1099 Laser Dividend
    - 1099 Laser Interest
    - 1099 Laser Miscellaneous

4. Select **Insert**, select the same report in the **Modified Reports** box, and then select **Open**.
5. In the Report Definition window, select **Layout**.
6. In the Report Layout, move the appropriate fields so that they align with the preprinted 1099 form.
7. On the **File** menu, select **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**. When you are prompted to save changes, select **Save**.
8. To assign security permissions to the modified report, use one of the following methods.

    - Method A - Use security in Microsoft Dynamics GP 10.0

      1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
      2. In the **ID** box, type the ID of the user who will print this modified report.
      3. In the **Product** list, select **Microsoft Dynamics GP**.
      4. In the **Type** list, select **Reports**.
      5. Expand the **Financials** folder.
      6. Expand the folder for the report that you modified.
      7. Select to select **Microsoft Dynamics GP (Modified)**.
      8. Select **Save**.
      9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
      10. In the **User** list, select a user ID.
      11. In the **Company** list, select a company.
      12. In the **Alternate/Modified Forms and Reports ID** list, select the ID from step b.
  
    - Method B - Use the Advanced Security tool in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0

      1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
      2. If you are prompted, type the system password in the **Please Enter Password** box, and then select **OK**.
      3. In the Advanced Security window, select **View**, and then select **By Alternate, Modified and Custom**.
      4. Use one of the following steps, depending on which version is installed:
         - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
         - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
      5. Expand **Reports**, expand **Financials**, and then expand the report that you modified.
      6. Use one of the following steps, depending on which version is installed:
  
         - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
         - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**.
  
      7. Select **Apply**, and then select **OK**.

         > [!NOTE]
         > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.

    - Method C - Use the Standard Security tool in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0

      1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.
      2. If you are prompted, type the system password in the **Please Enter Password** box, and then select **OK**.
      3. In the **User ID** list, select the ID of the user who you want to have access to the modified report.
      4. In the **Type** list, select **Modified Reports**.
      5. In the **Series** list, select **Financials**.
      6. In the **Access List** box, double-click the report that you modified, and then select **OK**.

          > [!NOTE]
          > An asterisk (*) appears next to the report name.
