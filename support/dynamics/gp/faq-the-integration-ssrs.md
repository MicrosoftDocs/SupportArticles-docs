---
title: FAQ about the integration of SSRS
description: Contains answers to frequently asked questions about the integration of SQL Server Reporting Services (SSRS) with Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010.
ms.reviewer: theley, lmiller, kyouells
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Frequently asked questions about the integration of SQL Server Reporting Services (SSRS) with Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010

This article contains answers to frequently asked questions about the integration of Microsoft SQL Server Reporting Services (SSRS) with Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 954242

## General questions and answers  

Q1: Where can I find documentation about SQL Server Reporting Services for Microsoft Dynamics 10.0?  

A1: To download the SQL Server Reporting Services Administration Guide.

Q2: Where can I find documentation about SQL Server Reporting Services for Microsoft Dynamics 2010?  

A2: To download the SQL Server Reporting Services Guide (SQLServerReportingServicesGuide.pdf), visit [Microsoft Dynamics GP 2010 Guides: Analytics and Reporting](https://www.microsoft.com/download/details.aspx?id=18981).

Q3: Where can I obtain the SQL Server Reporting Services Wizard and Report Models?  

A3: The SQL Server Reporting Services Wizard is available in Microsoft Dynamics GP 10.0 CD2.

Q4: Can I install and run the SQL Server Reporting Services Wizard on a 64-bit server?  

A4: The SQL Server Reporting Wizard for Microsoft Dynamics GP 10.0 is supported on 64-bit operating systems. For more information, see [Description of the 64-bit operating systems that are supported together with Microsoft Dynamics GP](https://support.microsoft.com/help/918983).

> [!NOTE]
> The x64 Dexterity Common Components are required to be installed before you install the SQL Server Reporting Services Wizard on an x64 operating system.

Q5: What versions of SQL Server Reporting Services are supported?  

A5: The SQL Server Reporting Services Wizard is supported on the Standard and Enterprise editions of SQL Server Reporting Services 2005 with Service Pack 2 or a later service pack.

SQL Server Reporting Services 2008 and SQL Server Reporting Services 2008 R2 are also supported, with the following conditions:

- Service Pack 3 for the SQL Server Reporting Services Wizard is required for the installation with SQL Server 2008. Service Pack 4 for the SQL Server Reporting Services Wizard is required for the installation with SQL Server 2008 R2.

- If the User Account Control (UAC) is enabled on the Windows Server 2008-based server, you must right-click the SQL Server Reporting Services Wizard in the program group, and then select **Run as Administrator** to obtain the permissions that you need.

    For more information, see [Description of the 64-bit operating systems that are supported together with Microsoft Dynamics GP](https://support.microsoft.com/help/918983). If you want to list the SSRS SQL Server Reporting Services 2008 reports in the Custom Report List in Microsoft Dynamics GP 10.0, you must consider the following conditions:
  - You must be using Microsoft Dynamics GP 10.0 with Service Pack 3 or a later version to be compatible with SQL Server 2008. You must be using Microsoft Dynamics GP 10.0 with Service Pack 5 or later to be compatible with SQL Server 2008 R2To download the latest update release for Microsoft Dynamics GP 10.0.

  - In the Reporting Tools Setup window, you've to use the following syntax in the Report Server URL field on the SQL Reporting Services tab if you're using a Native Mode SSRS deployment:  
    `http:// <servername>:<port> /ReportServer/ReportService2005.asmx`

    > [!NOTE]
    > If you created a named instance for your SSRS 2008 installation, your URL may resemble the following:  
    > `http:// <servername>:<port> /ReportServer2008/ReportService2005.asmx`

You can verify the URL to use on the Web Services URL tab of the SSRS SQL Server 2008 Reporting Services Configuration Manager tool.

Q6: Which reports are available in Microsoft Dynamics GP 10.0  

A6: In Microsoft Dynamics GP 10.0, more than 60 reports and 13 report models are built on SQL Server 2005 Reporting Services technology. SQL Server Reporting Services reports pull data from Microsoft Dynamics GP. These reports are visible within the report list if the appropriate setup is completed.

To help make setup easier, reports are automatically associated with report roles that are created during the installation.

SSRS reports

- Field Service
- Contract Information
- SVC RTV Hard Copy Financial
- Additions Report
- Bank Transaction History Report
- Checkbook Register
- Fixed Asset Depreciation Detail
- Fixed Assets Depreciation Ledger
- Fixed Assets to General Ledger Reconciliation Report -Journal Entry Report
- Period Projection Report
- Retirements Report
- Source Cross Reference
- Trial Balance Detail
- Trial Balance Summary
- Undeposited Receipts Human Resources
- Employee Attendance Detail
- Employee Attendance Summary
- Enrollment by Benefit
- Enrollment by Employee Inventory
- Purchase Advice Report
- Purchase Receipts
- Sales Summary
- Stock Status Manufacturing
- BOM Detail Report
- Item Standard Cost Changes Report
- Job Detail
- Manufacturing BOM Report Standard Costs
- MO PO Links Report Sort By Vendor
- Picking Report - Item Number
- Picking Report Multibin - Item Number
- Traveler Graphics Reports Payroll
- Check History
- Check Registry
- Department Wage and Hour Report
- Earnings Summary
- Employee Pay History
- Employee Wage and Hour
- Payroll Summary
- State Wage Report
- Vacation Sick Time List Project
- Detail Trial Balance
- Monthly Employee Utilization
- PA PBW Fee -PA PBW T and M
- Pre-Billing Worksheet CPFP
- Pre-Billing Worksheet T and M -Project Cost Breakdown
- Projects in Progress Purchasing
- Aged Trial Balance - by Document Date
- Aged Trial Balance Details Subreport - by Document Date
- Back-ordered Items Received
- Cash Requirements
- Expected Shipments
- Historical Aged Trial Balance
- Purchase Order History
- Purchase Order Status
- Received Not Invoiced
- Receivings Trx History
- Transaction Detail
- Vendor Summary Sales
- Accounts Due -Aged Trial Balance - Detail
- Historical Aged Trial Balance
- Receivables Sales Analysis
- Sales Distribution History
- Sales Document Status -Sales Transaction History
- Sales Transaction History Payment Details Subreport
- Sales Transaction History Tax Details Subreport
- SOP Document Analysis
- SOP Document Analysis by Customer
- SOP Inventory Sales Report

## Questions and answers about setup  

Q1: Can I use SQL Server Reporting Services in the SharePoint integration mode with the Microsoft Dynamics GP 10.0 reports?  

A1: Currently, SharePoint integrated mode isn't supported with Microsoft Dynamics GP 10.0, and the SQL Server Reporting Services Wizard doesn't deploy reports to a site that is running in SharePoint integrated mode.

Q2: What are the prerequisites to deploy reports by using the SQL Server Reporting Services Wizard?  

A2: You must have the following applications installed and configured on a 32-bit server:

- One of the following versions of SQL Server Reporting Services:

- SQL Server Reporting Services 2005 with Service Pack 2 or a later service pack

- SQL Server Reporting Services 2008 with Service Pack 3 for SQL Server Reporting Services Wizard SQL Server Reporting Services 2008 R2 with Service Pack 4 for SQL Server Reporting Services Wizard

- Internet Information Services 6.0 (SQL Server Reporting Services 2005 only)

- Windows Internet Explorer 6 Service Pack 1 or later, Internet Explorer 7, Internet Explorer 8, or Internet Explorer 9

- Dynamics GP 10.0 with Service Pack 1 or a later service pack

Q3: I've created my own custom SSRS reports and published them to the Report Manager. However, they aren't displayed in the Custom Report list in Microsoft Dynamics GP 10.0.  

A3: The Custom Report list is intended to pull in reports that are deployed to SQL Server Reporting Services by using the SQL Server Reporting Services Wizard.

If you want to view reports that haven't been deployed by using this tool, you must replicate the folder structure that the tool will create to display your SSRS reports in the Custom Reports List. To do it, follow these steps:

1. Create a top-level folder that is named for your company database (for example, TWO).

2. Inside the folder that you created in step 1, create a folder that is named for one of the series in Microsoft Dynamics GP. For example, name the folder **Financials**, **Sales**, or **Purchasing**.

If you move an SSRS report to that series folder, it will be displayed in the Custom Report list after you enter the correct URL in the Reporting Tools Setup window.

> [!NOTE]
> These reports are displayed in the Reporting Services Reports list under each series in Microsoft Dynamics GP 2010. If you don't see them listed there, these rules also apply.

Q4: How do I set up security for Microsoft Dynamics GP SSRS reports?  

A4: You must grant access to some items to let users view SSRS reports. To do it, follow these steps:

1. Grant access to the Report Manager Home page. Report Manager Home page

2. Set permissions to the database.

    There are two methods for configuring security in SQL Server Reporting Services:

    - By using SQL Server Management Studio (SQL Server Reporting Services 2005 only)

    - By using the SQL Server Reporting Services Report Manager

    For more information about security, see Chapter 3 and Chapter 7 of the SQL Server Reporting Services Administration Guide. To obtain the SQL Server Reporting Services Administration Guide, see A1 in the [General questions and answers](#general-questions-and-answers) section.

## Questions and answers about troubleshooting  

Q1: When I try to deploy reports by using the SQL Server Reporting Services Wizard, I receive the following error message:  

> Specified argument was out of the range of valid values. Parameter name: site  

A1: This error message occurs if you've installed the SQL Server Reporting Services Wizard on a 64-bit server. or to a site that isn't the default site.

To resolve this problem, run the deployment on a 32-bit server that has all the prerequisites installed. You can also install the prerequisites for running the SQL Server Reporting Services Wizard on a 64-bit server. For more information on it, see Q and A3 in the [General questions and answers](#general-questions-and-answers) section.

Q2: When I try to view an SSRS report, I receive the following error message:  

> An error has occurred during report processing. (rsProcessingAborted)  
> Cannot create a connection to data source 'DataSourceGPCompany'. (rsErrorOpeningConnection)  

A2: This error message may occur if there's an extra character space in the data source that the SSRS reports are using to communicate with SQL Server.

To resolve this problem, follow these steps:

1. Visit the following Web site: `http://< server_name >/reports`

    > [!NOTE]
    > Replace < server_name > with the actual name of your server.

2. Select **Data Sources**, and then select one of the GP XXX folders that correspond to the Microsoft Dynamics GP companies that you have deployed reports to.

3. In the Connection string field, determine whether there's an extra character space between the = sign and the characters around it.

    For example, the following example is incorrect:

    Data Source = server\instance;Initial Catalog=TWO;Integrated Security=True

    To resolve this problem, change it to the following example:

    Data Source=server\instance;Initial Catalog=TWO;Integrated Security=True

4. Repeat steps 2 and 3 for each data source that is listed.

Q3: When I try to access a report, I receive the following error message:  

> An error has occurred during report processing. (rsProcessingAborted)  
Cannot create a connection to data source 'DataSourceGPCompany'. (rsErrorOpeningConnection)  
Login failed for user 'domain\username'.

A3: This problem occurs because you don't have permissions to the report.

To resolve this problem, you must obtain database permissions. (see Chapter 7 of the Reporting Services Admin Guide). To obtain the SQL Server Reporting Services Administration Guide, see A1 in the [General questions and answers](#general-questions-and-answers) section.

Q4: When I try to view an SSRS report, I receive the following error message:  

> An error has occurred during report processing.  
Query execution failed for data set 'dsCompanyName'.  
 The SELECT permission was denied on the object 'SY01500', database 'DYNAMICS', schema 'dbo'.  

A4: This problem occurs if your corresponding SQL Server sign-in hasn't been added to the rpt_alluser database role in the DYNAMICS database.

To resolve this problem, add a SQL Server sign-in to this database role. For more information, see page 35 of the Reporting Services Admin Guide. To obtain the SQL Server Reporting Services Administration Guide, see A1 in the [General questions and answers](#general-questions-and-answers) section.

Q5: When I try to run a SQL Server Reporting Services report from a client workstation, I receive the following error message:  

> An error has occurred during report processing. (rsProcessingAborted)Cannot create a connection to data source 'DataSourceGPCompany'. (rsErrorOpeningConnection)Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'. An error has occurred during report processing. (rsProcessingAborted)  
Cannot create a connection to data source 'dsGP10 XX '. (rsErrorOpeningConnection)  

For more information about this error, navigate to the report server on the local machine, or enable remote errors.  

> [!NOTE]
> XX is a two-letter placeholder for the series that the report that you are trying to print belongs to. For example, this series may be GL, BR, PM, or FA.  

A5: This problem occurs if you have SSRS or Internet Information Services (IIS) installed on a computer other than the computer that is running the instance of SQL Server for Microsoft Dynamics GP.

By default, SQL Server Reporting Services will use Windows Authentication. However, there's a limitation in Windows Authentication by which Windows credentials can be passed only from one source to another.

In the problem Q5 scenario, you first have to pass your credentials from the GP workstation to the IIS server on which the SSRS reports are stored. Then, IIS must make a call to SQL Server to populate the reports. However, because of this "double-hop" behavior, Windows Authentication becomes inoperative.

To resolve this problem, you must make SQL Server Reporting Services pass credentials to the computer that is using SQL Authentication. To do it, follow these steps:

1. On the server that is running IIS, browse to the Report Manager. For example, the link may resemble the following example: `http:// server : port /Reports`

2. Select **Data Sources**.

3. Select to open any of the Microsoft Dynamics GP data source folders, such as `GPDYNAMICS`.

4. In the Connection string field, you may see an `Integrated Security = True` string. You must change it to `Integrated Security = False`.

5. Select the **Credentials** stored securely in the report server option.

6. Enter the user name and password of a SQL Server sign-in that has access to every Microsoft Dynamics GP database.

    We recommended that you don't use the sa sign-in. It's better to create a new login and to give it read-only access to the database.

7. Select **Apply** to save the changes.

8. Select the **Data Sources link** at the top of the window.

9. Repeat steps 3 through 7 for each GP xxxx data source.

To create a read-only SQL Server login, follow these steps:

1. In SQL Server Management Studio, expand **Security**, right-click the **Logins** folder, and then select **New Login**.

2. Enter the login name and password that meets your policies.

3. Select **OK** to create the login.

4. Double-click the **login** to open the Login Properties window.

5. Select **User Mapping**, and then select the DYNAMICS database and all GP company databases.

6. Under **User Mapping**, add this user to the rpt_power user database role. It provides the datasources the necessary permissions for all stored procedures and views the reports rely on.

    > [!NOTE]
    > This method grants users access to all SSRS reports because Windows Authentication is no longer used. Also, you must remove access to specific company and series folders and reports in Report Manager to determine what the user can view.

The other option for resolving this issue is to enable Kerberos authentication.

Q6: When I try to run the SQL Server Reporting Services Wizard, I receive the following error message:  

> Retrieving the COM class factory for component with CLSID {58737586-7149-11D4-9BB0-00A0CC359411} failed due to the following error: 80040154.  

A6: This problem occurs if the following components aren't installed on the computer on which you run the SQL Server Reporting Services Wizard:

- Internet Information Services 6.0 (SQL Server Reporting Services 2005 only)

- Microsoft SQL Server Reporting Services 2005 with Service Pack 2

- Microsoft Dynamics GP 10.0 (including the Dexterity shared components)

Q7: When I try to view a SQL Server Reporting Services report, I receive the following error message:

> An error has occurred during report processing.
(rsProcessingAborted) Item has already been added. Key in dictionary: 'xxx' Key being added: 'xxx'

A7: This problem occurs if Service Pack 2 for SQL Server 2005 hasn't been applied. To view your version information, run the following script in SQL Server Management Studio:

```sql
SELECT @@version
```

> [!NOTE]
> Build 9.00.3042 corresponds to Service Pack 2.

You can also use SQL Server Management Studio interface to find this information. To do it, in SQL Server Management Studio, right-click the server name, select **Properties**, and then select **General**. The build number is displayed in the Version field.

Q8: When I try to run the SQL Server Reporting Services Wizard, I receive the following error message:  

> System.Web.SErvices.Protocols.SoapException: There was an exception running the extensions specified in the config file. System.Web.HttpException: Maximum request length exceeded.  

A8: This error message indicates that the Web.config file for the Report Server wasn't updated by using the recommended maximum request length. To manually set the maximum request length, follow these steps:

1. On the server that is running IIS, locate the Web.config file for the Report Server. By default, you can find this file in the following location:

    `C:\Program Files\Microsoft SQL Server\MSSQL.1\Reporting Services\ReportServer`

2. Make a backup copy of the Web.config file.

3. Open the Web.config file in a text editor, and then make the following change.

    Existing text

    `<httpRuntime executionTimeout = "9000"/>`

    Replacement text

    `<httpRuntime executionTimeout = "9000" maxRequestLength="20690"/>`

4. Restart the SQL Server Reporting Services service to force the change into effect

5. Run the SQL Server Reporting Services Wizard again.

Q9: When I try to run the SQL Server Reporting Services Wizard, I receive the following error message:  

> The operation you are attempting requires a secure connection (HTTPS)  

A9: This error can occur if you're using SQL Server Report Services 2008. During the Reporting Services 2008 configuration, the open to use Secure Socket Later (SSL) for your Reporting Services site option may have been inadvertently selected. To resolve this problem, follow these steps:

1. Locate the SQL Server Reporting Services 2008 folder. By default, this folder is located at the following path:

    `C:\Program Files\Microsoft SQL Server 2008\MSRS10.xxxxx\Reporting Services\ReportServer`

2. Open the rsreportserver.config file in a text editor. Then, make the following change:

    1. Locate the following code:

    `<Add Key="SecureConnectionLevel" Value="2"/>`

    1. Replace the existing code with the following code:

    `<Add Key="SecureConnectionLevel" Value="0"/>`

3. Save the change.

4. Run the SQL Server Reporting Services Wizard again.

Q10: When I try to run a SQL Server Reporting Services report from a client workstation, I receive the following error message:  

> An error has occurred during report processing. (rsProcessingAborted)  
error text(rsErrorOpeningConnection)  

For more information about this error, navigate to the report server on the local machine, or enable remote errors.  

A10: This error is too generic to troubleshoot. You'll want to enable remote errors to receive more details on the issue.

1. Navigate to your SQL Server

2. Select **Start**, point to **All Programs**, then Microsoft SQL Server, then select **SQL Server Management Studio**.

3. When prompted, connect to your SQL Server Reporting Services instance by selecting the **Reporting Service Server Type**.

4. When connected, right-click on your instance name and select **Properties**. If you don't see your instance name on the left side of the screen, select **View > Object Explorer** in the menu.

5. In the **Properties** window, select the **Advanced** tab, look for the Security section and set **Enable RemoteErrors** to **True**.

6. Select **OK** to save this change and have the user recreate the issue.

Q11: When attempting to deploy the SQL Server Reporting Services reports for Microsoft Dynamics GP, you receive the following error:  

> You do not have security access to deploy reports to the location entered  

A11: It indicates that the Windows/domain account that is signed into the server while the deployment is running doesn't have the necessary rights to SQL Server Reporting Services. Check the following ones:

1. Verify that your user can browse the Web Service URL (for example, `https://servername/ReportServer`) site. If you're using Native Mode also verify that you can access the Report Manager (for example, `https://servername/Reports`) site. If you can't, you'll need to grant your user permissions per Chapter 7 of the SQL Server Reporting Services Guide.

1. If you're using a SharePoint Integrated SSRS instance, you'll want to verify that you can browse the library the reports will be deployed to.

1. If you can browse all SSRS sites, it may be that the Content Manager role for the Native Mode of SSRS is missing a permission. To verify it, do the following steps:

    1. Open SQL Server Management Studio on your SQL Server by selecting **Start**, pointing to **All Programs**, then Microsoft SQL Server and then selecting **SQL Server Management Studio**.

    1. Connect to your SQL Server Reporting Services instance

    1. In the Object Explorer section of this application, expand your instance name, then **Security**, then **Roles**.

    1. Right-click on **Content Manager** and select **Properties**.

    1. Verify that every option has been selected, particularly **Manage Models**.

    1. Save the change, verify that your deploying user has been granted access to the Content Manager SSRS role and try the report deployment again

Q12: You receive the following error when attempting to access the Report Manager site:  

> User "(domain\alias)" does not have required permissions. Verify that sufficient permissions have been granted and Windows User Account Control (UAC) restrictions have been addressed.  

You may find this error when troubleshooting a report deployment issue.

A12: This error occurs because of the User Account Control restrictions placed on the site. To resolve this issue, you need to use the following steps to explicitly grant the user in question access to the Report Manager site:

1. First, sign in to the SQL Server Reporting Services server as the administrative user for that application.

1. Select **Start** and then **All Programs**. Find the shortcut for Internet Explorer, right-click on it and select **Run as Administrator**.

1. Once IE has opened, navigate to your Report Manager site. If you don't know what URL it is, you can select **Start**, then **All Programs**, then **Microsoft SQL Server**, then **Configuration Tools**, then **Reporting Service Configuration Manager**.

1. Once the Report Manager side loads, select the **Site Settings** link in the upper right.

1. Use the security interface to add your user to the System Administrator or System User roles

1. Select the **Home link** to go back to the top-level site.

1. You may then want to also add your user to the Content Manager role.

    1. In SQL Server 2008, select the blue **Properties** tab on the Home page to add this role to your user.

    1. In SQL Server 2008 R2, select the **Folder Options** button on the Home page to do the role assignment. After making these changes, your user can browse the Report Manager site without error.
