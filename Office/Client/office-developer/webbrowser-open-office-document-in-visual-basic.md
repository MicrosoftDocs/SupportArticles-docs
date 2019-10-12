---
title: How to use the WebBrowser control in Visual Basic to open an Office document
description: Describes that how to use the WebBrowser control in Visual Basic to open an Office document.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft Office
---

# How to use the WebBrowser control in Visual Basic to open an Office document

For a Microsoft Visual C# 2005 and Microsoft Visual C# .NET version of this article, see [304662](https://support.microsoft.com/help/304662).

## Summary

You may want to display, or embed, a Microsoft Office document directly on a Microsoft Visual Basic form. Microsoft Visual Basic 2005 and Visual Basic .NET do not provide an OLE control that lets you embed an Office document in a form. If you want to embed an existing document and open it as an in-place ActiveX document object within a Visual Basic form, a potential solution for you is to use the WebBrowser control.

This article demonstrates how to browse to an existing Office document and display it in a Visual Basic form by using the WebBrowser control. 

## More Information

ActiveX documents are embeddable OLE objects that behave more like ActiveX controls than traditional OLE objects. Unlike a traditional embedded object, an ActiveX document is not designed to be a contained object in a larger document. Instead, it is considered in itself a complete document that is merely being viewed (such as with Microsoft Internet Explorer) or collected in a single resource with other documents (such as a Microsoft Office Binder file). An ActiveX document that is hosted in the WebBrowser control is always active; therefore, unlike traditional OLE embedded objects, there is no sense of in-place activation.

While Microsoft Visual Basic .NET and Visual Basic 2005 do not currently support hosting ActiveX documents directly, you may use the WebBrowser control for this purpose. The WebBrowser control (Shdocvw.dll) is a part of Internet Explorer and can only be used on systems that have Internet Explorer installed. 

### Creating a Visual Basic application that opens Office documents

> [!NOTE]
> When you use two methods above to create a Visual Basic application that opens Office documents, you must change the code in Visual Studio 2005. By default, Visual Basic adds one form to the project when you create a Windows Forms project. The form is named Form1. The two files that represent the form are named Form1.vb and Form1.designer.vb. You write the code in Form1.vb. The Form1.designer.vb file is where the Windows Forms Designer writes the code that implements all the actions that you performed by dragging and dropping controls from the Toolbox.

After the Visual Basic application is created, Press F5 to run the project. When you click **Browse**, the **Open** dialog box appears and allows you to browse to a Word, Excel, or PowerPoint file. Select any file and click **Open**. The document opens inside the WebBrowser control, and a message box that displays the name of the Office document server appears

#### Method 1

1. In Microsoft Visual Studio 2005 or in Microsoft Visual Studio .NET, create a Windows Application project by using Visual Basic 2005 or Visual Basic .NET. Form1 is created by default.   
2. On the **Tools** menu, click **Customize ToolBox** to open the **Customize ToolBox** dialog box. On the **COM Components** tab, add a reference to the **Microsoft WebBrowser**. Click **OK** to add the WebBrowser control to the Windows Forms toolbox. The WebBrowser control appears with the text **Explorer** in the toolbox. 

    **Note** In Visual Studio 2005, you do not have to do step 2.   
3. Using the Toolbox, add a WebBrowser control, an OpenFileDialog control, and a Button control to Form1. This step adds the AxWebBrowser1 member variable, the OpenFileDialog1 member variable, and the Button1 member variable to the Form1 class.   
4.  Define a private member in the Form1 class as follows.
    ```vb
    Dim oDocument as Object
    ```

5. Paste the following code in the Form1 class.
    ```vb
    Private Sub Button1_Click(ByVal sender As System.Object, _
       ByVal e As System.EventArgs) Handles Button1.Click
    
    Dim strFileName As String
    
    'Find the Office document.
        With OpenFileDialog1
            .FileName = ""
            .ShowDialog()
            strFileName = .FileName
        End With
    
    'If the user does not cancel, open the document.
        If strFileName.Length Then
            oDocument = Nothing
            AxWebBrowser1.Navigate(strFileName)
        End If
    
    End Sub
    
    Private Sub Form1_Load(ByVal sender As Object, ByVal e As _
       System.EventArgs) Handles MyBase.Load
    
    Button1.Text = "Browse"
    
    With OpenFileDialog1
            .Filter = "Office Documents " & _
            "(*.doc, *.xls, *.ppt)|*.doc;*.xls;*.ppt"
            .FilterIndex = 1
        End With
    
    End Sub
    
    Private Sub Form1_Closing(ByVal sender As Object, ByVal e As _
       System.ComponentModel.CancelEventArgs) Handles MyBase.Closing
    
    oDocument = Nothing
    
    End Sub
    
    Private Sub AxWebBrowser1_NavigateComplete2(ByVal sender As Object, _
       ByVal e As AxSHDocVw.DWebBrowserEvents2_NavigateComplete2Event) _
       Handles AxWebBrowser1.NavigateComplete2
    
    On Error Resume Next
    
    oDocument = e.pDisp.Document
    
    'Note: You can use the reference to the document object to
        '      automate the document server.
        MsgBox("File opened by: " & oDocument.Application.Name)
    
    End Sub
    ```

#### Method 2

1. In Microsoft Visual Studio 2005 or in Microsoft Visual Studio .NET, create a Windows Application project by using Visual Basic 2005 or Visual Basic .NET. Form1 is created by default.
2. From the Project menu, select Components to open the Components dialog box. In the Components dialog box, add references to the Microsoft Common Dialog Control and the Microsoft Internet Controls. Click OK to add the items to the toolbox.
3. Add an instance of the WebBrowser control, CommonDialog control, and a CommandButton to Form1.
4. Next, add the following code into the Code window for Form1:
    
    ```vb
    Option Explicit
    
    Dim oDocument As Object
    
    Private Sub Command1_Click()
       Dim sFileName As String
       
     ' Find an Office file...
       With CommonDialog1
          .FileName = ""
          .ShowOpen
          sFileName = .FileName
       End With
       
     ' If the user didn't cancel, open the file...
       If Len(sFileName) Then
          Set oDocument = Nothing
          WebBrowser1.Navigate sFileName
       End If
    End Sub
    
    Private Sub Form_Load()
       Command1.Caption = "Browse"
       ' For the 2007 Microsoft Office documents, change the .Filter parameter of the 
       ' With CommonDialog1 statement to:
       ' .Filter = "Office Documents " & _
       '      "(*.docx, *.xlsx, *.pptx)|*.docx;*.xlsx;*.pptx"
       With CommonDialog1
          .Filter = "Office Documents " & _
          "(*.doc, *.xls, *.ppt)|*.doc;*.xls;*.ppt"
          .FilterIndex = 1
          .Flags = cdlOFNFileMustExist Or cdlOFNHideReadOnly
       End With
    End Sub
    
    Private Sub Form_Unload(Cancel As Integer)
       Set oDocument = Nothing
    End Sub
    
    Private Sub WebBrowser1_NavigateComplete2(ByVal pDisp As Object, _
    URL As Variant)
       On Error Resume Next
       Set oDocument = pDisp.Document
    
       MsgBox "File opened by: " & oDocument.Application.Name
    End Sub
    ```

### Considerations when you use the WebBrowser control
 
You should consider the following when you use the WebBrowser control: 

- The WebBrowser control browses to documents asynchronously. When you call WebBrowser1.Navigate, the call returns control to your Visual Basic application before the document has been completely loaded. If you plan to Automate the contained document, you need to use the NavigateComplete2 event to be notified when the document has finished loading. Use the Document property of the WebBrowser object that is passed in to get a reference to the Office document object, which, in the preceding code, is set to oDocument.   
- The WebBrowser control does not support menu merging.    
- The WebBrowser control generally hides any docked toolbars before displaying an Office document. You can use Automation to show a floating toolbar using code such as the following.
    ```vb
    With oDocument.Application.CommandBars("Standard")
       .Position = 4 '[msoBarFloating]
       .Visible = True
    End With
    
    ```
  Newer versions of Internet Explorer (5.0 and later) also allow you to display docked toolbars using the following code. 
    ```vb
    ' This is a toggle option, so call it once to show the 
    ' toolbars and once to hide them. This works with Internet Explorer 5
    ' but often fails to work properly with earlier versions...
    AxWebBrowser1.ExecWB(SHDocVw.OLECMDID.OLECMDID_HIDETOOLBARS, SHDocVw.OLECMDEXECOPT.OLECMDEXECOPT_DONTPROMPTUSER)
    ```

- There are several known issues with having more than one WebBrowser control in a project and having each control loaded with the same type of Office document (that is, all Word documents, or all Excel spreadsheets). It is recommended that you only use one control per project, and browse to one document at a time.

    The most common problem is with Office command bars, which appear disabled. If you have two WebBrowser controls on the same form, both of which are loaded with Word documents, and you have displayed toolbars by using one of the preceding techniques, only one set of toolbars is active and works correctly. The other is disabled and cannot be used.   
- To clear the WebBrowser of its current contents, in the Click event of another command button (or in some other appropriate place in your code), browse to the default blank page by using the following code:
    ```vb
       AxWebBrowser1.Navigate("about:blank")
    ```

### Considerations when you use the WebBrowser control together with a 2007 Microsoft Office program

By default, the 2007 Office programs do not open Office documents in the Web browser. This behavior also affects the WebBrowser control. We recommended that you use a custom ActiveX document container instead of the WebBrowser control when you develop applications that open 2007 Office documents.

For existing applications that require backward compatibility with the WebBrowser control, you can modify the registry to configure Internet Explorer. You can use this method to configure Internet Explorer to open 2007 Office documents in the Web browser. For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[927009](https://support.microsoft.com/help/927009) A new window opens when you try to view a 2007 Microsoft Office program document in Windows Internet Explorer 7

**Note** If you modify the registry by using the method that is mentioned in Knowledge Base article 927009, the changes affect the WebBrowser control that you use in the application. The changes also affect all instances of Internet Explorer. Additionally, this method may not work for any future versions of the Microsoft Office suites. Therefore, we recommend that you use this method only for compatibility with a existing application.

## References

For more information about how to use the WebBrowser control, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[304562](https://support.microsoft.com/help/304562) Visual Studio 2005 and Visual Studio .NET do not provide an OLE container control for Windows Forms

[927009](https://support.microsoft.com/help/927009) A new window opens when you try to view a 2007 Microsoft Office program document in Windows Internet Explorer 7