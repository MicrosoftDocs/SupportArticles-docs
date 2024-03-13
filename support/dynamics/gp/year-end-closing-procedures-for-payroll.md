---
title: Year-end closing procedures
description: Describes how to perform the year-end closing procedure for Microsoft Dynamics GP Payroll. This article also lists preparation steps and troubleshooting information for the year-end closing procedure.
ms.reviewer: theley
ms.date: 03/13/2024
---
# Year-end closing procedures for Microsoft Dynamics GP Payroll

This article provides steps to perform the year-end closing procedures and the related troubleshooting information for Microsoft Dynamics GP Payroll.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850663  

## Summary

This document outlines the recommended year-end closing procedures for Microsoft Dynamics GP Payroll. The [More information](#more-information) section contains the following:

- A detailed checklist of the steps that you must follow to complete the year-end closing procedures.
- An alternative checklist to use instead of the standard checklist if you must process new pay runs for the new year before you complete the year-end closing procedures for the prior year.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Introduction

Detailed information about each step in the payroll year-end closing routine is included in the Payroll Manual. Before you follow the steps in this article, look for the following updated year-end information.

- [U.S. Year-End Update for Microsoft Dynamics GP](/dynamics/s-e/gp/usgpye2018_396)
- [U.S. Payroll Tax Update for Microsoft Dynamics GP](/dynamics/s-e/gp/tugp2018_391)
- [U.S. Payroll Year-end documentation](/dynamics-gp/payroll/us-year-end)

## More information

### Payroll year-end checklist

To perform the year-end closing procedures, follow these steps:

1. [Verify that you've installed the latest payroll tax update](#step-1-verify-that-you-have-installed-the-latest-payroll-tax-update).
1. [Complete all pay runs for the current year](#step-2-complete-all-pay-runs-for-the-current-year).
1. [Complete all month-end, period-end, or quarter-end procedures for the current year](#step-3-optional-complete-all-monthly-and-quarterly-payroll-month-end-period-end-or-quarter-end-procedures-for-the-current-year).
1. [Make a backup of the original file](#step-4-make-a-backup-of-the-original-file).
1. [Install the year-end update](#step-5-install-the-year-end-update).
1. [Create the year-end file](#step-6-create-the-year-end-file).
1. [Make a backup of the new file](#step-7-make-a-backup-of-the-new-file).
1. [Verify W-2 and 1099-R statement information](#step-8-verify-w-2-and-1099-r-statement-information).
1. [Print the W-2 statements and the W-3 Transmittal form](#step-9-print-the-w-2-statements-and-the-w-3-transmittal-form).
1. [Print the 1099-R forms and the 1096 Transmittal form and ACA forms](#step-10-print-the-1099-r-forms-the-1096-transmittal-form-and-the-aca-forms).
1. [(Optional) Create a W-2 Electronic file](#step-11-optional-create-a-w-2-electronic-file).
1. [(Optional) Archive inactive employee Human Resources information](#step-12-optional-archive-inactive-employee-human-resources-information).
1. [Set up fiscal periods](#step-13-set-up-fiscal-periods).
1. [(Optional) Close fiscal periods for the payroll series](#step-14-optional-close-fiscal-periods-for-the-payroll-series).
1. [Install the payroll tax update](#step-15-install-the-payroll-tax-update).

### Alternative payroll year-end checklist

If you must process payroll for the new year before you complete the year-end closing procedures for the prior year, follow the steps in this alternative checklist:

1. [Verify that you've installed the latest payroll tax update](#step-1-verify-that-you-have-installed-the-latest-payroll-tax-update).
1. [Complete all pay runs for the current year](#step-2-complete-all-pay-runs-for-the-current-year).
1. [(Optional) Complete all month-end, period-end, or quarter-end procedures for the current year](#step-3-optional-complete-all-monthly-and-quarterly-payroll-month-end-period-end-or-quarter-end-procedures-for-the-current-year).
1. [Make a backup of the original file](#step-4-make-a-backup-of-the-original-file).
1. [Install the year-end update](#step-5-install-the-year-end-update).
1. [Create the year-end file](#step-6-create-the-year-end-file).
1. [Make a backup of the new file](#step-7-make-a-backup-of-the-new-file).
1. [Verify W-2 and 1099-R statement information](#step-8-verify-w-2-and-1099-r-statement-information).
1. [(Optional) Archive inactive employee Human Resources information](#step-12-optional-archive-inactive-employee-human-resources-information).
1. [Set up Fiscal Periods](#step-13-set-up-fiscal-periods).
1. [(Optional) Close fiscal periods for the payroll series](#step-14-optional-close-fiscal-periods-for-the-payroll-series).
1. [Install the payroll tax update](#step-15-install-the-payroll-tax-update).
1. Process the new year payroll.

### Payroll module year-end details

#### Step 1: Verify that you have installed the latest payroll tax update

Download the latest tax table update and installation instructions to ensure your FICA Wage Limit is correct. To access the **U.S. Payroll Tax Update** pages, select the **US Taxes** link for your version within the [Microsoft Dynamics GP Resource Directory](/dynamics-gp/resources) page or select the following link:

[U.S. Payroll Tax Update for Microsoft Dynamics GP](/dynamics/s-e/gp/tugp2018_391)

#### Step 2: Complete all pay runs for the current year

#### Step 3: (Optional) Complete all monthly and quarterly payroll month-end, period-end, or quarter-end procedures for the current year

For more information about period-end procedures for payroll for Microsoft Dynamics GP, use the [Printable guides](/dynamics-gp/payroll/payrollus) to obtain the printable manual for U.S. Payroll.

#### Step 4: Make a backup of the original file

Create a backup, and then put this backup into safe, permanent storage. By creating a backup, you make sure that you have a permanent record of the company's financial position at the end of the year. You can restore the backup to quickly recover data if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Maintenance** > **Backup**.

   > [!NOTE]
   > The **Back Up Company** window opens.

1. In the **Company Name** list, select your company name.
1. Change the path of the backup file if it's required, and then select **OK**.

> [!NOTE]
> We recommend that you name this backup **Pre Year-End Update** to differentiate it from your other backups.

#### Step 5: Install the year-end update

To install the payroll year-end update, you must follow the steps in the [Microsoft Dynamics GP U.S. Year-end document](/dynamics-gp/payroll/us-year-end). The installation must be performed on each computer that has Microsoft Dynamics GP installed. When the update is released, install the update and download the [U.S. Year-End Update for Microsoft Dynamics GP](/dynamics/s-e/gp/usgpye2018_396).

> [!NOTE]
> Review the [USYE](/dynamics-gp/payroll/us-year-end) and [W-2 DataSource](/dynamics-gp/payroll/w-2-statement) documents for details on what is included in the Year-End Update, checklists to follow, FAQs, year-end procedures, electronic W2s, and reporting.

#### Step 6: Create the year-end file

To create the year-end file in Microsoft Dynamics GP, select **Microsoft Dynamic GP** > **Tools** > **Routines** > **Payroll** > **Year-End Closing**.

#### Step 7: Make a backup of the new file

Create a backup, and then put this backup into safe, permanent storage. By creating a backup, you make sure that you have a permanent record of the company's financial position at the end of the year. You can restore the backup to quickly recover data if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Maintenance** > **Backup**.
1. In the **Company Name** list, select your company name.
1. Change the path of the backup file if it's required, and then select **OK**.

> [!NOTE]
> We recommend that you name this backup **Post Year-End File** to differentiate it from your other backups.

#### Step 8: Verify W-2 and 1099-R statement information

To view the W-2 information in Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Edit W-2s**.

To view the 1099-R information in Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools Routines** > **Payroll** > **Edit 1099-Rs**.

> [!NOTE]
> If you change the W-2 or the 1099-R information, we recommend that you make another backup.

#### Step 9: Print the W-2 statements and the W-3 Transmittal form

To print the W-2 statements, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print W-2s**.
1. In the **Print W-2 Forms** window, specify the following settings:
   - **Print W-2s for**: Normal Year-End
   - **Print**: W-2 Forms
1. Select **Print**.

To print the W-3 Transmittal Form, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print W-2s**.
1. In the **Print W-2 Forms** window, specify the following settings:
   - **Print W-2s for**: Normal Year-End
   - **Print**: W-3 Transmittal Form
1. Select **Print**.

#### Step 10: Print the 1099-R forms, the 1096 Transmittal form, and the ACA forms

To print the 1099-R forms, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print 1099-Rs**.
1. In the **Print 1099-R Forms** window, select **1099-R Forms**, and then select **Print**.

   > [!NOTE]
   > You can print employee1099-R forms as many times as you have to.

To print the 1096 Transmittal form, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print 1099-Rs**.
1. In the **Print 1099-R Forms** window, select **1096 Transmittal Form**, and then select **Print**.

To print the 1095-C (ACA) forms, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print W-2s**.
1. In the **Print W-2 Forms** window, select **1095-C**, and then select **Print**.

To print the 1094-C Transmittal form, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print W-2s**.
1. In the **Print W-2 Forms** window, select **1094-C Transmittal**, and then select **Print**.

#### Step 11: (Optional) Create a W-2 Electronic File

To create a W-2 Electronic File, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **W-2 Electronic File**.
1. In the **W-2 Electronic File** window, select the check box that is next to each company that you want to include in your W-2 Electronic File.
1. In the **User ID Number** field, enter the user ID number (formerly called a PIN).
1. Select **Submitter**. The **Electronic Filer Submitter Information** window opens. Enter the submission information.
1. Change the file destination information in the **File Name** field if it's required.
1. Select **Create File** or **Save** to store the information to create the file later.

#### Step 12: (Optional) Archive inactive employee Human Resources information

To archive inactive employee Human Resources information, select **Microsoft Dynamics GP** > **Tools** > **Utilities** > **Human Resources** > **Archive Employee**.

#### Step 13: Set up fiscal periods

To set up fiscal periods for the next year in Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **Fiscal Periods**.

> [!NOTE]
> You may want to close all periods except period 1 to prevent users from posting to future periods. This is a "soft-close" and just prevents users from posting transactions to these dates or periods.

#### Step 14: (Optional) Close fiscal periods for the payroll series

You can use the **Fiscal Periods Setup** window to lock down all fiscal periods that are still open for the year. By closing or locking down any fiscal periods, you prevent users from accidentally posting transactions to the wrong period or to the wrong year.

Before you close a fiscal period, verify that you've posted all transactions for the period and for the year for all modules. To later post a transaction to a fiscal period that you've closed, you must first reopen the period in the **Fiscal Periods Setup** window.

To lock down posting in a fiscal period, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **Fiscal Periods**.

1. Select the **Payroll** check box for each **Period** that you close.

#### Step 15: Install the payroll tax update

To install the payroll tax update for the new year, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Maintenance** > **U.S. Payroll Updates** > **Check for Tax Updates**.
1. In the **Tax Update Method** window, select **Automatic**, and then select **Next**.
1. In the **Authorization Number** field, type your authorization number, and then select **Log in**.
1. Select **Finish**.
