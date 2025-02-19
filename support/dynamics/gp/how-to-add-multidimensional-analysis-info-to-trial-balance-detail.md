---
title: Add Multidimensional Analysis info to Trial Balance Detail
description: How to add Multidimensional Analysis information to the Trial Balance Detail report in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# How to add Multidimensional Analysis information to the Trial Balance Detail report in Microsoft Dynamics GP

This article describes how to add Multidimensional Analysis information to the Trial Balance Detail report in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 862086

To add Multidimensional Analysis information to the Trial Balance Detail report, follow these steps.

## Step 1 - Back up the Reports.dic file, and then start Report Writer

1. If you have any modified Microsoft Dynamics GP reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

    1. Follow the appropriate step:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **Edit Launch File**.

    2. If you are prompted, type the system password.
    3. Follow the appropriate step:
        - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the Edit Launch File window.
    4. Note the path that appears in the **Reports** box.
    5. To close the Edit Launch File window, select **OK**.

2. Follow the appropriate step:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**.
   - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then select **Report Writer**.

3. Follow the appropriate step:
   - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.
   - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the **Product** list, and then select **OK**.

## Step 2 - Create table relationships

1. Select **Tables**, select **Tables**, select **GL_YTD_TRX_OPEN**, and then select **Open**.
2. In the Table Definition window, select **Relationships**.
3. In the Table Relationship window, select **New**.
4. In the Table Relationship Definition window, select the ellipsis button (...) that is next to the **Secondary Table** field, select **Transaction Analysis Groups**, and then select **OK**.
5. In the **Secondary Table Key** list, select **DTA_Trx_Groups_WORK_Key3**.
6. Select the account index in the **Primary Table** field to match the account index in the **Secondary Table** field, and then select **OK**.
7. Close the Table Relationship window.
8. Select **OK** to close the Table Relationship Definition window.
9. Select **OK** to close the Table Definition window.
10. Close the Tables window.
11. Select **Reports**, select **Trial Balance Detail** in the **Original Reports** list, and then select **Insert**.
12. In the **Modified Reports** list, select **Trial Balance Detail**, and then select **Open** to open the Report Definition window.
13. In the Report Definition window, select **Tables**.
14. In the Report Table Relationships window, select **Year-to-Date Transaction Open***, and then select **New**.
15. In the Related Tables window, select **Transaction Analysis Groups***, and then select **OK**.
16. In the Report Table Relationships window, select **Transaction Analysis Groups***, and then select **New**.
17. In the Related Tables window, select **Transaction Analysis Codes***, and then select **OK**.
18. In the Report Table Relationships window, select **Transaction Analysis Codes***, and then select **New**.
19. In the Related Tables window, select **Analysis Codes Master**, and then select **OK**.
20. In the Report Table Relationships window, select **Analysis Codes Master**, and then select **New**.
21. In the Related Tables window, select **Analysis Group Master**, and then select **OK**.

    The table hierarchy is displayed as follows:

    General Ledger Trial Balance Temporary

    - Account Master
    - Year-to-Date Transaction Open*  
    -- Transaction Analysis Groups*  
    --- Transaction Analysis Codes*  
    ---- Analysis Codes Master  
    ----- Analysis Group Master

22. Select **Close** to close the Report Table Relationships window.

## Step 3 - Create restrictions

1. In the Report Definition window, select **Restrictions**, and then select **New**.

2. In the Report Restriction Definition window, type *ACTINDX* in the **Restriction Name** field, select **Transaction Analysis Groups** in the **Report Table** field, select **Account Index** in the **Table Fields** field, select **Add Field**, select **=** under **Operators**, select **Year-to-Date Transaction Open** in the **Report Table** field, select **Account Index** in the **Table Fields** field, and then select **Add Field**.

   The restriction is displayed in the **Restriction Expression** field as follows:

   DTA_Transaction_Groups_WORK.Account Index = GL_YTD_TRX_OPEN.Account Index

3. Select **OK**.

4. In the Report Restrictions window, select **New**, type *IDENTITY* in the **Restriction Name** field, select **Transaction Analysis Codes** in the **Report Table** field, select **Account Index** in the **Table Fields** field, select **Add Field**, select **=** under **Operators**, and then select **Add Field**.

   The restriction is displayed in the **Restriction Expression** field as follows:

   DTA_Transaction_Codes_WORK.Account Index = DTA_Transaction_Codes_WORK.Account Index

5. Select **OK**.

6. In the Report Restrictions window, select **New**, type *MDA JOURNAL ENTRY* in the **Restriction Name** field, select **Transaction Analysis Groups** in the **Report Table** field, select **Journal Entry** in the **Table Fields** field, select **Add Field**, select **=** under **Operators**, select **Year-to-Date Transaction Open** in the **Report Table** field, select **Journal Entry** in the **Table Fields** field, and then select **Add Field**.

   The restriction is displayed in the **Restriction Expression** field as follows:

   DTA_Transaction_Groups_WORK.Journal Entry = GL_YTD_TRX_OPEN.Journal Entry

