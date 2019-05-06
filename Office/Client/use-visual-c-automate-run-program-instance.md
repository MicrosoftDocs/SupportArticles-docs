---
title: How to use Visual C# to automate a running instance of an Office program
description: Describes how to create a Visual C# 2005 or Visual C# .NET client that gets an Automation Reference to a running instance of an Office program.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to use Visual C# to automate a running instance of an Office program

## Summary

This step-by-step article shows you how to create a Microsoft Visual C# 2005 or Microsoft Visual C# .NET client that gets an Automation Reference to a running instance of an Office program.

### Create a Visual C# 2005 or Visual C# .NET Application That Automates a Running Instance of an Office Program
 
Client programs that automate Office can either create a new instance of that Office program or get a reference to the instance that is already running. Microsoft generally recommends that you create a new instance instead of attaching to a running instance. However, in some scenarios, the client program must automate an already-running instance of an Office program. In this case, the Automation client gets the reference to the Automation server's Component Object Model (COM) object from the Running Object Table (ROT). 

If the Automation server registered itself in the Running Object Table, a .NET client can get a reference to the running instance by calling the following:

System.Runtime.InteropServices.Marshal.GetActiveObject

-or-

System.Runtime.InteropServices.Marshal.BindToMoniker

#### Sample Code

1. Start Microsoft Visual Studio 2005 or Microsoft Visual Studio .NET. On the File menu, click New, and then click Project. Under Project types, click Visual C# Projects, and then, under Templates, click Windows Application. Form1 is created by default.

    **Note** In Visual C# 2005, click **Visual C#** instead of **Visual C# Projects**.   
2. Add a reference to the Microsoft Excel Object Library and the Microsoft Word Object Library. To do this, follow these steps:

   1. On the Project menu, click Add Reference.   
   2. On the COM tab, locate the**Microsoft Excel Object Library**, and then click Select.

      **Note** In Visual C# 2005, you do not have to click **Select**.

      **Note** Microsoft Office 2003 includes Primary Interop Assemblies (PIAs). Microsoft Office XP does not include PIAs, but they may be downloaded. 

   3. Locate the **Microsoft Word Object Library**, and then click Select.

      **Note** In Visual C# 2005, you do not have to click **Select**. 
  
   4. In the Add References dialog box, click OK to accept your selections.   
   
3. On the View menu, click Toolbox to display the toolbox. Add three buttons and a text box to Form1. Type the text for these controls as follows:

     |ID |Text|
     |--------| ---------|
     |button1| Get Automation Reference to running Instance of Excel|
     |button2| Get Automation Reference to Excel using File Moniker|
     |button3 |Shell Word and Get Automation Reference to it|
     |textBox1| Enter the filename for the saved xls file|

4. Set up the Click event handlers of the button controls, as follows:

   1. Double-click button1, and then click Designer on the View menu.   
   2. Double-click button2, and then click Designer on the View menu.   
   3. Double-click button3.   
   
5. Add the following code to the top of Form1.cs, after the other using statements:
    ```vb
    using Excel = Microsoft.Office.Interop.Excel;
    using Word = Microsoft.Office.Interop.Word;
    ```

6. Add the following code to the event handlers:
    ```vb
    private void button1_Click(object sender, System.EventArgs e)
    {
    
    //Excel Application Object
    Excel.Application oExcelApp;
    
    this.Activate();
    
    //Get reference to Excel.Application from the ROT.
    oExcelApp =  (Excel.Application)System.Runtime.InteropServices.Marshal.GetActiveObject("Excel.Application");
    
    //Display the name of the object.
    MessageBox.Show(oExcelApp.ActiveWorkbook.Name);
    
    //Release the reference.
    oExcelApp = null;
    }
    
    private void button2_Click(object sender, System.EventArgs e)
    {
    Excel.Workbook  xlwkbook;
    Excel.Worksheet xlsheet;
    
    //Get a reference to the Workbook object by using a file moniker.
    //The xls was saved earlier with this file name.
    xlwkbook = (Excel.Workbook)  System.Runtime.InteropServices.Marshal.BindToMoniker(textBox1.Text); 
    
    string sFile = textBox1.Text.Substring(textBox1.Text.LastIndexOf("\\")+1);
    xlwkbook.Application.Windows[sFile].Visible = true;
    xlwkbook.Application.Visible = true;
    xlsheet = (Excel.Worksheet) xlwkbook.ActiveSheet;
    xlsheet.Visible = Excel.XlSheetVisibility.xlSheetVisible;
    xlsheet.Cells[1,1] = 100;
    
    //Release the reference.
    xlwkbook = null;
    xlsheet = null;
    }
    
    private void button3_Click(object sender, System.EventArgs e)
    {
    Word.Application wdapp;
    
    //Shell Word
    System.Diagnostics.Process.Start("<Path to WINWORD.EXE>");
    
    this.Activate();
    
    //Word and other Office applications register themselves in 
    //ROT when their top-level window loses focus. Having a MessageBox 
    //forces Word to lose focus and then register itself in the ROT.
    
    MessageBox.Show("Launched Word");
    
    //Get the reference to Word.Application from the ROT.
    wdapp = (Word.Application)System.Runtime.InteropServices.Marshal.GetActiveObject("Word.Application");
    
    //Display the name.
    MessageBox.Show(wdapp.Name);
    
    //Release the reference.
    wdapp = null;
    }
    
    ```
    **Note** In button3_click(), replace **Path to Winword.exe** with the correct path to Winword.exe. The default location for Microsoft Word is C:\Program Files\Microsoft Office\Office\Winword.exe. 

