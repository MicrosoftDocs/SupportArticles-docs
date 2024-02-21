---
title: Frequently asked questions about role-based security
description: This article describes answers for the frequently asked questions about role-based security in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 02/20/2024
---
# Frequently asked questions about role-based security in Microsoft Dynamics GP

This article describes answers for the frequently asked questions about role-based security in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 951229

## Introduction

This article contains frequently asked questions about role-based security in Microsoft Dynamics GP.

## Overview

- **Q1: Is documentation available that describes role-based security for Microsoft Dynamics GP?**

   A1: The [System Setup](/dynamics-gp/installation/systemsetup) describes security in Microsoft Dynamics GP.
  
- **Q2: What are the basic components of role-based security?**

  A2: The basic components are as follows:

  - Operation: The Operation component is the base level element of security for windows, for reports, for posting permissions, and for document access.

  - Task: The Task component is the group of operations that are needed to complete a business task. For example, the business task can be the Enter Customers task and the Post Sales Transactions task.

  - Role: The Role component is the group of tasks that defines a particular job in a company. Operations are assigned to tasks. Tasks are assigned to roles. Roles are assigned to users. More than one operation can be assigned to a task. More than one task can be assigned to a role. A user can be assigned many roles.

- **Q3: Is the security setup company-specific?**

   A3: Yes. The roles that are assigned to each user are company-specific.

- **Q4: What is the DEFAULTUSER task?**

   A4: The DEFAULTUSER task is automatically assigned to each role. This task grants access to the basic areas that all users usually access, such as the User Date window.

- **Q5: What is the POWERUSER role?**

  A5: By default, the POWERUSER role is assigned to the sa user. The POWERUSER role grants the user access to all areas and to all modules in Microsoft Dynamics GP.

- **Q6: What are the security tables?**

  A6: The following are the security tables in Microsoft Dynamics GP:

  - SY09000: Task master
  - SY09100: Role master
  - SY09200: Alternate or modified form and report ID master
  - SY09400: Security Resource Descriptions
  - SY10000: User Security
  - SY10500: Role assignment master
  - SY10550: DEFAULTUSER task ID assignment master
  - SY10600: Tasks assignments master
  - SY10700: Operations assignments master
  - SY10750: DEFAULTUSER task assignment
  - SY10800: Alternate or modified form and report ID assignment master

## Security setup

- **Q1: What are the steps to assign roles to a user?**

  A1: The [System Setup](/dynamics-gp/installation/systemsetup) describes how to assign roles to a user in Microsoft Dynamics GP.

