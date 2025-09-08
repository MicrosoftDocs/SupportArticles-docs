---
title: Using Microsoft Management Reporter Migration Wizard
description: Describes information on the Migration Wizard in Microsoft Management Reporter.
ms.reviewer: theley, kevogt
ms.date: 04/17/2025
ms.custom: sap:Financial - Management Reporter
---
# Information on using the Microsoft Management Reporter Migration Wizard

This article provides more information on using the Microsoft Management Reporter Migration Wizard.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2425087

## Symptoms

When you use the Migration Wizard in Microsoft Management Reporter to migrate your FRx reports, you receive an error or not all the information is migrated. The reports and building blocks may be missing some information after they're migrated to Management Reporter.

## Cause

Microsoft FRx data may be damaged. Management Reporter won't migrate all information from FRx because of differences in the two products.

## More information

Migration preparation

> [!NOTE]
>
> 1. The Migration Wizard will help you get started with converting existing reports but it not intended to handle all scenarios.
> 2. Before proceeding with the cleanup and migration, browse to the shared SysData directory and back up this folder. You can confirm the location of this directory in FRx Report Designer under **Admin** > **Organization** > **SysData**.

- Remove any companies that are currently not in use. The demo companies such as FW, FWC, or SolDemo won't upgrade and must be removed.
- If multiple companies are migrated and reports are shared between them, verify that the segment names within Microsoft Dynamics GP are the same. In Microsoft Dynamics GP go to **Tools** > **Setup** > **Company** > **Account Forma**. Make sure the Name of each segment matches between all companies.
- Remove all specification sets from **Company** > **Specification Sets** that aren't assigned to a company under **Company** > **Information**.
- Remove any unneeded or unused building blocks (catalogs, rows, columns, and trees).
- Remove spaces found at the beginning of building block names.
- Rows, columns, and trees that aren't associated with a catalog will migrate, however they'll be missing the dimension codes. To get the dimension codes to migrate, a common approach is to create dummy catalogs in FRx that can be linked to the unassociated rows, columns, and trees. After the migration, the dummy catalogs (now called Report Definitions) can be removed.
- In each catalog, check the Company field. If any are set to @ANY, change this to an actual company. Failure to do this will cause the dimension codes to disappear during the migration.
- Close FRx, browse to the SysData directory, delete all files that end with `.G32`, start FRx, and then log into each company to re-create the files.
- Close FRx, browse to the SysData directory, and delete all files that don't have one of the following extensions:
  - `.cfg`
  - `.dax`
  - `.f32`
  - `.g32`
  - `.mdb`
  - `.pmm`
  - `.tpl`
- Close FRx, browse to the SysData directory, and delete all folders other than these:

  LogFiles  
  Report Book Design Files
- Close FRx, browse to the SysData directory, and delete any `.F32` files that aren't currently used by a specification set. Check the Location field under **Company** > **Specification Sets** to confirm.
- Compact the specification sets:

  1. Have one user log into a company in FRx.
  2. Select **File** > **Compact FRx Database** > **Current Spec Set Database**.
  3. Select **Yes** and then **OK** when complete.
  4. Repeat Steps 1 through 3 while logged into each remaining company.

Migrating FRx 6.7 data

It's assumed that Management Reporter is up and running correctly before you begin the migration process. Confirm this by logging into each company in Report Designer and creating a test report. Check the Management Reporter Configuration Console for any errors in the Service or Data Mart Logs section. If you find any problems, correct them or contact support for further assistance before attempting the migration.

For the migration process, follow the **Migrate the data** section in MRforDynERPInstGuide.pdf available here: [Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916)

Migration limitations

The followings items won't migrate:

FRx Report Designer

- FRx Security

Reports

- Report chains
- Locked or password protected rows
- Web publishing settings
- Page breaks between units
- Allow column text overflow
- Effective dates
- Subtotal and filter account detail
- Email
- Currency Translation rates

Rows

- Account sets
- Account Types
- Currency format codes
- Row linking
- XBRL link
- Locked or password protected rows

Columns

- XBRL column
- Locked or password protected columns

Trees

- Page breaks
- Locked or password protected trees
- E-mail/Security (Column P)
- Additional Text (Column Z)
- If you have one segment with one or more ampersand characters '&' and one or more question marks '?', such as '&&???', then Management Reporter will return no data for that specific unit. A special character that is used to identify which dimensions or segments in a chart of accounts should be selected when you use the Insert Rows from Dimension function. This default selection is the natural account, but any combination of account and dimensions can be selected.

Items that need to be manually configured once the migration completes