7. Select **OK**.
8. In the Report Restrictions window, select **New**, type SEQUENCE NUMBER in the **Restriction Name** field, select **(**, select **Transaction Analysis Groups** in the **Report Table** field, select **Sequence Number** in the **Table Fields** field, select **Add Field**, select **=** under **Operators**, select **Year-to-Date Transaction Open** in the **Report Table** field, select **Originating Sequence Number** in the **Table Fields** field, select **Add Field**, and then select **)**.

9. Select **OR**, select **(**, select **Transaction Analysis Groups** in the **Report Table** field, select **Sequence Number** in the **Table Fields** field, select **Add Field**, select **=** under **Operators**, select **Year-to-Date Transaction Open** in the **Report Table** field, select **Sequence Number** in the **Table Fields** field, select **Add Field**, and then select **)**.

   The restriction is displayed in the **Restriction Expression** field as follows:

   (DTA_Transaction_Groups_WORK.Sequence Number = GL_YTD_TRX_OPEN.Originating Sequence Number) OR (DTA_Transaction_Groups_WORK.Sequence Number = GL_YTD_TRX_OPEN.Sequence Number)

10. Select **OK**, and then close the Report Restrictions window.

## Step 4 - Override the built-in sort that is used by the report

1. In the Report Definition window, select **Sort**.
2. In the Sorting Definition window, select **General Ledger Trial Balance Temporary** in the **Report Table** field, select **Account Number** in the **Table Fields** list, and then select **Insert**.
3. Select **Year-to-Date Transaction Open** in the **Report Table** field, select **TRX Date** in the **Table Fields** list, select **Account Number of table General Ledger Trial Balance Temporary** in the **Sort By** list, and then select **Insert**.
4. Select **Year-to-Date Transaction Open** in the **Report Table** field, select **Journal Entry** in the **Table Fields** list, select **TRX Date of table Year-to-Date Transaction Open** in the **Sort By** list, and then select **Insert**.
5. Select **Transaction Analysis Groups** in the **Report Table** field, select **Sequence Number** in the **Table Fields** list, select **Journal Entry of table Year-to-Date Transaction Open** in the **Sort By** list, and then select **Insert**.
6. Select **Transaction Analysis Groups** in the **Report Table** field, select **DTA_Group_ID** in the **Table Fields** list, select **Sequence Number of table Transaction Analysis Groups** in the **Sort By** list, and then select **Insert**.
7. Select **Transaction Analysis Codes** in the **Report Table** field, select **DTA_Code_ID** in the **Table Fields** list, select **DTA_Group_ID of table Transaction Analysis Groups** in the **Sort By** list, and then select **Insert**.

   The **Sort By** list is displayed as follows:

   Account Number of table General Ledger Trial Balance Temporary  
   TRX Date of table Year-to-Date Transaction Open  
   Journal Entry of table Year-to-Date Transaction Open  
   Sequence Number of table Transaction Analysis Groups  
   DTA_Group_ID of table Transaction Analysis Groups  
   DTA_Code_ID of table Transaction Analysis Codes

8. Select **OK**.
9. Select **OK** to close the Report Definition window.

## Step 5 - Open the report, and then create two calculated fields in the report layout

1. In the Report Definition window, select **Layout**.
2. In the Toolbox window, select **Calculated Fields** in the list, and then select **New**.
3. In the Calculated Field Definition window, type MDA CODE in the **Name** box, select **String** in the **Result Type** field, and then select **Conditional** in the **Expression Type** area.
4. Select the **Conditional** section, select **Transaction Analysis Codes** in the **Resources** field on the **Fields** tab, select **DTA_Code_ID** in the **Field** field, and then select **Add**.
5. Under **Operators**, select **=**.
6. Select the **Constants** tab, select **String** in the **Type** field, and then select **Add**.

   The **Conditional** section is displayed as follows:

   DTA_Transaction_Codes_WORK.DTA_Code_ID = ""
7. Select the **True Case** section, select the **Constants** tab, select **String** in the **Type** field, and then select **Add**.

   The **True Case** section is displayed as follows:""
8. Select the **False Case** section, select the **Fields** tab, select **Transaction Analysis Codes** in the **Resources** field, select **DTA_Code_ID** in the **Field** field, and then select **Add**.

   The **False Case** section is displayed as follows:

   DTA_Transaction_Codes_WORK.DTA_Code_ID

9. Select **OK**.
10. In the Toolbox window, make sure that **Calculated Fields** is still selected in the list.
11. Select **New**.
12. Type MDA GROUP in the **Name** box, select **String** in the **Result Type** field, and then select **Conditional** in the **Expression Type** area.
13. Select the **Conditional** section, select **Transaction Analysis Groups** in the **Resources** field on the **Fields** tab, select **DTA_Group_ID** in the **Field** field, and then select **Add**.
14. Under **Operators**, select **=**.
15. Select the **Constants** tab, select **String** in the **Type** field, and then select **Add**.

    The **Conditional** section is displayed as follows:

    DTA_Transaction_Groups_WORK.DTA_Group_ID = ""
