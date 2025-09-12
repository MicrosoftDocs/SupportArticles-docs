---
title: Create a test or historical company in Payroll or in Canadian Payroll
description: This article describes how to create a test or historical company in Payroll or in Canadian Payroll in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Payroll
---
# Create a test or historical company in Payroll or in Canadian Payroll in Microsoft Dynamics GP

This article describes how to create a test or historical company in Payroll or in Canadian Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 885542

## Introduction

This article describes how to create a test or historical company in Payroll in Microsoft Dynamics GP. Labeling a company as a test company or as a historical company is useful because active employees in the test company or in the historical company are not counted against the registered employee count for a user.

## Create a new test company or a new historical company

1. To open GP Utilities, click **Start**, point to **All Programs**, click on **Microsoft Dynamics**, click the ' GP ' version folder, and then click **Utilities**.
2. On the **Additional Tasks** page, click **Create a Company** in the list, and then click **Process**.
3. Type a new company identifier in the **DB/Company ID** box, type a company name in the **Company Name** box, and then click **Next**.
4. Complete the steps in the wizard to create the new company.
5. Click **Launch Microsoft Dynamics GP**.
6. Log on to Microsoft Dynamics GP.
7. Select the company that you want to label as a test company or as a historical company, and then sign in to that company.
8. Open the Company Setup Window. To do this, click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Company and click Company**.
9. In the **Company Name**  field, type the following after the company name:

   - \<TEST>
   - \<HISTORICAL>  

   For example, to label Contoso, Ltd as a test or historical company, type the following in the Company Name field:

    - Contoso, Ltd\<TEST>
    - Contoso, Ltd\<HISTORICAL>

10. Click **OK** to save your changes. You can now use the company for testing or historical data purposes.

## Label an existing company as a test company or a historical company

Complete step 5 through step 9 in the previous section if you have an existing company that you want to change to a test company or a historical company. Complete step 5 through step 9 in the previous section if you have upgraded from an earlier version of Microsoft Dynamics GP, and you have existing test or historical companies.

## Troubleshooting

If you receive a warning message that states that you are over your registered employee count in the U.S. Payroll module, follow these steps:

1. Have all users log off from Microsoft Dynamics GP.
2. If you use Microsoft SQL Server, start SQL Query Analyzer. If you use Microsoft SQL Server Desktop Engine (MSDE), start the Support Administrator Console.
3. Run the following statement against the **DYNAMICS** database:

    ```sql
    DELETE UPR41600
    ```

4. Log back on to Microsoft Dynamics GP.
5. Verify the employee count is now correct as follows:

   - In Microsoft Dynamics GP 10.0 and higher versions, click **Help**  (blue icon with question mark on it) in the upper-right corner of the window, and then click **About Microsoft Dynamics GP..**. In the Session Information section, verify the Current and Total Registered employee count numbers.