- **Q2: How do I grant a user access to a custom report in Microsoft Dynamics GP?**

  A2: To add the custom report to a current security task that is assigned to the security role:

  Method 1. To create a new security task for the custom report, create a new security role, assign the new security task to the new security role, and grant the access to the new security role.

  Method 2. Create a new security task and a new security role for the custom report

  - Method 1: Add the custom report to a current security task

    1. Log on to Microsoft Dynamics GP as the sa user.

    2. Specify the security task. To do this, follow these steps:

       1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Security Tasks**.

       2. In the Security Task Setup window, select the lookup button next to the **Task ID** field.

       3. Select the security task to which you want to add the custom report, and then select **Select**.

       4. In the **Product** list, select the product for which the custom report is used.

       5. In the **Type** list, select **Custom Reports**.

       6. In the **Series** list, select the appropriate series.

          The **Access List** area displays the reports.

       7. Select the checkboxes for the custom reports to which you want to grant access.

       8. Select **Save**.

       9. Close the **Security Task Setup** window.

    3. Specify the security role. To do this, follow these steps:

       1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Security Roles**.

       2. In the Security Role Setup window, select the lookup button next to the **Role ID** field.

       3. Select the security role that you want to use.

       4. Verify that the checkbox for the security task that you specified in step 2 is selected. Otherwise, select the checkbox.

       5. Select **Save** to save the changes to the security role.

          > [!NOTE]
          > Any users who are assigned to the security role have access to the reports that you select for the task.

       6. Close the Security Roles Setup window.

    4. Verify that the security role is assigned to the appropriate user. Otherwise, add the security role to the appropriate user. To do this, follow these steps:

       1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **User Security**.

       2. In the User Security Setup window, select the lookup button next to the **User** field, select a user who you want to use, and then select **Select**.

       3. In the **Company** list, select a company that you want to use.

       4. Verify that the checkbox for the security role that you specified in step 3 is selected. Otherwise, select the checkbox.

       5. Select **Save** to assign the user to the security role.

       6. Close the User Security Setup window.

  - Method 2: Create a new security task and a new security role for the custom report

    1. Log on to Microsoft Dynamics GP as the sa user.
    2. Create a new security task. To do this, follow these steps:

       1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Security Tasks**.

       2. In the Security Task Setup window, type a task identifier (ID) in the **Task ID** field, type a task name in the **Task Name** field, and then type a description in the **Task Description** field.

       3. In the **Category** list, select the category that you want to use for the task.

       4. In the **Product** list, select the product that you want to use for the custom report.

       5. In the **Type** list, select **Custom Reports**.

       6. In the **Series** list, select the appropriate series.

          The **Access List** area displays the custom reports.

       7. Select the checkboxes for the custom reports.

       8. Select **Save**.

       9. Close the Security Task Setup window.

    3. Create a new security role for the security task that you created in step 2. To do this, follow these steps:

       1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Security Roles**.

       2. In the Security Role Setup window, type a role identifier (ID) in the **Role ID** field, type a role name in the **Role Name** field, and then type a description in the **Role Description** field.

       3. Select the security role that you want to use.

       4. Select the checkbox for the security task that you created in step 2.

       5. Select **Save**.

       6. Close the Security Roles Setup window.

    4. Assign the security role to the user. To do this, follow these steps:

       1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **User Security**.

       2. In the User Security Setup window, select the lookup button next to the **User** field, select a user who you want to use, and then select **Select**.

       3. In the **Company** list, select a company that you want to use.

       4. Verify that the checkbox for the security role that you specified in step 3 is selected. Otherwise, select the checkbox.

       5. Select **Save**.

       6. Close the User Security Setup window.

