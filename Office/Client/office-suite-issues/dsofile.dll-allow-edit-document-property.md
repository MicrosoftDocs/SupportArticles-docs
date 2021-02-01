---
title: Dsofile.dll lets you edit OLE document property
description: Explains that Dsofile.dll is a sample COM component written in Visual C++ that lets developers working in Visual Basic or other languages read and edit OLE document properties for Microsoft Office documents without Office installed.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
ms.custom: CSSTroubleshoot
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: joecr
appliesto:
- Microsoft Office
---

# The Dsofile.dll files lets you edit Office document properties when you do not have Office installed

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

The Dsofile.dll sample file is an in-process ActiveX component for programmers that use Microsoft Visual Basic .NET or the Microsoft .NET Framework. You can use this in your custom applications to read and to edit the OLE document properties that are associated with Microsoft Office files, such as the following:

- Microsoft Excel workbooks   
- Microsoft PowerPoint presentations   
- Microsoft Word documents   
- Microsoft Project projects   
- Microsoft Visio drawings   
- Other files that are saved in the OLE Structured Storage format    

The Dsofile.dll sample file is written in Microsoft Visual C++. The Dsofile.dll sample file demonstrates how to use the OLE32 IPropertyStorage interface to access the extended properties of OLE structured storage files. The component converts the data to Automation friendly data types for easier use by high level programming languages such as Visual Basic 6.0, Visual Basic .NET, and C#. The Dsofile.dll sample file is given with full source code and includes sample clients written in Visual Basic 6.0 and Visual Basic .NET 2003 (7.1).

## More Information

### Download sample ActiveX Component

The following files are available for download from the Microsoft Download Center:

