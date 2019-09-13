---
title: Automate Excel from MFC and Visual C++ to fill or obtain data using arrays
description: Describes how to automate Excel from Visual C++ 2005 or Visual C++ .NET to fill and retrieve values in a multi-cell range by using arrays.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft Excel
---

# How to automate Excel from MFC and Visual C++ 2005 or Visual C++ .NET to fill or obtain data in a range using arrays

For a Microsoft C# .NET version of this article, see [302096](https://support.microsoft.com/help/302096). 
For a Microsoft Visual Basic .NET version of this article, see [302094](https://support.microsoft.com/help/302094). 

> [!NOTE]
> Microsoft Visual C++ 2005, Microsoft Visual C++ .NET 2003, and Microsoft Visual C++ .NET 2002 support both the managed code model that is provided by the Microsoft .NET Framework and the unmanaged native Microsoft Windows code model. The information in this article applies only to unmanaged Visual C++ code.

## Summary

This step-by-step article demonstrates how to automate Microsoft Excel from Visual C++ 2005 or Visual C++ .NET to fill and retrieve values in a multi-cell range by using arrays.

### Create an Automation Client for Excel
 
To fill a multi-cell range without populating cells one at a time, you can set the Value property of a Range object to a two-dimensional array. Likewise, you can retrieve a two-dimensional array of values for multiple cells at once by using the Value property. The following steps demonstrate this process for both setting and retrieving data using two-dimensional arrays. 

1. Follow the steps in the "Create an Automation Client" section of the following Microsoft Knowledge Base article to create a basic Automation client: 

    [307473 ](https://support.microsoft.com/help/307473) How To Use a Type Library for Office Automation from Visual C++ .NET
 
    In step 3, add a second button and a check box to the form. Change the ID of the button to IDC_GETVALUES and the caption to Get Values. Change the ID of the check box to IDC_CHECK and the caption to Fill with Strings.

    In step 4 of the article, select "Microsoft Excel 10.0 Object Library" if you are automating Excel 2002 from Office XP. The default location for Excel 2002 is C:\Program Files\Microsoft Office\Office10\Excel.exe. Or, select "Microsoft Excel 11.0 Object Library" if you are automating Microsoft Office Excel 2003. The default location for Excel 2003 is C:\Program Files\Microsoft Office\Office11\Excel.exe. Select the following Microsoft Excel interfaces:

    - _Application   
    - _Workbook   
    - _Worksheet   
    - Range   
    - Workbooks   
    - Worksheets
   
   In step 6, add the following #include statements directly after the #pragma once directive in Autoprojectdlg.h:
    ```c
    #include "CApplication.h"
    #include "CRange.h"
    #include "CWorkbook.h"
    #include "CWorkbooks.h"
    #include "CWorksheet.h"
    #include "CWorksheets.h"
    
    ```

2. Add the following two public member variables to the CAutoProjectDlg class:
    ```c
    CApplication oExcel;
    CWorkbook oBook;
    
    ```

3. On your dialog box, right-click IDC_CHECK and select Add Variable. Name the variable m_bFillWithStrings and click Finish.   
4. On your dialog box, double-click Run and replace the following code
    ```c
    void CAutoProjectDlg::OnBnClickedRun()
    {
    // TODO: Add your control notification handler code here
    }
    
    ```
    with: 
    ```c
    void CAutoProjectDlg::OnBnClickedRun()
    {
    CWorkbooks oBooks;
    CWorksheets oSheets;
    CWorksheet oSheet;
    CRange oRange;
    COleVariant covOptional(DISP_E_PARAMNOTFOUND,VT_ERROR);
    
    // If you have not created Excel, create a new instance.
    if (oExcel.m_lpDispatch == NULL) {
    oExcel.CreateDispatch("Excel.Application");
    }
    // Show Excel to the user.
    oExcel.put_Visible(TRUE);
    oExcel.put_UserControl(TRUE);
    
    // Add a new workbook and get the first worksheet in that book.
    oBooks = oExcel.get_Workbooks();
    oBook = oBooks.Add(covOptional);
    oSheets = oBook.get_Worksheets();
    oSheet = oSheets.get_Item(COleVariant((short)1));
    
    // Get a range of data.
    oRange = oSheet.get_Range(COleVariant("A1"),covOptional);
    oRange = oRange.get_Resize(COleVariant((short)5),COleVariant((short)5));
    
    COleSafeArray saRet;
    DWORD numElements[2];
    numElements[0] = 5;
    numElements[1] = 5;
    
    long index[2];
    // Create a BSTR or double safe array.
    if (m_bFillWithStrings.GetCheck())
    saRet.Create(VT_BSTR,2,numElements);
    else
    saRet.Create(VT_R8,2,numElements);
    
    // Fill the array with data.
    for (int iRow = 1; iRow <= 5; iRow++) {
    for (int iCol = 1; iCol <= 5; iCol++) {
    index[0]=iRow-1;
    index[1]=iCol-1;
    if (m_bFillWithStrings.GetCheck()) {
    CString szTemp;
    szTemp.Format("%d|%d",iRow,iCol);
    BSTR bstr = szTemp.AllocSysString();
    saRet.PutElement(index,bstr);
    SysFreeString(bstr);
    } else {
    double d = iRow * iCol;
    saRet.PutElement(index,&d);
    }
    }
    }
    // Send the array to Excel.
    oRange.put_Value(covOptional,COleVariant(saRet));
    }
    
    ```
    **Note** In Visual C++ 2005, you must add the common language runtime support compiler option (/clr:oldSyntax) to successfully compile the previous code sample. To add the common language runtime support compiler option, follow these steps:

      1. Click **Project**, and then click **ProjectName Properties**.

         **Note** **ProjectName** is a placeholder for the name of the project.   
      2. Expand **Configuration Properties**, and then click **General**.

      3. In the right pane, click to select **Common Language Runtime Support, Old Syntax (/clr:oldSyntax)** in the **Common Language Runtime support** project settings.   
      4. Click **Apply**, and then click **OK**.

     For more information about common language runtime support compiler options, visit the following Microsoft Developer Network (MSDN) Web site: 

     [https://msdn.microsoft.com/en-us/library/k8d11d4s.aspx](https://msdn.microsoft.com/library/k8d11d4s.aspx)These steps apply to the whole article.   
       5. Return to your dialog box and double-click Get Values. Replace the following code
    ```c
    void CAutoProjectDlg::OnBnClickedGetvalues()
    {
    // TODO: Add your control notification handler code here
    }
    
    ```
     with: 
    ```c
    void CAutoProjectDlg::OnBnClickedGetvalues()
    {
    CWorksheets oSheets;
    CWorksheet oSheet;
    CRange oRange;
    COleVariant covOptional(DISP_E_PARAMNOTFOUND,VT_ERROR);
    
    // Make sure that Excel has been started.
    if (oExcel.m_lpDispatch == NULL) {
    AfxMessageBox("Excel has not been started.  Press button1 to start Excel.");
    return;
    }
    // Get the first worksheet.
    oSheets = oBook.get_Worksheets();
    oSheet = oSheets.get_Item(COleVariant((short)1));
    // Set the range of data to retrieve
       oRange = oSheet.get_Range(COleVariant("A1"),COleVariant("E5"));
    
    // Get the data.
    COleSafeArray saRet(oRange.get_Value(covOptional));
    
    long iRows;
            long iCols;
            saRet.GetUBound(1, &iRows);
            saRet.GetUBound(2, &iCols);
    
    CString valueString = "Array Data:\r\n";
    long index[2];
    // Loop through the data and report the contents.
    for (int rowCounter = 1; rowCounter <= iRows; rowCounter++) {
    for (int colCounter = 1; colCounter <= iCols; colCounter++) {
    index[0]=rowCounter;
    index[1]=colCounter;   
    COleVariant vData;
    saRet.GetElement(index,vData);
    CString szdata(vData);
                valueString += szdata;
    valueString += "\t";
    }
    valueString += "\r\n";
    }
    AfxMessageBox(valueString,MB_SETFOREGROUND,NULL);
    }
    
    ```

### Test the Automation Client

1. Press F5 to build and run the sample program.    
2. Click Run. The program starts Excel with a new workbook and populates cells A1:E5 of the first worksheet with numeric data from an array.    
3. Click Get Values. The program retrieves the data in cells A1:E5 into a new array and displays the results in a message box.   
4. Select Fill With Strings and click Run to fill cells A1:E5 with string data.   
5. Click Get Values to display the string values in a message box.   

### Troubleshooting
 
If you add class wrappers for the Excel object library by using the File option in the Add Class From TypeLib Wizard, you may receive an error message when you browse to the object library. To avoid this problem, type the full path and file name for the object library instead of browsing to the file. 
 
If you receive the following error message when you build your sample application, change "Variant DialogBox" in CRange.h to "Variant _DialogBox":

**warning C4003: not enough actual parameters for macro 'DialogBoxA'**

## References

For more information, see the following Microsoft Developer Network (MSDN) Web site: Microsoft Office Development with Visual Studio
[https://msdn.microsoft.com/en-us/library/aa188489(office.10).aspx](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx) 

For more information about using arrays to set and retrieve Excel data with earlier versions of Visual Studio, see the following Knowledge Base article: 

[247412](https://support.microsoft.com/help/247412) INFO: Methods for Transferring Data to Excel from Visual Basic