16. Select the **True Case** section, select the **Constants** tab, select **String** in the **Type** field, and then select **Add**.

    The **True Case** section is displayed as follows:""

17. Select the **False Case** section, select the **Fields** tab, select **Transaction Analysis Groups** in the **Resources** field, select **DTA_Group_ID** in the **Field** field, and then select **Add**.

    The **False Case** section is displayed as follows:

    DTA_Transaction_Groups_WORK.DTA_Group_ID.

18. Select **OK**.

## Step 6 - Add new sections to the report

1. With the Report Layout window still appearing, select **Tools**, and then select **Section Options**.
2. In the Report Section Options window, select **Account Number** in the **Additional Headers** list, and then select **New**.
3. In the Header Options window, type *JOURNAL ENTRY* in the **Header Name** box, select **Year-to-Date Transaction Open** in the **Report Table** field, select **Journal Entry** in the **Field** list, and then select **OK**.
4. Select **JOURNAL ENTRY** in the **Additional Headers** list, and then select **New**.
5. In the Header Options window, type *MDA GROUP* in the **Header Name** box, select **Transaction Analysis Groups** in the **Report Table** field, select **DTA_Group_ID** in the **Field** list, select to select the **Suppress When Field Is Empty** check box, select **MDA GROUP** in the **Calculated Field** list, and then select **OK**.

6. In the Report Section Options window, select **MDA GROUP** in the **Additional Headers** list, and then select **New**.

7. In the Header Options window, type *MDA CODE* in the **Header Name** box, select **Transaction Analysis Codes** in the **Report Table** field, select **DTA_CODE_ID** in the **Field** list, select to select the **Suppress When Field Is Empty** check box, select **MDA CODE** in the **Calculated Field** list, and then select **OK**.

8. In the **Additional Footers** section, select **New**.
9. In the Footer Options window, type *SEQUENCE NUMBER* in the **Footer Name** box, select **Transaction Analysis Groups** in the **Report Table** field, select **Sequence Number** in the **Field** List, and then select **OK**.

10. In the Report Section Options window, select **OK**.
11. Drag each field in the **B** (Body) section of the report to the **H2** section.
12. After you move each field to the **H2** section, select **Tools**, select **Section Options**, select to clear the **Body** check box, and then select **OK**.
13. In the Toolbox window, select **Calculated Fields** in the list, and then drag the **MDA GROUP** calculated field to the **H3** section of the report.
14. In the Toolbox window, select **Calculated Fields** in the list, and then drag the **MDA CODE** calculated field to the **H4** section of the report.
15. In the Toolbox window, select **Transaction Analysis Groups** in the list, and then drag the **DTA_Group_Amount** field to **H3** section of the report.
16. In the Toolbox window, select **Transaction Analysis Codes** in the list, and then drag the **DTA_Amount** field to the **H4** section of the report.
17. To add text fields to the report, select **A** in the Toolbox window, select the report layout where you want to put the text field, and then type the text of the field.
18. Close the Report Layout window, and then select **Save**.
19. In the Report Definition window, select **OK**.
20. Exit Report Writer. To do this, follow the appropriate step:

    - In Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** on the **File** menu.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 7 - Assign security permissions to the modified report

### Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. If you are prompted, type the system password in the **Please Enter Password** box, and then select **OK**.
3. In the ID box, type the Alternate/Modified Forms and Reports ID that is associated with the user ID that will print this modified report.
4. In the **Product** list, select **Microsoft Dynamics GP**.
5. In the **Type** list, select **Reports**.
6. Expand **Financials**.
7. Expand the folder of the report that you modified.
8. Select **Microsoft Dynamics GP (Modified)**.
9. Select **Save**.
10. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
11. In the **User** list, select a user ID.
12. In the **Company** list, select a company.
13. In the **Alternate/Modified Forms and Reports ID** list, select the ID from step 3.
14. Select **Save**.

### Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

#### Method 1: Use the Advanced Security tool

1.On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
2.If you are prompted, type the system password in the **Please Enter Password** box, and then select **OK**.
3.In the Advanced Security window, select **View**, and then select **By Alternate, Modified and Custom**.

4.Use the appropriate method:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.

5.Expand **Reports**, expand **Financials**, and then expand the report that you modified.

6.Use the appropriate method:
    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**.

7.Select **Apply**, and then select **OK**.

> [!NOTE]
> By default, the current user and the current company are selected when you start the Advanced Security tool. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.

#### Method 2: Use the Standard Security tool

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.
2. If you are prompted, type the system password in the **Please Enter Password** box, and then select **OK**.
3. In the **User ID** list, select the ID of the user who you want to have access to the modified report.
4. In the **Type** list, select **Modified Reports**.
5. In the **Series** list, select **Financials**.
6. In the **Access List** box, double-select the report that you modified, and then select **OK**.

    > [!NOTE]
    > An asterisk (*) appears next to the report name.