[Download the DsoFileSetup_KB224351_x86.exe package now.](https://www.microsoft.com/download/details.aspx?familyid=9ba6fac6-520b-4a0a-878a-53ec8300c4c2&displaylang=en)

You have a royalty-free right to use, to modify, to reproduce, and to distribute the Dsofile.dll sample file component and the C++ source code files in any way you find useful. This is provided that you agree that Microsoft has no warranty, no obligations, and no liability for their use or for the information provided within. The component and source code is provided free of charge for educational purposes only and is considered a sample. If you want to use the component, or any part thereof, in a production solution, you are responsible for reviewing, for modifying, for testing, and for supporting the component yourself. 

> [!WARNING]
> The Dsofile.dll, the source code, and the associated samples are provided "as is" without warranty of any kind, either expressed or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose. Use at your own risk.

**Note** To read and to edit Office 2007 documents by using this sample, you must install the Office 2007 Compatibility Pack. For more information, see the "Resources" section.

### Information about OLE document properties

Every OLE compound document can store additional information about the document in persistent property sets. These are collectively called the "Document Summary Properties." These property sets are managed by "COM/OLE" so that third-party clients can read this information without the aid of the main application that is responsible for the file.

To help developers that are interested in reading document properties, we have provided the following two interfaces to manage property sets:

- IPropertySetStorage   
- IPropertyStorage   
 
However, some high-level programming languages may have trouble using these interfaces because the interfaces are not Automation-compatible. To resolve this problem, developers can use an ActiveX DLL, such the "DsoFile sample" to read and to write the most common properties that are used in OLE compound documents. This applies particularly those that are used by Microsoft Office applications.

### Use the DsoFile component from your custom application

The Dsofile.dll sample file reads and writes to both the standard properties and the custom properties from any "OLE Structured Storage" file. This includes, but is not limited to, the following:

- Word documents   
- Excel workbooks   
- PowerPoint presentations   
 
Because of the size and the speed of the Dsofile.dll sample file, the DLL can be much more efficient than trying to Automate Office to read document properties.

To use the component, set a reference to the Dsofile type library that is named "DSO OLE Document Properties Reader 2.1." The component can be used for both late calls and early bound calls. the Dsofile.dll sample file has only one object that can be created. That object is named DSOFile.OleDocumentProperties. The DSOFile.OleDocumentProperties object provides access to the OLE document properties of a file you load by using the Open method. All properties are read in and cached on open. All properties are then made available through the OleDocumentProperties object for editing. The properties are only written back to the file when you call Save. When you are done editing a file, call Close to release the file lock.

The standard OLE properties and the standard Office Summary properties can be obtained from the SummaryProperties property. Custom properties are listed in the CustomProperties collection. Each custom property has a unique name. Each custom property is accessible in the collection by that name. You can add or remove individual properties. Also, you can enumerate through the entire collection by using the "For Each" syntax in Visual Basic .NET.

When the Open method is called, the OleDocumentProperties object that is named Dsofile tries to open the document for both read access and write access. If the file has been marked read-only or if the files is located on an NTFS share that only provides Read access, the call may fail. You may receive the following error message:  

"Error 70: Permission denied"

If you want to open the file for read access only , pass True for the ReadOnly parameter on the Open method. Additionally, you can pass the dsoOptionOpenReadOnlyIfNoWriteAccess flag if you want Dsofile to try to open the file for editing. However, if Dsofile cannot gain access because file is read-only or is locked by another process, open a read-only copy. Then, you can verify whether the document is opened read-only by using the IsReadOnly property.

Once a property has been changed or modified, you can use the IsDirty property to verify whether the property set has to be saved. Changes that are made are not written to the file until Save is called. If you do not call Save, your changes are lost on Close.

In addition to the standard Automation error messages, Dsofile can return one of the following custom error messages when something goes wrong:

"Error -2147217151 (&H80041101): You must open a document to perform the action requested."

"Error -2147217150 (&H80041102): You must close the current document before opening a new one in the same object."

"Error -2147217149 (&H80041103): The document is in use by another program and cannot be opened for read-write access."

"Error -2147217148 (&H80041104): The document is not an OLE file, and does not support extended document properties."

"Error -2147217147 (&H80041105): The command is not available because document was opened in read-only mode."

"Error -2147217146 (&H80041106): The command is available for OLE Structured Storage files only."

"Error -2147217145 (&H80041107): The object is not connected to the document (it was removed or the document was closed)."

"Error -2147217144 (&H80041108): Cannot access property because the set it belongs to does not exist."

"Error -2147217143 (&H80041109): The property requested does not exist in the collection."

"Error -2147217142 (&H8004110A): An item by that name already exists in the collection."

### Unicode Property Sets

OLE Property Sets can store strings in either Unicode format or in Multi-Byte Character String (MBCS) format with a specified code page. Dsofile can read and write to either type of property set. By default, Dsofile selects Unicode when Dsofile creates new sets, such as when adding properties to a file that has none. If you want Dsofile to create the set by using MBCS format for strings, you can pass the dsoOptionUseMBCStringsForNewSets flag in the Open method.

Because existing property sets may use MBCS format, Dsofile has to store strings in the same format during a save. If you try to add a string that is unable to map into the code page for the property set, the operation may fail. Therefore, limit your strings to characters that you know exist in the code page of the system that made the file. Alternatively, make sure that all property sets are in Unicode format before you edit those properties.

**Note** Dsofile does not convert an existing MBCS property set to Unicode. You have to modify the sample if you want to add this ability.

### Steps to set up and test the DLL

The self-extracting setup installs and registers the DsoFile.dll component in a location that you want. The self-extracting setup also installs two Visual Basic .NET test applications that demonstrate how to use the component and all the source code.

If you move the DLL to another location or to another computer, you have to re-register the DLL before you can use it again. To do this, type regsvr32 [filepath]\dsofile.dll in the Run dialog box on the Start menu.

To run the sample, follow these steps: 

#### For a Visual Basic 6.0 demonstration

1. Open the Visual Basic 6.0 sample project that is named as follows:

   .\Source\Vb6Demo\PropDemo.vbp   
2. Make sure that Dsofile.dll has been correctly referenced. To do this, select References on the Project menu. Verify whether a reference is set for DSO OLE Document Properties Reader 2.1.   
3. Press F5 to run the project.   
4. When you are prompted to open a compound document file, select an appropriate file and notice that its document properties appear.   

#### For a Visual Basic 2003 (7.1) or for a Visual Basic 2005 (8.0) demonstration

1. Open the Visual Basic 7.1 project that is named as follows:

   .\Source\Vb7Demo\FilePropDemoVB7.sln

    You can open this project in either Visual Basic 7.1 in Visual Studio .NET 2003 or in Visual Basic 8.0 in Visual Studio 2005.   
2. If you are prompted to automatically convert the solution to 8.0 format, click **Yes**, and follow the wizard to convert the project.   
3. Press F5 to compile and to run the Visual Basic project.   
4. When the form appears, click **Open**.   
5. Select an appropriate Office file and click **OK**. 

   Notice that the document properties of the Office file appear in the dialog box. You can edit the document properties.
