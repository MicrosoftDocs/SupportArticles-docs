---
title: How to automate Microsoft Word to perform mail merge using Visual C++ and MFC
description: Describes that how to automate Microsoft Word to perform mail merge using Visual C++ and MFC.
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
- Microsoft Word
---

# How to automate Microsoft Word to perform a mail merge using Visual C++ and MFC

## Summary

This article demonstrates how to create and manipulate a Microsoft Word document using Automation from Microsoft Visual C++ and Microsoft Foundation Classes (MFC). 

## More Information

This article parallels a Microsoft Knowledge Base article that describes the same process using Microsoft Visual Basic.

### Building the automation sample

1. With Microsoft Developer Studio, start a new "MFC AppWizard (exe)" project named "AutoProject."
1. In step 1 of the MFC AppWizard, choose "Dialog Based" for the application type and then click Finish. 

    The New Project Information dialog box appears and indicates that the Classes to be created include:

    ```vb
    Application: CAutoProjectApp in AutoProject.h and AutoProject.cpp
    Dialog: CAutoProjectDlg in AutoProject.h and AutoProjectDlg.cpp
    ```

    Click OK to create the project.
1. The Dialog box "IDD_AUTOPROJECT_DIALOG" opens in the Visual Studio design/edit area. Modify it according to the instructions in the next two steps.
1. Remove the Label control (IDC_STATIC) and the Cancel button (IDCANCEL).
1. Change the name of the OK button to "IDRUN" and the caption to "Run." Close the AutoProject.rc dialog box design form.
1. Click ClassWizard on the View menu (or press CTRL+W).
1. Select the Message Maps tab. Select IDRUN in the Object Ids list box and select "BN_CLICKED" in the Messages list box. Click Add Function and accept the function name "OnRun". Click OK to close the ClassWizard.

    **NOTE**:** This step adds a declaration for the function member "OnRun();" to the header file named AutoProjectDLG.h. This step also adds an empty skeleton message handler function named CAutoProjectDlg::OnRun() to the file named AutoProjectDLG.cpp.
1. Click ClassWizard on the View menu (or press CTRL+W).
1. Select the Automation tab. Click Add Class and choose "From a type library." Navigate to select the object library for the application you wish to automate (for this example, if you are automating Excel 97, choose the Microsoft Excel 8.0 Object Library; the default location is C:\Program Files\Microsoft Office\Office\Excel8.olb). 

    If you are automating Microsoft Excel 2000, choose Microsoft Excel 9.0 Object Library for which the default location is the C:\Program Files\Microsoft Office\Office\Excel9.olb.


    If you are automating Microsoft Excel 2002 and Microsoft Office Excel 2003, the object library is embedded in the file Excel.exe. The default location for Excel.exe in Office 2002 is C:\program Files\Microsoft Office\Office10\Excel.exe. The default location for Excel.exe in Office 2003 is C:\program Files\Microsoft Office\Office11\Excel.exe. Once you have selected the appropriate object library, click Open. Select all classes in the Confirm Classes list, and then click OK. 

    **NOTE** The list box in the Confirm Classes dialog box contains all of the IDispatch interfaces (which are virtually identical to classes) in the Microsoft Excel type library. In the lower half of the dialog box you will see that an Implementation file named Excel8.cpp contains generated class wrappers derived from ColeDispatchDriver(), and the appropriate declaration header file is named Excel8.h. (For Excel 2002 and Excel 2003, the files are named Excel.cpp and Excel.h.)

    **Note** Choose the correct type library for the version of Word you are automating. See the references section below for information on finding the correctly type library.
1. Click OK to close the MFC ClassWizard dialog box.
1. Add the following code to the CAutoProjectApp::InitInstance() function, which loads and enables the COM services library:

    ```vb
    BOOL CAutoProjectApp::InitInstance()
      {
         if(!AfxOleInit())  // Your addition starts here
         {
            AfxMessageBox("Could not initialize COM dll");
            return FALSE;
         }                 // End of your addition

         AfxEnableControlContainer();
      .
      .
      .

      }
    ```
1. Add the following line to the #include statements at the top of the AutoProject.cpp program file:

    ```vb
      #include <afxdisp.h>
    ```

    
1. Add the include statement for the header file that was created above (either msword8.h, msword9.h or msword.h) in AutoProjectDlg.cpp after the include statement for stdafx.h. An example for Word 97 would be: 
    ```vb
       #include "stdafx.h"
       #include "msword8.h"
    
    ```

1. Add Automation code to the CAutoProjectDlg::OnRun method so that it appears as shown below:
    ```vb
    void CAutoProjectDlg::OnRun()
    {
    _Application oWord;
    Documents oDocs;
    _Document oDoc;
    Selection oSelection;
    Paragraphs oParagraphs;
    Tables oTables;
    Table oTable;
    Range oRange;
    Columns oColumns;
    Column oColumn;
    Rows oRows;
    Row oRow;
    
    Cells oCells;
    Cell oCell; 
    Shading oShading;
    Hyperlinks oHyperlinks;
    MailMerge oMailMerge;
    MailMergeFields oMailMergeFields;
    COleVariant vtOptional((long)DISP_E_PARAMNOTFOUND,VT_ERROR),
            vtTrue((short)TRUE),
    vtFalse((short)FALSE);
    CString StrToAdd;
    
    // Create an instance of Word
    if (!oWord.CreateDispatch("Word.Application")) {
    AfxMessageBox("Word failed to start!");
    } else {
    // Set the visible property
    oWord.SetVisible(TRUE);
    // Add a new document
    oDocs = oWord.GetDocuments();
    oDoc = oDocs.Add(vtOptional,vtOptional);
    
    CreateMailMergeDataFile(&oWord,&oDoc);
    // Add the address header
    
    StrToAdd = "State University\r\nElectrical Engineering " \ 
           "Department";
    oSelection = oWord.GetSelection();
    
    oParagraphs = oSelection.GetParagraphs();
    oParagraphs.SetAlignment(1);  // 1 = wdAlignParagraphCenter  
    oSelection.TypeText(StrToAdd);
    
    InsertLines(&oSelection,4);
    
    oParagraphs.SetAlignment(0);  // 0 = wdAlignParagraphLeft
    oMailMerge = oDoc.GetMailMerge();
    oMailMergeFields = oMailMerge.GetFields();
    oMailMergeFields.Add(oSelection.GetRange(),"FirstName");
    oSelection.TypeText(" ");
    oMailMergeFields.Add(oSelection.GetRange(),"LastName");
    oSelection.TypeParagraph();
    oMailMergeFields.Add(oSelection.GetRange(),"Address");
    oSelection.TypeParagraph();
    oMailMergeFields.Add(oSelection.GetRange(),"CityStateZip");
    
    InsertLines(&oSelection,4);
    // Set the paragraph alignment to Right justified
    oParagraphs = oSelection.GetParagraphs();
    
    oParagraphs.SetAlignment(2);  // 2 = wdAlignParagraphRight
    // Insert the current date
    oSelection.InsertDateTime(COleVariant("dddd, MMMM dd, yyyy"),\ 
     vtFalse,vtOptional);
    
    InsertLines(&oSelection,2);
    
    // Reset the justification to Justify
    
    oParagraphs = oSelection.GetParagraphs();
    oParagraphs.SetAlignment(3);  // 3 = wdAlignParagraphJustify
    
    oSelection.TypeText("Dear ");
    oMailMergeFields.Add(oSelection.GetRange(),"FirstName");
    oSelection.TypeText(",");
    
    InsertLines(&oSelection,2);
    
    // Add the body of the message
    StrToAdd = "Thank you for your recent request for next " \ 
           "semester's class schedule for the Electrical " \ 
           "Engineering Department.  Enclosed with this letter " \ 
           "is a booklet containing all the classes offered " \ 
           "next semester at State University.  Several new " \ 
           "classes will be offered in the Electrical " \ 
              "Engineering Department next semester.  These " \ 
           "classes are listed below.";
    oSelection.TypeText(StrToAdd);
    
    InsertLines(&oSelection,2);
    
    // Add a new table with 9 rows and 4 columns
    oRange = oSelection.GetRange();
    oTables = oDoc.GetTables();
    oTable = oTables.Add(oRange,9,4);
    
    // Set the width of each column
    oColumns = oTable.GetColumns();
    oColumn = oColumns.Item(1);
    oColumn.SetWidth(51.0,0);  // 0 = wdAdjustNone
    oColumn = oColumns.Item(2);
    oColumn.SetWidth(198.0,0);  // 0 = wdAdjustNone
    oColumn = oColumns.Item(3);
    oColumn.SetWidth(100.0,0);  // 0 = wdAdjustNone
    oColumn = oColumns.Item(4);
    oColumn.SetWidth(111.0,0);  // 0 = wdAdjustNone
    
    // Set the shading for row 1 to wdGray25
    oRows = oTable.GetRows();
    oRow = oRows.Item(1);
    oCells = oRow.GetCells();
    oShading = oCells.GetShading();
    oShading.SetBackgroundPatternColorIndex(16); // 16 = wdGray25
    
    // Turn on BOLD for the first row
    oRange = oRow.GetRange();
    oRange.SetBold(TRUE);
    
    // Set the alignment for cell (1,1) to center
    oCell = oTable.Cell(1,1);
    oRange = oCell.GetRange();
    oParagraphs = oRange.GetParagraphs();
    oParagraphs.SetAlignment(1);  // 1 = wdAlignParagraphCenter
    
    // Fill in the class schedule data
    FillRow(&oTable,1,"Class Number","Class Name",\ 
    "Class Time","Instructor");
    FillRow(&oTable,2, "EE220", "Introduction to Electronics II", \ 
    "1:00-2:00 M,W,F", "Dr. Jensen");
    FillRow(&oTable,3, "EE230", "Electromagnetic Field Theory I", \ 
    "10:00-11:30 T,T", "Dr. Crump");
    FillRow(&oTable,4, "EE300", "Feedback Control Systems", \ 
    "9:00-10:00 M,W,F", "Dr. Murdy");
    FillRow(&oTable,5, "EE325", "Advanced Digital Design", \ 
    "9:00-10:30 T,T", "Dr. Alley");
    FillRow(&oTable,6, "EE350", "Advanced Communication Systems", \ 
    "9:00-10:30 T,T", "Dr. Taylor");
    FillRow(&oTable,7, "EE400", "Advanced Microwave Theory", \ 
    "1:00-2:30 T,T", "Dr. Lee");
    FillRow(&oTable,8, "EE450", "Plasma Theory", \ 
    "1:00-2:00 M,W,F", "Dr. Davis");
    FillRow(&oTable,9, "EE500", "Principles of VLSI Design", \ 
    "3:00-4:00 M,W,F", "Dr. Ellison");
    
    // Go to the end of the document
    oSelection.GoTo(COleVariant((short)3), // 3 = wdGoToLine
    COleVariant((short)-1),vtOptional,vtOptional);  // -1 = wdGoToLast
    
    InsertLines(&oSelection,2);
    
    // Add closing text
    StrToAdd = "For additional information regarding the " \ 
                 "Department of Electrical Engineering, " \ 
                 "you can visit our website at ";
    oSelection.TypeText(StrToAdd);
    
    // Add a hyperlink to the homepage
    oHyperlinks = oSelection.GetHyperlinks();
    oHyperlinks.Add(oSelection.GetRange(),\ 
    COleVariant("http://www.ee.stateu.tld"),vtOptional);
    
    // Finish adding closing text
    StrToAdd = ".  Thank you for your interest in the classes " \ 
                 "offered in the Department of Electrical " \ 
                 "Engineering.  If you have any other questions, " \ 
                 "please feel free to give us a call at (999) " \ 
                 "555-1212.\r\n\r\n" \ 
                 "Sincerely,\r\n\r\n" \ 
                 "Kathryn M. Hinsch\r\n" \ 
                 "Department of Electrical Engineering\r\n";
    oSelection.TypeText(StrToAdd);
    
    // Perform mail merge
    oMailMerge.SetDestination(0); // 0 = wdSendToNewDocument
    oMailMerge.Execute(vtFalse);
    
    // Close the original form document
    oDoc.SetSaved(TRUE);
    oDoc.Close(vtFalse,vtOptional,vtOptional);
    
    }
    }
    
    ```