- **Q3: What are the steps to find the SECURITYRESIDs for windows and for reports?**

    A3: To find the SECURITYRESIDs for windows and for reports, follow these steps:

    1. Select **Microsoft Dynamics GP**, point to **Maintenance**, and then select **Clear Data** to open the Clear Data window.
    2. On the **Display** menu, select **Physical**.
    3. In the **Series** list, select **System**.
    4. In the **Tables** pane, select the **Security Resource Descriptions** table, and then select **Insert**.
    5. Select **OK**.
    6. Select **Yes**.
    7. In the Report Destination window, select the **Screen** checkbox, and then select **OK** to send the report to the screen.
    8. Close the report.

   The Security Resource Descriptions table is populated. You can use the table in an SQL query in Microsoft SQL Query Analyzer or in Microsoft SQL Server Management.

   The following query is used to display security roles and security tasks that are associated with a specific window or with a specific report. You can specify the window or the report by changing the display name in the last line of the query.

    ```sql
    SELECT ISNULL(A.SECURITYROLEID,'') AS SECURITYROLEID, 
    ISNULL(M.SECURITYROLENAME,'') AS SECURITYROLENAME, 
    --ISNULL(M.SECURITYROLEDESC,'') AS SECURITYROLEDESC, 
    ISNULL(O.SECURITYTASKID,'') AS SECURITYTASKID, 
    ISNULL(T.SECURITYTASKNAME,'') AS SECURITYTASKNAME, 
    --ISNULL(T.SECURITYTASKDESC,'') AS SECURITYTASKDESC, 
    R.PRODNAME, R.TYPESTR, R.DSPLNAME, R.RESTECHNAME, R.DICTID, R.SECRESTYPE, R.SECURITYID
    FROM DYNAMICS.dbo.SY09400 R
    FULL JOIN DYNAMICS.dbo.SY10700 O ON R.DICTID = O.DICTID 
    AND O.SECRESTYPE = R.SECRESTYPE AND O.SECURITYID = R.SECURITYID
    FULL JOIN DYNAMICS.dbo.SY09000 T ON T.SECURITYTASKID = O.SECURITYTASKID
    FULL JOIN DYNAMICS.dbo.SY10600 A ON A.SECURITYTASKID = T.SECURITYTASKID
    FULL JOIN DYNAMICS.dbo.SY09100 M ON M.SECURITYROLEID = A.SECURITYROLEID
    WHERE R.DSPLNAME = '<Display_Name>'
    ```

    > [!NOTE]
    > The _<Display_Name>_ placeholder represents the actual display name. For example, the display name may be "Sales Transaction Entry."

    The following table lists the result of the query for the Sales Transaction Entry object against a default installation.

    |SECURITYROLEID|SECURITYROLENAME|SECURITYTASKID|SECURITYTASKNAME|PRODNAME|TYPESTR|DSPLNAME|RESTECHNAME|DICTID|SECRESTYPE|SECURITYID|
    |---|---|---|---|---|---|---|---|---|---|---|
    |BOOKKEEPER*|Bookkeeper|TRX_SALES_001*|Enter SOP transactions|Microsoft Dynamics GP|Windows|Sales Transaction Entry|SOP_Entry|0|0|619|
    |CUSTOMER SERVICE REP*|Customer Service Representative|TRX_SALES_001*|Enter SOP transactions|Microsoft Dynamics GP|Windows|Sales Transaction Entry|SOP_Entry|0|2|619|
    |OPERATIONS MANAGER*|Operations Manager|TRX_SALES_001*|Enter SOP transactions|Microsoft Dynamics GP|Windows|Sales Transaction Entry|SOP_Entry|0|2|619|
    |SHIPPING AND RECEIVING*|Shipping and Receiving|TRX_SALES_001*|Enter SOP transactions|Microsoft Dynamics GP|Windows|Sales Transaction Entry|SOP_Entry|0|2|619|

    If no security roles are assigned to the security tasks, the table is blank. If no security tasks are assigned to the operation, the table is also blank.

- **Q4: How can I create my own security task and assign the task to a new security role?**

  A4: For information about how to create a task and to create a role, see page 33 in the SystemSetup.pdf file.

