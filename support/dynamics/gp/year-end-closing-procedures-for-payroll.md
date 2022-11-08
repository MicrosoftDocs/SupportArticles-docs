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
- An alternative checklist to use instead of the standard checklist if you must process 2022 pay runs before you complete the year-end closing procedures for 2021.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Introduction

Read this whole article before you perform any one of the steps. If you have any questions, contact Technical Support for Microsoft Dynamics and related products. Use this link to open a support incident if you need technical assistance:

[Microsoft Support for business](https://serviceshub.microsoft.com/supportforbusiness)

Detailed information about each step in the payroll year-end closing routine is included in the Payroll Web services. Before you follow the steps in this article, look for updated year-end information at the following Microsoft web sites:

- [Microsoft Dynamics GP U.S. Year-End Update 2021 RELEASED](https://community.dynamics.com/gp/b/dynamicsgp/posts/microsoft-dynamics-gp-u-s-year-end-update-2021-released)
- [U.S. Year-End Update for Microsoft Dynamics GP](/dynamics/s-e/gp/usgpye2018_396)
- [U.S. Payroll Tax Update for Microsoft Dynamics GP](/dynamics/s-e/gp/tugp2018_391)
- [Service Pack, Hotfix, and Compliance Update Patch Releases for Microsoft Dynamics GP](/dynamics/s-e/gp/MDGP2018_PatchReleases_377)

## More information

### Payroll year-end checklist

To perform the year-end closing procedures, follow these steps:

1. [Verify that you have installed the latest 2021 payroll tax update](#step-1-verify-that-you-have-installed-the-latest-2021-payroll-tax-update)
2. [Complete all pay runs for the current year](#step-2-complete-all-pay-runs-for-the-current-year)
3. [Complete all month-end, period-end, or quarter-end procedures for the current year](#step-3-optional-complete-all-monthly-and-quarterly-payroll-month-end-period-end-or-quarter-end-procedures-for-the-current-year)
4. [Make a backup of the original file](#step-4-make-a-backup-of-the-original-file)
5. [Install the 2021 Year-End Update](#step-5-install-the-2021-year-end-update)
6. [Create the Year-End file](#step-6-create-the-year-end-file)
7. [Make a backup of the new file](#step-7-make-a-backup-of-the-new-file)
8. [Verify W-2 and 1099-R statement information](#step-8-verify-w-2-and-1099-r-statement-information)
9. [Print the W-2 statements and the W-3 Transmittal form](#step-9-print-the-w-2-statements-and-the-w-3-transmittal-form)
10. [Print the 1099-R forms and the 1096 Transmittal form and ACA forms](#step-10-print-the-1099-r-forms-and-the-1096-transmittal-form-and-aca-forms)
11. [(Optional:) Create a W-2 Electronic file](#step-11-optional-create-a-w-2-electronic-file)
12. [(Optional:) Archive inactive employee Human Resources information](#step-12-optional-archive-inactive-employee-human-resources-information)
13. [Set up fiscal periods for 2022](#step-13-set-up-fiscal-periods-for-2022)
14. [(Optional:) Close fiscal periods for the payroll series for 2021](#step-14-optional-close-fiscal-periods-for-the-payroll-series-for-2021)
15. [Install the payroll tax update for 2022](#step-15-install-the-payroll-tax-update-for-2022)

### Alternative payroll year-end checklist

If you must process 2022 pay runs before you complete the 2021 year-end closing procedures, follow the steps in this alternative checklist:

1. [Verify that you have installed the latest 2021 payroll tax update](#step-1-verify-that-you-have-installed-the-latest-2021-payroll-tax-update)
2. [Complete all pay runs for the current year](#step-2-complete-all-pay-runs-for-the-current-year)
3. [(Optional:) Complete all month-end, period-end, or quarter-end procedures for the current year](#step-3-optional-complete-all-monthly-and-quarterly-payroll-month-end-period-end-or-quarter-end-procedures-for-the-current-year)
4. [Make a backup of the original file](#step-4-make-a-backup-of-the-original-file)
5. [Install the 2021 Year-End Update](#step-5-install-the-2021-year-end-update)
6. [Create the year-end file](#step-6-create-the-year-end-file)
7. [Make a backup of the new file](#step-7-make-a-backup-of-the-new-file)
8. [Verify W-2 and 1099-R statement information](#step-8-verify-w-2-and-1099-r-statement-information)
9. [(Optional:) Archive inactive employee Human Resources information](#step-12-optional-archive-inactive-employee-human-resources-information)
10. [Set up Fiscal Periods for 2022](#step-13-set-up-fiscal-periods-for-2022)
11. [(Optional:) Close fiscal periods for the payroll series for 2021](#step-14-optional-close-fiscal-periods-for-the-payroll-series-for-2021)
12. [Install the payroll tax update for 2022](#step-15-install-the-payroll-tax-update-for-2022)
13. Process the 2022 pay runs. The user date must occur in 2022
14. [Print the W-2 statements and the W-3 Transmittal form](#step-9-print-the-w-2-statements-and-the-w-3-transmittal-form)
15. [Print the 1099-R forms and the 1096 Transmittal form and ACA forms](#step-10-print-the-1099-r-forms-and-the-1096-transmittal-form-and-aca-forms)
16. [(Optional:) Create a W-2 Electronic file](#step-11-optional-create-a-w-2-electronic-file)

### Payroll module year-end details

#### Step 1: Verify that you have installed the latest 2021 payroll tax update

Download the latest tax table update and installation instructions for 2021 to ensure your FICA Wage Limit is correct. To access the **U.S. Payroll Tax Update** pages, select the **US Taxes** link for your version within the [Microsoft Dynamics GP Resource Directory](/dynamics-gp/resources) page or select the link below:

[U.S. Payroll Tax Update for Microsoft Dynamics GP](/dynamics/s-e/gp/tugp2018_391)

> [!NOTE]
> To check your tax table update date, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Payroll Tax**. The Last Tax Update should be 12/18/2020 (Round 1 for 2021) or later (if later tax updates were installed during the year).

#### Step 2: Complete all pay runs for the current year

#### Step 3: (Optional:) Complete all monthly and quarterly payroll month-end, period-end, or quarter-end procedures for the current year

For more information about period-end procedures for payroll for Microsoft Dynamics GP, use the [Printable guides](/previous-versions/dynamics-gp/appuser-itpro/jj673202(v=gp.30)) to obtain the printable manual for U.S. Payroll.

#### Step 4: Make a backup of the original file

Create a backup, and then put this backup into safe, permanent storage. By creating a backup, you make sure that you have a permanent record of the company's financial position at the end of the year. You can restore the backup to quickly recover data if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Maintenance** > **Backup**.

    > [!NOTE]
    > The **Back Up Company** window opens.
2. In the **Company Name** list, select your company name.
3. Change the path of the backup file if it's required, and then select **OK**.

    > [!NOTE]
    > We recommend that you name this backup **2021 Pre Year-End Update** to differentiate it from your other backups.

#### Step 5: Install the 2021 year-end update

To install the payroll year-end update, you must follow the steps in the Microsoft Dynamics GP U.S. 2021 Year-end document. The install must be performed on each computer that has Microsoft Dynamics GP installed. When the update is released, install the update and download the 2021 Year End document from the following location:

[U.S. Year-End Update for Microsoft Dynamics GP](/dynamics/s-e/gp/usgpye2018_396)

> [!NOTE]
> Review the [US21YE](/dynamics-gp/payroll/us-year-end) and [W-2 DataSource](/dynamics-gp/payroll/w-2-statement) documents for details of what is included in the Year End Update, checklists to follow, FAQ, year-end procedures, electronic W2s, reporting and more.
>
> There will not be a year-end update available for Microsoft Dynamics GP 2016 and prior versions.

#### Step 6: Create the year-end file

To create the year-end file, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamic GP** > **Tools** >> **Routines** > **Payroll** > **Year-End Closing**.
2. In the **Year** field, type *2021*, and then select **Process**.

> [!NOTE]
> When you process the 2021 Year End Wage file, make sure you have a 2021 tax update in place, so the correct FICA limit used. You can install the payroll tax update for 2022 any time *after* the year-end wage file for 2021 has been created, and before you process a new payrun for 2022.

#### Step 7: Make a backup of the new file

Create a backup, and then put this backup into safe, permanent storage. By creating a backup, you make sure that you have a permanent record of the company's financial position at the end of the year. You can restore the backup to quickly recover data if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Maintenance** > **Backup**.
2. In the **Company Name** list, select your company name.
3. Change the path of the backup file if it's required, and then select **OK**.

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
2. In the **Print W-2 Forms** window, specify the following settings:
   - **Print W-2s for**: Normal Year-End
   - **Print**: W-2 Forms
3. Select **Print**.

> [!NOTE]
> You can print employee W-2 statements as many times as you have to.

To print the W-3 Transmittal Form, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print W-2s**.
2. In the **Print W-2 Forms** window, specify the following settings:
   - **Print W-2s for**: Normal Year-End
   - **Print**: W-3 Transmittal Form
3. Select **Print**.

> [!NOTE]
> You can print the W-3 Transmittal Form as many times as you have to.

#### Step 10: Print the 1099-R forms and the 1096 Transmittal form and ACA forms

To print the 1099 forms, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print 1099-Rs**.
2. In the **Print 1099-R Forms** window, select **1099-R Forms**, and then select **Print**.

> [!NOTE]
> You can print employee1099-R forms as many times as you have to.

To print the 1096 Transmittal form, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print 1099-Rs**.
2. In the **Print 1099-R Forms** window, select **1096 Transmittal Form**, and then select **Print**.

> [!NOTE]
> You can print the 1096 Transmittal form as many times as you have to.

To print the 1095-C (ACA) forms, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print W-2s**.
2. In the **Print W-2 Forms** window, select **1095-C**, and then select **Print**.

To print the 1094-C Transmittal form, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **Print W-2s**.
2. In the **Print W-2 Forms** window, select **1094-C Transmittal**, and then select **Print**.

#### Step 11: (Optional:) Create a W-2 Electronic File

To create a W-2 Electronic File, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Payroll** > **W-2 Electronic File**.
2. In the **W-2 Electronic File** window, select the check box that is next to each company that you want to include in your W-2 Electronic File.
3. In the **User ID Number** field, enter the user ID number (formerly called a PIN).
4. Select **Submitter**. The **Electronic Filer Submitter Information** window opens. Enter the submission information.
5. Change the file destination information in the **File Name** field if it's required.
6. Select **Create File** or Save to store the information to create the file later.

#### Step 12: (Optional:) Archive inactive employee Human Resources information

To archive inactive employee Human Resources information, select **Microsoft Dynamics GP** > **Tools** > **Utilities** > **Human Resources** > **Archive Employee**.

#### Step 13: Set up fiscal periods for 2022

To set up fiscal periods for the next year, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **Fiscal Periods**.
2. In the **Year** field, type *2022*, and then select **Calculate**.

    > [!NOTE]
    > You may want to close all periods except period 1 to prevent users from posting to future periods. This is a "soft-close" and just prevents users from posting transactions to these dates or periods.

3. Select **OK**.

#### Step 14: (Optional:) Close fiscal periods for the payroll series for 2021

You can use the **Fiscal Periods Setup** window to lock down all fiscal periods that are still open for the year. By closing or locking down any fiscal periods, you prevent users from accidentally posting transactions to the wrong period or to the wrong year.

Before you close a fiscal period, verify that you've posted all transactions for the period and for the year for all modules. To later post a transaction to a fiscal period that you've closed, you must first reopen the period in the **Fiscal Periods Setup** window.

To lock down posting in a fiscal period, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **Fiscal Periods**.

2. Select the **Payroll** check box for each **Period** that you close.

#### Step 15: Install the payroll tax update for 2022

> [!NOTE]
> Do not install the payroll tax update for 2022 until the year-end file has been created for 2021.

To install the payroll tax update for the new year, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Maintenance** > **U.S. Payroll Updates** > **Check for Tax Updates**.
2. In the **Tax Update Method** window, select **Automatic**, and then select **Next**.
3. In the **Authorization Number** field, type your authorization number, and then select **Log in**.
4. Select **Finish**.

### FAQ

Q1: Can I install the U.S. Payroll Year-End Update PRIOR to finishing all my pay runs for the current year?

Yes, you can. The Year-End update is released early to give you plenty of time to install it. The important thing to remember is that you run the Year-End Wage file and finish all 2021 pay runs for the current year BEFORE you install any Tax Updates for the next year. When you process your first pay run for the new year, you want to make sure you have the newest tax tables and FICA limits for January 1, 2022 in place so you get the correct taxes calculated for the new year.

The key to remember is that you have THAT YEAR'S taxes in place when you perform any action for that year. (Have the 2021 taxes in place when you create the year-end wage file and perform all your 2021 pay runs, and have the 2022 taxes in place when you process the first pay run of the next year.)

Q2: Where can I get more information on the Affordable Care Act (ACA) functionality in Microsoft Dynamics GP?

1. Refer to our latest blog article about ACA: (Link will be updated at a later time)

   [Microsoft Dynamics GP Year-End Update 2016: Affordable Care Act (ACA)](https://community.dynamics.com/gp/b/dynamicsgp/posts/microsoft-dynamics-gp-year-end-update-2016-affordable-care-act-aca)

2. Visit the [Microsoft Dynamics GP Resource](/dynamics-gp/resources) page. Scroll to the **On This Page** section and open the *Module Information* link. Select ACA/Year End to open a document that included information about complying with ACA and other information about other year-end changes.

3. There were several blog articles written to cover the ACA changes and functionality. All the blog links are listed in [ACA blog links for Microsoft Dynamics GP](https://support.microsoft.com/topic/aca-blog-links-for-microsoft-dynamics-gp-619fbabb-6211-7d46-55a8-822aac413674).

Q3: Is there a year-end update for GP 2016 for this year?

Mainstream support for Dynamics GP 2016 ended on July 13, 2021, which means you'll no longer receive any tax or year-end updates for Dynamics GP 2016 or prior versions. select to review the [Lifecycle guidelines](https://community.dynamics.com/gp/b/dynamicsgp/posts/microsoft-dynamics-gp-2018-r2-and-year-end-update-lifecycle-and-upgrade-services) for all Dynamics GP products.  

Q4: Is there a year-end update for GP 2018 for this year?

Dynamics GP 2018 users will install the Year-end Update for Dynamics GP and be brought up to version 18 series.  Visit the links on the [Dynamics GP Resource Directory](/dynamics-gp/resources) for upgrade information and general guidance.
