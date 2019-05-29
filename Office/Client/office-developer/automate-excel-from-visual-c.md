---
title: How to automate Microsoft Excel from Microsoft Visual C#.NET
description: 
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to automate Microsoft Excel from Microsoft Visual C#.NET

## Summary

This article demonstrates how to create an Automation client for Microsoft Excel by using Microsoft Visual C# .NET. 

## More Information

Automation is a process that permits applications that are written in languages such as Visual C# .NET to programmatically control other applications. Automation to Excel permits you to perform actions such as creating a new workbook, adding data to the workbook, or creating charts. With Excel and other Microsoft Office applications, virtually all of the actions that you can perform manually through the user interface can also be performed programmatically by using Automation.

Excel exposes this programmatic functionality through an object model. The object model is a collection of classes and methods that serve as counterparts to the logical components of Excel. For example, there is an Application object, a Workbook object, and a Worksheet object, each of which contain the functionality of those pieces of Excel. To access the object model from Visual C# .NET, you can set a project reference to the type library.

This article demonstrates how to set the proper project reference to the Excel type library for Visual C# .NET and provides sample code to automate Excel. 

### Create an Automation Client for Microsoft Excel

1. Start Microsoft Visual Studio .NET.   
2. On the File menu, click New, and then click Project. Select Windows Application from the Visual C# Project types. Form1 is created by default.   
3. Add a reference to the Microsoft Excel Object Library. To do this, follow these steps: 

   1. On the Project menu, click Add Reference.   
   2. On the COM tab, locate Microsoft Excel Object Library, and click Select.

   **Note** Microsoft Office 2003 includes Primary Interop Assemblies (PIAs). Microsoft Office XP does not include PIAs, but they can be downloaded. 

   3. Click OK in the Add References dialog box to accept your selections. If you are prompted to generate wrappers for the libraries that you selected, click Yes.   
   
