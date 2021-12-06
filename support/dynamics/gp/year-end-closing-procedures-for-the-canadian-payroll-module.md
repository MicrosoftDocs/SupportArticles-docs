---
title: Year-end closing procedures for the Canadian Payroll module
description: Describes how to perform the year-end closing routine for Canadian Payroll in Microsoft Dynamics GP. This article also lists preparation steps and troubleshooting information for the year-end closing routine.
ms.reviewer: theley
ms.date: 03/31/2021
---
# Year-end closing procedures for the Canadian Payroll module in Microsoft Dynamics GP

This article introduces the year-end closing routine for Canadian Payroll in Microsoft Dynamics GP. And this article also provides troubleshooting information for the year-end closing routine.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861806

## 2020 payroll year-end update and 2021 payroll tax update

This article discusses the payroll year-end update and the payroll tax update. When the payroll year-end update for the year 2020 and the payroll tax update for the year 2021 are released, you may download the file from Customersource. (See the links that are listed in the [Install the 2020 Canadian year-end update](#install-the-2020-canadian-year-end-update) section.) Until the payroll year-end update and the payroll tax update are released, use this article for information and for preparation purposes only.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Summary

This document outlines the recommended year-end closing procedures for the Microsoft Dynamics GP integrated Canadian Payroll module. The [More information](#more-information) section contains the following:

- A detailed checklist of the steps that you must follow to complete the year-end closing procedures
- Detailed information for each step in the checklist

## Introduction

Read this whole article before you perform any one of the steps. If you have any questions, contact Microsoft Dynamics Technical Support. More information about the Canadian Payroll module is typically included in the year-end update documentation.

## More information

### Payroll year-end checklist

1. [Complete all the pay runs for the current year](#complete-all-the-pay-runs-for-the-current-year)
2. [Complete any necessary 2020 payroll reports](#complete-any-necessary-2020 payroll-reports)
3. [Make a backup of the data](#make-a-backup-of-the-data)
4. [Install the 2020 Canadian year-end update](#install-the-2020 canadian-year-end-update)
5. [Complete the Year End File Reset process](#complete-the-year-end-file-reset-process)
6. [Make another backup of the data](#make-another-backup-of-the-data)
7. [Create the T4, T4A, and RL-1 statements, and print the T4, T4A, and RL1 reports](#create-the-t4-t4a-and-rl-1-statements-and-print-the-t4-t4a-and-rl-1-reports)
8. [Edit the T4, T4A, and RL-1 records as necessary](#edit-the-t4-t4a-and-rl-1-records-as-necessary)
9. [Create T4, T4A, and RL-1 Summary records](#create-t4-t4a-and-rl-1-summary-records)
10. [Print the T4, T4A, RL-1 reports and create T4, T4A and RL-1 XML files, if appropriate](#print-the-t4-t4a-rl-1-reports-and-create-t4-t4a-and-rl-1-xml-files-if-appropriate)
11. [Verify that pay periods for 2021 are set correctly](#verify-that-the-pay-periods-are-set-correctly-for-2021)

### Payroll year-end details

> [!NOTE]
> There will not be a 2020 Year-End Update available for Microsoft Dynamics GP 2015 and prior versions.  

#### Complete all the pay runs for the current year

> [!NOTE]
> Any batch that has a value of **2021** in the **Cheque Date** field should be processed after you perform the year-end reset. If the cheque date of your final pay period for 2020 is in the year 2021, the 2021 tax tables must be used per the statement in the Canada Customs and Revenue Agency document T4001.

For example, a weekly payroll at the end of December that has a cutoff date of January 1, 2021, is processed by using the 2021 tax calculations. This payroll will be included in the 2021 history.

#### Complete any necessary 2020 payroll reports

#### Make a backup of the data

Create a backup, and then put this backup into safe, permanent storage. By creating a backup, you make sure that you have a permanent record of the company's financial position at the end of the year. You can restore the backup to quickly recover data if a power fluctuation or other problem occurs during the year-end closing procedure. To create a backup from Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, select **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Backup**.
2. In the **Company Name** list, select the company name.
3. Change the path of the backup file if this action is required, and then select **OK**.

> [!NOTE]
> We recommend that you name this backup 2020 Pre Year-End Tax Update to differentiate it from your other backups.

#### Install the 2020 Canadian year-end update

Install the update from one of the following locations.

#### Complete the Year End File Reset process

To perform a year-end file reset, follow these steps:

1. Have all users close all Canadian Payroll windows. Users can continue to work in other Microsoft Dynamics GP modules.
2. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Routines**, point to **Payroll - Canada**, and then select **Year End File Reset**.
3. In the Payroll Reset Files window, select **Copy Files to History**. This step creates the required data to view inquiries from the previous year in Canadian Payroll. To access the inquiries from the previous year in Canadian Payroll, point to **Payroll Canada** on the **Inquiry** menu, and then select **Employee Last Year Information**.

    > [!NOTE]
    > In this step, you receive a message that warns you to check available disk space. You must have at least two times as much available disk space as the amount that is currently occupied by all the files that are in the Data/Project directory.

4. Select **Tax Credit Indexation Factors**.
5. In the **Tax Credit Indexation Factors** window, verify the basic personal factor (Cost of Living Factor) from the Canada Customs and Revenue Agency document T4127. Verify the numbers, and then select **OK**.

    > [!NOTE]
    >
    > - When the employee masters are reset, the TD1 Basic Personal amounts will be adjusted by the multiplier that you enter.
    > - These TD1 Basic Personal amounts should be automatically updated after you install the Canadian Payroll Year-End Update file.

6. Select **Reset Employee Master**.

    > [!NOTE]
    > You must run this process before you process any pay runs for the new year.
7. Select **Yes** or **No** when you are prompted to reset the **Employee User Numeric** fields, depending on your preference.
8. On the **Cards** menu, point to **Payroll-Canada**, and then select **Employee** to view the **Employee User Numeric** fields.
9. In the **Employee ID** field, type an employee ID, select **Miscellaneous**, and then select **User Data**.

> [!NOTE]
> If any errors during the Year-End Reset process, be sure to restore to a backup!

#### Make another backup of the data

Create a backup, and then put this backup into safe, permanent storage. By creating a backup, you make sure that you have a permanent record of the company's financial position at the end of the year. You can restore the backup to quickly recover data if a power fluctuation or other problem occurs during the year-end closing procedure. To create a backup, follow these steps:

1. In Microsoft Dynamics GP, select **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Backup**.
2. In the **Company Name** list, select your company name.
3. Change the path of the backup file if this action is required, and then select **OK**.

> [!NOTE]
> We recommend that you name this backup 2020 Post Year-End Tax Update to differentiate it from your other backups.

#### Create the T4, T4A, and RL-1 statements, and print the T4, T4A, and RL-1 reports

> [!NOTE]
> This step can be performed any time after you complete the previous step, **Perform a year-end file reset**. For example, you may complete pay runs for the new year before you create and print any reports.

#### Create and print the T4 reports and the RL-1 reports

To do this, follow these steps:

1. In Microsoft Dynamics GP, point to Tools on the Microsoft Dynamics GP menu, point to **Routines**, point to **Payroll - Canada**, and then select **T4 and R1 Creation**.
2. Select **Create T4's**.
3. Select **Create R1's**.
4. To print the T4 Verification Report, select **Print T4 Report**.
5. To print the R1 Verification Report, select **Print R1 Report**.
6. Select **OK** to exit.
7. Print the T4 Edit List. To do this, point to **Payroll-Canada** on the **Reports** menu, select **Routines**, select **Routines Reports**, and then select **T4 Edit Report**.

#### Create and print the T4A reports

To do this, follow these steps

1. In Microsoft Dynamics GP, point to Tools on the Microsoft Dynamics GP menu, point to **Routines**, point to **Payroll - Canada**, point to **T4A Routines**, and then select **T4A Setup**.
2. Select **Create T4A's**.
3. Select **Print T4A Report** to print the T4A Verification Report.

#### Edit the T4, T4A, and RL-1 records as necessary

##### Modify the T4 statements

To do this, in Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Payroll - Canada**, and then select **T4 Edit**.

##### Modify the T4A statements

To do this, in Microsoft Dynamics GP, point to Tools on the Microsoft Dynamics GP menu, point to **Routines**, point to **Payroll - Canada**, point to **T4A Routines**, and then select **T4A Record Edit**.

##### Modify the R1 amounts based on the edit list in the R1 Edit window

To do this, in Microsoft Dynamics GP, point to Tools on the Microsoft Dynamics GP menu, point to **Routines**, point to **Payroll - Canada**, and then select **R1 Edit**.

#### Create T4, T4A, and RL-1 Summary records

#### Create the summary information for the T4 reports and for the RL-1 reports

To do this, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP**  menu, point to **Routines**, point to **Payroll - Canada**, and then select **T4 and R1 Summary**.
2. Select **Create T4 Summary Records**.
3. Select **Create R1 Summary Records**.

##### Create the summary information for the T4A reports

To do this, follow these steps:

1. In Microsoft Dynamics GP, point to Tools on the Microsoft Dynamics GP menu, point to **Routines**, point to **Payroll - Canada**, point to **T4A Routines**, and then select **T4A Summary**.
2. Select **Create T4A Summary Records**.

#### Print the T4, T4A, RL-1 reports and create T4, T4A and RL-1 XML files, if appropriate

##### Print the final T4 reports

To do this, follow these steps:

1. In Microsoft Dynamics GP, point to Tools on the Microsoft Dynamics GP menu, point to **Routines**, point to **Payroll - Canada**, and then select **T4 and R1 Print**.
2. In the **Employer Number** field, select the appropriate employer number.
3. Select **T4 Slip Type** to select the appropriate form.
4. To print the T4 Statements, select **T4 Slips**. Follow the prompts and select if you want to test the form alignment by printing a test record.
5. Select **T4 Summary** and **T4 Segment**.

    > [!NOTE]
    > These reports are not designed to print on to a pre-printed form.

6. To generate the electronic T4 file, select **Electronic T4's**. Complete the Payroll Electronic Transfer T4 window and then select either **Verify Only** or **Verify and Generate**.

##### Print the RL-1 reports

To do this, follow these steps:

1. In Microsoft Dynamics GP, point to Tools on the Microsoft Dynamics GP menu, point to **Routines**, point to **Payroll - Canada**, and then select **T4 and R1 Print**.
2. In the **Employer Number** field, select the appropriate employer number.
3. Select **R1 Slip Type** choose **Laser**.
4. To print the R1 statements, select **R1 Slips**.
5. To print the R1 Summary report, select **R1 Summary**.

    > [!NOTE]
    > This report is not designed to print on to a pre-printed form.
6. To generate the electronic RL-1 file, select **Electronic R1's**. Complete the Payroll Electronic Transfer R1 window and enter the required fields including the Software Developer Authorization Number. Then select either **Verify Only** or **Verify and Generate**.

##### Print the T4A reports

To do this, follow these steps:

1. In Microsoft Dynamics GP, point to Tools on the Microsoft Dynamics GP menu, point to **Routines**, point to **Payroll - Canada**, point to **T4A Routines**, and then select **T4A Print**.
2. In the **Employer Number** field, select the appropriate employer number.
3. Select **T4A Slip Type** to choose either **Laser Employee** or **Laser CCRA**.
4. In Microsoft Dynamics GP 2015 and higher versions, enter the RL-1 Auth Number. (Refer to Q1 in the FAQ section below for more information about this field.)
5. To print the T4A statements, select **T4A Slips**.
6. To print the reports, select **T4A Segment** and **T4A Summary**.
7. To generate the electronic T4A's, select **Electronic T4A's**. Complete the **Payroll Electronic Transfer T4A** window and then select either **Verify Only** or **Verify and Generate**.

#### Verify that the pay periods are set correctly for 2021

To verify that the pay periods are set correctly for the upcoming new year, in Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **Payroll - Canada**, point to **Control**, and then select **Frequency**.

### FAQ

**Q1: Are there any new features/changes that I should be aware of for Year-End?**

A1: Refer to the Year-End [Microsoft Dynamics GP Year-End Update 2017: Canadian Payroll](https://community.dynamics.com/gp/b/dynamicsgp/posts/microsoft-dynamics-gp-year-end-update-2017-canadian-payroll) article for the most up-to-date information.

**Q2: When should I install the Year-End Update?**

A2: Basically, you should finish all your payruns for the current year, and install the Year-End Update (and complete through the Year-End File Reset or step 5 in the checklist above so Basic Personal Amounts are updated) before you do any payruns for the next new year. The Year-End update will include the new tax code needed for the payruns in the next new year. Follow the steps noted in the checklist above.

**Q3: What should I do if the Year-End Reset was done AFTER a payrun was made in the new year?**

A3: You will need to restore to a backup from BEFORE the Year-End Reset was done. Void the payrun for the new year. Then do the Year-End Reset (to move all the current year data to history, and Reset Master to index all the Employee's Basic Personal Amounts). Then you can redo the payrun for the new year, now that the updated tax amounts are in place for each employee. (Keep in mind that the new payrun may produce different amounts, as they may have maxed out on some amounts using last year's amounts, and taxes may have changed for the new year.)

**Q4: Why do I have to key in the RL-1 Auth Number?**

A4: In order to make year-end more seamless, the *RL-1 Auth Number* field was added as an editable field to the *Payroll T4/R1 Print- Canada* window in Microsoft Dynamics GP 2013 build 12.00.1488 and included in R2 (and later versions). The user will now be required to key in the RL-1 Slip number in this field. This authorization number is used by Revenue Quebec to identify that the forms came from Microsoft Dynamics GP. (This authorization number will be stored in a SQL table [CPY20100], per year, so it is available for reprints.) If the user updates the RL-1 Auth number field, the Last Updated Date will be changed to be the current System Date. The RL-1 Report (P_CPY_SETP_R1_Laser) was also changed to read this new authorization number field. You can find the RL-1 Slip number in the CAN20YETAX.pdf document that can be downloaded from the Year-End Update page (see links at top).

**Q5: Why do the taxes calculated in Dynamics GP differ from the CRA online calculator? How are Income Taxes calculated in Canadian Payroll?**

A5: Tax rates are included in the GP code and not stored in SQL tables for Canadian Payroll. Microsoft Dynamics GP uses an Averaging Convention formula to calculate taxes, which are within the acceptable tax ranges published by the CRA. See [Income Tax calculations or discrepancies with the CRA in Canadian Payroll for Microsoft Dynamics GP](https://support.microsoft.com/topic/income-tax-calculations-or-discrepancies-with-the-cra-in-canadian-payroll-for-microsoft-dynamics-gp-fef9d8f2-ab29-f03e-639f-28d59b595f4c) for more information on how taxes are calculated.