7. On the Build menu, select Build Solution to build the application.   

### Test the Application

1. Press F5 to build and run your application.   
2. Shut down all running instances of Excel.   
3. Start Excel with a new workbook.   
4. Click the **Get Automation Reference to running Instance of Excel** button.   
5. The application gets the Automation reference to the existing instance of Excel. The Automation reference is stored in the local variable oExcelApp for button1_Click. A message box displays the name of the active workbook.   
6. Save the workbook to your local disk. Leave the workbook open in Excel.   
7. Type the full path and file name of the workbook that you saved in the previous step in textBox1.   
8. Click the **Get Automation Reference to Excel using File Moniker** button.   
9. The application gets an Automation reference to the running instance of Excel. The Automation Reference is stored in the local variable xlwkbookfor button2_Click. A value of 100 is entered in the first row and first column of the active sheet.   
10. Quit Excel without saving changes to the workbook.   
11. Click the **Get Automation Reference to Excel using File Moniker** button.   
12. A new instance of Excel is created, and the previously saved workbook is opened. The application gets an Automation reference to this instance of Excel. The Automation Reference is stored in the local variable xlwkbook for button2_Click. A value of 100 is entered in the first row and first column of the active sheet.   
13. Close Excel.   
14. Click the **Shell Word and Get Automation Reference to it** button.   
15. Word starts, just as if you started it from a command prompt, and a Launched Word message box is displayed. Displaying a message box forces a WM_SETFOCUS message to be sent to the Word program window. This allows Word to register itself in the Running Object Table (ROT).   
16. Close the message box. The program gets an Automation reference to the newly started instance of Word. The Automation reference is stored in the local variable wdapp for button3_Click. A message box is displayed that shows the name of the Word.Application object.   

### Additional Notes
 
COM servers can be classified as Multiuse (Single Instance) or Single Use (Multiple Instances), depending on the number of instances of that server that can run simultaneously on a single computer. 

When a request for a new COM object comes to a Multiuse (Single Instance) COM server, the server uses only one instance of the .exe file to create that object. No matter how many clients request a new COM object, there will be only one server .exe process. In the Single Use (Multiple Instances) server, each request for a new COM object starts a separate instance of the server .exe file. Therefore, more than one instance of the server can run on the same computer.

Multiple instances of Word (Winword.exe), Excel (Excel.exe), and Microsoft Access (MSAccess.exe) can run simultaneously. Therefore, these servers are defined as Single Use (Multiple Instances) servers. Only one instance of PowerPoint (Powerpnt.exe) can run at any given time. Therefore, PowerPoint is a Multiuse (Single Instance) server.

Whether a COM server is Single Use (Multiple Instances) or Multiuse (Single Instance) might affect your decision to use GetActiveObject to get reference to that server. Because potentially more than one instance of Word, Excel, or Microsoft Access can be running, GetActiveObject on a particular server may return an instance that you did not expect. The instance that is first registered in the ROT is typically the instance that is returned by GetActiveObject. If you want to get an Automation Reference to a specific running instance of Word, Excel, or Microsoft Access, use BindToMoniker with the name of the file that is opened in that instance. For a Multiuse (Single Instance) server like PowerPoint, it does not matter, because the automation reference points to the same running instance. 

COM servers are expected to register themselves in Running Object Table after startup. Office programs register themselves when they lose focus. If a program tries to attach to a running instance before the program loses focus, you may receive an error message. 

### References

For additional information about the different behaviors of Office programs when you use GetActiveObject, click the article number below to view the article in the Microsoft Knowledge Base: 

[288902](https://support.microsoft.com/help/288902) INFO: GetObject and CreateObject Behavior of Office Automation Servers
 For more information, see the following Microsoft Developer Network (MSDN) Web site:

[Microsoft Office Development with Visual Studio](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx)