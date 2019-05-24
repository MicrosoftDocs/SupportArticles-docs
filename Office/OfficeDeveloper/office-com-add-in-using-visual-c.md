---
title: How to build an Office COM add-in by using Visual C# .NET
description: 
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to build an Office COM add-in by using Visual C# .NET

## Summary

Microsoft Office XP, Microsoft Office 2003, and Microsoft Office 2007 support a uniform design architecture for building application add-ins to enhance and to control Office applications. These add-ins are called Microsoft Component Object Model (COM) add-ins. This step-by-step article discusses Office COM add-ins and describes how to build an Office COM add-in by using Microsoft Visual C# .NET. 

### The IDTExensibility2 interface
 
A COM add-in is an in-process COM server, or ActiveX dynamic link library (DLL), that implements the IDTExensibility2 interface as described in the Microsoft Add-in Designer type library (Msaddndr.dll). All COM add-ins inherit from this interface and must implement each of its five methods. 

#### OnConnection
 
The OnConnection event fires whenever the COM add-in is connected. The add-in may be connected on startup, by the end user, or through Automation. If the OnConnection event returns successfully, the add-in is said to be loaded. If an error message is returned, the host application immediately releases its reference to the add-in, and the object is destroyed. 

The OnConnection event takes the following four parameters: 


- Application: A reference to the host application object.   
- ConnectMode: A constant that specifies how the add-in is connected. The add-in can be connected in the following ways:

  - ext_cm_AfterStartup: The add-in is started by the end user from the COM Add-ins dialog box.   
  - ext_cm_CommandLine: The add-in is connected from the command line. Note that this does not apply to building COM add-ins for Office applications.   
  - ext_cm_External: The add-in is connected by an external application through Automation. Note that this does not apply to building COM add-ins for Office applications.   
  - ext_cm_Startup: The add-in is started by the host at application startup. This behavior is controlled by a setting in the registry.   
   
- AddInInst: A reference to the COMAddIn object that refers to this add-in in the COMAddIns collection for the host application.   
- Custom: An array of Variant type values that can hold user-defined data.   

#### OnDisconnection
 
The OnDisconnection event fires when the COM add-in is disconnected and just before it unloads from memory. The add-in should perform any cleanup of resources in this event, and restore any changes made to the host application. 

The OnDisconnection event takes the following two parameters: 


- RemoveMode: A constant that specifies how the add-in was disconnected. The add-in can be disconnected in the following ways:

  - ext_dm_HostShutdown: The add-in is disconnected when the host application closes.   
  - ext_dm_UserClosed: The add-in is disconnected by the end user or an Automation controller.   
   
- Custom: An array of Variant type values that can hold user-defined data.   

#### OnAddInsUpdate
 
The OnAddInsUpdate event fires when the set of registered COM add-ins changes. In other words, whenever a COM add-in is installed or removed from the host application, this event fires. 

#### OnStartupComplete and OnBeginShutdown
 
Both the OnStartupComplete method and the OnBeginShutdown method are called when the host application has left or is entering a state in which user interaction should be avoided because the application is busy loading or unloading itself from memory. The OnStartupComplete method is called only if the add-in was connected during startup, and the OnBeginShutdown method is called only if the host disconnects the add-in during shutdown. 

Because the user interface for the host application is fully active when these events fire, they may be the only way to perform certain actions that otherwise would be unavailable from the OnConnection event and the OnDisconnection event. 

### COM add-in registration
 
In addition to normal COM registration, a COM add-in needs to register itself with each Office application in which it runs. To register itself with a particular application, the add-in should create a subkey, using its ProgID as the name for the key, under the following location: 

**HKEY_CURRENT_USER\Software\Microsoft\Office\OfficeApp\Addins\ProgID**

The add-in can provide values at this key location for both a friendly display name and a full description. In addition, the add-in should specify its desired load behavior by using a DWORD value that is named LoadBehavior. This value determines how the add-in is loaded by the host application, and is made up of a combination of the following values: 

