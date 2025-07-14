---
title: Troubleshoot issues in Office solutions
description: Learn how to troubleshoot issues that may occur while you develop Microsoft Office solutions in Visual Studio.
ms.date: 02/02/2017
f1_keywords:
  - VST.Project.DesignerDisabled
  - VST.Designer.CannotActivate
  - VST.Project.ExcelBusy
  - VST.SelectDocWizard.AlreadyCustomized
  - VST.SelectDocWizard.DocPath
  - VST.Project.CannotOpen
  - VST.Designer.ErrorsOccurred
dev_langs:
  - VB
  - CSharp
author: aartig13
ms.author: aartigoyle
ms.reviewer: johnhart
ms.custom: sap:Tools and Utilities\Microsoft Office dev tools
---
# Troubleshoot issues in Office solutions

_Applies to:_&nbsp;Visual Studio

This article introduces how to troubleshoot issues that you may encounter when you perform different tasks while developing Office solutions in Visual Studio。

## Issues when you create, upgrade, and open projects

You might encounter the following issues when you create or open Office projects.

### Issue 1: The project can't be created

If an error occurs when you try to create or open an Office project, but Visual Studio doesn't have enough information to determine the cause, try closing your project, exiting Visual Studio, and starting again.

If you're trying to create a document-level project, it's possible that another document with the same name as the document in the new project is already open in Excel or Word. Make sure that all other instances of Excel or Word are closed.

### Issue 2: Control properties are lost when you create a new project based on a document from an existing project

If you create a new Office project based on a document from an existing project, the properties for any controls that are on the document aren't copied into the new project. Reset the properties for any pre-existing controls manually. Alternatively, you can preserve the control properties by creating a copy of the existing project instead of creating a new project, or by loading the existing project into the new solution (in the designer) and copying and pasting the controls from the existing document to the new document.

### Issue 3: Errors when you create an Excel workbook project based on an existing workbook

If you create a new Excel workbook project based on an existing workbook, you might see a combination of the following errors.

- From Excel: "Privacy warning: This document contains macros, ActiveX controls, XML expansion pack information, or Web components. These may include personal information that cannot be removed by the Document Inspector."
- From Visual Studio: "Designer failed to load correctly."

These errors can occur you try to create a project that is based on a workbook that had its personal information removed by using the Document Inspector. To avoid this ISSUE, perform the following steps before creating the project:

1. Open the workbook in Excel.
1. In Excel, open the Trust Center.
1. On the **Privacy Options** tab, clear the **Remove personal information from file properties on save** check box.
1. Save the workbook and close Excel.

### Issue 4: Can't open a project after migration

After an Office solution is migrated to Microsoft Office 2010, the project can't be opened on a development computer with only the 2007 Microsoft Office system installed. You may see the following errors.

- "One or more projects in the solution were not loaded correctly. Please see the Output Window for details."
- "Cannot create the project because the application associated with this project type is not installed on this computer. You must install the Microsoft Office application that is associated with this project type."

To resolve this issue, edit the _.vbproj_ or _.csproj_ file. For a Word project, replace `HostPackage="{763FDC83-64E5-4651-AC9B-28C4FEB985A1}"` with `HostPackage="{6CE98B71-D55A-4305-87A8-0D6E368D9600}"`. For an Excel project, replace `HostPackage="{B284B16A-C42C-4438-BDCD-B72F4AC43CFB}"` with `HostPackage="{825100CF-0BA7-47EA-A084-DCF3308DAF74}"`. For an Outlook project, replace `HostPackage="{D2B20FF5-A6E5-47E1-90E8-463C6860CB05}"` with `HostPackage="{20A848B8-E01F-4801-962E-25DB0FF57389}"`.

Alternatively, ensure that migrated projects are only opened on development computers with Microsoft Office 2010 already installed.

### Issue 5: Errors in upgraded Office 2003 document-level projects that contain Windows Forms controls

