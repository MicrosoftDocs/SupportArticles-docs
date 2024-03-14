---
title: Use and troubleshoot Report Writer
description: Provides information about how to use Report Writer and how to troubleshoot common problems in Report Writer.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use and troubleshoot Report Writer in Microsoft Dynamics GP

This article contains information about how to use and troubleshoot Report Writer in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861803

## How to determine the name of a report

To determine the name of a report in Report Writer, print the report to the screen in Microsoft Dynamics GP. The name of the report appears in the title bar of the window.

## About primary copies and secondary copies

In Report Writer, a report can have primary copies or secondary copies.

> [!NOTE]
> To select a report to modify, start Report Writer, and then select **Reports**.

### Primary copies

- A primary copy is created when the report is inserted in the **Modified Reports** list in Report Writer.
- Report Writer prints the primary copy of a modified report instead of the original modified report after a user is granted permissions to the modified report.
- Only one primary copy of a report can exist.
- You can't change a secondary copy of a report to be the primary copy of the report.
- You can't print the primary copy of a report from Report Writer if the report pulls information from a temporary table.

### Secondary copies

- You can use either of the following methods to create a secondary copy of a report:
  - Select **Copy** to add the report to the modified report list.
  - Select a modified report, and then select **Duplicate**.
- You can't make a secondary copy of a report if the report pulls information from a temporary table. The **Copy** button and the **Duplicate** button will be unavailable.
- You can print the secondary copy of a report in Report Writer. In Microsoft Dynamics GP, you can also print the secondary copy of a report by selecting **Customized** on the **Reports** menu. You can't print the secondary copy of a report instead of the original report.

    > [!NOTE]
    > Typically, we recommend that you modify an existing report instead of creating a new custom report. A custom report has no report options. You must add any restrictions or sorts for the report in Report Writer. The restrictions can't be changed when you print the report. It's especially important for invoices and for checks.

### About the Report Definition window

In the Report Definition window, you can open several other windows that let you modify the relationships between the tables that provide information for your reports. These other windows also let you apply sorts or restrictions to your reports. These other windows also let you modify the layout of your reports.

### Report Table Relationships window

In the Report Definition window, select **Tables** to open the Report Table Relationships window. Consider the following information when you use the Report Table Relationships window:

- This window will show the tables that are already linked for this report. Tables with a **1 to Many** link are marked with an asterisk.

- The only tables that appear or that can be added in this window are tables in which relationships have already been defined.
- The following types of relationships can exist between tables:

  - A **1 to 1** relationship can exist between tables. For every record in the primary table, there's one matching record in the secondary table. For example, the relationship between the YTD Transaction Open table (the primary table) and the Account Master table (the secondary table) is a **1 to 1** relationship. The relationship between these tables is created by using the Account Number field. The account number for each record in the YTD Transaction Open table will match only one record in the Account Master table.
  - A **1 to Many** relationship can exist between tables. For every record in the primary table, there can be more than one matching record in the secondary table. For example, the relationship between the Transaction Work table and the Transaction Amounts Work table is a **1 to Many** relationship in Invoicing in Microsoft Dynamics GP. The Transaction Work table contains information about the whole document. The Transaction Amounts Work table contains all the items on each invoice. The relationship between them is a **1 to Many** relationship because one record in the Transaction Work table can have more than one record in the Transaction Amounts Work table if more than one item is on the invoice.
- To link an additional table, select the existing table, and then select **New**. The tables that can be linked to this table will be listed in the Related Tables window. If a **1 to Many** relationship already exists for this table, only the **1 to 1** relationships will be included in the list.
- You can only create five **1 to Many** relationships in a single report.
- If a new relationship is created between two tables, the new table must still be added to this list of tables.

### Sorting Definition window

In the Report Definition window, select **Sort** to open the Sorting Definition window. Consider the following information when you use the Sorting Definition window.

- If you're adding more than one sort to a report, the main sort should be listed first. To insert a sort underneath the main sort, select the main sort. The additional sort will be inserted under the existing sort. If the first sort isn't selected, the additional sort will be inserted above the existing sort.

- If you add more sorts, the additional sorts will override the original sort or sorts from the key of the main file. In the Sorting Definition window, you can add all the sorts that you need on the report. Make sure that you review the additional headers and footers in the layout to make sure that the fields on which they'll break are still valid.

### Report Restrictions window

In the Report Definition window, select **Restrictions** to open the Report Restrictions window. Consider the following information when you use the Report Restrictions window.

- A restriction limits the records that are included in a report. Excluded records won't be included in the report. It differs from suppressing a report section. If a section is suppressed in the layout, amounts that are associated with the suppressed records are included in subtotals and in totals even though these amounts don't appear in the report.

- You can't restrict a report by using a calculated field.

### Report Layout window

In the Report Definition window, select **Layout** to open the Report Layout window. Consider the following information when you use the Report Layout window.