- In the migration of reports, catalogs default options will change so that reports won't open automatically when generated. To modify reports in Management Reporter to automatically open when generated, go to **Report Definitions**, select the **Output and Distribution** tab, under **Other options**, select the option **View report** when generated.
- To update all Report Definitions, run the following SQL Statement against the Management Reporter database.
  - CU12 or prior

    ```sql
    UPDATE ControlReport SET ActivateBrowser = 1
    ```

  - CU13

    ```sql
    UPDATE Reporting.ControlReport SET ActivateBrowser = 1
    ```

- In row migration, NP DES or NP REM rows in FRx that aren't FD, TOT, or CAL will migrate but will flag errors. The error will read **Print control options can only be used if the format code is TOT, CAL, or blank**.
- Column ranges won't be allowed in calculations.
- A WKS or a CALC column with headers will migrate but won't validate. Remove headers.
- Period ranges only work with PERIODIC columns. For example, any range such as 1:BASE YTD in a column must be set to 1:BASE PERIODIC.
- In the migration of trees, when there's an unknown company message, @ANY will be used for the company.
- Different row definitions specified in the reporting tree will have errors. You'll need to use the same row format or remove all row formats to use the default specified in the report definition.

Known issues when you use Microsoft Dynamics products:

- Migrated reports won't open when generated without opening through Report Library. Select the **View report** when generated option under **Output and Distribution** tab in the **Report Definitions**. In the Specify Connection window of the Migration Wizard, if you type in the wrong SQL Server name for the ManagementReporter database the Migration Wizard will be unresponsive for 10 minutes before being able to be reentered.
- In the Select FRx Data window of the Migration Wizard, you may not be able to see the ellipsis **...** button next to the field Path to the FRx 6.7 FRxSys32.mdb file.
- If you choose only validate building blocks using cached credentials in the Migration Wizard after you've already completed only migrate and convert your FRx 6.7 data, the conversion will fail. Users will need to reenter the credentials and attempt validation again.
- If the Migration Wizard isn't at the same version as the Application Server the Migration Wizard will crash.
- BXB and BXC may cause report generation errors in a report migrated from FRx.
- Open the associated Row Definition and select **File** > **Save As**.

  Give the Row Definition a new name and generate the report again with the new Row Definition.

  Delete the original Row Definition.

Known Migration issues when you use Microsoft Dynamics AX 2009

- A row with all wildcards to represent all accounts will migrate as a blank line.
- A column with attribute filters will need those attribute filters removed before migration in order to be able to open the migrated column without error.
- A column containing budget book codes in FRx will need their names changed to remove the word *Budget* before the budget name.
- The base period can reference different periods in some scenarios and should be validated in migrated reports that span multiple years.
- Migrated accounts and dimensions aren't trimmed to remove trailing white space.
- A row containing all questions marks (??????) won't migrate. After migration the row will need to be manually updated to `??????` for six character accounts, or an asterisk (*) to wildcard all accounts.

Troubleshooting:

- No General Ledger/Dimension accounts display after the migration can indicate possible corruption in the f32 report file.

Follow these steps to re-create your F32 reports file as there could be data corruption within the F32 report file causing the error message.

> [!NOTE]
> You should have all users close out of FRx.

1. To export the Catalog, begin by going to **Company** > **Specification Set**.
2. Select the Specification Set from which you want to export the report.
3. When the Specification Set has been selected, select the Export button.
4. In the Export Selection dialog box, select the **Catalogs** and select all. Select the tabs for **Rows**, **Columns**, and **Trees** and select all for each tab.
5. Select **Export**.
6. In the Create Export File dialog box, select the **Drive**, **Folder**, and **File Name** where you want to export the Catalog(s). The file has to be saved with a `.TDB` (temporary database) extension.
7. Select OK.
8. To import the Catalog, begin by going to **Company** > **Specification Set**.
9. Select the New button to create a new Specification Set. You must use a different Name. However, this can be renamed later after you delete the old Specification Set. Make sure that the Location points to a new *.F32 called MRFrxrpts.f32. You should leave the path the same merely rename the frxrpts.f32 file.
10. Select the **Import** button.
11. In the Select Import File dialog box, select the **Drive**, **Folder**, and **File name** where the*.TDB file was saved.
12. Select **OK**.
13. Select **Company** > **Information** and select the company that you want to use the new Specification Set with.

> [!NOTE]
> If you are unable to create a new report file, please contact support.

For more information about how to migrate to MR, use the following link to review the Management Reporter Migration document.

[Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916)

Select the MRforDynERPMigrfromFRxGuide_ENUS.pdf document.