If you upgrade a Microsoft Office 2003 document-level project, and the document contains Windows Forms controls, the upgraded project might have compile or runtime errors. To avoid this issue, install the Visual Studio 2005 Tools for Office Second Edition Runtime on the development computer before you upgrade the project. This version of the runtime is available as a redistributable package from the Microsoft Download Center at Microsoft Visual Studio 2005 Tools for Office Second Edition Runtime (VSTO 2005 SE) (x86).

After you finish upgrading the project, you can uninstall the Visual Studio 2005 Tools for Office Second Edition Runtime from the development computer if it isn't being used by any other Office solutions.

## Issues when you use the designers

You might encounter the following issues when you work with the document, workbook, or worksheet designer in document-level projects.

### Issue 1: Designer failed to load correctly

Visual Studio can't open the designer in the following cases:

- Excel or Word is already open and is displaying a modal dialog box. To open the designer, check to see if Excel or Word has a modal dialog box open, and close any open modal dialog boxes. If there are no modal dialog boxes open, there might be some other action required before Excel or Word responds.
- The project is currently being debugged. To open the designer, stop or finish debugging.
- An Excel VSTO Add-in that is installed on the development computer is displaying a dialog box when Excel starts. To create an Excel document-level project, you must first disable the VSTO Add-in.

### Issue 2: Controls appear as black rectangles on the document or worksheet

If you group controls on a document or worksheet, Visual Studio no longer recognizes the controls. Grouped controls can't be accessed in the **Properties** window and they appear as black rectangles on the document or worksheet. You must ungroup the controls in order to restore their functionality.

### Issue 3: Controls on a Word template aren't visible in Visual Studio

If you open a Word template in the Visual Studio designer, controls on the template that aren't in line with text might not be visible. This is because Visual Studio opens Word templates in **Normal** view. To view the controls, select the **View** menu, point to **Microsoft Office Word View** and then select **Print Layout**.

### Issue 4: Insert clip art command does nothing in the Visual Studio designer

When Excel or Word is open in the Visual Studio designer, clicking the **Clip Art** button on the **Illustrations** tab in the ribbon doesn't open the **Clip Art** task pane. To add clip art, you must open the copy of the workbook or document that is in the main project folder (not the copy that is in the _\bin_ folder) outside of Visual Studio, add the clip art, and then save the workbook or document.

## Issues when you write code

You might encounter the following issues when you write code in Office projects.

### Issue 1: Some events of Office objects aren't accessible when using C\#

In some cases, you might see a compiler error like the following when you try to access a particular event of an instance of an Office primary interop assembly (PIA) type in a Visual C# project.

> Ambiguity between 'Microsoft.Office.Interop.Excel._Application.NewWorkbook' and 'Microsoft.Office.Interop.Excel.AppEvents_Event.NewWorkbook'

This error means that you're trying to access an event that has the same name as another property or method of the object. To access the event, you must cast the object to its _event interface_.

Office PIA types that have events implement two interfaces: a core interface with all the properties and methods, and an event interface that contains the events that are exposed by the object. These event interfaces use the naming convention _\<objectname>_Events_\<n>_Event_, such as <xref:Microsoft.Office.Interop.Excel.AppEvents_Event> and <xref:Microsoft.Office.Interop.Word.ApplicationEvents2_Event>. If you can't access an event that you expect to find on an object, cast the object to its event interface.

For example, <xref:Microsoft.Office.Interop.Excel.Application> objects have a <xref:Microsoft.Office.Interop.Excel.AppEvents_Event.NewWorkbook> event and a <xref:Microsoft.Office.Interop.Excel._Application.NewWorkbook%2A> property. To handle the <xref:Microsoft.Office.Interop.Excel.AppEvents_Event.NewWorkbook> event, cast the <xref:Microsoft.Office.Interop.Excel.Application> to the <xref:Microsoft.Office.Interop.Excel.AppEvents_Event> interface. The following code example demonstrates how to do this in a document-level project for Excel.

