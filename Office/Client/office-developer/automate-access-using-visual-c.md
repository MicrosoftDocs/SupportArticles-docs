---
title: How to automate Microsoft Access by using Visual C#
description: Describes how to automate Microsoft Access from Visual C# 2005 or Visual C# .NET.
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
- Microsoft Access
---

# How to automate Microsoft Access by using Visual C#

## Summary

This article demonstrates how to automate Microsoft Access by using Microsoft Visual C# 2005 or Microsoft Visual C# .NET. The topics and the sample code show you how to do the following: 

- Open a database in Access.   
- Print or preview an Access report.   
- Show and edit an Access form.   
- Avoid dialog boxes when you open a password-protected database or when user-level security is turned on.   
- Automate the Access Runtime.   

### Automation vs. ADO.NET
 
A developer can work with a Microsoft Access database from Visual C# 2005 or Visual C# .NET by using two separate technologies: Automation and Microsoft ADO.NET.

ADO.NET is the preferred technology if you want to work with data objects, such as tables and queries in an Access database. Use Automation only if you need Microsoft Access application-specific features, such as the ability to print or to preview an Access report, to display an Access form, or to call Access macros.

This article discusses how to automate Access. The article does not discuss ADO.NET. For information regarding ADO.NET, click the article numbers below to view the articles in the Microsoft Knowledge Base: 