1. Insert the following code above in the code that is given in step 3:
    ```vb
    void InsertLines(Selection *pSelection, int NumLines)
    {
    int iCount;
    
    // Insert NumLines blank lines
    for (iCount = 1; iCount <= NumLines; iCount++)
    pSelection->TypeParagraph();
    }
    
    void FillRow(Table *pTable,int Row, CString Text1, 
     CString Text2, CString Text3, CString Text4)
    {
    Cell oCell;
    Range oRange;
    
    // Insert data into the specific cell
    oCell = pTable->Cell(Row,1);
    oRange = oCell.GetRange();
    oRange.InsertAfter(Text1);
    oCell = pTable->Cell(Row,2);
    oRange = oCell.GetRange();
    oRange.InsertAfter(Text2);
    oCell = pTable->Cell(Row,3);
    oRange = oCell.GetRange();
    oRange.InsertAfter(Text3);
    oCell = pTable->Cell(Row,4);
    oRange = oCell.GetRange();
    oRange.InsertAfter(Text4);
    
    }
    
    void CreateMailMergeDataFile(_Application *pApp,_Document *pDoc)
    {
      _Document oDataDoc;
      MailMerge oMailMerge;
      Documents oDocs;
      Tables oTables;
      Table oTable;
      Rows oRows;
      int iCount;
      COleVariant vtOptional((long)DISP_E_PARAMNOTFOUND,VT_ERROR),
    vtFalse((short)FALSE);
    
    // Create a data source at C:\DataDoc.doc containing the field data
      oMailMerge = pDoc->GetMailMerge();
      oMailMerge.CreateDataSource(COleVariant("C:\\DataDoc.doc"), \ 
            vtOptional,vtOptional, \ 
            COleVariant("FirstName, LastName, Address,CityStateZip"),\ 
            vtOptional, vtOptional,vtOptional,vtOptional,vtOptional);
      // Open the file to insert data
      oDocs = pApp->GetDocuments();
      oDataDoc = oDocs.Open(COleVariant("C:\\DataDoc.doc"), \ 
           vtOptional,vtOptional,vtOptional,vtOptional,\ 
           vtOptional,vtOptional,vtOptional,vtOptional,\ 
           vtOptional);
      oTables = oDataDoc.GetTables();
      oTable = oTables.Item(1);
      oRows = oTable.GetRows();
      for (iCount=1; iCount<=2; iCount++)  
        oRows.Add(vtOptional);
    
    // Fill in the data
      FillRow(&oTable, 2, "Steve", "DeBroux", \ 
            "4567 Main Street", "Buffalo, NY  98052");
      FillRow(&oTable, 3, "Jan", "Miksovsky", \ 
            "1234 5th Street", "Charlotte, NC  98765");
      FillRow(&oTable, 4, "Brian", "Valentine", \ 
            "12348 78th Street  Apt. 214", "Lubbock, TX  25874");
      // Save and close the file
      oDataDoc.Save();
      oDataDoc.Close(vtFalse,vtOptional,vtOptional);
    }
    
    ```

1. Compile and run your program. Click the **Run** button, and Microsoft Word should start and display a sample letter. Note that some methods have changed with Word 2000 and Word 2002. For more information on these changes, see the "References" section.   


## References

### Notes for automating Microsoft Word 2000 and Microsoft Word 2002
 
Some methods and properties have changed for Microsoft Word 2000 and Microsoft Word 2002. 

For more information about Office Automation, visit the Microsoft Office Development support site at: [Microsoft Support](https://support.microsoft.com)