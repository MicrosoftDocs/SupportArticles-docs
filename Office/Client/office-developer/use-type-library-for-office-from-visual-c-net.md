---
title: How to use a type library for Office Automation from Visual C++.NET
description: Describes how to build a Visual C++.NET project that acts as an Automation client for applications that are Component Object Model (COM) compliant.
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
- Microsoft Office Professional Edition 2003
---

# How to use a type library for Office Automation from Visual C++.NET

## Summary

This article describes how to build a Visual C++ .NET project that acts as an Automation client for applications that are Component Object Model (COM) compliant. The sample in this article uses Microsoft Foundation Classes (MFC) with class wrappers for an Office component.

## More Information

The following steps demonstrate how to build a simple Automation client. There are three main steps to this procedure:

1. Create the Automation client.   
2. Add code to automate Microsoft Excel.
3. Run the Automation client.   
 
You can use the first step (Create the Automation Client), to create a new Automation client regardless of the Automation server that you are using. The second step (Add Code to Automate Microsoft Excel), is specific to the Automation server. 

### Create an Automation client

1. Start Microsoft Visual Studio .NET. On the File menu, click New, and then click Project. Select MFC Application from the Visual C++ Projects types, and then name the project AutoProject.   
2. When the MFC Application Wizard appears, click Application Type, set the application type to Dialog Based, and then click Finish.   
3. Modify the IDD_AUTOPROJECT_DIALOG dialog box as follows:

   1. Remove the Label control (IDC_STATIC) and the Cancel button (IDCANCEL).   
   2. Change the ID of the OKbutton to "IDRUN" and the caption to "Run."   
   
4. Create class wrappers from the type library for the Automation server as follows:

   1. In Solution Explorer, right-click AutoProject, and then click Add Class.   
   2. Click MFC Class from Typelib, and then click Open.   
   3. Click Add a class from: Registry, and locate the registered type library for your Automation server.

        For this example, select "Microsoft Excel 10.0 Type Library" for Microsoft ExcelXP or "Microsoft Excel 9.0 Type Library" for Microsoft Excel 2000.   
   4. Select the interface(s) that you need from the list, and then click the greater than symbol (>) to add them to the list of interfaces for which MFC creates wrappers. Click Finish when you have added all of the interfaces.

        For this example, you only need the _Application interface.

        **Important** If there are many interfaces in the type library that you chose, select only those interfaces that you will use because MFC will generate a separate header file for each selected interface. By minimizing your interface selections, you can avoid unnecessary overhead during file generation and compilation.   
   
5. To load and enable the COM services library to the CAutoProjectApp::InitInstance function, add the following code:
    ```vb
    if(!AfxOleInit())  // Your addition starts here.
    {
      AfxMessageBox("Cannot initialize COM dll");
      return FALSE;
      // End of your addition.
    }
    
    AfxEnableControlContainer();
    
    ```

6. Add an include directive for each header file that is generated from the interfaces in the type library of the Automation server. Add the directives after the include statement for Stdafx.h at the top of AutoProjectDlg.cpp.

    For this example, add an include for the CApplication.h header file, which is generated for the _Application interface:
    ```vb
          #include "stdafx.h"
          #include "CApplication.h"
    
    ```


### Add code to automate Microsoft Excel
 
In the IDD_AUTOPROJECT_DIALOG dialog box, right-click Run, and then click Add event handler from the drop-down list box. In the Event Handler Wizard, select the BN_CLICKED message type, and then click Add and Edit. Add the following code to automate Excel in the handler: 
```vb
void CAutoProjectDlg::OnBnClickedRun()
{
   CApplication app;  // app is the Excel _Application object

// Start Excel and get Application object.

if(!app.CreateDispatch("Excel.Application"))
   {
      AfxMessageBox("Cannot start Excel and get Application object.");
      return;
   }
   else
   {
      //Make the application visible and give the user control of
      //Microsoft Excel.
      app.put_Visible(TRUE);
      app.put_UserControl(TRUE);
   }
} 
```

### Run the Automation client
 
Press the F5 key to build and run the Automation client. When the dialog box appears, click Run. The Automation client starts Excel and makes the application visible. Notice that Excel remains running even when the Automation client ends because the user has been given control of the application.

### Additional notes
 
After you have added classes from a type library to your project, you may notice that they appear in the Class View of your project. In Class View, you can double-click a class to see the methods of that class, and then double-click the method to view the definition of that function in the implementation file of the MFC wrapper. You can review the definition of a member function if you want to verify a return type or if you must change an implementation of a function.

Although the earlier steps illustrate how to automate Microsoft Excel, you can apply the same ideas to automate other applications. The following list contains the file names for type libraries of other Microsoft Office applications: 

|Application|Type Library|
|---|---|
|Microsoft Access 97|Msacc8.olb|
|Microsoft Jet Database 3.5|DAO350.dll|
|Microsoft Binder 97|Msbdr8.olb|
|Microsoft Excel 97|Excel8.olb|
|Microsoft Graph 97|Graph8.olb|
|Microsoft Office 97|Mso97.dll|
|Microsoft Outlook 97|Msoutl97.olb|
|Microsoft PowerPoint 97|Msppt8.olb|
| Microsoft Word 97|Msword8.olb|
|||
|Microsoft Access 2000|Msacc9.olb|
|Microsoft Jet Database 3.51|DAO360.dll|
|Microsoft Binder 2000|Msbdr9.olb|
| Microsoft Excel 2000|Excel9.olb|
|Microsoft Graph 2000|Graph9.olb|
|Microsoft Office 2000|Mso9.dll|
|Microsoft Outlook 2000|Msoutl9.olb|
|Microsoft PowerPoint 2000|Msppt9.olb|
|Microsoft Word 2000|Msword9.olb |
|||
| Microsoft Access 2002|Msacc.olb|
|Microsoft Excel 2002|Excel.exe|
|Microsoft Graph 2002|Graph.exe|
|Microsoft Office 2002|MSO.dll|
|Microsoft Outlook 2002|MSOutl.olb|
|Microsoft PowerPoint 2002|MSPpt.olb|
|Microsoft Word 2002|MSWord.olb|
|||
|Microsoft Office Access 2003|Msacc.olb|
|Microsoft Office Excel 2003|Excel.exe|
|Microsoft Office Graph 2003|Graph.exe|
|Microsoft Office 2003|MSO.dll|
|Microsoft Office Outlook 2003|MSOutl.olb|
| Microsoft Office PowerPoint 2003|MSPpt.olb|
| Microsoft Office Word 2003|MSWord.olb|
|||
|Microsoft Office Access 2007|Msacc.olb|
|Microsoft Office Excel 2007|Excel.exe|
|Microsoft Office Graph 2007|Graph.exe|
| 2007 Microsoft Office|MSO.dll|
|Microsoft Office Outlook 2007|MSOutl.olb|
| Microsoft Office PowerPoint 2007|MSPpt.olb|
| Microsoft Office Word 2007|MSWord.olb|
Note The default location for these type libraries is: 

|Office Version|Path|
|---|---|
|Office 97|C:\Program Files\Microsoft Office\Office|
|Office 2000|C:\Program Files\Microsoft Office\Office|
|Office XP|C:\Program Files\Microsoft Office\Office10|
|Office 2003|C:\Program Files\Microsoft Office\Office11|
|2007 Office|C:\Program Files\Microsoft Office\Office12|
The default location for Dao350.dll and Dao360.dll is C:\Program Files\Common Files\Microsoft Shared\Dao.