- [306636](https://support.microsoft.com/help/306636) How to connect to a database and run a command by using ADO 2005 and Visual C# 2005 or by using ADO.NET and Visual C# .NET

- [314145](https://support.microsoft.com/help/314145) How to populate a DataSet object from a database by using Visual C# .NET

- [307587](https://support.microsoft.com/help/307587) How to update a database from a DataSet object by using Visual C# 2005 or Visual C# .NET

Automation is a Component Object Model (COM) technology. Automation allows applications that are written in languages such as Visual C# .NET to programmatically control other applications. When you automate a Microsoft Office application, you actually run an instance of that application in memory, and then call on the application's object model to perform various tasks in that application. With Access and other Microsoft Office applications, virtually all of the actions that you can perform manually through the user interface can also be performed programmatically by using Automation.

Access exposes this programmatic functionality through an object model. The object model is a collection of classes and methods that serve as counterparts to the logical components of Access. To access the object model from Visual C# .NET, you can set a project reference to the type library. 

### Common Automation Tasks

#### Open a Database in Access
 
When you automate Microsoft Access, you must open a database before you can perform useful tasks, such as printing reports. To open a database in the instance of Access you are automating, you use the OpenCurrentDatabase or OpenAccessProject methods of the Application object. You can have only one database opened in Access at a time. To work with a different database, you can use the CloseCurrentDatabase method before opening another.

You may also use the System.Runtime.InteropServices.Marshal.BindToMoniker(\<path to database>) method to open a database in an instance of Access. If the database is already open in an instance of Access, BindToMoniker returns the Application object of that instance. Otherwise, BindToMoniker starts a new instance of Access and opens the specified database.
 
OpenCurrentDatabase is the preferred method to open a database, because you specify the instance of Access that you are automating. You can also provide arguments to control how the database is opened, for example: 

```sql
Access.Application oAccess = null;

// Start a new instance of Access for Automation:
oAccess = new Access.ApplicationClass();

// Open a database in exclusive mode:
oAccess.OpenCurrentDatabase(
   "c:\\mydb.mdb", //filepath
   true //Exclusive
   );
```

#### Print or Preview an Access Report
 
To preview or to print an Access report, you call the OpenReport method of the DoCmd object. When you call OpenReport, one of the arguments that you pass determines whether the report is previewed on the screen, or whether it is sent to the printer: 

```sql
// Preview a report named Sales:
oAccess.DoCmd.OpenReport(
   "Sales", //ReportName
   Access.AcView.acViewPreview, //View
   System.Reflection.Missing.Value, //FilterName
   System.Reflection.Missing.Value //WhereCondition
   );

// Print a report named Sales:
oAccess.DoCmd.OpenReport(
   "Sales", //ReportName
   Access.AcView.acViewNormal, //View
   System.Reflection.Missing.Value, //FilterName
   System.Reflection.Missing.Value //WhereCondition
   );
```
 
Notice that the View argument determines whether the report is displayed in Access or whether it is sent to the printer. The WhereCondition argument can limit the report's recordset, if you use a valid SQL WHERE clause (without the word WHERE.) Notice that you can use System.Reflection.Missing.Value to skip any object parameters that are optional.

If you are previewing a report, be sure to set the Visible property of the Application object so that Access is visible on the screen. In this way, the user can view the report in the Access window.

There is another way to print a report or other objects in the database. Use the PrintOut method of the DoCmd object. In this example, you select a report named Employees in the Database window, and then you call PrintOut to print the selected object. The PrintOut method allows you to provide arguments that correspond to the Print dialog box in Access: 

```sql
// Select the Employees report in the database window:
oAccess.DoCmd.SelectObject(
   Access.AcObjectType.acReport, //ObjectType
   "Employees", //ObjectName
   true //InDatabaseWindow
   );

// Print 2 copies of the selected object:
oAccess.DoCmd.PrintOut(
   Access.AcPrintRange.acPrintAll, //PrintRange
   System.Reflection.Missing.Value, //PageFrom
   System.Reflection.Missing.Value, //PageTo
   Access.AcPrintQuality.acHigh, //PrintQuality
   2, //Copies
   false //CollateCopies
   );
```
 
Or, in some cases, you may want to use both the OpenReport and the PrintOut methods to print a report. Suppose you want to print multiple copies of the Employees report but only for a specific employee. This example first uses OpenReport to open the Employees report in preview mode, using the WhereCondition argument to limit the records to a specific employee. Then, PrintOut is used to print multiple copies of the active object: 

```sql
// Open the report in preview mode using a WhereCondition:
oAccess.DoCmd.OpenReport(
   "Employees", //ReportName
   Access.AcView.acViewPreview, //View
   System.Reflection.Missing.Value, //FilterName
   "[EmployeeID]=1" //WhereCondition
   );

// Print 2 copies of the active object: 
oAccess.DoCmd.PrintOut(
   Access.AcPrintRange.acPrintAll, //PrintRange
   System.Reflection.Missing.Value, //PageFrom
   System.Reflection.Missing.Value, //PageTo
   Access.AcPrintQuality.acHigh, //PrintQuality
   2, //Copies
   false //CollateCopies
   );

// Close the report preview window: 
oAccess.DoCmd.Close(
   Access.AcObjectType.acReport, //ObjectType
   "Employees", //ObjectName
   Access.AcCloseSave.acSaveNo //Save
   );
```

Access 2002 introduced the Printer object. You can use this object to customize Access printer settings more easily than in earlier versions of Access. For an example of using the Printer object in Access to print a report, click the article number below to view the article in the Microsoft Knowledge Base: 

[284286](https://support.microsoft.com/help/284286) How to reset changes to the Application.Printer object

#### Show and Edit an Access Form
 
Visual C# .NET has very powerful form capabilities. However, there may be times when you want the user to view a form that was previously developed in Access. Or, you may have a form in your Access database that provides criteria for a query or report, and you must open that form before you can preview or print the report. To open and show an Access form, you call the OpenForm method of the DoCmd object: 

```sql
// Show a form named Employees:
oAccess.DoCmd.OpenForm(
   "Employees", //FormName
   Access.AcFormView.acNormal, //View
   System.Reflection.Missing.Value, //FilterName
   System.Reflection.Missing.Value, //WhereCondition
   Access.AcFormOpenDataMode.acFormPropertySettings, //DataMode
   Access.AcWindowMode.acWindowNormal, //WindowMode
   System.Reflection.Missing.Value //OpenArgs
   );
```
 
You can now edit the controls on the form.

### Access Security Dialog Boxes
 
When you automate Access, you may be prompted to enter a user name or a password, or both, when you try to open a database. If the user enters the wrong information, an error will occur in your code. There may be times when you want to avoid these dialog boxes and instead to programmatically provide the user name and password so that your Automation code runs uninterrupted.

There are two types of security in Microsoft Access: password-protected databases and user-level security through a workgroup file (System.mdw). If you are trying to open a database that is password protected, you will receive a dialog box prompting for the database password. User-level security is different from a password-protected database. When user-level security is activated, Access displays a logon dialog box prompting for both a user name and password before the user can open any database in Access.

#### Avoiding Database Password Dialog Boxes
 
If you are opening a database that has been protected with a password, you can avoid the dialog box by providing the password to the OpenCurrentDatabase method: 

```sql
// Open a password-protected database in shared mode:
// Note: The bstrPassword argument is case-sensitive
oAccess.OpenCurrentDatabase(
   "c:\\mydb.mdb", //filepath
   false, //Exclusive
   "MyPassword" //bstrPassword
   );
```

Here is an example, where oAccess has been previously set to an instance of Access that does not have a database open. This code provides the password to the database to avoid a dialog box: 

```sql
string sDBPassword = "MyPassword"; //database password
DAO._DBEngine oDBEngine = oAccess.DBEngine;
DAO.Database oDB = oDBEngine.OpenDatabase("c:\\mydb.mdb",
   false, false, ";PWD=" + sDBPassword);
oAccess.OpenCurrentDatabase("c:\\mydb.mdb", false);
oDB.Close();
System.Runtime.InteropServices.Marshal.ReleaseComObject(oDB);
oDB = null;
System.Runtime.InteropServices.Marshal.ReleaseComObject(oDBEngine);
oDBEngine = null;
```
 
The oDB.Close does not actually close the database in Access. It only closes the DAO connection to the database that was made through the DBEngine object. The DAO connection is no longer necessary after the OpenCurrentDatabase method is used. Notice the code to release the oDB and oDBEngine objects. You must use these objects so that Access quits correctly after the code is completed.

#### Avoiding Access Security Logon Dialog Boxes
 
If user-level security is turned on in Access, the user is prompted with a logon dialog box, prompting for both a user name and a password. A user name and a password cannot be specified using the Access object model. Therefore, if you want to avoid the logon dialog box when you automate Access, you must first start the Msaccess.exe file and provide the /user and /pwd command-line switches to specify the user name and password. Afterward, you can use GetActiveObject or BindToMoniker to retrieve the Application object of the running instance of Access, so that you can then proceed with Automation. 

### Automating Access Runtime
 
The Microsoft Office Developer Edition includes the Microsoft Office Developer Tools (MOD). Using MOD, Access developers can create and distribute Access applications to users who do not have the retail version of Access. When the user installs the Access application on a computer that does not have the retail version of Access, a Runtime version of Access is installed. The Access Runtime is installed and is registered like the retail version. The executable is also called Msaccess.exe. The Access Runtime allows an Access application to run on a client computer, but the Access Runtime does not permit a user to develop new applications or modify the design of existing applications. 

The Access Runtime must be started with a database. Because of this requirement, if you want to automate the Access Runtime, you must start the Msaccess.exe and specify a database to open. After you use GetActiveObject or BindToMoniker to retrieve the Application object, you can then automate the Access Runtime. If you do not use this approach when you try to automate the Access Runtime, you will receive an error message such as the following when you try to instantiate the instance:
  
**System.Runtime.InteropServices.COMException (0x80080005) Server execution failed.**

### Create the Complete Sample Visual C# 2005 or Visual C# .NET Project
 
To use the following step-by-step sample, make sure the Northwind sample database is installed. By default, Microsoft Access 2000 installs the sample databases in the following path: 

C:\Program Files\Microsoft Office\Office\Samples 

Microsoft Access 2002 uses the following path: 

C:\Program Files\Microsoft Office\Office10\Samples 

Microsoft Office Access 2003 uses the following path:

C:\Program Files\Microsoft\Office\Office11\Samples

To make sure that the Northwind sample database is installed on Access 2002 or on Access 2003, click Sample Databases on the Help menu, and then click Northwind Sample Database. 

1. Close any instances of Access that are currently running.   
2. Start Microsoft Visual Studio .NET.   
3. On the File menu, click New, and then click Project. Select Windows Application from the Visual C# Project types. By default, Form1 is created.

    **Note** You must change the code in Visual Studio 2005. By default, Visual C# adds one form to the project when you create a Windows Forms project. The form is named Form1. The two files that represent the form are named Form1.cs and Form1.designer.cs. You write the code in Form1.cs. The Form1.designer.cs file is where the Windows Forms Designer writes the code that implements all the actions that you performed by dragging and dropping controls from the Toolbox. 
    
    For more information about the Windows Forms Designer in Visual C# 2005, visit the following Microsoft Developer Network (MSDN) Web site: [https://msdn.microsoft.com/en-us/library/ms173077.aspx](https://msdn.microsoft.com/library/ms173077.aspx)   
4. Add a reference to Microsoft Access Object Library. To do this, follow these steps: 

   1. On the Project menu, click Add Reference.   
   2. On the COM tab, locate Microsoft Access Object Library, and then click Select.

   **Note** In Visual Studio 2005. you do not have to click **Select**.

    **Note** Microsoft Office 2003 includes Primary Interop Assemblies (PIAs). Microsoft Office XP does not include PIAs, but they can be downloaded. 

3. In the Add References dialog box, click OK to accept your selections.

    **Note** If you are referencing the Access 10.0 object library and you receive errors when you try to add the reference.
   
5. On the View menu, click Toolbox to display the toolbox.   
6. Add five radio button controls and one button control to Form1.   
7. Select all of the radio button controls, and then set the Size property to 150,24.   
8. Add event handlers for the Form Load event and for the Click event of the Button control: 

   1. In design view for Form1.cs, double-click Form1. 

        The handler for the Form's Load event is created and displayed in Form1.cs.   
   2. On the View menu, click Designer to switch to design view.   
   3. Double-click Button1. 

        The handler for the button's Click event is created and displayed in Form1.cs.   
   
9. In Form1.cs, replace the following code

    ```cs
    private void Form1_Load(object sender, System.EventArgs e)
    {
    
    }
    
    private void button1_Click(object sender, System.EventArgs e)
    {
    
    } 
    ```
    with: 

    ```cs
          private string msAction = null;
          // Commonly-used variable for optional arguments:
          private object moMissing = System.Reflection.Missing.Value;
    
    private void Form1_Load(object sender, System.EventArgs e)
          {
             radioButton1.Text = "Print report";
             radioButton2.Text = "Preview report";
             radioButton3.Text = "Show form";
             radioButton4.Text = "Print report (Security)";
             radioButton5.Text = "Preview report (Runtime)";
             button1.Text = "Go!";
             radioButton1.Click += new EventHandler(RadioButtons_Click);
             radioButton2.Click += new EventHandler(RadioButtons_Click);
             radioButton3.Click += new EventHandler(RadioButtons_Click);
             radioButton4.Click += new EventHandler(RadioButtons_Click);
             radioButton5.Click += new EventHandler(RadioButtons_Click);
          }
    
    private void RadioButtons_Click(object sender, System.EventArgs e)
          {
             RadioButton radioBtn = (RadioButton) sender;
             msAction = radioBtn.Text;
          }
    
    private void button1_Click(object sender, System.EventArgs e)
          {
             // Calls the associated procedure to automate Access, based
             // on the selected radio button on the form.
             switch(msAction)
             {
                case "Print report": Print_Report();
                   break;
                case "Preview report": Preview_Report();
                   break;
                case "Show form": Show_Form();
                   break;
                case "Print report (Security)": Print_Report_Security();
                   break;
                case "Preview report (Runtime)": Preview_Report_Runtime();
                   break;
             }
          }
    
    private void NAR(object o)
          {
             // Releases the Automation object.
             try // use try..catch in case o is not set
             {
                Marshal.ReleaseComObject(o);
             }
             catch{}
          }
    
    private Access.Application ShellGetDB(string sDBPath, string sCmdLine,
             ProcessWindowStyle enuWindowStyle, int iSleepTime)
          {
             //Launches a new instance of Access with a database (sDBPath)
             //using System.Diagnostics.Process.Start. Then, returns the
             //Application object via calling: BindToMoniker(sDBPath). Returns
             //the Application object of the new instance of Access, assuming that
             //sDBPath is not already opened in another instance of Access. To
             //ensure the Application object of the new instance is returned, make
             //sure sDBPath is not already opened in another instance of Access
             //before calling this function.
             // 
             //Example:
             //Access.Application oAccess = null;
             //oAccess = ShellGetDB("c:\\mydb.mdb", null,
             //  ProcessWindowStyle.Minimized, 1000);
    
    Access.Application oAccess = null;
             string sAccPath = null; //path to msaccess.exe
             Process p = null;
    
    // Enable exception handler:
             try
             {
                // Obtain the path to msaccess.exe:
                sAccPath = GetOfficeAppPath("Access.Application", "msaccess.exe");
                if (sAccPath == null)
    
    {
                   MessageBox.Show("Can't determine path to msaccess.exe");
                   return null;
                }
    
    // Make sure specified database (sDBPath) exists:
                if(!System.IO.File.Exists(sDBPath))
                {
                   MessageBox.Show("Can't find the file '" + sDBPath + "'");
                   return null;
                }
    
    // Start a new instance of Access passing sDBPath and sCmdLine:
                if(sCmdLine == null)
                   sCmdLine = @"""" + sDBPath + @"""";
                else
                   sCmdLine = @"""" + sDBPath + @"""" + " " + sCmdLine;
                ProcessStartInfo startInfo = new ProcessStartInfo();
                startInfo.FileName = sAccPath;
                startInfo.Arguments = sCmdLine;
                startInfo.WindowStyle = enuWindowStyle;
                p = Process.Start(startInfo);
                p.WaitForInputIdle(60000); //max 1 minute wait for idle input state
    
    // Move focus back to this form. This ensures that Access
                // registers itself in the ROT:
                this.Activate();
    
    // Pause before trying to get Application object:
                System.Threading.Thread.Sleep(iSleepTime);
    
    // Obtain Application object of the instance of Access
                // that has the database open:
                oAccess = (Access.Application) Marshal.BindToMoniker(sDBPath);
                return oAccess;
             }
             catch(Exception e)
             {
                MessageBox.Show(e.Message);
                // Try to quit Access due to an unexpected error:
                try // use try..catch in case oAccess is not set
                {
                   oAccess.Quit(Access.AcQuitOption.acQuitSaveNone);
                }
                catch{}
                NAR(oAccess);
                oAccess = null;
                return null;
             }
          }
    
    private Access.Application ShellGetApp(string sCmdLine,
             ProcessWindowStyle enuWindowStyle)
          {
             //Launches a new instance of Access using System.Diagnostics.
             //Process.Start then returns the Application object via calling:
             //GetActiveObject("Access.Application"). If an instance of
             //Access is already running before calling this function,
             //the function may return the Application object of a
             //previously running instance of Access. If this is not
             //desired, then make sure Access is not running before
             //calling this function, or use the ShellGetDB()
             //function instead. Approach based on Q316125.
             // 
             //Examples:
             //Access.Application oAccess = null;
             //oAccess = ShellGetApp("/nostartup",
             //  ProcessWindowStyle.Minimized);
             // 
             //-or-
             // 
             //Access.Application oAccess = null;
             //string sUser = "Admin";
             //string sPwd = "mypassword";
             //oAccess = ShellGetApp("/nostartup /user " + sUser + "/pwd " + sPwd,
             //  ProcessWindowStyle.Minimized);
    
    Access.Application oAccess = null;
             string sAccPath = null; //path to msaccess.exe
             Process p = null;
             int iMaxTries = 20; //max GetActiveObject attempts before failing
             int iTries = 0; //GetActiveObject attempts made
    
    // Enable exception handler:
             try
             {
                // Obtain the path to msaccess.exe:
                sAccPath = GetOfficeAppPath("Access.Application", "msaccess.exe");
                if(sAccPath == null)
                {
                   MessageBox.Show("Can't determine path to msaccess.exe");
                   return null;
                }
    
    // Start a new instance of Access passing sCmdLine:
                ProcessStartInfo startInfo = new ProcessStartInfo();
                startInfo.FileName = sAccPath;
                startInfo.Arguments = sCmdLine;
                startInfo.WindowStyle = enuWindowStyle;
                p = Process.Start(startInfo);
                p.WaitForInputIdle(60000); //max 1 minute wait for idle input state
    
    // Move focus back to this form. This ensures that Access
                // registers itself in the ROT:
                this.Activate();
    
    tryGetActiveObject:
                // Enable exception handler:
                try
                {   
                   // Attempt to use GetActiveObject to reference a running
                   // instance of Access:
                   oAccess = (Access.Application)
                      Marshal.GetActiveObject("Access.Application");
                }
                catch
                {
                   //GetActiveObject may have failed because enough time has not
                   //elapsed to find the running Office application. Wait 1/2
                   //second and retry the GetActiveObject. If you try iMaxTries
                   //times and GetActiveObject still fails, assume some other
                   //reason for GetActiveObject failing and exit the procedure.
                   iTries++;
                   if(iTries < iMaxTries)
                   {
                      System.Threading.Thread.Sleep(500); //wait 1/2 second
                      this.Activate();
                      goto tryGetActiveObject;
                   }
                   MessageBox.Show("Unable to GetActiveObject after " +
                      iTries + " tries.");
                   return null;
                }
    
    // Return the Access Application object:
                return oAccess;
             }
             catch(Exception e)
             {
                MessageBox.Show(e.Message);
                // Try to quit Access due to an unexpected error:
                try // use try..catch in case oAccess is not set
                {
                   oAccess.Quit(Access.AcQuitOption.acQuitSaveNone);
                }
                catch{}
                NAR(oAccess);
                oAccess = null;
                return null;
             }
          }
    
    private string GetOfficeAppPath(string sProgId, string sEXE)
          {
             //Returns path of the Office application. e.g.
             //GetOfficeAppPath("Access.Application", "msaccess.exe") returns
             //full path to Microsoft Access. Approach based on Q240794.
             //Returns null if path not found in registry.
    
    // Enable exception handler:
             try
             {
                Microsoft.Win32.RegistryKey oReg = 
                   Microsoft.Win32.Registry.LocalMachine;
                Microsoft.Win32.RegistryKey oKey = null;
                string sCLSID = null;
                string sPath = null;
                int iPos = 0;
    
    // First, get the clsid from the progid from the registry key
                // HKEY_LOCAL_MACHINE\Software\Classes\<PROGID>\CLSID:
                oKey = oReg.OpenSubKey(@"Software\Classes\" + sProgId + @"\CLSID");
                sCLSID = oKey.GetValue("").ToString();
                oKey.Close();
    
    // Now that we have the CLSID, locate the server path at
                // HKEY_LOCAL_MACHINE\Software\Classes\CLSID\ 
                // {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx}\LocalServer32:
                oKey = oReg.OpenSubKey(@"Software\Classes\CLSID\" + sCLSID +
                   @"\LocalServer32");
                sPath = oKey.GetValue("").ToString();
                oKey.Close();
    
    // Remove any characters beyond the exe name:
                iPos = sPath.ToUpper().IndexOf(sEXE.ToUpper()); // 0-based position
                sPath = sPath.Substring(0, iPos + sEXE.Length);
                return sPath.Trim();
             }
             catch
             {
                return null;
             }
          }
    
    private void Print_Report()
          {
             // Prints the "Summary of Sales by Year" report in Northwind.mdb.
    
    Access.Application oAccess = null;
             string sDBPath = null; //path to Northwind.mdb
             string sReport = null; //name of report to print
    
    // Enable exception handler:
             try
             {
                sReport = "Summary of Sales by Year";
    
    // Start a new instance of Access for Automation:
                oAccess = new Access.ApplicationClass();
    
    // Determine the path to Northwind.mdb:
                sDBPath = oAccess.SysCmd(Access.AcSysCmdAction.acSysCmdAccessDir,
                   moMissing, moMissing).ToString();
                sDBPath = sDBPath + @"Samples\Northwind.mdb";
    
    // Open Northwind.mdb in shared mode:
                oAccess.OpenCurrentDatabase(sDBPath, false, "");
                // If using Access 10.0 object library, use this instead:
                //oAccess.OpenCurrentDatabase(sDBPath, false, null);
    
    // Select the report name in the database window and give focus
                // to the database window:
                oAccess.DoCmd.SelectObject(Access.AcObjectType.acReport, sReport, true);
    
    // Print the report:
                oAccess.DoCmd.OpenReport(sReport,
                   Access.AcView.acViewNormal, moMissing, moMissing, 
                   Access.AcWindowMode.acWindowNormal, moMissing);
                // If using Access 10.0 object library, use this instead:
                //oAccess.DoCmd.OpenReport(sReport,
                //  Access.AcView.acViewNormal, moMissing, moMissing,
                //  Access.AcWindowMode.acWindowNormal, moMissing);
             }
             catch(Exception e)
             {
                MessageBox.Show(e.Message);
             }
             finally
             {
                // Release any Access objects and quit Access:
                try // use try..catch in case oAccess is not set
                {
                   oAccess.Quit(Access.AcQuitOption.acQuitSaveNone);
                }
                catch{}
                NAR(oAccess);
                oAccess = null;
             }
          }
    
    private void Preview_Report()
          {
             // Previews the "Summary of Sales by Year" report in Northwind.mdb.
    
    Access.Application oAccess = null;
             Access.Form oForm = null;
             string sDBPath = null; //path to Northwind.mdb
             string sReport = null; //name of report to preview
    
    // Enable exception handler:
             try
             {
                sReport = "Summary of Sales by Year";
    
    // Start a new instance of Access for Automation:
                oAccess = new Access.ApplicationClass();
    
    // Make sure Access is visible:
                if(!oAccess.Visible) oAccess.Visible = true;
    
    // Determine the path to Northwind.mdb:
                sDBPath = oAccess.SysCmd(Access.AcSysCmdAction.acSysCmdAccessDir,
                   moMissing, moMissing).ToString();
                sDBPath = sDBPath + @"Samples\Northwind.mdb";
    
    // Open Northwind.mdb in shared mode:
                oAccess.OpenCurrentDatabase(sDBPath, false, "");
                // If using Access 10.0 object library, use this instead:
                //oAccess.OpenCurrentDatabase(sDBPath, false, null);
    
    // Close any forms that Northwind may have opened:
                while(oAccess.Forms.Count > 0)
                {   
                   oForm = oAccess.Forms[0];
                   oAccess.DoCmd.Close(Access.AcObjectType.acForm,
                      oForm.Name, Access.AcCloseSave.acSaveNo);
                   NAR(oForm);
                   oForm = null;
                }
    
    // Select the report name in the database window and give focus
                // to the database window:
                oAccess.DoCmd.SelectObject(Access.AcObjectType.acReport, sReport, true);
    
    // Maximize the Access window:
                oAccess.RunCommand(Access.AcCommand.acCmdAppMaximize);
    
    // Preview the report:
                oAccess.DoCmd.OpenReport(sReport,
                   Access.AcView.acViewPreview, moMissing, moMissing, 
                   Access.AcWindowMode.acWindowNormal, moMissing);
                // If using Access 10.0 object library, use this instead:
                //oAccess.DoCmd.OpenReport(sReport,
                //  Access.AcView.acViewPreview, moMissing, moMissing,
                //  Access.AcWindowMode.acWindowNormal, moMissing);
    
    // Maximize the report window:
                oAccess.DoCmd.Maximize();
    
    // Hide Access menu bar:
                oAccess.CommandBars["Menu Bar"].Enabled = false;
                // Also hide NorthWindCustomMenuBar if it is available:
                try
                {
                   oAccess.CommandBars["NorthwindCustomMenuBar"].Enabled = false;
                }
                catch{}
    
    // Hide Report's Print Preview menu bar:
                oAccess.CommandBars["Print Preview"].Enabled = false;
    
    // Hide Report's right-click popup menu:
                oAccess.CommandBars["Print Preview Popup"].Enabled = false;
    
    // Release Application object and allow Access to be closed by user:
                if(!oAccess.UserControl) oAccess.UserControl = true;
                NAR(oAccess);
                oAccess = null;
             }
             catch(Exception e)
             {
                MessageBox.Show(e.Message);
                // Release any Access objects and quit Access due to error:
                NAR(oForm);
                oForm = null;
                try // use try..catch in case oAccess is not set
                {
                   oAccess.Quit(Access.AcQuitOption.acQuitSaveNone);
                }
                catch{}
                NAR(oAccess);
                oAccess = null;
             }
          }
    
    private void Show_Form()
          {
             // Shows the "Customer Labels Dialog" form in Northwind.mdb
             // and manipulates controls on the form.
    
    Access.Application oAccess = null;
             Access.Form oForm = null;
             Access.Controls oCtls = null;
             Access.Control oCtl = null;
             string sDBPath = null; //path to Northwind.mdb
             string sForm = null; //name of form to show
    
    // Enable exception handler:
             try
             {
                sForm = "Customer Labels Dialog";
    
    // Start a new instance of Access for Automation:
                oAccess = new Access.ApplicationClass();
    
    // Make sure Access is visible:
                if(!oAccess.Visible) oAccess.Visible = true;
    
    // Determine the path to Northwind.mdb:
                sDBPath = oAccess.SysCmd(Access.AcSysCmdAction.acSysCmdAccessDir,
                   moMissing, moMissing).ToString();
                sDBPath = sDBPath + @"Samples\Northwind.mdb";
    
    // Open Northwind.mdb in shared mode:
                oAccess.OpenCurrentDatabase(sDBPath, false, "");
                // If using Access 10.0 object library, use this instead:
                //oAccess.OpenCurrentDatabase(sDBPath, false, null);
    
    // Close any forms that Northwind may have opened:
                while(oAccess.Forms.Count > 0)
                {   
                   oForm = oAccess.Forms[0];
                   oAccess.DoCmd.Close(Access.AcObjectType.acForm,
                      oForm.Name, Access.AcCloseSave.acSaveNo);
                   NAR(oForm);
                   oForm = null;
                }
    
    // Select the form name in the database window and give focus
                // to the database window:
                oAccess.DoCmd.SelectObject(Access.AcObjectType.acForm, sForm, true);
    
    // Show the form:
                oAccess.DoCmd.OpenForm(sForm, Access.AcFormView.acNormal, moMissing,
                   moMissing, Access.AcFormOpenDataMode.acFormPropertySettings,
                   Access.AcWindowMode.acWindowNormal, moMissing);
    
    // Use Controls collection to edit the form:
    
    oForm = oAccess.Forms[sForm];
                oCtls = oForm.Controls;
    
    // Set PrintLabelsFor option group to Specific Country:
    
    oCtl = (Access.Control)oCtls["PrintLabelsFor"];
                object[] Parameters = new Object[1];
                Parameters[0] = 2; //second option in option group
                oCtl.GetType().InvokeMember("Value", BindingFlags.SetProperty,
                   null, oCtl, Parameters);
                NAR(oCtl);
                oCtl = null;
    
    // Put USA in the SelectCountry combo box:
                oCtl = (Access.Control)oCtls["SelectCountry"];
                Parameters[0] = true;
                oCtl.GetType().InvokeMember("Enabled", BindingFlags.SetProperty,
                   null, oCtl, Parameters);
                oCtl.GetType().InvokeMember("SetFocus", BindingFlags.InvokeMethod,
                   null, oCtl, null);
                Parameters[0] = "USA";
                oCtl.GetType().InvokeMember("Value", BindingFlags.SetProperty,
                   null, oCtl, Parameters);
                NAR(oCtl);
                oCtl = null;
    
    // Hide the Database Window:
                oAccess.DoCmd.SelectObject(Access.AcObjectType.acForm, sForm, true);
                oAccess.RunCommand(Access.AcCommand.acCmdWindowHide);
    
    // Set focus back to the form:
                oForm.SetFocus();
    
    // Release Controls and Form objects:       
                NAR(oCtls);
                oCtls = null;
                NAR(oForm);
                oForm = null;
    
    // Release Application object and allow Access to be closed by user:
                if(!oAccess.UserControl) oAccess.UserControl = true;
                NAR(oAccess);
                oAccess = null;
             }
             catch(Exception e)
             {
                MessageBox.Show(e.Message);
                // Release any Access objects and quit Access due to error:
                NAR(oCtl);
                oCtl = null;
                NAR(oCtls);
                oCtls = null;
                NAR(oForm);
                oForm = null;
                try // use try..catch in case oAccess is not set
                {
                   oAccess.Quit(Access.AcQuitOption.acQuitSaveNone);
                }
                catch{}
                NAR(oAccess);
                oAccess = null;
             }
          }
    
    private void Print_Report_Security()
          {
             //Shows how to automate Access when user-level
             //security is enabled and you wish to avoid the logon
             //dialog asking for user name and password. In this
             //example we're assuming default security so we simply
             //pass the Admin user with a blank password to print the
             //"Summary of Sales by Year" report in Northwind.mdb.
    
    Access.Application oAccess = null;
             string sDBPath = null; //path to Northwind.mdb
             string sUser = null; //user name for Access security
             string sPwd = null; //user password for Access security
             string sReport = null; //name of report to print
    
    // Enable exception handler:
             try
             {
                sReport = "Summary of Sales by Year";
    
    // Determine the path to Northwind.mdb:
                sDBPath = GetOfficeAppPath("Access.Application", "msaccess.exe");
                if(sDBPath == null)
                {
                   MessageBox.Show("Can't determine path to msaccess.exe");
                   return;
                }
                sDBPath = sDBPath.Substring(0, sDBPath.Length - "msaccess.exe".Length)
                   + @"Samples\Northwind.mdb";
                if(!System.IO.File.Exists(sDBPath))
                {
                   MessageBox.Show("Can't find the file '" + sDBPath + "'");
                   return;
                }
    
    // Specify the user name and password for the Access workgroup
                // information file, which is used to implement Access security.
                // Note: If you are not using the system.mdw in the default
                // location, you may include the /wrkgrp command-line switch to
                // point to a different workgroup information file.
                sUser = "Admin";
                sPwd = "";
    
    // Start a new instance of Access with user name and password:
                oAccess = ShellGetDB(sDBPath, "/user " + sUser + " /pwd " + sPwd,
                   ProcessWindowStyle.Minimized, 1000);
                //or
                //oAccess = ShellGetApp(@"""" + sDBPath + @"""" + 
                //  " /user " + sUser + " /pwd " + sPwd,
                //  ProcessWindowStyle.Minimized);
    
    // Select the report name in the database window and give focus
                // to the database window:
                oAccess.DoCmd.SelectObject(Access.AcObjectType.acReport, sReport, true);
    
    // Print the report:
                oAccess.DoCmd.OpenReport(sReport,
                   Access.AcView.acViewNormal, moMissing, moMissing,
                   Access.AcWindowMode.acWindowNormal, moMissing );
                // If using Access 10.0 object library, use this instead:                       
                //oAccess.DoCmd.OpenReport(sReport,
                //  Access.AcView.acViewNormal, moMissing, moMissing,
                //  Access.AcWindowMode.acWindowNormal, moMissing);
             }
             catch(Exception e)
             {   
                MessageBox.Show(e.Message);
             }
             finally
             {
                // Release any Access objects and quit Access:
                try // use try..catch in case oAccess is not set
                {
                   oAccess.Quit(Access.AcQuitOption.acQuitSaveNone);
                }
                catch{}
                NAR(oAccess);
                oAccess = null;
             }
          }
    
    private void Preview_Report_Runtime()
          {
             //Shows how to automate the Access Runtime to preview
             //the "Summary of Sales by Year" report in Northwind.mdb.
    
    Access.Application oAccess = null;
             Access.Form oForm = null;
             string sDBPath = null; //path to Northwind.mdb
             string sReport = null; //name of report to preview
    
    // Enable exception handler:
             try
             {
                sReport = "Summary of Sales by Year";
    
    // Determine the path to Northwind.mdb:
                sDBPath = GetOfficeAppPath("Access.Application", "msaccess.exe");
                if(sDBPath == null)
                {
                   MessageBox.Show("Can't determine path to msaccess.exe");
                   return;
                }
    
    sDBPath = sDBPath.Substring(0, sDBPath.Length - "msaccess.exe".Length)
                   + @"Samples\Northwind.mdb";
                if(!System.IO.File.Exists(sDBPath))
                {
                   MessageBox.Show("Can't find the file '" + sDBPath + "'");
                   return;
                }
    
    // Start a new instance of Access with a database. If the
                // retail version of Access is not installed, and only the
                // Access Runtime is installed, launches a new instance
                // of the Access Runtime (/runtime switch is optional):
                oAccess = ShellGetDB(sDBPath, "/runtime",
                   ProcessWindowStyle.Minimized, 1000);
                //or
                //oAccess = ShellGetApp(@"""" + sDBPath + @"""" + " /runtime",
                //  ProcessWindowStyle.Minimized);
    
    // Make sure Access is visible:
                if(!oAccess.Visible) oAccess.Visible = true;
    
    // Close any forms that Northwind may have opened:
                while(oAccess.Forms.Count > 0)
                {   
                   oForm = oAccess.Forms[0];
                   oAccess.DoCmd.Close(Access.AcObjectType.acForm,
                      oForm.Name, Access.AcCloseSave.acSaveNo);
                   NAR(oForm);
                   oForm = null;
                }
    
    // Select the report name in the database window and give focus
                // to the database window:
                oAccess.DoCmd.SelectObject(Access.AcObjectType.acReport, sReport, true);
    
    // Maximize the Access window:
                oAccess.RunCommand(Access.AcCommand.acCmdAppMaximize);
    
    // Preview the report:
                oAccess.DoCmd.OpenReport(sReport,
                   Access.AcView.acViewPreview, moMissing, moMissing,
                   Access.AcWindowMode.acWindowNormal, moMissing );
                // If using Access 10.0 object library, use this instead:
                //oAccess.DoCmd.OpenReport(sReport,
                //  Access.AcView.acViewPreview, moMissing, moMissing,
                //  Access.AcWindowMode.acWindowNormal, moMissing);
    
    // Maximize the report window:
                oAccess.DoCmd.Maximize();
    
    // Hide Access menu bar:
                oAccess.CommandBars["Menu Bar"].Enabled = false;
                // Also hide NorthWindCustomMenuBar if it is available:
                try
                {
                   oAccess.CommandBars["NorthwindCustomMenuBar"].Enabled = false;
                }
                catch{}
    
    // Release Application object and allow Access to be closed by user:
                if(!oAccess.UserControl) oAccess.UserControl = true;
                NAR(oAccess);
                oAccess =  null;
             }
             catch(Exception e)
             {
                MessageBox.Show(e.Message);
                // Release any Access objects and quit Access due to error:
                NAR(oForm);
                oForm = null;
                try // use try..catch in case oAccess is not set
                {
                   oAccess.Quit(Access.AcQuitOption.acQuitSaveNone);
                }
                catch{}
                NAR(oAccess);
                oAccess = null;
             }
          }
    
    ```

10. Add the following code to the Using directives in Form1.cs:

    ```cs
    using System.Runtime.InteropServices;
    using System.Diagnostics;
    using System.Reflection; 
    ```

11. Press F5 to build and to run the program. Form1 is displayed.   
12. Click Print report, and then click Go!. The Print_Report procedure prints a report from the Northwind database.    
13. Click Preview report, and then click Go!. The Preview_Report procedure previews a report from the Northwind database. Close the Access instance when you are ready to continue.   
14. Click Show form, and then click Go!. The Show_Form procedure displays the Customer Labels dialog box form from the Northwind database. It also sets the option group on the form to "Specific Country" and selects "USA" from the list. Close the Access instance when you are ready to continue.   
15. Click Print report (Security), and then click Go!. The Print_Report_Security procedure shows you how to automate Access and how to avoid the logon dialog box if user-level security is turned on. In this example, assume the default logon by passing the user Admin with a blank password. The code then prints a report in the Northwind database.   
16. Click Preview report (Runtime), and then click Go!. The Preview_Report_Runtime procedure shows you how to automate the Access Runtime to preview a report in the Northwind database. If the retail version of Access is installed, the procedure will still work correctly. Close the instance of Access when you are ready to continue.   

### References
 
For more information, visit the following MSDN Web site: Microsoft Office Development with Visual Studio
[https://msdn.microsoft.com/en-us/library/aa188489(office.10).aspx](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx)For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[317109](https://support.microsoft.com/help/317109) Office application does not quit after automation from Visual Studio .NET client

[316126](https://support.microsoft.com/help/316126) How to use Visual C# to automate a running instance of an Office program