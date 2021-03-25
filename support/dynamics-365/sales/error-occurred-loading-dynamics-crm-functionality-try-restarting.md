---
title: An error occurred loading Microsoft Dynamics CRM functionality
description: Describes a problem that occurs when you try to start Outlook on a computer that has the Microsoft Dynamics CRM client for Outlook installed, and you receive an error message. Includes a resolution.
ms.reviewer: tlemar
ms.topic: troubleshooting
ms.date: 
---
# An error occurred loading Microsoft Dynamics CRM functionality error when starting Outlook

This article provides resolutions for the issues that may occur when you start the Microsoft Dynamics CRM client for Outlook.

_Applies to:_ &nbsp; Microsoft CRM client for Microsoft Office Outlook  
_Original KB number:_ &nbsp; 911384

## Symptoms

### Symptoms 1

When you open the Microsoft Dynamics CRM client for Microsoft Office Outlook, you receive the following error message:

> An error occurred loading Microsoft CRM functionality, try restarting Outlook.

In the event log, error messages that resemble the following are logged.

Error message 1

> The description for Event ID ( 2 ) in Source ( Microsoft CRM ) cannot be found. The local computer may not have the necessary registry information or message DLL files to display messages from a remote computer. You may be able to use the /AUXSOURCE= flag to retrieve this description; see Help and Support for details.

The following information is part of the event. MSCRM Platform Error Report:

> Error: Exception from HRESULT: 0x80040220. Error Message: Exception from HRESULT: 0x80040220. Error Details: Details on this error have not been provided by the platform. Source File: Not available Line Number: Not available Stack Trace Info: at System.Web.UI.Page.HandleError(Exception e) at System.Web.UI.Page.ProcessRequestMain() at System.Web.UI.Page.ProcessRequest() at System.Web.UI.Page.ProcessRequest(HttpContext context) at System.Web.CallHandlerExecutionStep.System.Web.HttpApplication+IExecutionStep.Execute() at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously).

Error message 2

> The description for Event ID ( 16930 ) in Source ( MSCRMAddin ) cannot be found. The local computer may not have the necessary registry information or message DLL files to display messages from a remote computer. You may be able to use the /AUXSOURCE= flag to retrieve this description; see Help and Support for details. The following information is part of the event: 80004005, , CAddin::HrActivateAddin, 472.

Error message 3

> The description for Event ID ( 5944 ) in Source ( MSCRMAddin ) cannot be found. The local computer may not have the necessary registry information or message DLL files to display messages from a remote computer. You may be able to use the /AUXSOURCE= flag to retrieve this description; see Help and Support for details. The following information is part of the event: 80004005, , CAddin::HrInitializeUI, 137.

### Symptoms 2

When you use Windows Vista with the Microsoft Dynamics CRM for Outlook and when you enable platform tracing, you receive an error message that resembles the following:

> Client Configuration: [Error] COM registry keys appear to be corrupted. Rerun the CRM Configuration Wizard or contact your Microsoft Dynamics CRM administrator. ---> System.TypeLoadException: Retrieving the COM class factory for component with CLSID {\<ID>} failed due to the following error: 80131522. at  
System.RuntimeTypeHandle.CreateInstance(RuntimeType type, Boolean publicOnly, Boolean noCheck, Boolean& canBeCached, RuntimeMethodHandle& ctor, Boolean& bNeedSecurityCheck) at  
System.RuntimeType.CreateInstanceSlow(Boolean publicOnly, Boolean fillCache) at  System.RuntimeType.CreateInstanceImpl(Boolean publicOnly, Boolean skipVisibilityChecks, Boolean fillCache) at  
System.Activator.CreateInstance(Type type, Boolean nonPublic) at  
Microsoft.Crm.Outlook.Diagnostics.ComponentObjectModelDiagnosticCheck.Execute(BackgroundWorker backgroundWorker) --- End of inner exception stack trace --- at  
Microsoft.Crm.Outlook.Diagnostics.ComponentObjectModelDiagnosticCheck.Execute(BackgroundWorker backgroundWorker) at Microsoft.Crm.Outlook.Diagnostics.DiagnosticCheck.DeepExecute(BackgroundWorker backgroundWorker)

### Symptoms 3

When you try to run the Microsoft Dynamics CRM client for Outlook, you cannot view the Microsoft Dynamics CRM folder structure. Additionally, you receive the following error message:

> An error occurred loading Microsoft CRM functionality, try restarting Outlook.

The following error messages are logged in the event log:

> Event Type: Error Event Source: MSCRMAddin Event Category: None Event ID: 16930 Date: Date Time: Time User: N/A Computer: ComputerName Description: Initialization of the Microsoft CRM UI failed. Try restarting Microsoft Outlook. HR=0x80004005. Context=. Function=CAddin::HrActivateAddin. Line=521. Additionally, you receive the following error message in the OUTLOOK-YYDDMM.log trace log file: [Date and Time] Process: OUTLOOK |Thread:0832 |Category: Unmanaged.Platform |User: PlatformUser |Level: Error | HrGetXmlDOM File: c:\bt\643\src\application\outlook\v3caddin\xmlutil.cpp Line: 179 >hr = 0x80004005

> [!NOTE]
> In this error message, the Date and Time placeholder represents the actual date and the actual time. For example, the actual date and the actual time could be "2007-10-19 17:53:26.138."

### Symptoms 4

When you start the Microsoft Dynamics CRM client for Outlook, you receive the following error message:

