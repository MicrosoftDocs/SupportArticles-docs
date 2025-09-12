---
title: Storing DB2 connection strings
description: This article explains how to save DB2 connection strings in Enterprise Single Sign-On, using KB 2499828 for Microsoft Host Integration Server 2010, or Cumulative Update 1.
ms.date: 05/07/2024
ms.custom: sap:Data Integration (DB2, Host Files)
ms.reviewer: jeremyr
---
# Storing DB2 connection strings in Enterprise Single Sign-On

This article explains how to save DB2 connection strings in Enterprise Single Sign-On, using KB 2499828 for Microsoft Host Integration Server (HIS) 2010, or Cumulative Update 1.

_Original product version:_ &nbsp; Host Integration Server 2010  
_Original KB number:_ &nbsp; 2592014

## Summary

In this task, you will save DB2 connections strings in Enterprise Single Sign-On, using hotfix KB 2499828 for HIS 2010, or 2010 Cumulative Update 1. The new feature works with existing tools and Data Providers for DB2. The task involves the following basic steps:

1. Add ESSO to an HIS 2010 installation.
2. Configure ESSO for use with HIS 2010.
3. Apply HIS 2010 hotfix KB 2499828/Cumulative Update 1.
4. Define an ESSO Affiliate Application for Windows-initiated SSO.
5. Define a DB2 connection string for Windows-initiated SSO.
6. Define an ESSO Affiliate Application for storing DB2 connection string.
7. Define a DB2 connection that retrieves connection string from SSO.
8. Using SSO Command Line to automate SSO configuration.

Prerequisites
In order to complete this walk through, you will need:

- HIS 2010.
- hotfix KB 2499828.
- Enterprise Single Sign-On V5.
- IBM DB2 server.

To add ESSO to an HIS 2010 installation. You must have access to an ESSO installation, in order to use Windows-initiated SSO and to store a DB2 connection securely for use by multiple client programs and users. If you did not include ESSO when installing HIS 2010, then you can add ESSO by rerunning the HIS 2010 setup program.

1. In Windows Explorer, locate the installation folder containing the HIS 2010 installation files.
2. Double-click **Setup.exe**. When prompted by **User Access Control**, click **Yes**. The **Host Integration Server Setup Autorun** dialog appears.
3. Under **Installation**, click the HIS product name hyperlink to launch the installation wizard. The HIS 2010 Installation Wizard appears.
4. In the **Program Maintenance** dialog, click **Modify** and then **Next**.
5. In the **Component Installation** dialog, click to expand the Server items under the Available components list. Scroll down and click the checkbox for Enterprise Single Sign-On, and then click **Next**.
6. In the **Summary** dialog, review the ESSO Prerequisites (ESSO runtime Server and Administration tools) and the HIS 2010 Components to be installed (Enterprise Single Sign-On feature set). Click **Install** to continue.
7. In the **Installation Progress** dialog, monitor the process for any errors. If any errors occur, the **Installation Failed** dialog appears. Click the Logfile hyperlink and provide the file to your network administrator or client administrator.
8. In the **Installation Completed** dialog, optionally click **Check** for Updates. Verify the checkbox is selected for Launch Configuration Wizard, and then click **Finish**.

To configure ESSO for use with HIS 2010. You must configure Enterprise Single Sign-On as a feature of HIS 2010, in order to use Windows-initiated SSO and to store a DB2 connection securely for use by multiple client programs and users.

1. In the scope pane (list of installed features on left side of dialog) of the **HIS 2010 Configuration** dialog, click **Enterprise SSO**.
2. In the **Enterprise Single Sign-On** dialog, click **Enable Enterprise Single Sign-On**. Verify the warning glyphs appear, indicating that ESSO requires configuration of the data store and Windows service instance.
3. Select **Create a new SSO system**, enter a Server Name for the Data store (SQL Server database), and then click the **ellipse button** (...) to specify a Windows service Account.
4. In the **User Credentials** dialog, enter a User name and Password in which to run the ESSO runtime service instance, and then click **OK**.
5. In the scope pane (list of installed features on left side of dialog) of the **HIS 2010** dialog, click **Enterprise SSO Secret Backup**.
6. In the **Enterprise SSO Secret Backup** dialog, enter a password in the **Secret backup password and Confirm password** edit boxes. Optionally, enter a Password reminder and change the Backup file location.
7. In the **Actions menu of the HIS 2010 Configuration** dialog, click **Apply Configuration**.
8. In the **Summary** dialog, verify the Components being configured include Enterprise SSO, and then click **Next**.
9. In the **Configuration Progress** dialog, monitor the process for any errors. If any errors occur, the **Configuration Failed** dialog appears. Click the Logfile hyperlink and provide the file to your network administrator or client administrator.
10. In the **Configuration Result** dialog, verify the **Success**, and then click **Finish**.
11. In the **HIS 2010 Configuration** dialog, click **File**, and then click **Exit**.

    > [!NOTE]
    > You can launch the HIS 2010 Configuration from the **Start** menu. On the **Start** menu, point to **All Programs**, point to **HIS 2010**, and click **Configuration Tool**. When prompted by **User Access Control**, click **Yes**. The **HIS 2010 Configuration** dialog appears.

