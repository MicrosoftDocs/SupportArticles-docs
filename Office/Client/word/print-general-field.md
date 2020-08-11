---
title: Print a general field using Word and Visual FoxPro 9.0 or earlier versions
description: Describes two methods to use to print a general field by using Word and Visual FoxPro.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Word
---

# How to print a general field by using Word and Visual FoxPro 9.0 or earlier versions

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

When using the Report Designer to print a general field that has text inserted into it with a word processor, the OLE bound Control object of the Report Designer has to be sized to be as large as the largest amount of text in the general fields. This can present problems if there are multiple pages of text in the general field. The OLE Bound control can be enlarged only to the height of a single page in the Report Designer, which is usually not large enough to print a general field that has more than a page of data.

## More Information

Using a memo field would be one way to store the data and have it print correctly in the Report Designer. The problem with this method is that any formatting such as underlining, bolding, or different font sizes of the text is not allowed in a memo field. A word processor is needed to format data in this way and storing it into a general field is the only way to keep the formatting of the data intact. Instead of using the Report Designer to print the general field, sending it to a word processor like Word for Windows will allow all of the data in a general field to be printed correctly.

Below are two examples of code that use OLE Automation to call Word and then use WordBasic or Visual Basic for Applications (VBA) commands to pass the data to Word. The first example works only with Word 6.0, Word 95, or Office Word 2003 with any version of Visual FoxPro. The second example works only with Word 97 and Visual FoxPro versions 5.0 with Service Pack 2 and 6.0.

If using the example that works with Word 6.0 or Word 95 and the following error occurs, then the data in the general field of the table was inserted with Word 97:

**OLE Idispatch exception code 269 from Microsoft Word: Microsoft Word Err=1269 - Word cannot edit the object...**

Change to the second example using Visual FoxPro 5.0 SP 2 and Word 97 to pass the data to Word.

To use the code as is, you need to create a table with field names like those below:

|Field Name|Type|Width|
|----------|----------|----------|
|FIRST|Character|15|
|LAST|Character|15|
|ADDRESS|Character|25|
|CITY|Character|15|
|STATE|Character|2|
|ZIPCODE|Character|5|
|GEN|General|4|

After building the table and adding some data to each character field, make sure that each general field has been populated by double-clicking on the general field to open it and selecting the EDIT - INSERT OBJECT menu options. With the "Create New" button selected, select "Microsoft Word Document" in the "Object Type" list box and type some data into Word. Close Word to save the data into the general field.

The following code works with Visual FoxPro 3.x, 5.x, 6.0, 7.0 , 8.0, and 9.0 when using Word 6.0, Word 95, or Office Word 2003. Place the following code into a program (.prg) file and run it.

```vb
   ************* Beginning of code. ****************

PUBLIC oWord
    oWord = CREATEOBJECT("Word.Basic")
    WITH oWord
       .AppShow        && Makes Word Visible
       .FileNewDefault && Opens up blank Word document

* The following Insert commands place the FoxPro fields into
       * the Word document. You can change these commands to place
       * any text in the document.
       * Ensure that the table is already open. If only a portion
       * of records are to be printed, change the EOF() to a certain
       * number so that all of the records do not get processed.
       * Example: DO WHILE RECNO() < 10

GO TOP

DO WHILE NOT EOF()
          .Insert("Record: "+ALLTRIM(STR(RECNO())))
            && The above line shows the record number.
          .InsertPara
          .InsertPara
          .Insert(ALLTRIM(first)+" "+last)   && Field in the table.
          .InsertPara
          .Insert(address)
          .InsertPara
          .Insert(ALLTRIM(city)+", "+state+"  "+zipcode)
          .InsertPara
          .InsertPara
          .Insert("Contents of the General Field:")
          .InsertPara
          .InsertPara
           KEYBOARD "{ctrl+c} {ctrl+w}" && Copies and closes the general
                                        && field to the clipboard.
           MODIFY GENERAL gen           && This has to be after the
                                        && KEYBOARD command.
          .EditPaste
          .WordLeft(1,1)
          .EditObject("0")
          .EditSelectAll
          .Editcopy
          .FileClose
          .EditClear
          .EditPaste
          .InsertPara
          .InsertPara
          .InsertPara
           SKIP                     && Move the record pointer to
                                    && the next record.
       ENDDO
       .FileSaveAs("c:\mydoc.doc")  && Saves the Word document as
                                    && Mydoc.doc.
       .FilePrint
       .AppClose
    ENDWITH

**************** End of code. ****************
```

If you are using Word 97, Visual FoxPro 5.0 Service Pack 2 and Visual FoxPro 6.0 are the only versions that run this code correctly. Place the following code into a program (.prg) file and run it.

```vb
   **************** Beginning of code. **********
   PUBLIC oWord
   oWord = CREATEOBJECT("Word.Application")
   WITH oWord
      .visible=.t.       && Makes Word Visible
    .documents.add     && Opens up blank Word document

* The following Insert commands place the FoxPro fields into
      * the Word document. You can change these commands to place
      * any text in the document.
      * Ensure that the table is already open. If only a portion
      * of records are to be printed, change the EOF() to a certain
      * number so that all of the records do not get processed.
      * Example: DO WHILE RECNO() < 10
      GO TOP
      DO WHILE NOT EOF()

.Selection.TypeText("Record: "+ALLTRIM(STR(RECNO())))
           && The above line shows the record number.
         .Selection.TypeParagraph
         .Selection.TypeParagraph
         .Selection.TypeText(ALLTRIM(first)+" "+last)&& Field in the table.
         .Selection.TypeParagraph
         .Selection.TypeText(address)
         .Selection.TypeParagraph
         .Selection.TypeText(ALLTRIM(city)+", "+state+"  "+zipcode)
         .Selection.TypeParagraph
         .Selection.TypeParagraph
         .Selection.TypeText("Contents of the General Field:")
         .Selection.TypeParagraph
         .Selection.TypeParagraph
          KEYBOARD "{ctrl+c} {ctrl+w}" && Copies and closes the general
                                       && field to the clipboard.
         MODIFY GENERAL gen           && This has to be after the
                                       && KEYBOARD command.
         .Selection.Paste
         .Selection.MoveLeft
         x = .ActiveDocument.Shapes.Count
         .ActiveDocument.Shapes(x).OLEFormat.Edit
         .Selection.Wholestory
         .Selection.Copy
         .ActiveDocument.Close
         .Selection.Delete
         .Selection.EndKey(6)
         .Selection.Paste
         .Selection.TypeParagraph
         .Selection.TypeParagraph
         .Selection.TypeParagraph
          SKIP                     && Move the record pointer to
      ENDDO
         .ActiveDocument.SaveAs("Mydoc.doc")  && Saves the Word document as
                                              && Mydoc.doc.
         .Application.PrintOut
   ENDWITH

.Quit

**************** End of code ****************
```

## References

For more information on Word Basic and Visual Basic Applications (VBA), look in the Word Help file.