> An error occurred loading Microsoft CRM functionality, try restarting Outlook. Additionally, Error event 80072f19 is referenced in the Application log: Event: 16941 A problem occurred initializing the initialization progress toolbar. Restart Microsoft CRM and try again. HR=0x80072f19. Context=. Function=CAddin::HrActivateAddin. Line=322.

### Symptoms 5

When you try to start Microsoft Office Outlook on a computer that has the Microsoft Dynamics CRM client for Outlook installed, you receive the following error message:

> An error occurred loading Microsoft Dynamics CRM functionality.
>
> Try restarting Microsoft Outlook.
>
> Contact your system administrator if errors persist.

Additionally, the following error message is logged in the Application event log:

> Event Type: Error  
Event Source: MSCRMAddin  
Event Category: None  
Event ID: 16931  
Description:
>
> A problem occurred initializing Microsoft CRM COM interop. Restart Microsoft CRM and try again. HR=0x80131700. Context=. Function=CAddin::HrActivateAddin. Line=274.
>
> Event Type: Error  
Event Source: MSCRMAddin  
Event Category: None  
Event ID: 5903  
Description:
>
> The Microsoft CRM Outlook add-in could not be initialized correctly. Restart Microsoft Outlook and try again. HR=0x80070057. Context=. Function=CAddin::OnConnection. Line=196.

## Cause

### Cause 1

This problem occurs because the role that is assigned to the user account does not have Read access to the Saved View entity in Microsoft Dynamics CRM. See Resolution 1.

### Cause 2

The Disable Folder Home Page configuration is enabled through Group Policy. The Disable Folder Home Page configuration is a Microsoft Office 2003 Administrative Template (OUTLK11.adm) configuration. If this setting is enabled, Office 2003 cannot load the Microsoft Dynamics CRM folder structure. See Resolution 2.

### Cause 3

This problem occurs if IIS is missing the mappings for the .srf extensions that point to the CRMisapi.dll file. See Resolution 3.

### Cause 4

This problem occurs because the check for server certificate revocation is enabled. See Resolution 4.

### Cause 5

This problem occurs because the Outlook.exe.config file exists in the Microsoft Office installation folder. This file is used in troubleshooting instances for the Microsoft Outlook CRM client for Outlook so that Outlook can use a specific version of the Microsoft .NET Framework. See Resolution 5.

## Resolution

### Resolution 1

To correctly start the Microsoft Dynamics CRM client for Outlook, the role that is assigned to the user account must have Read access to the Saved View entity. To change the user's access, follow these steps:

1. Open Microsoft Dynamics CRM.
2. Select **Settings**, select **Settings**, select **Business Unit Settings**, select **Users**, and then double-click the user to open the user.
3. Select **Roles**, double-click the role to open the role, select the **Core Records** tab, and then select **Read** access for the **Saved View** entity.

### Resolution 2

To resolve this problem, change the setting of the Disable Folder Home Page configuration to **disabled** status. To do this, follow these steps for Outlook 2003:

1. To edit the Group Policy that contains the Office 2003 Administrative Template, open **Group Policy Object Editor**.
2. Expand **User Configuration**, expand **Policies**, expand Administrative Templates and then expand Microsoft Office Outlook 2003.
3. Select **Folder Home Pages for Outlook special folders**, and then double-click **Disable Folder Home Pages**.
4. On the **Disable Folder Home Pages Properties** page, select the **Disabled** check box, and then select **OK**.
5. Exit **Group Policy Object Editor**.
6. Reboot the affected client computer.

Follow these steps for Outlook 2007:

1. To edit the **Group Policy** that contains the **Office 2007 Administrative Template**, open **Group Policy Object Editor**.
2. Expand **User Configuration**, expand **Policies**, expand **Administrative Templates** and then expand **Microsoft Office Outlook 2007**.
    > [NOTE]
    > The Microsoft Office Outlook 2007 folder may be contained under Classic Administrative Templates (ADM).
3. Select **Folder Home Pages for Outlook special folders**, and then double-click **Do not allow Home Page URL to be set in folder Properties**.
4. On the **Do not allow Home Page URL to be set in folder Properties** page, select the **Disabled** check box and then select **OK**.
5. Exit **Group Policy Object Editor**.
6. Reboot the affected client computer.

### Resolution 3

To resolve this problem, add the .srf mapping to the Microsoft Dynamics CRM Web site. To do this, follow these steps:

1. Expand the **Microsoft Dynamics CRM** Web site in IIS.
2. Right-click the **MSCRMServices** application virtual directory, and then select **Properties**.
3. On the **Virtual Directory** tab, select **Configuration**.
4. In the **Application Extensions** section, select **Add**.
5. Locate the **CRMIsapi.dll** file, and then put the path in quotation marks as follows:  
   C:\Program Files\Microsoft CRM\Server\bin\CrmIsapi.dll
6. In the **Extension** box, enter *.srf*.
7. In the **Limit to** box, enter **GET, POST, HEAD**.
8. Select the **Script engine** check box and the **Verify that file exists** check box, and then select **OK**.
9. Reset IIS. To do this, select **Start**, select **Run**, type *iisreset* in the **Open** box, and then select **OK**.

### Resolution 4

To resolve this problem, follow these steps:

1. In Internet Explorer, select the **Tools** menu, and then select **Internet Options**.
2. Select the **Advanced** tab, and then clear the **Check for server certificate revocation** (requires restart) check box.
3. Restart Outlook.

### Resolution 5

To resolve this problem, remove or rename the Outlook.exe.config file, and then restart Outlook.