- 0 = Disconnect - Is not loaded.   
- 1 = Connected - Is loaded.   
- 2 = Bootload - Load on application startup.   
- 8 = DemandLoad - Load only when requested by user.   
- 16 = ConnectFirstTime - Load only once (on next startup).   
 
The typical value specified is 0x03 (Connected | Bootload).

Add-ins that implement IDTExtensibility2 should also specify a DWORD value called **CommandLineSafe** to indicate whether the add-ins are safe for operations that do not support a user interface. A value of 0x00 indicates False, and a value of 0x01 indicates True.

### How to build a COM add-in by using Visual C# .NET
 
As mentioned earlier, an Office COM add-in is an in-process COM server that is activated by an Office application through the COM run-time layer. Therefore, developing a COM add-in in .NET requires that the add-in component be implemented in .NET and then exposed to the COM clients (that is, the Office applications) through the COM interop layer. 

To create a COM add-in in Visual C# .NET, follow these steps: 

1. In Visual C# .NET, create a Class Library project.   
2. Add a reference to the type library that implements IDTExtensibility2. The primary interop assembly for this is already available under the name Extensibility.    
3. Add a reference to the Microsoft Office object library. The primary interop assembly for this is already available under the name Office.   
4. Create a public class in the class library that implements IDTExtensibility2.   
5. After the class library is built, register the library for COM interop. To do this, generate a strong named assembly for this class library and then register it with COM interop. You can use Regasm.exe to register a .NET component for COM interop.    
6. Create registry entries so that Office applications can recognize and load the add-in.   
 
You can choose to complete all of these steps, or you can create a .NET project of type Shared Addin. This starts the Extensibility Wizard, which helps you to create a COM add-in in .NET. 

The Extensibility Wizard creates a Visual C# .NET class library project along with a Connect class that implements the IDTExtensibility2 interface. The skeleton code that implements the empty members of IDTExtensibility is also generated. This project has references to Extensibility and Office assemblies. The build settings of the project have Register for COM Interop selected. The assembly key (.snk) file is generated and is referenced in the AssemblyKeyfile attribute in Assemblyinfo.vb. 

Along with the class library project, the wizard generates a setup project that you can use to deploy the COM add-in on other computers. You may remove this project if desired.

### Step-by-step example

1. On the File menu in Microsoft Visual Studio .NET, click New, and then click Project.   
2. In the New Project dialog box, expand Other Projects under Project Types, select Extensibility Projects, and then select the Shared Add-in template.   
3. Type MyCOMAddin as the name of the add-in and then click OK.   
4. When the Extensibility Wizard appears, follow these steps:

    1. On page 1, select Create an Add-in using Visual C#, and then click Next.   
    2. On page 2, select the following host applications, and then click Next:

        - Microsoft Word   
        - Microsoft PowerPoint   
        - Microsoft Outlook   
        - Microsoft Excel   
        - Microsoft Access      
   3. On page 3, provide a name and description for the add-in, and then click Next.

      **Note** The name and the description of the add-in appear in the COM Add-in dialog box in the Office application.

   4. On page 4, select all of the available options, and then click Next.   
    5. Click Finish.   
   
5. On the Project menu, click Add Reference. Click System.Windows.Forms.DLL in the components list, click Select, and then click OK.   
6. Add the following to the list of namespaces in the Connect class:
    ```c
    using System.Reflection;
    ```

7. Add the following member to the Connect class:
    ```c
    private CommandBarButton MyButton;
    ```

