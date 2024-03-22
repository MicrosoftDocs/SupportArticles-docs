---
title: PurchaseOrderDetail package for Analysis Cubes may not load all Purchase Orders
description: Describes an issue where the Purchase Orders may be missing from Analysis Cubes for Dynamics GP. Provides a solution.
ms.topic: troubleshooting
ms.reviewer: theley, kellybj, kevogt
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# PurchaseOrderDetail package for Analysis Cubes may not load all Purchase Orders

This article provides a solution to an issue where the Purchase Orders may be missing from Analysis Cubes for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2851158

## Symptoms

Purchase Orders are missing from Analysis Cubes for Dynamics GP.

## Cause

This is caused by a bug in the PurchaseOrderDetail SSIS package that runs during the data load from Dynamics GP to the Analysis Cubes Data Warehouse database. The bug occurs due to a timestamp comparison on the LastUpdated timestamp and LSTEDTDT/CREATDDT/DOCDATE of the Purchase Order detail line in the Dynamics GP database. The timestamp in the LastUpdated value includes HH:MM:SS whereas the LSTEDTDT/CREATDDT/DOCDATE does not. This difference can cause Purchase Orders to not be included in Analysis Cubes.

## Resolution

Use the following steps to resolve this issue:

1. Open SQL Server Business Intelligence Development Studio (BIDS).
2. Click **File**, point to **New**, and then select **Project...**.
3. Click **OK**.
4. Right-click SSIS Packages folder in the **Solution Explorer** pane and then select **Add Existing Package**.
5. Choose SSIS Package Store for the **Package Location**.
6. Type in the SQL server name where the Analysis Cubes SSIS packages reside into the **Server** field.
7. Choose the Authentication type and type in a user if required.
8. Click the ellipses button next to the **Package path** field.
9. Expand MSDB.
10. Expand your Analysis Cubes SSIS folder.
11. Locate the SSIS package that ends with "PurchaseOrderDetail". Select it and then click **OK**.
12. Click **OK**.
13. Double-click the PurchaseOrderDetail SSIS package in the **Solution Explorer** pane.
14. Double-click the icon inside the Copy Data from Results to PendingPurchaseOrders Task to open that task.
15. Double-click the icon inside the OLE DB Source entity.
16. Copy the contents of the SQL command text section into a text editor, such as Notepad.
17. In the text editor, use the Replace function to replace `select @lastdate = DateUpdated from [DynamicsGPWarehouse].[dbo].[LastUpdated] where CompanyID = @CompID and TableName = 'PurchaseOrderDetail'` with `select @lastdate = convert(char(12),DateUpdated,101) from [DynamicsGPWarehouse].[dbo].[LastUpdated] where CompanyID = @CompID and TableName = 'PurchaseOrderDetail'`.
18. Go back to BIDS and select all of the text inside the SQL command text section and then press the Delete key to remove the text.
19. Copy the updated text from the text editor into the SQL command text section.
20. Click the **Parse Query** button. If the query was not parsed successfully, the text was not updated correctly or copied back correctly. Click **Cancel** on the OLE DB Source Editor window and retry steps 15-20.
21. Save the changes to the PurchaseOrderDetail SSIS package in BIDS.
22. Open SQL Server Management Studio and then connect to the SSIS instance where the Analysis Cubes packages are located.
23. Expand the **Stored Packages** folder.
24. Expand MSDB.
25. Right-click the Analysis Cubes SSIS folder and then select **Import Package**.
26. Choose **File System** for the Package location.
27. Click the ellipses button next to **Package Path**.
28. Locate and select the SSIS package file you saved in step 21 and then click **Open**.
29. Click **OK**.
30. Click **Yes** to overwrite.