4. On the View menu, select Toolbox to display the toolbox, and then add a button to Form1.   
5. Double-click Button1. The code window for the form appears.   
6. In the code window, replace the following code:

   ```c
   private void button1_Click(object sender, System.EventArgs e)
   {
   }
   ```
   with: 

   ```c
   private void button1_Click(object sender, System.EventArgs e)
   {
   Excel.Application oXL;
   Excel._Workbook oWB;
   Excel._Worksheet oSheet;
   Excel.Range oRng;

   try
   {
   //Start Excel and get Application object.
   oXL = new Excel.Application();
   oXL.Visible = true;

   //Get a new workbook.
   oWB = (Excel._Workbook)(oXL.Workbooks.Add( Missing.Value ));
   oSheet = (Excel._Worksheet)oWB.ActiveSheet;

   //Add table headers going cell by cell.
   oSheet.Cells[1, 1] = "First Name";
   oSheet.Cells[1, 2] = "Last Name";
   oSheet.Cells[1, 3] = "Full Name";
   oSheet.Cells[1, 4] = "Salary";

   //Format A1:D1 as bold, vertical alignment = center.
   oSheet.get_Range("A1", "D1").Font.Bold = true;
   oSheet.get_Range("A1", "D1").VerticalAlignment = 
   Excel.XlVAlign.xlVAlignCenter;

   // Create an array to multiple values at once.
   string[,] saNames = new string[5,2];

   saNames[ 0, 0] = "John";
   saNames[ 0, 1] = "Smith";
   saNames[ 1, 0] = "Tom";
   saNames[ 1, 1] = "Brown";
   saNames[ 2, 0] = "Sue";
   saNames[ 2, 1] = "Thomas";
   saNames[ 3, 0] = "Jane";
   saNames[ 3, 1] = "Jones";
   saNames[ 4, 0] = "Adam";
   saNames[ 4, 1] = "Johnson";

   //Fill A2:B6 with an array of values (First and Last Names).
        oSheet.get_Range("A2", "B6").Value2 = saNames;

   //Fill C2:C6 with a relative formula (=A2 & " " & B2).
   oRng = oSheet.get_Range("C2", "C6");
   oRng.Formula = "=A2 & \" \" & B2";

   //Fill D2:D6 with a formula(=RAND()*100000) and apply format.
   oRng = oSheet.get_Range("D2", "D6");
   oRng.Formula = "=RAND()*100000";
   oRng.NumberFormat = "$0.00";

   //AutoFit columns A:D.
   oRng = oSheet.get_Range("A1", "D1");
   oRng.EntireColumn.AutoFit();

   //Manipulate a variable number of columns for Quarterly Sales Data.
   DisplayQuarterlySales(oSheet);

   //Make sure Excel is visible and give the user control
   //of Microsoft Excel's lifetime.
   oXL.Visible = true;
   oXL.UserControl = true;
   }
   catch( Exception theException ) 
   {
   String errorMessage;
   errorMessage = "Error: ";
   errorMessage = String.Concat( errorMessage, theException.Message );
   errorMessage = String.Concat( errorMessage, " Line: " );
   errorMessage = String.Concat( errorMessage, theException.Source );

   MessageBox.Show( errorMessage, "Error" );
   }
   }

   private void DisplayQuarterlySales(Excel._Worksheet oWS)
   {
   Excel._Workbook oWB;
   Excel.Series oSeries;
   Excel.Range oResizeRange;
   Excel._Chart oChart;
   String sMsg;
   int iNumQtrs;

   //Determine how many quarters to display data for.
   for( iNumQtrs = 4; iNumQtrs >= 2; iNumQtrs--)
   {
   sMsg = "Enter sales data for ";
   sMsg = String.Concat( sMsg, iNumQtrs );
   sMsg = String.Concat( sMsg, " quarter(s)?");

   DialogResult iRet = MessageBox.Show( sMsg, "Quarterly Sales?", 
   MessageBoxButtons.YesNo );
   if (iRet == DialogResult.Yes)
   break;
   }

   sMsg = "Displaying data for ";
   sMsg = String.Concat( sMsg, iNumQtrs );
   sMsg = String.Concat( sMsg, " quarter(s)." );

   MessageBox.Show( sMsg, "Quarterly Sales" );

   //Starting at E1, fill headers for the number of columns selected.
   oResizeRange = oWS.get_Range("E1", "E1").get_Resize( Missing.Value, iNumQtrs);
   oResizeRange.Formula = "=\"Q\" & COLUMN()-4 & CHAR(10) & \"Sales\"";

   //Change the Orientation and WrapText properties for the headers.
   oResizeRange.Orientation = 38;
   oResizeRange.WrapText = true;

   //Fill the interior color of the headers.
   oResizeRange.Interior.ColorIndex = 36;

   //Fill the columns with a formula and apply a number format.
   oResizeRange = oWS.get_Range("E2", "E6").get_Resize( Missing.Value, iNumQtrs);
   oResizeRange.Formula = "=RAND()*100";
   oResizeRange.NumberFormat = "$0.00";

   //Apply borders to the Sales data and headers.
   oResizeRange = oWS.get_Range("E1", "E6").get_Resize( Missing.Value, iNumQtrs);
   oResizeRange.Borders.Weight = Excel.XlBorderWeight.xlThin;

   //Add a Totals formula for the sales data and apply a border.
   oResizeRange = oWS.get_Range("E8", "E8").get_Resize( Missing.Value, iNumQtrs);
   oResizeRange.Formula = "=SUM(E2:E6)";
   oResizeRange.Borders.get_Item( Excel.XlBordersIndex.xlEdgeBottom ).LineStyle 
   = Excel.XlLineStyle.xlDouble;
   oResizeRange.Borders.get_Item( Excel.XlBordersIndex.xlEdgeBottom ).Weight 
   = Excel.XlBorderWeight.xlThick;

   //Add a Chart for the selected data.
   oWB = (Excel._Workbook)oWS.Parent;
   oChart = (Excel._Chart)oWB.Charts.Add( Missing.Value, Missing.Value, 
   Missing.Value, Missing.Value );

   //Use the ChartWizard to create a new chart from the selected data.
   oResizeRange = oWS.get_Range("E2:E6", Missing.Value ).get_Resize( 
   Missing.Value, iNumQtrs);
   oChart.ChartWizard( oResizeRange, Excel.XlChartType.xl3DColumn, Missing.Value,
   Excel.XlRowCol.xlColumns, Missing.Value, Missing.Value, Missing.Value, 
   Missing.Value, Missing.Value, Missing.Value, Missing.Value );
   oSeries = (Excel.Series)oChart.SeriesCollection(1);
   oSeries.XValues = oWS.get_Range("A2", "A6");
   for( int iRet = 1; iRet <= iNumQtrs; iRet++)
   {
   oSeries = (Excel.Series)oChart.SeriesCollection(iRet);
   String seriesName;
   seriesName = "=\"Q";
   seriesName = String.Concat( seriesName, iRet );
   seriesName = String.Concat( seriesName, "\"" );
   oSeries.Name = seriesName;
   }  

   oChart.Location( Excel.XlChartLocation.xlLocationAsObject, oWS.Name );

   //Move the chart so as not to cover your data.
   oResizeRange = (Excel.Range)oWS.Rows.get_Item(10, Missing.Value );
   oWS.Shapes.Item("Chart 1").Top = (float)(double)oResizeRange.Top;
   oResizeRange = (Excel.Range)oWS.Columns.get_Item(2, Missing.Value );
   oWS.Shapes.Item("Chart 1").Left = (float)(double)oResizeRange.Left;
   }

   ```

7. Scroll to the top of the code window. Add the following line to the end of the list of using directives:

   ```c
   using Excel = Microsoft.Office.Interop.Excel;
   using System.Reflection; 
   ```

### Test the Automation Client

1. Press F5 to build and to run the program.   
2. Click Button1 on the form. The program starts Excel and populates data on a new worksheet.   
3. When you are prompted to enter quarterly sales data, click Yes. A chart that is linked to quarterly data is added to the worksheet.   

## References

For more information, See [Microsoft Developer Network (MSDN) Web site](https://msdn.microsoft.com/library/aa188489.aspx).