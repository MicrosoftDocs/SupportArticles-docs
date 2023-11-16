---
title: Year-end closing procedures
description: Describes how to perform the year-end closing procedure for Microsoft Dynamics GP Payroll. This article also lists preparation steps and troubleshooting information for the year-end closing procedure.
ms.reviewer: theley
ms.date: 12/20/2022
---

# Year-end closing procedures for Microsoft Dynamics GP Payroll

This article provides steps to perform the year-end closing procedure and the related troubleshooting information for Microsoft Dynamics GP Payroll.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850663  

## Summary

This document outlines the recommended year-end closing procedures for Microsoft Dynamics GP Payroll. The [More information](#more-information) section contains the following:

- A detailed checklist of the steps that you must follow to complete the year-end closing procedures.
- An alternative checklist to use instead of the standard checklist if you must process 2023 pay runs before you complete the year-end closing procedures for 2022.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Introduction

Read this whole article before you do any one of the steps. If you have any questions, contact Technical Support for Microsoft Dynamics and related products. If you need technical assistance, use the following link to open a support incident:

[Microsoft Support for business](https://serviceshub.microsoft.com/supportforbusiness)

Detailed information about each step in the payroll year-end closing routine is included in the Payroll Web services. Before you follow the steps in this article, look for updated year-end information at the following Microsoft websites:

- [Microsoft Dynamics GP U.S. Year-End Update 2022 RELEASED](/dynamics/s-e/gp/usgpye2018_396#2022-year-end-changes---released)
- [U.S. Year-End Update for Microsoft Dynamics GP](/dynamics/s-e/gp/usgpye2018_396)
- [U.S. Payroll Tax Update for Microsoft Dynamics GP](/dynamics/s-e/gp/tugp2018_391)
- [Service Pack, Hotfix, and Compliance Update Patch Releases for Microsoft Dynamics GP](/dynamics/s-e/gp/MDGP2018_PatchReleases_377)

## More information

### Payroll year-end checklist

To perform the year-end closing procedures, follow these steps:

1. [Verify that you've installed the latest 2022 payroll tax update](#step-1-verify-that-you-have-installed-the-latest-2022-payroll-tax-update).
1. [Complete all pay runs for the current year](#step-2-complete-all-pay-runs-for-the-current-year).
1. [Complete all month-end, period-end, or quarter-end procedures for the current year](#step-3-optional-complete-all-monthly-and-quarterly-payroll-month-end-period-end-or-quarter-end-procedures-for-the-current-year).
1. [Make a backup of the original file](#step-4-make-a-backup-of-the-original-file).
1. [Install the 2022 Year-End Update](#step-5-install-the-2022-year-end-update).
1. [Create the Year-End file](#step-6-create-the-year-end-file).
1. [Make a backup of the new file](#step-7-make-a-backup-of-the-new-file).
1. [Verify W-2 and 1099-R statement information](#step-8-verify-w-2-and-1099-r-statement-information).
1. [Print the W-2 statements and the W-3 Transmittal form](#step-9-print-the-w-2-statements-and-the-w-3-transmittal-form).
1. [Print the 1099-R forms and the 1096 Transmittal form and ACA forms](#step-10-print-the-1099-r-forms-and-the-1096-transmittal-form-and-aca-forms).
1. [(Optional) Create a W-2 Electronic file](#step-11-optional-create-a-w-2-electronic-file).
1. [(Optional) Archive inactive employee Human Resources information](#step-12-optional-archive-inactive-employee-human-resources-information).
1. [Set up fiscal periods for 2023](#step-13-set-up-fiscal-periods-for-2023).
1. [(Optional) Close fiscal periods for the payroll series for 2022](#step-14-optional-close-fiscal-periods-for-the-payroll-series-for-2022).
1. [Install the payroll tax update for 2023](#step-15-install-the-payroll-tax-update-for-2023).

### Alternative payroll year-end checklist

If you must process 2023 pay runs before you complete the 2022 year-end closing procedures, follow the steps in this alternative checklist:

1. [Verify that you've installed the latest 2022 payroll tax update](#step-1-verify-that-you-have-installed-the-latest-2022-payroll-tax-update).
1. [Complete all pay runs for the current year](#step-2-complete-all-pay-runs-for-the-current-year).
1. [(Optional) Complete all month-end, period-end, or quarter-end procedures for the current year](#step-3-optional-complete-all-monthly-and-quarterly-payroll-month-end-period-end-or-quarter-end-procedures-for-the-current-year).
1. [Make a backup of the original file](#step-4-make-a-backup-of-the-original-file).
1. [Install the 2022 Year-End Update](#step-5-install-the-2022-year-end-update).
1. [Create the year-end file](#step-6-create-the-year-end-file).
1. [Make a backup of the new file](#step-7-make-a-backup-of-the-new-file).
1. [Verify W-2 and 1099-R statement information](#step-8-verify-w-2-and-1099-r-statement-information).
1. [(Optional) Archive inactive employee Human Resources information](#step-12-optional-archive-inactive-employee-human-resources-information).
1. [Set up Fiscal Periods for 2023](#step-13-set-up-fiscal-periods-for-2023).
1. [(Optional) Close fiscal periods for the payroll series for 2022](#step-14-optional-close-fiscal-periods-for-the-payroll-series-for-2022).
1. [Install the payroll tax update for 2023](#step-15-install-the-payroll-tax-update-for-2023).
1. Process the 2023 pay runs.

   > [!IMPORTANT]
   > The user date must be in 2023.
1. [Print the W-2 statements and the W-3 Transmittal form](#step-9-print-the-w-2-statements-and-the-w-3-transmittal-form).
1. [Print the 1099-R forms and the 1096 Transmittal form and ACA forms](#step-10-print-the-1099-r-forms-and-the-1096-transmittal-form-and-aca-forms).
1. [(Optional) Create a W-2 Electronic file](#step-11-optional-create-a-w-2-electronic-file).

### Payroll module year-end details

#### Step 1: Verify that you have installed the latest 2022 payroll tax update

Download the latest tax table update and installation instructions for 2022 to ensure your FICA Wage Limit is correct. To access the **U.S. Payroll Tax Update** pages, select the **US Taxes** link for your version within the [Microsoft Dynamics GP Resource Directory](/dynamics-gp/resources) page or select the following link:

[U.S. Payroll Tax Update for Microsoft Dynamics GP](/dynamics/s-e/gp/tugp2018_391)

> [!NOTE]
> To check your tax table update date, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Payroll Tax**. The Last Tax Update should be at least December 16, 2021 (Round 1 for 2022) or later (if later tax updates were installed during the year).

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
   > We recommend that you name this backup **2022 Pre Year-End Update** to differentiate it from your other backups.

#### Step 5: Install the 2022 year-end update

To install the payroll year-end update, you must follow the steps in the Microsoft Dynamics GP U.S. 2022 Year-end document. The installation must be performed on each computer that has Microsoft Dynamics GP installed. When the update is released, install the update and download the 2022 Year End document from [U.S. Year-End Update for Microsoft Dynamics GP](/dynamics/s-e/gp/usgpye2018_396).

> [!NOTE]
> Review the [US22YE](/dynamics-gp/payroll/us-year-end) and [W-2 DataSource](/dynamics-gp/payroll/w-2-statement) documents for details of what is included in the Year End Update, checklists to follow, FAQ, year-end procedures, electronic W2s, and reporting.
>
> There will not be a year-end update available for Microsoft Dynamics GP 2016 and previous versions.

#### Step 6: Create the year-end file

To create the year-end file, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamic GP** > **Tools** > **Routines** > **Payroll** > **Year-End Closing**.
1. In the **Year** field, type _2022_, and then select **Process**.

> [!NOTE]
> When you process the 2022 Year End Wage file, ensure you have a 2022 tax update in place, so the correct FICA limit is used. You can install the payroll tax update for 2023 any time _after_ the year-end wage file for 2022 has been created, and before you process a new payrun for 2023.

#### Step 7: Make a backup of the new file

Create a backup, and then put this backup into safe, permanent storage. By creating a backup, you make sure that you have a permanent record of the company's financial position at the end of the year. You can restore the backup to quickly recover data if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Maintenance** > **Backup**.
1. In the **Company Name** list, select your company name.
1. Change the path of the backup file if it's required, and then select **OK**.

> [!NOTE]
> We recommend that you name this backup 2021 Post Year-End File to differentiate it from your other backups.

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

    > [!NOTE]
    > You can print employee W-2 statements as many times as you have to.

To print the W-3 Transmittal Form, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print W-2s**.
1. In the **Print W-2 Forms** window, specify the following settings:
   - **Print W-2s for**: Normal Year-End
   - **Print**: W-3 Transmittal Form
1. Select **Print**.

    > [!NOTE]
    > You can print the W-3 Transmittal Form as many times as you have to.

#### Step 10: Print the 1099-R forms and the 1096 Transmittal form and ACA forms

To print the 1099 forms, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print 1099-Rs**.
1. In the **Print 1099-R Forms** window, select **1099-R Forms**, and then select **Print**.

    > [!NOTE]
    > You can print employee1099-R forms as many times as you have to.

To print the 1096 Transmittal form, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print 1099-Rs**.
1. In the **Print 1099-R Forms** window, select **1096 Transmittal Form**, and then select **Print**.

    > [!NOTE]
    > You can print the 1096 Transmittal form as many times as you have to.

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

#### Step 13: Set up fiscal periods for 2023

To set up fiscal periods for the next year, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **Fiscal Periods**.
1. In the **Year** field, type _2023_, and then select **Calculate**.

    > [!NOTE]
    > You may want to close all periods except period 1 to prevent users from posting to future periods. This is a "soft-close" and just prevents users from posting transactions to these dates or periods.

1. Select **OK**.

#### Step 14: (Optional) Close fiscal periods for the payroll series for 2022

You can use the **Fiscal Periods Setup** window to lock down all fiscal periods that are still open for the year. By closing or locking down any fiscal periods, you prevent users from accidentally posting transactions to the wrong period or to the wrong year.

Before you close a fiscal period, verify that you've posted all transactions for the period and for the year for all modules. To later post a transaction to a fiscal period that you've closed, you must first reopen the period in the **Fiscal Periods Setup** window.

To lock down posting in a fiscal period, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **Fiscal Periods**.

1. Select the **Payroll** check box for each **Period** that you close.

#### Step 15: Install the payroll tax update for 2023

> [!IMPORTANT]
> Do not install the payroll tax update for 2023 until the year-end file has been created for 2022.

To install the payroll tax update for the new year, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Maintenance** > **U.S. Payroll Updates** > **Check for Tax Updates**.
1. In the **Tax Update Method** window, select **Automatic**, and then select **Next**.
1. In the **Authorization Number** field, type your authorization number, and then select **Log in**.
1. Select **Finish**.

### FAQ

**Q1: Can I install the U.S. Payroll Year-End Update PRIOR to finishing all my pay runs for the current year?**

Yes, you can. The Year-End update is released early to give you plenty of time to install it. The important thing to remember is that you run the Year-End Wage file and finish all 2022 pay runs for the current year BEFORE you install any Tax Updates for the next year. When you process your first pay run for the new year, you want to make sure you have the newest tax tables and FICA limits for January 1, 2023 in place so you get the correct taxes calculated for the new year.

The key to remember is that you have THAT YEAR'S taxes in place when you take any action for that year. (Have the 2022 taxes in place when you create the year-end wage file and make all your 2022 pay runs, and have the 2023 taxes in place when you process the first pay run of the next year.)

**Q2: Where can I get more information on the Affordable Care Act (ACA) functionality in Microsoft Dynamics GP?**

- Refer to our latest blog article about ACA:

   [Microsoft Dynamics GP Year-End Update 2022: Affordable Care Act (ACA)](https://community.dynamics.com/blogs/post/?postid=fc90c41e-2721-4bd4-ab84-4e013c1858ee)

- In the Detailed Module Information section of the [Microsoft Dynamics GP Resource](/dynamics-gp/resources) page, select [Affordable Care Act/Year End](https://mbs2.microsoft.com/fileexchange/?fileID=b6386ed9-7351-46b2-8682-6e74ca756d1c) to see the information about complying with ACA and other information about other year-end changes.

- There were several blog articles written to cover the ACA changes and functionality. All the blog links are listed in [ACA blog links for Microsoft Dynamics GP](aca-blog-links-dynamics-gp.md).

**Q3: Is there a year-end update for GP 2016 for this year?**

Mainstream support for Microsoft Dynamics GP 2016 ended on July 13, 2021. This means that you'll no longer receive any tax or year-end updates for Microsoft Dynamics GP 2016 or previous versions. See [Lifecycle guidelines](https://community.dynamics.com/blogs/post/?postid=dbd4de4c-deba-4f47-b3f3-5d9cef50ea0a) for all Microsoft Dynamics GP products.

**Q4: Is there a year-end update for GP 2018 for this year?**

Microsoft Dynamics GP 2018 users will install the Year-end Update for Dynamics GP and be brought up to the version 18 series. See [Microsoft Dynamics GP Resource Directory](/dynamics-gp/resources) for upgrade information and general guidance.