8. Implement the code for the members of IDTExtensibility2 in the Connect class, as follows:
    ```c
    public void OnConnection(object application, Extensibility.ext_ConnectMode connectMode, object addInInst, ref System.Array custom) {
       applicationObject = application;
       addInInstance = addInInst;
    
    if(connectMode != Extensibility.ext_ConnectMode.ext_cm_Startup)
       {
          OnStartupComplete(ref custom);
       }
    
    }
    
    public void OnDisconnection(Extensibility.ext_DisconnectMode disconnectMode, ref System.Array custom) {
       if(disconnectMode != Extensibility.ext_DisconnectMode.ext_dm_HostShutdown)
       {
          OnBeginShutdown(ref custom);
       }
       applicationObject = null;
    }
    
    public void OnAddInsUpdate(ref System.Array custom)
    {
    }
    
    public void OnStartupComplete(ref System.Array custom)
    {
       CommandBars oCommandBars;
       CommandBar oStandardBar;
    
    try
       {
       oCommandBars = (CommandBars)applicationObject.GetType().InvokeMember("CommandBars", BindingFlags.GetProperty , null, applicationObject ,null);
       }
       catch(Exception)
       {
       // Outlook has the CommandBars collection on the Explorer object.
       object oActiveExplorer;
       oActiveExplorer= applicationObject.GetType().InvokeMember("ActiveExplorer",BindingFlags.GetProperty,null,applicationObject,null);
       oCommandBars= (CommandBars)oActiveExplorer.GetType().InvokeMember("CommandBars",BindingFlags.GetProperty,null,oActiveExplorer,null);
       }
    
    // Set up a custom button on the "Standard" commandbar.
       try
       {
       oStandardBar = oCommandBars["Standard"];        
       }
       catch(Exception)
       {
       // Access names its main toolbar Database.
       oStandardBar = oCommandBars["Database"];      
       }
    
    // In case the button was not deleted, use the exiting one.
       try
       {
       MyButton = (CommandBarButton)oStandardBar.Controls["My Custom Button"];
       }
       catch(Exception)
       {
          object omissing = System.Reflection.Missing.Value ;
          MyButton = (CommandBarButton) oStandardBar.Controls.Add(1, omissing , omissing , omissing , omissing);
          MyButton.Caption = "My Custom Button";
          MyButton.Style = MsoButtonStyle.msoButtonCaption;
       }
    
    // The following items are optional, but recommended. 
       //The Tag property lets you quickly find the control 
       //and helps MSO keep track of it when more than
       //one application window is visible. The property is required
       //by some Office applications and should be provided.
       MyButton.Tag = "My Custom Button";
    
    // The OnAction property is optional but recommended. 
       //It should be set to the ProgID of the add-in, so that if
       //the add-in is not loaded when a user presses the button,
       //MSO loads the add-in automatically and then raises
       //the Click event for the add-in to handle. 
       MyButton.OnAction = "!<MyCOMAddin.Connect>";
    
    MyButton.Visible = true;
       MyButton.Click += new Microsoft.Office.Core._CommandBarButtonEvents_ClickEventHandler(this.MyButton_Click);
    
    object oName = applicationObject.GetType().InvokeMember("Name",BindingFlags.GetProperty,null,applicationObject,null);
    
    // Display a simple message to show which application you started in.
       System.Windows.Forms.MessageBox.Show("This Addin is loaded by " + oName.ToString()   , "MyCOMAddin");
       oStandardBar = null;
       oCommandBars = null;
    }
    
    public void OnBeginShutdown(ref System.Array custom)
    {
       object omissing = System.Reflection.Missing.Value ;
       System.Windows.Forms.MessageBox.Show("MyCOMAddin Add-in is unloading.");
       MyButton.Delete(omissing);
       MyButton = null;
    }
    
    private void MyButton_Click(CommandBarButton cmdBarbutton,ref bool cancel) {
       System.Windows.Forms.MessageBox.Show("MyButton was Clicked","MyCOMAddin"); }
    ```

9. Build and test the COM add-in. To do this, follow these steps:

   1. On the Build menu, click Build Solution. Note that building the COM add-in registers the .NET class with the COM interop.   
   2. Start one of the Office applications that you selected as host applications for your add-in (for example, Microsoft Word or Microsoft Excel).   
   3. After the add-in has started, the OnStartupComplete event of the add-in is fired, and you receive a message. Dismiss the message box. Note that the add-in added a new custom button with the caption "My Custom Button" to the standard toolbar.   
   4. Click My Custom Button. The Click event for the button is handled by the add-in and you receive a message box. Dismiss the message box.   
   5. Quit the Office application.   
   6. When you quit the application, the OnBeginShutDown event fires, and you receive a message. Dismiss the message box to end the demonstration.