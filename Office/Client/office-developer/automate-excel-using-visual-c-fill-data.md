---
title: Automate Excel by using Visual C# to fill or to obtain data by using arrays
description: Describes some sample steps about how to automate Excel with Visual C# 2005 or Visual C# .NET to fill or to obtain data in a range by using arrays.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft Excel
---

# How to automate Excel by using Visual C# to fill or to obtain data in a range by using arrays

## Summary

This article demonstrates how to automate Microsoft Excel by using Microsoft Visual C# 2005 or Microsoft Visual C# .NET to fill and retrieve values in a multi-cell range by using arrays.

## More Information

To fill a multi-cell range without populating cells one at a time, you can set the Value property of a Range object to a two-dimensional array. Likewise, you can retrieve a two-dimensional array of values for multiple cells at once by using the Value property. The following steps demonstrate this process for both setting and retrieving data using two-dimensional arrays. 

### Build the Automation Client for Microsoft Excel

1. Start Microsoft Visual Studio 2005 or Microsoft Visual Studio .NET.   
2. On the File menu, click New, and then click Project. Select Windows Application from the Visual C# Project types. Form1 is created by default.   
3. Add a reference to **Microsoft Excel 11.0 Object Library** in Visual Studio 2005 or Microsoft Excel Object Library in Visual Studio .NET. To do this, follow these steps: 

   1. On the Project menu, click Add Reference.   
   2. On the COM tab, locate Microsoft Excel Object Library, and then click Select.

   In Visual Studio 2005, locate **Microsoft Excel 11.0 Object Library** on the **COM** tab.

   **Note** Microsoft Office 2003 includes Primary Interop Assemblies (PIAs). Microsoft Office XP does not include PIAs, but they may be downloaded. 

4. Click OK in the Add References dialog box to accept your selections. If you are prompted to generate wrappers for the libraries that you selected, click Yes.   
   
5. On the View menu, select Toolbox to display the Toolbox. Add two buttons and a check box to Form1.   
6. Set the Name and the Text properties for the check box to FillWithStrings.   
7. Double-click Button1. The code window for the form appears.   
8. In the code window, replace the following code:

   ```cs
   private void button1_Click(object sender, System.EventArgs e)
   {
   }
   ```
   with:
 
   ```cs
      //Declare these two variables globally so you can access them from both
      //Button1 and Button2.
      Excel.Application objApp;
      Excel._Workbook objBook;

   private void button1_Click(object sender, System.EventArgs e)
      {
         Excel.Workbooks objBooks;
         Excel.Sheets objSheets;
         Excel._Worksheet objSheet;
         Excel.Range range;

   try
         {
            // Instantiate Excel and start a new workbook.
            objApp = new Excel.Application();
            objBooks = objApp.Workbooks;
            objBook = objBooks.Add( Missing.Value );
            objSheets = objBook.Worksheets;
            objSheet = (Excel._Worksheet)objSheets.get_Item(1);

   //Get the range where the starting cell has the address
            //m_sStartingCell and its dimensions are m_iNumRows x m_iNumCols.
            range = objSheet.get_Range("A1", Missing.Value);
            range = range.get_Resize(5, 5);

   if (this.FillWithStrings.Checked == false)
            {
               //Create an array.
               double[,] saRet = new double[5, 5];

   //Fill the array.
               for (long iRow = 0; iRow < 5; iRow++)
               {
                  for (long iCol = 0; iCol < 5; iCol++)
                  {
                     //Put a counter in the cell.
                     saRet[iRow, iCol] = iRow * iCol;
                  }
               }

   //Set the range value to the array.
               range.set_Value(Missing.Value, saRet );
            }

   else
            {
               //Create an array.
               string[,] saRet = new string[5, 5];

   //Fill the array.
               for (long iRow = 0; iRow < 5; iRow++)
               {
                  for (long iCol = 0; iCol < 5; iCol++)
                  {
                     //Put the row and column address in the cell.
                     saRet[iRow, iCol] = iRow.ToString() + "|" + iCol.ToString();
                  }
               }

   //Set the range value to the array.
               range.set_Value(Missing.Value, saRet );
            }

   //Return control of Excel to the user.
            objApp.Visible = true;
            objApp.UserControl = true;
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
   ```

   **Note** You must change the code in Visual Studio 2005. By default, Visual C# adds one form to the project when you create a Windows Forms project. The form is named Form1. The two files that represent the form are named Form1.cs and Form1.designer.cs. You write the code in Form1.cs. The Form1.designer.cs file is where the Windows Forms Designer writes the code that implements all the actions that you performed by dragging and dropping controls from the Toolbox. 

   For more information about the Windows Forms Designer in Visual C# 2005, visit the following Microsoft Developer Network (MSDN) Web site:

   [Creating a Project (Visual C#)](https://msdn.microsoft.com/library/ms173077.aspx)   
9. Return to the design view for Form1, and double-click Button2.   
10. In the code window, replace the following code:

   ```cs
   private void button2_Click(object sender, System.EventArgs e)
   {
   }

   ```
   with: 
   ```cs
   private void button2_Click(object sender, System.EventArgs e)
      {
         Excel.Sheets objSheets;
         Excel._Worksheet objSheet;
         Excel.Range range;

   try
         {
            try
            {
               //Get a reference to the first sheet of the workbook.
               objSheets = objBook.Worksheets;
               objSheet = (Excel._Worksheet)objSheets.get_Item(1);
            }

   catch( Exception theException ) 
            {
               String errorMessage;
               errorMessage = "Can't find the Excel workbook.  Try clicking Button1 " +
                  "to create an Excel workbook with data before running Button2.";

   MessageBox.Show( errorMessage, "Missing Workbook?");

   //You can't automate Excel if you can't find the data you created, so 
               //leave the subroutine.
               return;
            }

   //Get a range of data.
            range = objSheet.get_Range("A1", "E5");

   //Retrieve the data from the range.
            Object[,] saRet;
            saRet = (System.Object[,])range.get_Value( Missing.Value );

   //Determine the dimensions of the array.
            long iRows;
            long iCols;
            iRows = saRet.GetUpperBound(0);
            iCols = saRet.GetUpperBound(1);

   //Build a string that contains the data of the array.
            String valueString;
            valueString = "Array Data\n";

   for (long rowCounter = 1; rowCounter <= iRows; rowCounter++)
            {
               for (long colCounter = 1; colCounter <= iCols; colCounter++)
               {

   //Write the next value into the string.
                  valueString = String.Concat(valueString,
                     saRet[rowCounter, colCounter].ToString() + ", ");
               }

   //Write in a new line.
               valueString = String.Concat(valueString, "\n");
            }

   //Report the value of the array.
            MessageBox.Show(valueString, "Array Values");
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
   ```

11. Scroll to the top of the code window. Add the following line to the end of the list of using directives:

    ```cs
    using System.Reflection; 
    using Excel =  Microsoft.Office.Interop.Excel;
    ```

### Test the Automation Client

1. Press F5 to build and to run the sample program.   
2. Click Button1. The program starts Microsoft Excel with a new workbook and populates cells A1:E5 of the first worksheet with numeric data from an array.   
3. Click Button2. The program retrieves the data in cells A1:E5 into a new array and displays the results in a message box.   
4. Select FillWithStrings, and then click Button1 to fill cells A1:E5 with string data.   

## References

For more information, visit the following Microsoft Developer Network (MSDN) Web site: 

[Microsoft Office Development with Visual Studio](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx)