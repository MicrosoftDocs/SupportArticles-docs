---
title: How to automate Excel from an HTML Web page by using JScript
description: Describes that how to automate Excel from an HTML Web page by using JScript.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft Excel
---

# How to automate Excel from an HTML Web page by using JScript

## Summary

This article demonstrates how to create and manipulate a Microsoft Office Excel workbook from an HTML page. 

## More Information

This article illustrates JScript code that automates Excel. JScript has no internal means of creating SAFEARRAYs. When using automation, if you call a function that requires a SAFEARRAY, you can use VBScript to create the SAFEARRAY. The code below demonstrates this combination of JScript and VBScript code. 

### Building the automation sample

1. Start Notepad.   
2. Paste the following code into Notepad. 
    ```javascript
    <HTML>
    <BODY>
    Press the button to start Excel and display quarterly data.
    <SCRIPT LANGUAGE="VBScript">
    Function CreateNamesArray()
    ' Create an array to set multiple values at once.
      Dim saNames(5, 2)
      saNames(0, 0) = "John"
    
    saNames(0, 1) = "Smith"
      saNames(1, 0) = "Tom"
      saNames(1, 1) = "Brown"
      saNames(2, 0) = "Sue"
      saNames(2, 1) = "Thomas"
      saNames(3, 0) = "Jane"
      saNames(3, 1) = "Jones"
      saNames(4, 0) = "Adam"
      saNames(4, 1) = "Johnson"
      CreateNamesArray = saNames
    End Function
    </SCRIPT>
    
    <SCRIPT LANGUAGE="JScript"> 
    function AutomateExcel()
    {
    
    // Start Excel and get Application object.
          var oXL = new ActiveXObject("Excel.Application");
    
    oXL.Visible = true;
    
    // Get a new workbook.
          var oWB = oXL.Workbooks.Add();
          var oSheet = oWB.ActiveSheet;
    
    // Add table headers going cell by cell.
          oSheet.Cells(1, 1).Value = "First Name";
          oSheet.Cells(1, 2).Value = "Last Name";
          oSheet.Cells(1, 3).Value = "Full Name";
          oSheet.Cells(1, 4).Value = "Salary";
    
    // Format A1:D1 as bold, vertical alignment = center.
          oSheet.Range("A1", "D1").Font.Bold = true;
          oSheet.Range("A1", "D1").VerticalAlignment =  -4108; //xlVAlignCenter
    
    // Create an array to set multiple values at once.
    
    // Fill A2:B6 with an array of values (from VBScript).
          oSheet.Range("A2", "B6").Value = CreateNamesArray();
    
    // Fill C2:C6 with a relative formula (=A2 & " " & B2).
          var oRng = oSheet.Range("C2", "C6");
          oRng.Formula = "=A2 & \" \" & B2";
    
    // Fill D2:D6 with a formula(=RAND()*100000) and apply format.
          oRng = oSheet.Range("D2", "D6");
          oRng.Formula = "=RAND()*100000";
          oRng.NumberFormat = "$0.00";
    
    // AutoFit columns A:D.
          oRng = oSheet.Range("A1", "D1");
          oRng.EntireColumn.AutoFit();
    
    // Manipulate a variable number of columns for Quarterly Sales Data.
          DispalyQuarterlySales(oSheet);
    
    // Make sure Excel is visible and give the user control
       // of Excel's lifetime.
          oXL.Visible = true;
          oXL.UserControl = true;
    }
    
    function DispalyQuarterlySales(oWS)
    {
          var iNumQtrs, sMsg, iRet;
    
    // Number of quarters to display data for.
          iNumQtrs = 4;
    
    // Starting at E1, fill headers for the number of columns selected.
          var oResizeRange = oWS.Range("E1", "E1").Resize(1,iNumQtrs);
          oResizeRange.Formula = "=\"Q\" & COLUMN()-4 & CHAR(10) & \"Sales\"";
    
    // Change the Orientation and WrapText properties for the headers.
          oResizeRange.Orientation = 38;
          oResizeRange.WrapText = true;
    
    // Fill the interior color of the headers.
          oResizeRange.Interior.ColorIndex = 36;
    
    // Fill the columns with a formula and apply a number format.
          oResizeRange = oWS.Range("E2", "E6").Resize(5,iNumQtrs);
          oResizeRange.Formula = "=RAND()*100";
          oResizeRange.NumberFormat = "$0.00";
    
    // Apply borders to the Sales data and headers.
          oResizeRange = oWS.Range("E1", "E6").Resize(6,iNumQtrs);
          oResizeRange.Borders.Weight = 2;  // xlThin
    
    // Add a Totals formula for the sales data and apply a border.
          oResizeRange = oWS.Range("E8", "E8").Resize(1,iNumQtrs);
          oResizeRange.Formula = "=SUM(E2:E6)";
        // 9 = xlEdgeBottom      
          oResizeRange.Borders(9).LineStyle = -4119; //xlDouble
          oResizeRange.Borders(9).Weight = 4; //xlThick
    
    // Add a Chart for the selected data.
    
    oResizeRange = oWS.Range("E2:E6").Resize(5,iNumQtrs);
          var oChart = oWS.Parent.Charts.Add();
          oChart.ChartWizard(oResizeRange, -4100, null, 2);  // -4100 = xl3dColumn
          oChart.SeriesCollection(1).XValues = oWS.Range("A2", "A6");
          for (iRet = 1; iRet <= iNumQtrs; iRet++) {
             oChart.SeriesCollection(iRet).Name = "=\"Q" + iRet + "\"";
          }
          oChart.Location(2, oWS.Name); // 2 = xlLocationAsObject
    
    // Move the chart so as not to cover your data.
          oWS.Shapes("Chart 1").Top = oWS.Rows(10).Top;
          oWS.Shapes("Chart 1").Left = oWS.Columns(2).Left;
    }
    </SCRIPT>
    <P><INPUT id=button1 type=button value="Start Excel" 
              onclick="AutomateExcel"></P>
    </BODY>
    </HTML>
    ```

3. Save the file to a directory of your choice with the file name Excelaut.htm.   
4. Close Notepad and start Internet Explorer.   
5. In the Address bar, type C:\**path**\excelaut.htm, where **path** is the directory you saved the file in.   
6. When Internet Explorer loads the file, you'll see one sentence with a button. When you press the button, Excel will start on the client's machine and fill with data.   

## References

This article parallels other articles that describe the same process using different languages. For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[219151](https://support.microsoft.com/help/219151) How to automate Microsoft Excel from Visual Basic

[179706](https://support.microsoft.com/help/179706) How to use MFC to automate Excel and create and format a new workbook

For more information about how to automate Excel from a HTML page, click the following article number to view the article in the Microsoft Knowledge Base:

[198703](https://support.microsoft.com/help/198703) How to automate Excel from a client-side VBScript

For more information about Office Automation, visit the following Microsoft Office Development support Web site: [Microsoft Support](https://support.microsoft.com/)