Apply HIS 2010 hotfix KB 2499828/Cumulative Update 1. You must apply HIS 2010 hotfix KB 2499828 or Cumulative Update 1, in order to use Windows-initiated SSO and to store a DB2 connection securely for use by multiple client programs and users.

1. Download the hotfix package.
2. Install the hotfix package on the HIS 2010 computer(s).

To define an ESSO Affiliate Application for Windows-initiated SSO  
You must define an ESSO Affiliate Application, in order to use Windows-initiated SSO for use by multiple client programs and users.

1. On the **Start** menu, point to **All Programs**, point to **Enterprise Single Sign-On**, and click **SSO Administration**. When prompted by **User Access Control**, click **Yes**.
2. In the **Enterprise Single Sign-On** scope pane, of the ENTSSO MMC snap-in, click the **Affiliate Applications** folder; click the **Action** menu, and then **Create Application**.
3. In the **Enterprise Single Sign-On Application Wizard Welcome** dialog, click **Next**.
4. In the **General** dialog, enter an Application name (for example "SYS1"), click **Allow local accounts for access accounts**, click **Use SSO Affiliate Admin Accounts for Application Admin** accounts, and then click **Next**.
5. In the **Accounts** dialog, under the **Application Users** list, click **Add**.
6. In the **Select Users** or **Groups** dialog, enter a user account (for example, *DOMAIN\username*), click **Check Names**, and then click **OK**. Verify the account is added to the **Application Users** list, and then click **Next**.
7. In the **Options** dialog, verify the **Affiliate Application** is Enabled, and that **Allow Windows Initiated SSO** is selected, and then click **Next**.
8. In the **Fields** dialog, verify the Number of fields is the default two (2), and then click **Create**.
9. In the **Completing the Application Wizard** dialog, verify that you successfully created the Application, and then click **Finish**. If any errors occur, then contact your network administrator or client administrator.
10. In the Enterprise Single Sign-On scope pane, of the ENTSSO MMC snap-in, click the **Affiliate Applications** folder; click the newly created **Affiliate Application** (for example "SYS1"), click the **Action** menu, click **New Mapping**.
11. In the **Create New Mapping** dialog, enter a Windows user (for example, DOMAIN\username), enter an External user (for example "HISDEMO" account authorized to access "SYS1" DB2 server), click **Set credentials for new mapping**, and then click **OK**.
12. In the **Set Credentials** dialog, enter a valid DB2 server password (for example "HISDEMO") in the **Password and Confirm** edit boxes, and then click **OK**.
13. In the **Enterprise Single Sign-On** scope pane, of the ENTSSO MMC snap-in, click the **Affiliate Applications** folder, verify the newly created **Affiliate Application** (for example "SYS1") is Enabled. Click the **Affiliate Application** (for example "SYS1"), and verify in the results pane (list of Windows users on right side of dialog) is enabled.

To define a DB2 connection string for Windows-initiated SSO
You must define a DB2 connection string in order to use Windows-initiated SSO, you can define a connection string using the ADO.NET Data Provider for DB2 ConnectionString Builder. You can define a string manually with a text editor. You can define a connection string using OLE DB Data Links. You can define a connection string using the Data Source Wizard (DSW), within the Data Access Tool (DAT) or Visual Studio Server Explorer. In this task, we will use the latter approach of the DSW in the DAT.

