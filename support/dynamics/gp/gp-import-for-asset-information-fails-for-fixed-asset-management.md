---
title: GP Import for asset information fails
description: Describes that GP Import for asset information fails for Fixed Asset Management in Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# GP Import for asset information fails for Fixed Asset Management in Microsoft Dynamics GP

This article provides information about how to successfully asset information for Fixed Asset Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871638

## Symptoms

The asset information cannot be successfully imported into Microsoft Dynamics GP by using the Asset Import Utility for Fixed Assets Management.

## Cause

The import may fail for various reasons. Review the following guidelines to successfully import asset information.

The following guidelines apply to importing asset information into Fixed Assets Management:

- The import source file should be saved in a tab-delimited file or in a comma-delimited file. If you use Microsoft Office Excel to create a tab-delimited file, save the file as **Text (Tab delimited) (*.txt)-**.
- The Fixed Assets feature sorts the asset ID by the first character on the left. For example, if you use a numbering scheme, and if the assets are numbered 1 through 1,000, the following data is returned when you search for an asset:

  1, 10, 100, 2, 20, 200, and so on

  To force the program to sort numerically, each number must have leading zeros, as in the following example:
  
  00001, 00002, 00003

  The Asset ID field is an alphanumeric field. Type the asset IDs in all uppercase characters when you import the Asset Book information.

- Do not use the Table Import feature in Microsoft Dynamics GP. This feature is not supported for asset information.
- To save imported account numbers to the asset records, select **Require Accounts** in the **Fixed Assets Company Setup** dialog box. This option lets you import data from the **Payables/Purchase Order** dialog box. Also, this option lets you export data to the **General Ledger** dialog box. If you do not select **Require Accounts**, the account numbers will not be completely saved to the asset.
- When you import Asset Book information, do not select **Auto Add Book** in the **Fixed Assets Company Setup** dialog box. If you do select **Auto Add Book**, you may receive the following error message:

  > You have changed a depreciation sensitive field.

  If you receive this error message, the macro stops, and you must restart the import process.

  You cannot import new Asset General records or new Asset Book records over existing records. For example, if you try to import records, and the import fails, some assets may have been created in Fixed Assets. To import new Asset General records or new Asset Book records, use one of the following methods:

  - Method 1: If you cannot import data because the asset already exists, you can clear this asset from the system. For more information about this procedure, see [How to clear data for the Fixed Asset files in order to rerun an import in Fixed Assets in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-clear-data-for-the-fixed-asset-files-in-order-to-rerun-an-import-in-fixed-assets-in-microsoft-dynamics-gp-9c1ad552-14f5-0298-fffd-c380b3248be8).
  - Method 2: If you cannot import data because the asset already exists, you must restore the data from a backup. Or, you can remove the assets one at a time by using the Asset Delete utility. To use this utility, follow these steps:
    1. Use one of the following substeps as appropriate for your installation:
       - In Microsoft Dynamic GP 10.0 or in Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, and then point to **Utilities**.
       - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, select **Utilities** on the **Tools** menu.
    2. Select **Fixed Assets**, and then select **Delete**.
    3. Select the first asset to delete, and then select **Delete**.

- Do not use the following items during the import process:
  - A screen saver
  - Antivirus software
  - A mouse
  
  If you use any of these items, the macro stops, and you must restart the import process.
- Do not use a slash (/) or a hyphen (-) in the date fields. The import may fail if you use these characters.

  To format the date correctly when you use an Excel spreadsheet, you must set up a custom format for the cells. To do this, use the following custom formats:

  - January through September: 0#####
  - October through December: ######
- You cannot import retired assets. You can bring retired assets into the system as fully depreciated. But there is no field and no option that you can use to flag the assets as retired. You must perform the retirement process while the asset is in the system.
- Use Notepad to open a comma-delimited source file. When you use Excel to open the source file, Excel deletes any leading zeros that are in the asset IDs.
- Use different macros for each import.
- In the **Asset Import/Export** dialog box, select **Run macro after creation**, and then process the import. Or, you can manually run the macro. To do this, use one of the following substeps as appropriate for your installation:
  - In Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Macro**, and then select **Play**.
  - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, select **Tools**, select **Macro**, and then select **Play**.
- If you receive errors when you try to import data, examine the field in which the import process stopped. You may have to change this field in the imported file.
- You can also use Integration Manager in Microsoft Dynamics GP to import asset information.
- Setup information cannot be imported by using this import process. This import process is only for asset cards.
- If General Ledger is already updated for asset balances before the asset additions are run in Fixed Asset Management, make sure that you run the **FA to GL Posting** routine for these additions, and then delete the FATRX batch that is automatically created. Follow this step so that accounts in General Ledger are not overstated if the FATRX batch for asset addition is posted in error.
- If assets are imported, and the assets have a **Depreciated To Date** that falls in an FA calendar year, the **YTD Depreciation** field must also be included in the import.

## More information

For more information and guidelines about how to import asset information, see Chapter 7 in the FixedAssets.pdf. To locate this document, use one of the following methods:

- Method 1: In Microsoft Dynamics GP, select the **Help** button, select **Printable Manuals**, select **Financial**, and then select **Fixed Asset Management**.
- Method 2: Right-click the **Start Menu** to open Explorer, and locate the Documentation folder in the Microsoft Dynamics GP code folder. The default path of the document is `C:\\Program Files\Microsoft Dynamics\GP\Documentation\FixedAssets.pdf`.
