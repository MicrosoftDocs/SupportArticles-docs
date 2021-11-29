---
title: Year-end closing procedures
description: Describes how to perform the year-end closing procedure for Microsoft Dynamics GP Payroll. This article also lists preparation steps and troubleshooting information for the year-end closing procedure.
ms.reviewer: theley
ms.date: 03/31/2021
---
# Year-end closing procedures for Microsoft Dynamics GP Payroll

This article provides steps to perform the year-end closing procedure and the related troubleshooting information for Microsoft Dynamics GP Payroll.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850663

## Summary

This document outlines the recommended year-end closing procedures for Microsoft Dynamics GP Payroll. The [More information](#more-information) section contains the following:

- A detailed checklist of the steps that you must follow to complete the year-end closing procedures.
- An alternative checklist to use instead of the standard checklist if you must process 2021 pay runs before you complete the year-end closing procedures for 2020.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Introduction

Read this whole article before you perform any one of the steps. If you have any questions, contact Technical Support for Microsoft Dynamics and related products. Use this link to open a support incident if you need technical assistance:

[Microsoft Support for business](https://serviceshub.microsoft.com/supportforbusiness)

Detailed information about each step in the payroll year-end closing routine is included in the Payroll Web services.

## More information

### Payroll year-end checklist

To perform the year-end closing procedures, follow these steps:

1. [Verify that you have installed the latest 2020 payroll tax update](#verify-that-you-have-installed-the-latest-2020-payroll-tax-update)
2. [Complete all pay runs for the current year](#complete-all-pay-runs-for-the-current-year)
3. [Complete all month-end, period-end, or quarter-end procedures for the current year](#optional-complete-all-monthly-and-quarterly-payroll-month-end-period-end-or-quarter-end-procedures-for-the-current-year)
4. [Make a backup of the original file](#make-a-backup-of-the-original-file)
5. [Install the 2020 Year-End Update](#install-the-2020-year-end-update)
6. [Create the Year-End file](#create-the-year-end-file)
7. [Make a backup of the new file](#make-a-backup-of-the-new-file)
8. [Verify W-2 and 1099-R statement information](#verify-w-2-and-1099-r-statement-information)
9. [Print the W-2 statements and the W-3 Transmittal form](#print-the-w-2-statements-and-the-w-3-transmittal-form)
10. [Print the 1099-R forms and the 1096 Transmittal form and ACA forms](#print-the-1099-r-forms-and-the-1096-transmittal-form-and-aca-forms)
11. [(Optional:) Create a W-2 Electronic file](#optional-create-a-w-2-electronic-file)
12. [(Optional:) Archive inactive employee Human Resources information](#optional-archive-inactive-employee-human-resources-information)
13. [Set up fiscal periods for 2021](#set-up-fiscal-periods-for-2021)
14. [(Optional:) Close fiscal periods for the payroll series for 2020](#optional-close-fiscal-periods-for-the-payroll-series-for-2020)
15. [Install the payroll tax update for 2021](#install-the-payroll-tax-update-for-2021)

### Alternative payroll year-end checklist

If you must process 2021 pay runs before you complete the 2020 year-end closing procedures, follow the steps in this alternative checklist:

1. [Verify that you have installed the latest 2020 payroll tax update](#verify-that-you-have-installed-the-latest-2020 payroll-tax-update)
2. [Complete all pay runs for the current year](#complete-all-pay-runs-for-the-current-year)
3. [(Optional:) Complete all month-end, period-end, or quarter-end procedures for the current year](#optional-complete-all-monthly-and-quarterly-payroll-month-end-period-end-or-quarter-end-procedures-for-the-current-year)
4. [Make a backup of the original file](#make-a-backup-of-the-original-file)
5. [Install the 2020 Year-End Update](#install-the-2020-year-end-update)
6. [Create the year-end file](#create-the-year-end-file)
7. [Make a backup of the new file](#make-a-backup-of-the-new-file)
8. [Verify W-2 and 1099-R statement information](#verify-w-2-and-1099-r-statement-information)
9. [(Optional:) Archive inactive employee Human Resources information](#optional-archive-inactive-employee-human-resources-information)
10. [Set up Fiscal Periods for 2021](#set-up-fiscal-periods-for-2021)
11. [(Optional:) Close fiscal periods for the payroll series for 2020](#optional-close-fiscal-periods-for-the-payroll-series-for-2020)
12. [Install the payroll tax update for 2021](#install-the-payroll-tax-update-for-2021)
13. Process the 2021 pay runs. The user date must occur in 2021
14. [Print the W-2 statements and the W-3 Transmittal form](#print-the-w-2-statements-and-the-w-3-transmittal-form)
15. [Print the 1099-R forms and the 1096 Transmittal form and ACA forms](#print-the-1099-r-forms-and-the-1096-transmittal-form-and-aca-forms)
16. [(Optional:) Create a W-2 Electronic file](#optional-create-a-w-2-electronic-file)

### Payroll module year-end details

#### Verify that you have installed the latest 2020 payroll tax update

Download the latest tax table update and installation instructions for 2020 to ensure your FICA Wage Limit is correct. 

> [!NOTE]
> To check your tax table update date, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and select **Payroll Tax**. The Last Tax Update should be 12/20/2019 (Round 1 for 2020) or later.

#### Complete all pay runs for the current year

##### (Optional:) Complete all monthly and quarterly payroll month-end, period-end, or quarter-end procedures for the current year

For more information about period-end procedures for payroll for Microsoft Dynamics GP 2013, use the [Printable guides](/previous-versions/dynamics-gp/appuser-itpro/jj673202(v=gp.30)) to obtain the printable manual for U.S. Payroll.

#### Make a backup of the original file

Create a backup, and then put this backup into safe, permanent storage. By creating a backup, you make sure that you have a permanent record of the company's financial position at the end of the year. You can restore the backup to quickly recover data if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the Microsoft Dynamics GP **menu**, and then select **Backup**.

    > [!NOTE]
    > The **Back Up Company** window opens.
2. In the **Company Name** list, select your company name.
3. Change the path of the backup file if it is required, and then select **OK**.

    > [!NOTE]
    > We recommend that you name this backup **2020 Pre Year-End Update** to differentiate it from your other backups.

#### Install the 2020 year-end update

To install the payroll year-end update, you must follow the steps in the Microsoft Dynamics GP U.S. 2020 Year-end document. The install must be performed on each computer that has Microsoft Dynamics GP installed.

> [!NOTE]
> Download the US20YE.pdf and W-2DataSourceGP.pdf documents in the links above for details of what is included in the Year End Update, checklists to follow, FAQ, year-end procedures, electronic W2s, reporting and more.
>
> There will not be a year-end update available for Microsoft Dynamics GP 2015 and prior versions.

#### Create the year-end file

To create the year-end file, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamic GP** menu, point to **Routines**, point to **Payroll**, and then select **Year-End Closing**.
2. In the **Year** field, type *2020*, and then select **Process**.

> [!NOTE]
> When you process the 2020 Year End Wage file, make sure you have a 2020 tax update in place, so the correct FICA limit used. You can install the payroll tax update for 2021 any time *after* the year-end wage file for 2020 has been created, and before you process a new payrun for 2021.

#### Make a backup of the new file

Create a backup, and then put this backup into safe, permanent storage. By creating a backup, you make sure that you have a permanent record of the company's financial position at the end of the year. You can restore the backup to quickly recover data if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Backup**.
2. In the **Company Name** list, select your company name.
3. Change the path of the backup file if it is required, and then select **OK**.

> [!NOTE]
> We recommend that you name this backup 2017 Post Year-End File to differentiate it from your other backups.

#### Verify W-2 and 1099-R statement information

To view the W-2 information in Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll**, and then select **Edit W-2s**.

To view the 1099-R information in Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll**, and then select **Edit 1099-Rs**.

> [!NOTE]
> If you change the W-2 or the 1099-R information, we recommend that you make another backup.

#### Print the W-2 statements and the W-3 Transmittal form

To print the W-2 statements, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll**, and then select **Print W-2s**.
2. In the **Print W-2 Forms** window, specify the following settings:
   - **Print W-2s for**: Normal Year-End
   - **Print**: W-2 Forms
3. Select **Print**.

> [!NOTE]
> You can print employee W-2 statements as many times as you have to.

To print the W-3 Transmittal Form, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll**, and then select **Print W-3s**.
2. In the **Print W-2 Forms** window, specify the following settings:
   - **Print W-2s for**: Normal Year-End
   - **Print**: W-3 Transmittal Form
3. Select **Print**.

> [!NOTE]
> You can print the W-3 Transmittal Form as many times as you have to.

#### Print the 1099-R forms and the 1096 Transmittal form and ACA forms

To print the 1099 forms, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll** and then select **Print 1099-Rs**.
2. In the **Print 1099-R Forms** window, select **1099-R Forms**, and then select **Print**.

> [!NOTE]
> You can print employee1099-R forms as many times as you have to.

To print the 1096 Transmittal form, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll**, and then select **Print 1099-Rs**.
2. In the **Print 1099-R Forms** window, select **1096 Transmittal Form**, and then select **Print**.

> [!NOTE]
> You can print the 1096 Transmittal form as many times as you have to.

To print the 1095-C (ACA) forms, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll**, and then select **Print W-2s.**  
2. In the Print W-2 Forms window, select **1095-C**, and then select **Print**.

To print the 1094-C Transmittal form, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll**, and then select **Print W-2s**.
2. In the Print W-2 Forms window, select **1094-C Transmittal**, and then select **Print**.

#### (Optional:) Create a W-2 Electronic File

To create a W-2 Electronic File, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll**, and then select **W-2 Electronic File**.
2. In the **W-2 Electronic File** window, select the check box that is next to each company that you want to include in your W-2 Electronic File.
3. In the **User ID Number** field, enter the user ID number (formerly called a PIN).
4. Select **Submitter**. The **Electronic Filer Submitter Information** window opens. Enter the submission information.
5. Change the file destination information in the **File Name** field if it is required.
6. Select **Create File** or Save to store the information to create the file later.

#### (Optional:) Archive inactive employee Human Resources information

To archive inactive employee Human Resources information in Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Human Resources**, and then select **Archive Employee**.

#### Set up fiscal periods for 2021

To set up fiscal periods for the next year, follow these steps:

1. In Microsoft Dynamics GP, point to **Setup** on the **Microsoft Dynamics GP** menu, point to **Company**, and then select **Fiscal Periods**.
2. In the **Year** field, type *2021*, and then select **Calculate**.

    > [!NOTE]
    > You may want to close all periods except period 1 to prevent users from posting to future periods.

3. Select **OK**.

#### (Optional:) Close fiscal periods for the payroll series for 2020

You can use the **Fiscal Periods Setup** window to close all fiscal periods that are still open for the year. By closing fiscal periods, you prevent users from accidentally posting transactions to the wrong period or to the wrong year.

Before you close a fiscal period, verify that you have posted all transactions for the period and for the year for all modules. To later post a transaction to a fiscal period that you have closed, you must first reopen the period in the **Fiscal Periods Setup** window.

To close a fiscal period, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.

2. Select the **Payroll** check box for each **Period** that you close.

#### Install the payroll tax update for 2021

> [!NOTE]
> Do not install the payroll tax update for 2021 until the year-end file has been created for 2020.

To install the payroll tax update for the new year, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the **Microsoft Dynamics GP** menu, point to **U.S. Payroll Updates**, and then select **Check for Tax Updates**.
2. In the **Tax Update Method** window, select **Automatic**, and then select **Next**.
3. In the **Authorization Number** field, type your authorization number, and then select **Log in**.
4. Select **Finish**.

### FAQ

Q1: Can I install the U.S. Payroll Year-End Update PRIOR to finishing all my payruns for the current year?

A1: Yes, you can! We release it early to give you plenty of time to install it. The important thing to remember is that you run the Year-End Wage file and finish all payruns for the current year BEFORE you install any *Tax Updates* for the next year. When you process your first payrun for the new year, you want to make sure you have the newest tax tables and FICA limits for Jan 1.

Q2: Where can I get more information on the Affordable Care Act (ACA) functionality in Microsoft Dynamics GP?

1. Refer to our latest blog article about ACA: (Link will be updated at a later time)

   [Microsoft Dynamics GP Year-End Update 2016: Affordable Care Act (ACA)](https://community.dynamics.com/gp/b/dynamicsgp/posts/microsoft-dynamics-gp-year-end-update-2016-affordable-care-act-aca)

2. Visit the Microsoft Dynamics GP Directory page. Scroll to the *On This Page* section and open the *Module Information* link. Select ACA/Year End to open a document that included information about complying with ACA and other information about other year-end changes.

3. There were several blog articles written to cover the ACA changes and functionality. All the blog links are listed in [ACA blog links for Microsoft Dynamics GP](https://support.microsoft.com/topic/aca-blog-links-for-microsoft-dynamics-gp-619fbabb-6211-7d46-55a8-822aac413674).
