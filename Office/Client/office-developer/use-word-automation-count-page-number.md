---
title: How to use Word automation to count page number in each section of a document
description: Describes how you can use automation with Word to determine the number of pages in each section of a document.
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

# How to use Word automation to count the number of pages in each section of a document

## Summary

This article describes how you can use automation with Word to determine the number of pages in each section of a document. 

## More Information

The following sample code uses a document that is saved to C:\Mydoc.doc. For testing the sample code, either create a new document with multiple sections and multiple pages and save it as C:\Mydoc.doc, or change the document path in the code to reference one of your existing Word documents.

NOTE: The sample code assumes that a section break forces a new page break and that each page contains no more than one section. Therefore, when you insert section breaks while creating the C:\Mydoc.doc Word document for testing the sample code, you should choose Next Page as the Section Break type. 
#### Visual Basic Sample


1. In Visual Basic, create a new Standard EXE project. Form1 is created by default.   
2. Add a command button to Form1, and add the following code to the button's Click event:
    ```vb
        Dim oApp As Object
        Dim oDoc As Object
        Dim oTbl As Object
    
    'Start Word and open the document.
        Set oApp = CreateObject("Word.Application")
        'For Word 2007, change the path to "c:\mydoc.docx"
        Set oDoc = oApp.Documents.Open("c:\mydoc.doc")
    
    'Repaginate the document.
        oDoc.Repaginate
    
    'Iterate each section in the document to retrieve the end page of the
        'document and compute the page count in that section. The results are 
        'displayed in the Immediate window.
        Dim oSec As Object
        Dim nStartPg As Integer, nEndPg As Integer, nSecPages As Integer
        Dim NumSections As Integer
        NumSections = oDoc.Sections.Count
        nStartPg = 1
        For Each oSec In oDoc.Sections
           nEndPg = oSec.Range.Information(3) - 1  'wdActiveEndPageNumber=3
           'Account for the last page.
           If oSec.Index = NumSections Then nEndPg = nEndPg + 1
           nSecPages = nEndPg - nStartPg + 1
           Debug.Print "Section " & oSec.Index & " --", _
                       "StartPage: " & nStartPg, _
                       "EndPage: " & nEndPg, _
                       "TotalPages: " & nSecPages
           nStartPg = nEndPg + 1
        Next
    
    'Close the document without saving changes and quit Word.
        oDoc.Close False
        oApp.Quit
    
    ```

3. Press F5 to run the application, and click the button on the form. The code displays the page count for each section in the Immediate window.   

### MFC Sample

1. Follow steps 1 through 12 in the following article in the Microsoft Knowledge Base to create a sample project that uses the IDispatch interfaces and member functions that are defined in the MSWord9.olb type library.

2. You must remove the Excel automation library.

    At the top of AutoProjectDlg.cpp, add one of the following lines:
      - In Word 2002 and in later versions of Word, add the following line: 
        ```vb
        #include "MSWord.h"
        ```

    - In Word 2000, add the following line: 
        ```vb
        #include "MSWord9.h"
        ```

   
3. Add the following code to CAutoProjectDlg::OnRun() in AutoProjectDlg.cpp. 
    ```vb
    COleVariant vOpt((long)DISP_E_PARAMNOTFOUND, VT_ERROR);
    
    //Start Word.
    _Application oWord;
    oWord.CreateDispatch("Word.Application");
    oWord.SetScreenUpdating(FALSE);
    
    //Open the document.
    Documents oDocs = oWord.GetDocuments();
    // For Word 2007, use:
    // _Document oDoc = oDocs.Open(COleVariant("c:\\mydoc.docx"),
    //     vOpt,vOpt,vOpt,vOpt,vOpt,vOpt,vOpt,vOpt,vOpt, vOpt, vOpt,vOpt,vOpt,vOpt,vOpt);
    _Document oDoc = oDocs.Open(COleVariant("c:\\mydoc.doc"),
             vOpt,vOpt,vOpt,vOpt,vOpt,vOpt,vOpt,vOpt,vOpt, vOpt, vOpt,vOpt,vOpt,vOpt,vOpt);
    
    //Repaginate the document.
    oDoc.Repaginate();
    
    //Iterate the collection of sections in the document to retrieve the page 
    //count for each section.
    Sections oSecs = oDoc.GetSections();
    long NumSections = oSecs.GetCount();
    long i;
    long StartPage=1; //Section start page.
    long EndPage=0;  //Section end page.
    long NumPages=0;  //Number of pages in the section.
    for(i=1;i<=NumSections;i++)
    {
    Section oSec = oSecs.Item(i);
    Range oSecRange = oSec.GetRange();
    VARIANT vInfo = oSecRange.GetInformation(3L);//wdActiveEndPageNumber=3
    //If oSec.Index = NumSections Then nEndPg = nEndPg + 1
    if(oSec.GetIndex()== NumSections) {EndPage++;}
    EndPage = vInfo.lVal-1;
    if(i==NumSections) {EndPage++;}  //Account for the last section.
    NumPages = EndPage - StartPage +1;
    char buf[5];
    sprintf(buf,"%d", NumPages);
    TRACE1("Section %d\n", oSec.GetIndex());
    TRACE3("   StartPage: %d  EndPage: %d   TotalPages: %d\n",
       StartPage, EndPage, NumPages);
    StartPage = EndPage + 1;
    }
    
    //Close the document without saving the changes, and then exit Word.
    oDoc.Close(COleVariant((short)false), vOpt, vOpt);
    oWord.Quit(COleVariant((short)false), vOpt, vOpt);
    
    ```

4. Compile and run the project.   
5.  When the dialog box appears, click **Run**. The count results are displayed in the Debug window. You must drag the NumPages variable to the Debug window.   

 (c) Microsoft Corporation 2001, All Rights Reserved. Contributions by Lori B. Turner, Microsoft Corporation.

## References

For more information, see the following Microsoft Developer Network (MSDN) Web sites: 

Microsoft Office Development with Visual Studio
[https://msdn.microsoft.com/en-us/library/aa188489(office.10).aspx](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx)

Microsoft Office Developer Center
[https://msdn.microsoft.com/office](https://msdn.microsoft.com/office)

For additional information, view the article in the Microsoft Knowledge Base: 

[220911](https://support.microsoft.com/help/220911) How To Automate Microsoft Word to Perform a Mail Merge Using Visual C++ and MFC