- **Q5: How do I set up a security role for the navigation lists?**

  A5: You can grant access to the navigation lists by using a task. The default tasks already include access. To grant access to a navigation list by using a new task, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Security Tasks**.
    2. Enter the security task that you want to use.
    3. In the **Product** list, select **Microsoft Dynamics GP**.
    4. In the **Type** list, select **Navigation Lists**.
    5. In the **Series** list, select **Navigation lists**.
    6. Select the navigation lists to which you want the task to have access.
    7. Assign the new task to a role.

    > [!NOTE]
    > For more information about how to do this, see question 4 in the [Security setup](#security-setup) section.

- **Q6: How do I grant access to the Create Return feature in the Sales Transaction Entry window?**

  A6: To grant access to the Create Return feature in the Sales Transaction Entry window, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Security Tasks**.
    2. In the **Task ID** field, type an ID.
    3. In the **Category** list, select **Sales**.
    4. In the **Task Name** field, type a name.
    5. In the **Product** list, select **Field Service**.
    6. In the **Type** list, select **Windows**.
    7. In the **Series** list, select **Project**.
    8. In the **Access List** pane, select the following checkboxes:

       - **Create Return**  
       - **Invoice Document Lookup**  
       - **Invoice Document Lookup**  
       - **Sales Invoice Return Item Selection**  

       > [!NOTE]
       > Two identical checkboxes exist for **Invoice Document Lookup**. Select both checkboxes.

    9. Select **Save**.

- **Q7: Can I copy one user's security access to another user?**

  A7: Yes. The copy functionality exists with the User Security Setup window. To access this window, select **Microsoft Dynamics GP** > **Tools**, point to **Setup**, point to **System**, and then select **User Security**. After you select the **User** and **Company** values, the **Copy** button becomes available. Select **Copy** to open the Copy User Security window. Use this window to copy the security roles and the alternative or modified forms ID for the selected user to the same user in any other company to which the user has access.

## Security conversion

1. If you perform the security conversion when you upgrade to Microsoft Dynamics GP 10.0 or 2010, the following actions occur:

   - For each user in a company, a task and a role are created. The name of the task and the role is CNV_USERID_COID. For example, if you perform the security conversion for the Phyllis user in the TWO company, the task and the role are named as CNV_PHYLLIS_TWO.
   - The existing security access is assigned to the CNV_USERID_COID task. Additionally, the task is assigned to the CNV_USERID_COID role.
   - The CNV_USERID_COID role is assigned to the user for the company.
   - All accesses to alternate forms and to modified forms are converted to an identifier (ID) of CNV_USERID_COID. The ID is assigned to the user in each company.
   - The SY02000 security table and the SY40300 security table in Microsoft Business Solutions - Great Plains 8.0 or in Microsoft Dynamics GP 9.0 are removed.

2. To view the records that are created when you perform the security conversion, you can run the following SQL script:

    ```sql
    select * from DYNAMICS.dbo.SY10700 where SECURITYTASKID like 'CNV%'
    select * from DYNAMICS.dbo.SY09000 where SECURITYTASKID like 'CNV%'
    
    select * from DYNAMICS.dbo.SY10600 where SECURITYROLEID like 'CNV%'
    select * from DYNAMICS.dbo.SY09100 where SECURITYROLEID like 'CNV%'
    
    select * from DYNAMICS.dbo.SY10500 where SECURITYROLEID like 'CNV%'
    
    select * from DYNAMICS.dbo.SY10800 where SECMODALTID like 'CNV%'
    select * from DYNAMICS.dbo.SY09200 where SECMODALTID like 'CNV%'
    
    select * from DYNAMICS.dbo.SY10550 where SECMODALTID like 'CNV%'
    ```

3. The converted security tasks and roles are created to provide a starting point for security. However, you can implement customized roles and tasks later. If you do this, you do not need the converted security tasks and roles anymore. To remove all of the converted security tasks and roles, run the following statements in Management Studio or in Query Analyzer:

    ```sql
    DELETE DYNAMICS..SY09000 WHERE SECURITYTASKID LIKE 'CNV%'
    DELETE DYNAMICS..SY10500 WHERE SECURITYTASKID LIKE 'CNV%'
    DELETE DYNAMICS..SY09100 WHERE SECURITYROLEID LIKE 'CNV%'
    DELETE DYNAMICS..SY10600 WHERE SECURITYROLEID LIKE 'CNV%'
    ```

    > [!NOTE]
    > Make sure that you have a current backup of the DYNAMICS database before you run these statements.

## Troubleshooting

- **Q1: Why do I receive a "You don't have security privileges to open this window. Contact your system administrator for assistance" error message when I use the Payroll Clerk security role to calculate payroll checks in Microsoft Dynamics GP?**

  A1: When you assign the Payroll Clerk security role to a user, the Calculate Payroll Taxes window is not included in the TRX_PAYRL_003* task ID. To work around this problem, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Security Tasks**.
    2. In the **Task ID** list, select **TRX_PAYRL_003***.
    3. In the **Product** list, select **Microsoft Dynamics GP**.
    4. In the **Type** list, select **Windows**.
    5. In the **Series** list, select **System**.
    6. Select the **Payroll Calculate Taxes** checkbox.
    7. Select **Save**.

  For more information, see [Error message when you use the Payroll Clerk security role to calculate payroll checks Microsoft Dynamics GP: "You don't have security privileges to open this window"](cannot-use-payroll-clerk-security-to-calculate-payroll-checks.md).

- **Q2: When I open the Purchase Order Entry window in Purchase Order Processing in Microsoft Dynamics GP, I receive a "You don't have security privileges to open this window. Contact your system administrator for assistance" error message. How can I resolve this problem?**

  A2: To resolve this problem, see [Error message when you try to open the Purchase Order Entry window in Purchase Order Processing in Microsoft Dynamics GP: "You don't have security privileges to open this window"](fail-to-open-purchase-order-entry-window.md).
