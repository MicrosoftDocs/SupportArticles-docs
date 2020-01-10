---
title: Use WebBrowser control to open documents in Visual C# 2005 or Visual C# .NET
description: Describes some sample steps for how to use the WebBrowser control to open Office documents in Visual C# 2005 or in Visual C# .NET.
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
- Microsoft Office
---

# How to use the WebBrowser control to open Office documents in Visual C# 2005 or in Visual C# .NET

For a Microsoft Visual Basic .NET version of this article, see [304643](https://support.microsoft.com/help/304643).

## Summary

You may want to display or to embed a Microsoft Office document directly on a Microsoft Visual C# form. Microsoft Visual C# 2005 and Microsoft Visual C# .NET do not provide an OLE control that allows you to embed an Office document on a form. If you want to embed an existing document and open it as an in-place ActiveX document object in a Visual C# form, a potential solution for you is to use the Microsoft WebBrowser control.

This article demonstrates how to browse to an existing Office document and how to display it inside a Visual C# form by using the WebBrowser control.

## More Information

ActiveX documents are embeddable OLE objects that behave more like ActiveX controls than traditional OLE objects. Unlike a traditional embedded object, an ActiveX document is not designed to be a contained object in a larger document. Instead, it is considered in itself a complete document that is merely being viewed (such as with Microsoft Internet Explorer) or being collected into a single resource with other documents (such as a Microsoft Office Binder file). An ActiveX document that is hosted in the WebBrowser control is always active; therefore, unlike traditional OLE embedded objects, there is no sense of in-place activation.

Although Visual C# 2005 and Visual C# .NET do not currently support hosting ActiveX documents directly, you can use the WebBrowser control for this purpose. The WebBrowser control (Shdocvw.dll) is a part of Internet Explorer and can only be used on systems that have Internet Explorer installed.

### Creating a Visual C# application that opens Office documents
To create a Visual C# application that opens Office documents, follow these steps:

1. Create a new Windows Application project in Visual C# 2005 or in Visual C# .NET. Form1 is created by default.

    **Note** In Visual C# 2005, if you cannot find the SHDocVw.dll file or the AxSHDocVw.dll file, run the following command at the Visual Studio command prompt: 

    ```cs
    aximp %WINDIR%\system32\shdocvw.dll
    ```
    Then, create a common language runtime proxy (SHDocVw.dll) and a Windows Forms proxy (AxSHDocVw.dll) for the Microsoft Web Browser control. To add the DLL files in Visual C# 2005, follow these steps:
     1. On the **Project** menu, click **Add Reference**.   
     2. In the **Add Reference** dialog box, click **Browse**.   
     3. Locate and then select the AxSHDocVw.dll file and the SHDocVw.dll file.   
     4. To add project references for these two files, click **OK**.   
   
2. On the Tools menu, click Customize ToolBox to open the Customize ToolBox dialog box. On the COM Components tab, add a reference to Microsoft WebBrowser. Click OK to add the WebBrowser control to the Windows Forms toolbox. The WebBrowser control appears with the text Explorer in the toolbox. 

   **Note** In Visual Studio 2005, you do not have to do step 2.   
3. Using the toolbox, add a WebBrowser control, an OpenFileDialog control, and a CommandButton control to Form1. This adds the AxWebBrowser1, OpenFileDialog1, and Button1 member variables to the Form1 class. In Visual C# 2005, the webBrowser1, openFileDialog1, and button1 member variables are added.   
4. On Form1, double-click Button1. This adds the Button1_Click event to Form1.

5. In the code window for Form1, add the following namespace to the list:

    ```cs
    using System.Reflection;
    ```

6. Define a private member in class Form1 as follows:

    ```cs
    private Object oDocument;
    ```

7. At the end of the InitializeComponent method of class Form1, add the following code to handle the Form1_Load, Form1_Closed, and axWebBrowser1_NavigateComplete2 events:

    ```cs
    this.axWebBrowser1.NavigateComplete2 += new AxSHDocVw.DWebBrowserEvents2_NavigateComplete2EventHandler(this.axWebBrowser1_NavigateComplete2);
    this.Load += new System.EventHandler(this.Form1_Load);
    this.Closed += new System.EventHandler(this.Form1_Closed);
    ```

8. Replace the following code
    ```cs
    private void button1_Click(object sender, System.EventArgs e)
    {
    }
    
    ```
    with:

    ```cs
    private void button1_Click(object sender, System.EventArgs e)
    {
    
    String  strFileName;
    
    //Find the Office document.
     openFileDialog1.FileName = "";
     openFileDialog1.ShowDialog();
     strFileName = openFileDialog1.FileName;
    
    //If the user does not cancel, open the document.
     if(strFileName.Length != 0)
     {
      Object refmissing = System.Reflection.Missing.Value;
      oDocument = null;
      axWebBrowser1.Navigate(strFileName, ref refmissing , ref refmissing , ref refmissing , ref refmissing);
     }
    }
    
    public void Form1_Load(object sender, System.EventArgs e)
    {
     button1.Text = "Browse";
     openFileDialog1.Filter = "Office Documents(*.doc, *.xls, *.ppt)|*.doc;*.xls;*.ppt" ;
     openFileDialog1.FilterIndex = 1;
    }
    
    public void Form1_Closed(object sender, System.EventArgs e)
    {
     oDocument = null;
    }
    
    public void axWebBrowser1_NavigateComplete2(object sender, AxSHDocVw.DWebBrowserEvents2_NavigateComplete2Event e)
    {
    
    //Note: You can use the reference to the document object to 
     //      automate the document server.
    
    Object o = e.pDisp;
    
    oDocument = o.GetType().InvokeMember("Document",BindingFlags.GetProperty,null,o,null);
    
    Object oApplication = o.GetType().InvokeMember("Application",BindingFlags.GetProperty,null,oDocument,null);
    
    Object oName = o.GetType().InvokeMember("Name",BindingFlags.GetProperty ,null,oApplication,null);
    
    MessageBox.Show("File opened by: " + oName.ToString() ); 
    }
    
    ```
    **Note** You must change the code in Visual Studio 2005. By default, Visual C# adds one form to the project when you create a Windows Forms project. The form is named Form1. The two files that represent the form are named Form1.cs and Form1.designer.cs. You write the code in Form1.cs. The Form1.designer.cs file is where the Windows Forms Designer writes the code that implements all the actions that you performed by dragging and dropping controls from the Toolbox. 

    For more information about the Windows Forms Designer in Visual C# 2005, visit the following Microsoft Developer Network (MSDN) Web site: [https://msdn.microsoft.com/en-us/library/ms173077.aspx](https://msdn.microsoft.com/library/ms173077.aspx)   
9. Press F5 to run the project. When you click Browse, the Open dialog box appears and allows you to browse to a Word document, an Excel worksheet, or a PowerPoint presentation. Select any file, and then click Open. The document opens inside the WebBrowser control, and a message box that displays the name of the Office document server appears.   

### What to consider when you use the WebBrowser control

You should consider the following when you use the WebBrowser control:

- The WebBrowser control browses to documents asynchronously. When you call WebBrowser1.Navigate, the call returns control to your Visual C# application before the document has been completely loaded. If you plan on automating the contained document, you need to use the NavigateComplete2 event to be notified when the document has finished loading. Use the Document property of the WebBrowser object that is passed in to get a reference to the Office document object, which, in the preceding code, is set to oDocument.   
- The WebBrowser control does not support menu merging.    
- In Internet Explorer versions 5.0 and later, you can display docked toolbars by using the following code:
    ```cs
     // This is a toggle option, so call it once to show the 
     // toolbars and once to hide them. This works with Internet Explorer 5
     // but often fails to work properly with earlier versions.
    
    Object refmissing = System.Reflection.Missing.Value;
     axWebBrowser1.ExecWB(SHDocVw.OLECMDID.OLECMDID_HIDETOOLBARS, SHDocVw.OLECMDEXECOPT.OLECMDEXECOPT_DONTPROMPTUSER,ref refmissing , ref refmissing);
    ```

- There are several known issues with having more than one WebBrowser control in a project and with having each control loaded with the same type of Office document (that is, all Word documents or all Excel worksheets). Microsoft recommends that you use only one control for each project, and browse to one document at a time.

    The most common problem is with Microsoft Office command bars, which appear disabled. If you have two WebBrowser controls on the same form, both of which are loaded with Word documents, and if you have displayed toolbars by using one of the preceding techniques, only one set of toolbars is active and works correctly. The other is disabled and cannot be used.   
- To clear the WebBrowser control of its current contents, in the Click event of another command button (or in some other appropriate place in your code), browse to the default blank page by using the following code:
    ```cs
       AxWebBrowser1.Navigate("about:blank");
    ```

### What to consider when you use the WebBrowser control together with a 2007 Microsoft Office program

By default, the 2007 Office programs do not open Office documents in the Web browser. This behavior also affects the WebBrowser control. We recommended that you use a custom ActiveX document container instead of the WebBrowser control when you develop applications that open 2007 Office documents.

For existing applications that require backward compatibility with the WebBrowser control, you can modify the registry to configure Internet Explorer. You can use this method to configure Internet Explorer to open 2007 Office documents in the Web browser. For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[927009](https://support.microsoft.com/help/927009) A new window opens when you try to view a 2007 Microsoft Office program document in Windows Internet Explorer 7

> [!NOTE]
> If you modify the registry by using the method that is mentioned in Microsoft Knowledge Base article 927009, the changes affect the WebBrowser control that you use in the application. The changes also affect all instances of Internet Explorer. Additionally, this method may not work for any future versions of the Microsoft Office suites. Therefore, we recommend that you use this method only for compatibility with an existing application.

## References

For more information about using the WebBrowser control, click the following article numbers to view the articles in the Microsoft Knowledge Base:

- [304562](https://support.microsoft.com/help/304562) Visual Studio 2005 and Visual Studio .NET do not provide an OLE container control for Windows Forms

- [243058](https://support.microsoft.com/help/243058) How to use the WebBrowser control to open an Office document

- [927009](https://support.microsoft.com/help/927009) A new window opens when you try to view a 2007 Microsoft Office program document in Windows Internet Explorer 7