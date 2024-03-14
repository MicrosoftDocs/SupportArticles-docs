---
title: Set up VAT Daybook reports
description: How to map columns in VAT Daybook using Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# Set up VAT Daybook reports in Microsoft Dynamics GP

This article will demonstrate how to map one tax detail to a particular column of choice in the VAT Daybook report. However, how you map the columns, to which column and what tax detail codes to map are your responsibility and out of scope for what a Microsoft engineer/documentation can advise on. You are responsible to map the columns according to the reporting rules required by your own taxing authority.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3139850

1. Access: Give the company access to use VAT Daybook, if you are using VAT Daybook reports for the first time as follows:

    1. Under **Microsoft Dynamics GP**, select **Tools**, point to **Setup**, point to **System** and select **Use VAT Daybook**.

    2. Mark the checkbox for the company you want to **Use VAT Daybook** with.

    3. Select a Report Template to use for your VAT report. This will be the default summary report template used for your VAT Return. Leave blank if you do not have any setup yet.

    4. Mark the **Multiple Countries** checkbox if you need to register for VAT in another EU country/region. This will allow you to print the summary reports for different countries/regions.  Refer to the VAT Daybook manual for more information.

    5. Select **OK**.

2. Report Setup: Set up report ID's and map column codes as follows:

    1. Select **Cards**, point to **Company** and select **VAT Daybook Reports**.
    2. Enter a **Report ID**, report description, and country/region code.
    3. Enter the column code for as many columns as you want on the report. You can have a maximum of 25 column codes each, for Sales and Purchase Tax Detail ID's.
    4. If you mark the **Default on Vat Viewer** checkbox, the Report ID you've selected will be the default ID in all transaction entry windows and VAT Daybook Report Options windows.
    5. If you mark the **Revision Allowed** option, you will access to resubmit the VAT Return.
    6. Select the Column Code link to open the VAT Daybook Column Codes window.
    7. Enter the column code such as *01* and give it a description that will appear as the heading in the VAT Detail report. You set up a maximum of 25 columns for each sales or purchase type.
    8. Mark the Tax Type as either Sales or Purchases.
    9. Next to Tax Detail ID, select the lookup and select the tax detail codes that you wish to pull into this column. You will select them one at a time.
    10. For each tax detail ID, enter a description, and select the Account Type:

        - Tax Amount is the total tax amount.
        - Net Amount is the total taxable amount.

    11. For the Document Type, select if you want to pull in for Invoices, Credits, or both Invoices & Credits.
    12. Add more Tax Detail ID's to pull into this column as needed.
    13. Save.

    > [!NOTE]
    > You cannot edit or modify these tax details once you have printed the summary report. To make any changes, you will have to copy the Report ID and make changes to the new report ID before using it.
    >
    > You are responsible to know which tax details to print in what column. Microsoft is unable to advise on this setup. If any questions, contact your local tax authority for any guidance.

3. Calendar: Go to **Cards**, point to **Company** and select **VAT Calendar**. Select the country/region code, year, Date to Use (choose Document Date, Posting date or Tax date), and define the first and last day of the year and number of periods and select **Calculate**. Once you print the Audit Trail report for the period, the Return Number column will display a Return number comprised of the period, year, and report ID to indicate that the report for this period has been printed.

4. Reports: To print the VAT Report:

    1. Select **Tools** under **Microsoft Dynamics GP**, point to **Routines**, point to **Company**, and select **VAT Daybook Reports**.
    2. Select an existing report option, or key in a name of your choice to create a new report option.
    3. If you marked a report as **Default on Vat Viewer** in the setup above, then that report ID will default in.
    4. Select the type of report you wish to print:

        - **Draft** - will print a draft of the detail in the TX30000 for the report setup that you defined, along with any exception reports.
        - **Draft+Draft Return** - will print a preview of what the Detail/Summary reports. It is recommended to print this option and review both the summary and detailed reports*.
        - **Audit Trail** - This is the *final* report to generate the VAT Return and will print the summary, detail and exception reports. This is the final report and will *commit* or mark off the transactions in the TX30000 table and generate a Return Number. There is no functionality in the front end to *un-do* this, so make sure you have printed and viewed the draft reports first before you run this final report.
        - **Audit Reprint** - Allows you to reprint the final Audit Report that was submitted.

    5. The Dates will look to the calendar you set up.
    6. Select Transactions of sales, purchases or both to be included. (The options of Draft+Draft Return or Audit Trail will default to Both.)
    7. Select **Print**.

You can also refer to the VAT Daybook manual for more information.