1. On the **Start** menu, point to **All Programs**, point to **HIS 2010**, and click **Data Access Tool**. When prompted by **User Access Control**, click **Yes**.
2. In the **Data Access Tool**, click the **Data Sources**, click the **File** menu, and then click **New Data Source**.
3. In the **Welcome** dialog of the Data Source Wizard, click **Next**.
4. In the **Data Source** dialog, select DB2/MVS in the Data source platform list, select TCP/IP, and click **Next**.
5. In **TCP/IP Network Connection** dialog, enter an Address or alias (for example "SYS1"), enter a Port (for example "446"), and then click **Next**.
6. In the **DB2 Database** dialog, enter an Initial Catalog (for example "DSN1D037"), Package collection (for example "HISDEMO", Default schema (for example "HISDEMO", Default qualifier (for example "HISDEMO", and then click **Next**.
7. In the **Locale** dialog, select the **Host CCSID** (for example "EBCDIC - U.S./Canada [37]") and PC code page (for example "ANSI - Latin I [1252]"), and then click **Next**.
8. In the **Security** dialog, select **Single sign-on** from the **Security** method list, select the newly created **Affiliate Application** (for example "SYS1") from the Affiliate application list, and then click **Next**.
9. In the **Advanced Options** dialog, optionally select **Connection pooling**, and then click **Next**.
10. In the **All Properties** dialog, optionally verify the properties in the list, and then click **Next**.
11. In the **Validation** dialog, click **Connect**, and then verify the Output of the test connection.

    > Successfully connected to data source 'New Data Source'.  
    Server class: DB2/MVS  
    Server version: 09.01.0005

12. In the **Validation** dialog, optionally click **Packages**, and then verify the Output of the create package process. When prompted by the **Warning** dialog, click **Continue**.

    > Connected to data source 'New Data Source'.  
    READ COMMITTED package has been created.  
    READ UNCOMMITTED package has been created.  
    SERIALIZABLE package has been created.  
    REPEATABLE READ package has been created.  
    The package creation process has completed successfully.

13. In the **Validation** dialog, optionally click **Sample Query**, and then verify the results in the Grid, and then click **Next**.
14. In the **Saving Information** dialog, enter a Data source name (for example `DB2_IP_SYS1_DSN1D037_SSO`), click Universal data link and Initialization string file, and then click **Next**.
15. In the **Completing the Data Source Wizard** dialog, review what you have accomplished, and then click **Finish**.
16. In the **Data Access Tool**, click the newly created DB2 OLE DB UDL (for example `DB2_IP_SYS1_DSN1D037_SSO`), copy the Connection String (at bottom of Data Link Tool dialog) to the Windows clipboard.

    > Provider=DB2OLEDB;Initial Catalog=DSN1D037;Network Transport Library=TCPIP;Host CCSID=37;PC Code Page=1252;Network Address=SYS1;Network Port=446;Package Collection=HISDEMO;Default Schema=HISDEMO;Process Binary as Character=False;Connect Timeout=15;Units of Work=RUW;Default Qualifier=HISDEMO;DBMS Platform=DB2/MVS;Affiliate Application=SYS1;Use Early Metadata=False;Defer Prepare=False;DateTime As Char=False;Rowset Cache Size=0;Max Pool Size=100;Datetime As Date=False;AutoCommit=True;Authentication=Server;Integrated Security=SSPI;Persist Security Info=False;Cache Authentication=False;Connection Pooling=True;Derive Parameters=False;

To define an ESSO Affiliate Application for storing DB2 connection string, you must have access to an ESSO installation, in order to store a DB2 connection securely for use by multiple client programs and users.

1. On the **Start** menu, point to **All Programs**, point to **Enterprise Single Sign-On**, and click **SSO Administration**. When prompted by **User Access Control**, click **Yes**.
2. In the **Enterprise Single Sign-On** scope pane, of the ENTSSO MMC snap-in, click the **Affiliate Applications** folder; click the **Action** menu, and then **Create Application**.
3. In the **Enterprise Single Sign-On Application Wizard Welcome** dialog, click **Next**.
4. In the **General** dialog, enter an Application name (for example `SYS1_DSN1D037_ConnectionString`), click **Allow local accounts for access accounts**, click **Use SSO Affiliate Admin Accounts for Application Admin accounts**, and then click **Next**.
5. In the **Accounts** dialog, under the **Application Users** list, click **Add**.
6. In the **Select Users** or **Groups** dialog, enter a user account (for example, DOMAIN\username), click **Check Names**, and then click **OK**. Verify the account is added to the Application Users list, and then click **Next**.
7. In the **Options** dialog, verify the **Affiliate Application** is Enabled, and that **Allow Windows Initiated SSO** is selected, and then click **Next**.
8. In the **Fields** dialog, specify "3" (three) for the Number of fields, change the third-listed field item named "Field 2" label to "ConnString", and then click **Create**.
9. In the **Completing the Application Wizard** dialog, verify that you successfully created the Application, and then click **Finish**. If any errors occur, then contact your network administrator or client administrator.
10. In the **Enterprise Single Sign-On** scope pane, of the ENTSSO MMC snap-in, click the **Affiliate Applications** folder; click the newly created Affiliate Application (for example `SYS1_DSN1D037_ConnectionString`), click the **Action** menu, click **New Mapping**.
11. In the **Create New Mapping** dialog, enter a Windows user (for example, DOMAIN\username), enter an External user (for example "HISDEMO" account authorized to access `SYS1_DSN1D037_ConnectionString` DB2 server), click **Set credentials for new mapping**, and then click **OK**.
12. In the **Set Credentials** dialog, enter a valid DB2 server password (for example "HISDEMO") in the **Password and Confirm** edit boxes, paste the DB2 connection string from the Data Access Tool into the **ConnString** edit box, and then click **OK**.
13. In the **Enterprise Single Sign-On** scope pane, of the ENTSSO MMC snap-in, click the **Affiliate Applications** folder, verify the newly created **Affiliate Application** (for example **SYS1_DSN1D037_ConnectionString**) is Enabled. Click the **Affiliate Application** (for example **SYS1_DSN1D037_ConnectionString**), and verify in the results pane (list of Windows users on right side of dialog) is enabled.

To define a DB2 connection that retrieves connection string from SSO, you must define a DB2 connection string in order to use Windows-initiated SSO. You can define a connection string using the ADO.NET Data Provider for DB2 ConnectionString Builder. You can define a string manually with a text editor. You can define a connection string using OLE DB Data Links. You can define a connection string using the Data Source Wizard (DSW), within the Data Access Tool (DAT) or Visual Studio Server Explorer. In this task, we will use the latter approach of the DSW in the DAT.

1. On the **Start** menu, point to **All Programs**, point to HIS 2010, and click **Data Access Tool**. When prompted by **User Access Control**, click **Yes**.
2. In the **Data Access Tool**, click the **Data Sources**, click the **File** menu, and then click **New Data Source**.
3. In the **Welcome** dialog of the Data Source Wizard, click **Next**.
4. In the **Data Source** dialog, select DB2/MVS in the Data source platform list, select **TCP/IP**, and click **Next**.
5. In **TCP/IP Network Connection** dialog, enter *x* for Address or alias, and then click **Next**.
6. In the **DB2 Database** dialog, enter *x* for Initial Catalog and Package collection, and then click **Next**.
7. In the **Locale** dialog, click **Next**.
8. In the Security dialog, select Single sign-on from the Security method list, select the newly created Affiliate Application (for example `SYS1_DSN1D037_ConnectionString`) from the Affiliate application list, and then click **Next**.
9. In the**Advanced Options** dialog, click **Next**.
10. In the **All Properties** dialog, click **Next**.
11. In the **Validation** dialog, click **Connect**, and then verify the Output of the test connection.

    - Successfully connected to data source 'New Data Source'.
    - Server class: DB2/MVS
    - Server version: 09.01.0005

12. In the **Validation** dialog, optionally click **Packages**, and then verify the Output of the create package process. When prompted by the **Warning** dialog, click **Continue**.

    - Connected to data source 'New Data Source'.
    - READ COMMITTED package has been created.
    - READ UNCOMMITTED package has been created.
    - SERIALIZABLE package has been created.
    - REPEATABLE READ package has been created.
    - The package creation process has completed successfully.

13. In the **Validation** dialog, optionally click **Sample Query**, and then verify the results in the Grid, and then click **Next**.
14. In the **Saving Information** dialog, enter a Data source name (for example `DB2_IP_SYS1_DSN1D037_ConnectionString`), click Universal data link and Initialization string file, and then click **Next**.
15. In the **Completing the Data Source Wizard** dialog, review what you have accomplished, and then click **Finish**.
16. In the **Data Access Tool**, click the newly created DB2 OLE DB UDL (for example `DB2_IP_SYS1_DSN1D037_ConnectionString`), copy the Connection String (at bottom of **Data Link Tool** dialog) to the Windows clipboard.

    > DB2OLEDB;Initial Catalog=x;Network Transport Library=TCPIP;Host CCSID=37;PC Code Page=1252;Network Address=x;Network Port=446;Package Collection=x;Process Binary as Character=False;Units of Work=RUW;DBMS Platform=DB2/MVS;Affiliate Application=SYS1_DSN1D037_ConnectionString;Use Early Metadata=False;Defer Prepare=False;DateTime As Char=False;Rowset Cache Size=0;Datetime As Date=False;Auto-Commit=True;Authentication=Server;Decimal As Numeric=False;FastLoad Optimize=False;Derive Parameters=True;Integrated Security=SSPI;Persist Security Info=False;Cache Authentication=False;Connection Pooling=False;

> [!NOTE]
> The Data Source Wizard writes default values into Universal Data Link and connection string files. When using SSO-stored DB2 connection strings, you need to specify these properties only in your client program.

- Provider=DB2OLEDB (for OLE DB only)
- Integrated Security=SSPI
- Affiliate Application=SYS1_DSN1D037_ConnectionStrin
- Network Address=x;
- Initial Catalog=x;
- Package Collection=x;

Provider=DB2OLEDB;Integrated Security=SSPI;Initial Catalog=x;Network Address=x; Package Collection=x;Affiliate Application=SYS1_DSN1D037_ConnectionString
