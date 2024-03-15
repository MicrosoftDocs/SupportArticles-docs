---
title: COM add-ins are not displayed in the COM Add-Ins dialog box
description: Works around an issue in which the COM Add-Ins dialog box in Excel 2013 and Excel 2016 does not display built-in COM add-ins as expected.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: lauraho, jenl
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Power BI for Microsoft 365
  - Excel 2016
  - Excel 2013
ms.date: 03/31/2022
---

# COM add-ins are not displayed in the COM Add-Ins dialog box in Excel 2013 and Excel 2016

## Symptoms

You try to enable one of the following COM add-ins installed with Microsoft Excel 2013 and Microsoft Excel 2016:

- Microsoft Office PowerPivot for Excel 2013 and Excel 2016
- Power View

To do this, you click Options, click Add-Ins, select **Com Add-Ins** in the Manage list, and then click **Go**. In this situation, the COM add-ins do not appear in the COM Add-Ins dialog box as expected.

## Cause

This issue occurs because the registry keys that provide the add-in information to the Add-in Manager are damaged or set to invalid values. See More Information for the Office 2013 and Office 2016 SKUs that contain these add-ins.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this issue, follow these steps to delete the affected registry keys:

1. Exit Excel 2013 or Excel 2016.
2. Start Registry Editor. To do this, use the appropriate method for your operating system, as follows:
   - In Windows 7, click **Start**, click **Run**, type **regedit**, and then click **OK**.
   - In Windows 8, click **Start**, type **regedit** in the **Start Search** box, and then press Enter.
3. Locate the registry keys that are described in the "Notes" section that follows this procedure.
4. Right-click the appropriate registry entry, and then click **Delete**.
5. Exit Registry Editor.
6. Start Excel 2013 or Excel 2016.
7. Follow the steps that are described in the "Symptoms" section to enable the add-in.

**Notes**

- Excel 2013 and Excel 2016 automatically rebuilds the registry keys.
- The registry keys that you have to delete vary, depending on the add-ins that you use. You have to delete the registry keys only for the add-in that is missing from the COM Add-Ins dialog box. Each add-ins corresponds to the following registry keys, respectively:

   Microsoft Office PowerPivot for Excel 2013 add-in

  - `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\User Settings\PowerPivotExcelAddin`
  - `HKEY_CURRENT_USER\Software\Microsoft\Office\Excel\Addins\PowerPivotExcelClientAddIn.NativeEntry.1`

   Microsoft Office PowerPivot for Excel 2016 add-in

  - ``HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\User Settings\PowerPivotExcelAddin``
  - ``HKEY_CURRENT_USER\Software\Microsoft\Office\Excel\Addins\PowerPivotExcelClientAddIn.NativeEntry.1``

   Power View add-in

  - ``HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\User Settings\PowerViewExcelAddin``
  - ``HKEY_CURRENT_USER\Software\Microsoft\Office\Excel\Addins\AdHocReportingExcelClientLib.AdHocReportingExcelClientAddIn.1``

## More Information

These add-ins and the Inquire add-in all require specific SKUs of Microsoft Office 2013 and Microsoft Office 2016. They are available on:

- Microsoft Office 2013 Professional Plus and Microsoft Office Professional Plus 2016
- Microsoft Microsoft 365 Apps for enterprise available as a standalone subscription.
- Microsoft Microsoft 365 Apps for enterprise available as part of the Office 365 Enterprise E3, Office 365 Enterprise E4, Office 365 Education E2, Office 365 Education E3, Office 365 Government E3, or Office 365 Government E4 offerings.
- Microsoft Excel 2013 standalone with the update: [Description of the Excel 2013 update: August 13, 2013](https://support.microsoft.com/help/2817425)

For more information about a COM add-in, see [What Is a COM Add-in?](https://msdn.microsoft.com/library/aa141383%28v=office.10%29.aspx).