- In the layout, there's a gray bar along the left side. The boxes in this bar mark the end of a report section. For example, a **B** in this bar marks the last line of the body of the report. To change the size of a section, use either of the following methods:
  - To make the section smaller, select the box, and then drag it up.
  - To make the section bigger, select the box, and then drag it down.
- To add a header or a footer, select the **Tools** menu in the layout, and then select **Section Options** to open the Report Section Options window. The Report Section Options window is used to specify the sections that will be in the report. For example, if you don't want to include a header on each page of the printed report, select to clear the **Page Header** check box. Consider the following guidelines when you work with headers and footers:

  - Headers and footers print information when a field changes. If you want a report to be grouped by customer class, the field that you select for the additional header should be a customer class. Whenever the class changes, the headers or the footers will print. You can only insert page breaks in fields that are in the sort key for the main table. You can also insert page breaks in any additional sorts that you've added. If the field in which you want to insert a page break isn't available in the Header/Footer Options window, you must add a sort to that field.
  - The H1 header is the first header. It's the most general type of header. The H2 header goes below the H1 header.
  - The F1 footer is the first footer. It should break on the same field as the H1 header. Footers print from the bottom of the report and work up. The F2 footer appears above the F1 footer in the layout.
  - In the Report Section Options window, additional headers and footers are listed in the same order in which they appear in the layout. The first header listed is the H1 header. The last footer listed is the F1 footer.
  - You may want to add a new header or a new footer below an existing header or an existing footer in the list. To do it, select the existing header or the existing footer, and then select **New**. To add a new header or a new footer above the existing header or the existing footer, select **New**.
- To add a subtotal, drag the field that you want to total into the footer. Double-click the field to open the Report Field Options window. In the **Display Type** list, select **Sum**. By default, when you drag a field into a footer, the **Display Type** field is set to **Last Occurrence**.
- If fields print too far down on the report, add space to the page footer and to the report footer. Footers start from the bottom of the report and work up. So if you add space to the bottom of a footer, that space will print at the bottom and force the rest of the footers up.
- If the report has a page footer and a report footer, when you change the size of one of these footers, you also have to change the size of the other footer. The footers should be the same size. It makes a difference when Report Writer determines when the report footer and the page footers should print.

For example, if the report footer is larger than the page footer, the report footer will signal that the document has to move to a second page and that the page footer should print at the bottom of the first page. However, if the page footer is smaller, there may be insufficient room for all the information on one page. However, the report footer will be printed.

### About graphic reports and text reports

To change a report from text mode to graphic mode, select to clear the **Text Report** check box in the Report Definitions window. When you change a report from text mode to graphic mode, the report is affected in the following ways:

- The right margin is released. The fields on the right side of the report must be moved back into position.
- Changing from text mode to graphic mode changes the default font of the report.
- Graphics, such as logos and signatures, can be added to the report. These graphics can't be larger that 32 kilobytes (KB).
- The user can change fonts in a field.

### Common error messages and how to troubleshoot them

- > Error in equation

    You may receive this error message if any calculated fields have been added or modified incorrectly. Look for missing operators (+, *), expressions that have no closing parentheses, or expressions that have the closing parentheses in the wrong position.

- > Inconsistent sort/expression

    Typically, you receive this error message after modifications have been made to a report, especially if additional files are linked or additional fields have been added to the report. The message usually includes a restriction that must be added. To resolve this problem, select **Tables** in the Report Definition window. Look for the table that is marked with an asterisk (*) and that is on the lowest level. The levels are defined by the number of dashes next to the table. Close this window, and then select **Restrictions** in the **Report Definition** window. Add a restriction that sets a field from this table to be equal to itself.
- > Type Mismatch

    You may receive this error message if either of the following conditions is true:
      - The result type for the calculated expression differs from the true and false case for the conditional expression or for the result of a calculated expression.
      - The true and false case for the calculated expression doesn't have the same result type. For example, the true case has a field that is stored as an integer, and the false case has a field that is stored as a currency.
- > Error accessing SQL data

    You may receive this error message when you print a report if the report has an incomplete restriction.

## How to add a page break in Report Writer

1. Start Report Writer. To do it, use the appropriate methods:
   - In Microsoft Dynamics GP 10.0 and higher, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**. In the **Product** list, select **Microsoft Dynamics GP**, and then select **OK**.
   - In Microsoft Dynamics GP 9.0, point to **Customize** on the **Tools** menu, and then select **Report Writer**. In the **Product** list, select **Microsoft Dynamics GP**, and then select **OK**.
2. Select **Reports**.

3. In the **Original Reports** list, select the report, and then select **Insert**.

4. In the **Modified Reports** list, select the report, and then select **Open**.

5. Select **Layout**.
6. On the **Tools** menu, select **Section Options**.
7. Select the additional footer that comes before the new page break.
8. Select **Open**.
9. Select the **Page Break** check box.
10. Select **OK**.
11. Close the report, and then select **Save** when you're prompted to save changes.