```csharp
private void ThisWorkbook_Startup(object sender, System.EventArgs e)
{
    ((Excel.AppEvents_Event)this.Application).NewWorkbook += 
        new Excel.AppEvents_NewWorkbookEventHandler(ThisWorkbook_NewWorkbook);
}

void ThisWorkbook_NewWorkbook(Excel.Workbook Wb)
{
    // Perform some work here.
}
```

For more information about event interfaces in the Office PIAs, see [Overview of classes and interfaces in the Office primary interop assemblies](/previous-versions/office/office-12//ms247299(v=office.12)).

### Issue 2: Can't reference Office PIA classes in projects that target the .NET Framework 4 or the .NET Framework 4.5

In projects that target the .NET Framework 4 or the .NET Framework 4.5, code that references a class that is defined in an Office PIA won't compile by default. Classes in the PIAs use the naming convention _\<objectname>Class_, such as <xref:Microsoft.Office.Interop.Word.DocumentClass> and <xref:Microsoft.Office.Interop.Excel.WorkbookClass>. For example, the following code from a Word VSTO Add-in project won't compile.

### [C#](#tab/csharp)

```csharp
Word.DocumentClass document = (Word.DocumentClass) Globals.ThisAddIn.Application.ActiveDocument;
```

### [VB](#tab/vb)

```vb
Dim document As Word.DocumentClass = Globals.ThisAddIn.Application.ActiveDocument
```

---

This code results in the following compile errors:

- Visual Basic: "Reference to class 'DocumentClass' is not allowed when its assembly is linked using No-PIA mode."
- Visual C#: "Interop type 'Microsoft.Office.Interop.Word.DocumentClass' cannot be embedded. Use the applicable interface instead."

To resolve this error, modify the code to reference the corresponding interface instead. For example, rather than reference a <xref:Microsoft.Office.Interop.Word.DocumentClass> object, reference an instance of the <xref:Microsoft.Office.Interop.Word.Document> interface instead.

### [C#](#tab/csharp)

```csharp
Word.Document document = Globals.ThisAddIn.Application.ActiveDocument;
```

### [VB](#tab/vb)

```vb
Dim document As Word.Document = Globals.ThisAddIn.Application.ActiveDocument
```

---

Projects that target the .NET Framework 4 or the .NET Framework 4.5, automatically embed all interop types from the Office PIAs by default. This compile error occurs because the embedded interop types feature only works with interfaces, not classes. For more information about interfaces and classes in the Office PIAs, see [Overview of classes and interfaces in the Office primary interop assemblies](/previous-versions/office/office-12/ms247299(v=office.12)). For more information about the embedded interop types feature in Office projects, see [Design and create Office solutions](/visualstudio/vsto/designing-and-creating-office-solutions).

### Issue 3: References to Office classes aren't recognized

Some class names, for example Application, are in multiple namespaces such as <xref:Microsoft.Office.Interop.Word> and <xref:System.Windows.Forms>. For this reason, the **Imports**/**using** statement at the top of the project templates includes a shorthand qualifying constant, for example:

### [C#](#tab/csharp)

```csharp
using Word = Microsoft.Office.Interop.Word;
```

### [VB](#tab/vb)

```vb
Imports Word = Microsoft.Office.Interop.Word
```

---

This usage of the **Imports**/**using** statement requires that you differentiate references to Office classes with the Word or Excel qualifier, for example:

### [C#](#tab/csharp)

```csharp
Word.Document doc;
```

### [VB](#tab/vb)

```vb
Dim doc As Word.Document
```

---

You'll get errors if you use an unqualified declaration, for example:

### [C#](#tab/csharp)

```csharp
Document doc;  // Class is ambiguous
```

### [VB](#tab/vb)

```vb
Dim doc As Document  ' Class is ambiguous
```

---

Even though you've imported the Word or Excel namespace and have access to all the classes inside it, you must fully qualify all the types with Word or Excel to remove namespace ambiguity.

## Issues when you build projects

You might encounter the following issues when you build Office projects.

### Issue 1: Can't build a document-level project that is based on a document with restricted permissions

Visual Studio can't build document-level projects if the document has restricted permissions. If your project contains a document that has restricted permissions, the project won't compile, and you'll receive the following message in the **Error List** window.

> Failed to add the customization.

If you want to include a document that has restricted permissions, use an unrestricted document while you develop and build the solution. Then, apply the restricted permissions to the document in the publish location, after you publish the solution.

### Issue 2: Compiler errors occur after a NamedRange control is deleted

If you delete a <xref:Microsoft.Office.Tools.Excel.NamedRange> control from a worksheet that isn't the active worksheet in the designer, the auto-generated code might not be removed from your project and compiler errors might occur. To make sure the code is removed, you should always select the worksheet that contains the <xref:Microsoft.Office.Tools.Excel.NamedRange> control to make it the active worksheet before deleting the control. If auto-generated code isn't deleted when you delete the control, you can cause the designer to delete the code by activating the worksheet and making a change so that the worksheet becomes marked as modified. When you rebuild the project, the code is removed.

## Issues when you debug projects

You might encounter the following issues when you debug Office projects.

### Issue 1: Prompt to uninstall appears when you publish and install a solution on the development computer

When you debug an Office solution, you might see the following error.

> The customization cannot be installed because another version is currently installed and cannot be upgraded from this location.

This error indicates that you've previously published and installed the Office solution on your development computer. To prevent the message from appearing, uninstall the solution from the list of installed programs on the computer before you debug the solution. Alternatively, you can create another user account on your development computer to test the installation of the published solution.

### Issue 2: Document-level projects created at UNC network locations don't run from Visual Studio

If you create a document-level project for Excel or Word at a UNC network location, you must add the location of the document to the trusted locations list in Excel or Word. Otherwise, the customization won't be loaded when you try to run or debug the project in Visual Studio. For more information about trusted locations, see [Grant trust to documents](/visualstudio/vsto/granting-trust-to-documents).

### Issue 3: Threads aren't stopped correctly after debugging

Office projects in Visual Studio follow a thread naming convention that enables the debugger to close the program correctly. If you create threads in your solution, you should name each thread with the prefix VSTA_ to ensure that these threads are handled correctly when you stop debugging. For example, you might set the `Name` property of a thread that waits for a network event to **VSTA_NetworkListener**.

### Issue 4: Can't run or debug any Office solution on the development computer

If you can't run or develop an Office project on your development computer, you may see the following error message.

> Customization could not be loaded because the application domain could not be created.

Visual Studio uses Fusion, the .NET Framework assembly loader, to cache the assemblies before loading Office solutions. Ensure that Visual Studio can write to the Fusion cache, and try again. For more information, see [Shadow copy assemblies](/dotnet/framework/app-domains/shadow-copy-assemblies).

### Issue 5: Error when stopping the debugger in a document-level project after using Edit and Continue

If you use **Edit** and **Continue** to make changes to code in a document-level project for Excel or Word while the project is in break mode, you might see a dialog box with the following error message if you then stop the debugger.

> Terminating the process in its current state can cause undesired results including the loss of data and system instability.

Whether you select **Yes** or **No** in the dialog box, Visual Studio terminates the Excel or Word process and stops the debugger. To stop debugging the project without displaying this dialog box, exit Excel or Word directly rather than stopping the debugger in Visual Studio.

## References

- [Troubleshoot Office solutions](/visualstudio/vsto/troubleshooting-office-solutions)
- [Troubleshoot Office solution security](./troubleshooting-office-solution-security.md)
- [Troubleshoot Office solution deployment](./troubleshooting-office-solution-deployment.md)
