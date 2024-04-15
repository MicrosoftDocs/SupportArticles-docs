---
title: Description of Visual Studio 2012 Update 4
description: This article describes Visual Studio 2012 Update 4 and lists the new features and fixed issues in Visual Studio 2012 Update 4.
ms.date: 06/11/2020
ms.reviewer: lisafeig
ms.custom: sap:Installation\Servicing updates and service packs
---
# Description of Visual Studio 2012 Update 4

This article describes Visual Studio 2012 Update 4 and lists new features and fixed issues in it.

_Original product version:_ &nbsp; Visual Studio 2012  
_Original KB number:_ &nbsp; 2872520

## Introduction

Microsoft released Visual Studio 2012 Update 4 (Visual Studio 2012.4) on November 13, 2013.

Support for Visual Studio 2012 is provided only for this current update, which is considered to be the Visual Studio 2012 Service Pack, and for the Visual Studio 2012 RTM version, which was released in August  2012. For more information, see the [Microsoft Support Lifecycle](/lifecycle/) policy.

## Get Visual Studio 2012 Update 4

Visual Studio 2012 updates are cumulative releases that include the new features and fixes that were delivered in [Overview of Visual Studio 2012 updates](https://support.microsoft.com/help/2707250). The following download link points you to the latest update:

[Download the latest Visual Studio 2012 update package now](https://www.microsoft.com/download/)

## Install Visual Studio 2012 Update 4

For installation guidance for Visual Studio products, see:

- [Install Visual Studio](/visualstudio/install/install-visual-studio-2015)
- [Installing Team Foundation Server](/previous-versions/visualstudio/visual-studio-2012/dd631902(v=vs.110))

> [!IMPORTANT]
> This update applies to Visual Studio and Team Foundation Server (TFS). Visual Studio and TFS installation mechanics are different. The Visual Studio update is an update that installs on top of whatever is already installed on the computer. The TFS update is a full layout that replaces whatever is installed on the computer. Before you try to apply the TFS update, make sure that you have a full backup of your current databases. If the TFS update installation fails, you will be unable to restart the update or roll back to the earlier version of TFS without performing a restore.

Because Visual Studio 2012 Update 4 is go-live, the following upgrade paths apply.

### Supported upgrades

- TFS 2012 Update 4 RC 4 to TFS 2012 Update 4 RTM
- TFS 2012 Update 4 RTM to TFS 2013 RTM

### Unsupported upgrades

- TFS 2012 Update 4 RC 4 to TFS 2013

## New technology improvements and fixed issues in Visual Studio 2012 Update 4

The following sections list improvements and fixed issues in Visual Studio 2012 Update 4.

> [!NOTE]
> Unless otherwise indicated, linked items will take you to Microsoft Connect webpages.  

### Team Foundation Server

- Administration and Operations

  - Assume that you install a Team Foundation Server (TFS) 2012 application-tier server on a computer that has no instance of Microsoft SQL Server installed. You don't configure Microsoft SQL Server Reporting Services. In this situation, you can't upgrade the application-tier server.
  
  - Scheduled Backups configuration is no longer blocked if the SQL Server service for TFS 2012 is running as a virtual account (for example: NT Service\MSSQLSERVER).
  
  - In TFS 2012 Update 2 and Update 3, transactional backups record a failure when they try to run while a full or differential backup is running.
  
  - Scheduled Backups no longer run transactional backups if a full or differential backup is running. Instead, the job will be suspended until the other backup has finished running.
  
  - TFS in-place upgrades now support configuration and settings persistence together with host headers. The TFS in-place upgrades will log an error when the process meets an invalid host header.
  
  - When you upgrade a configuration database to TFS 2012 Update 3, and attach a TFS collection to the upgraded configuration database, memberships, and permissions may be lost.
  
  - When you try to upgrade TFS, the upgrade operation may be not successful and you receive the following error message:

    > TF20507: The string argument contains a character that is not valid:u0009.

  - When you attach a TFS collection back to the upgraded TFS server, an unexpected database failure occurs and the TFS collection upgrade isn't successful.
  
  - Assume that you use a user to move domains, and then to detach and attach a collection to an existing configuration database. When you save favorites in TFS, the favorites can't be saved.
  
  - Assume that you use a user to upgrade TFS server to TFS 2012 Update 3 after a previous domain migration and display name change. The user won't be active in Work Item Tracking.
  
  - Assume that there are two identities that use the same domain and account name. For example: domain1\user1. In this situation, the wrong user will become activated and the user domain1\user1 can't access to TFS collections.

- Agile Planning

  - Assume that you have a TFS 2012 instance that contains many team projects. When you open the dashboard page in TFS SharePoint portal, you experience slow performance and may receive an error message.
  
  - When you use Turkish locale on the computer and upload an inline image into a work item in Visual Studio 2012, the image can't be viewed by other clients.
  
  - When you have a TFS 2012 server that is configured for synchronizing with Project Server, you may fail to reorder backlog items.

- Build Automation

  - Assume that you create a gated check-in for a build definition by using an upgrade template in a TFS 2010 server. You upgrade the TFS 2010 server to TFS 2012 server, and then you use the upgraded TFS server together with the TFS 2010 build agents. In this case, the build fails on the TFS 2010 build agents when you do a check-in action.
  
  - Assume that you create a build definition by using the default template in a TFS 2010 server. When you upgrade the server from TFS 2010 to TFS 2012, the build definition is modified to run against a newly uploaded upgrade template.
  
  - A No zip file of logs was created because the archive operation failed warning occurs when a build is completed successfully.
  
  - IndexSources build workflow activity experiences slow performance.
  
  - Assume that a scheduled build runs for a long time, and then the build is stopped manually on the next day. When you manually queue the build again, it suppresses the next scheduled build.

  - When you define a build by using Upgrade Template in file container, after you queue the build, the build starts but never completes.
  
  - Build may freeze on the last step and never complete, because of the failure of previous builds.

- Version Control

  - An error message is received when a user opens any view that tries to filter history by the display name of the user. This issue occurs if the display name contains a special character, such as a comma.
  
  - Assume that you try to check in a large file in TFS server. The file can't be uploaded. When you check in the file again, you receive an error message that states a previous upload process failed.
  
  - Assume that you edit a file, and you don't save it. When you check in the file in the Pending Changes window, you may not receive a message asking you to save the file.

- Work Item Tracking

  - There's a 60-second delay when you use Internet Explorer to browse any page in which a work item store is used. This issue occurs if the collection contains more than 175 team projects.
  
  - The functionality to create or edit work items stops working if a team is associated with many area paths.

  - The functionality to move items in the Kanban board doesn't work in some environments that have mixed cultures.
  
  - When a query is saved together with an Assigned to field that contains a constant, users won't see the correct query results after saving and running the query if the constant is also a TFS group display name.
  
  - Assume that you have a TFS 2012 server plugin that raises an exception (For example, during work item save), a generic AJAX exception is shown to the user instead of the exception thrown by the plugin.
  
  - A TFS user from a group that doesn't have work item write permission on an area can change the area of a work item to another area where he has the write permission.
  
  - When you delete a team project, you may receive the following error message when you do create, read, update, and delete operations for work items:  
    > TF400013: An unexpected database error occurred. Contact your Team Foundation Server administrator. (Code: 208)
  
  - Performance improvement in Web Access for work item types that have many allowed field values.

- Web Access

  - When you try to connect to a TFS 2012 server by using a web browser together with an unexpected user agent string, you receive an internal error page instead of the requested page. Additionally, you can't access any TFS web access pages.
  
  - Assume that you have a TFS 2012 server that is configured for synchronizing with Project Server. When you try to save a copied work item in TFS web access, you may receive the following error message:  
      > TF237165: Team Foundation could not update the work item because of a validation error on the server. This may happen because the work item type has been modified or destroyed, or you do not have permission to update the work item.

### Windows Forms

You may receive the following error message in Windows Forms Designer:

> Collection was modified; enumeration operation may not execute
  
### LightSwitch

- After you install Visual Studio 2012 Update 3, neither of the following applications display localized strings. Instead, these applications display English strings.
  - LightSwitch Hypertext Markup Language (HTML) Applications (VB or C#)
  - Upgraded LightSwitch Applications (VB or C#)

- LightSwitch HTML applications periodically show English strings after you install the latest security updates for the .NET Runtime 4.5.

- Assume that you open a project that contains a screen together with many date members. Additionally, each date member has a display name set. In this situation, the screen designer freezes when you try to do an operation in it.  

### Debugger

- When you remotely debug an ASP.NET application that is hosted in Internet Information Services (IIS), breakpoints in code behind might not be hit.

- You receive an error message when you try to debug a Visual Studio isolated shell application at the first time.

- The debugger occasionally steps to the wrong line when you debug native code.

- Enables the debugger to attach a remote web site that is running in Microsoft Azure.  

### Visual Studio IDE

- Visual Studio 2012 crashes randomly when the Telerik Justcode or Codesmith tool is installed.

- Project conversation report is formatted incorrectly on Windows 8.1 Preview.

- Assume that you have a dataset (.xsd) file that doesn't belong to a Visual Studio project. You receive an error message that states parameter is incorrect when you open the dataset file in Visual Studio 2012.

- Visual Studio 2012 may crash when you load some solutions.

- Slow performance when you scroll a source code page if **View White Space** option is turned on.

- In a long-running Visual Studio session, when you open and close documents, tool windows, and so on, Visual Studio may crash under certain circumstance.

### Windows Development

Assume that you have Visual Studio 2012 Update 3 installed on a Windows 8 computer. You upgrade the operating system to Windows 8.1 preview or later version. In this situation, you receive a blocking dialog when you start Windows Simulator. Additionally, you still can't start the Windows Simulator after you follow the instructions in the dialog.

### Profiler

- Concurrency Visualizer for 64-bit applications doesn't work on a 64-bit Windows 8.1 operating system.
- When you profile applications on Windows 8.1 Preview, the profiling tools have issues in collecting and displaying the symbolic information.

### C++

- Catch block might be removed incorrectly by C++ optimizer when the try block is calling a function that exists in an external Dynamic Link Library (DLL).

- Visual C++ 2012 Redistributable Package is uninstalled when you uninstall Visual Studio 2012.

- Visual C++ redistributable bootstrapper files (*product.xml*) are missing from Visual Studio 2012 installation.

- When you build a C++ application together with the Generate Debug Info option, you receive the following error message:  

    > fatal error LNK1318: Unexpected PDB error

- When you build large applications together with **/LTCG** (Link-time Code Generation) option, the linker crashes intermittently.

- Internal compiler error may occur when you compile a C++ class that contains many virtual functions together with **/LTCG** (Link-time Code Generation) option.

- Member variables of a type aren't properly visualized and displayed when you debug a Visual C++ application.

- Incorrect machine code generation for x64 may occur when an optimization option is enabled.

### IntelliTrace

Visual Studio Ultimate 2012 is now able to open IntelliTrace Log files that are created by Microsoft Monitoring Agent.

### .NET Framework Core

Adds support for portable class libraries in NuGet.  

### Entity Framework tools

Assume that you have Microsoft Visual Studio Express 2012 for Web or Visual Studio Express 2012 for Windows Desktop together with Visual Studio 2012 Update 1 or later versions installed. You receive the following compile-time error message in the Entity Framework designer when the T4 templates that generate the entities are executed:

> A processor named 'T4VSHost' could not be found for the directive named 'CleanupBehavior'. The transformation will not be run. The following Exception was thrown:  
System.IO.FileNotFoundException: Failed to resolve type for directive processor T4VSHost.
  
### Phone tools

- Windows Phone 8 GDR2 Emulators installed with the Windows Phone 8 GDR2 SDK aren't available as deployment targets for native Windows Phone 8.0 applications.

- Windows Phone 8.0 Unit Test Projects fail to run on the Windows Phone 8 GDR2 Emulators installed with the Windows Phone 8 GDR2 SDK.

- Add support for Windows Phone 8 GDR3 Emulators.  

### Localization

When you open a graphics log (.vsglog) file that is generated on Windows 8.1 Preview by using Visual Studio 2012 Update 3, you receive the following unlocalized message:

> This log file was created on a newer version of Windows and cannot be opened in Visual Studio 2012

### Visual Studio Test

- Test and Lab Manager
  - When you set up lab management in Team Foundation Server 2012 by configuring a connection to System Center Virtual Machine Manager (SCVMM) 2012 R2 server, the setup isn't successful, and you receive the following error message:

    > Get-MachineConfig command let doesn't exist

- When you try to clone an unfenced environment and deploy it, you receive the following error message:  

    > To use this environment, you must install a compatible test agent in all the machines of the environment. Click 'install agents' to complete this task.

- In a Build-Deploy-Test (BDT) workflow, a large number of web-service calls are made for refreshing the test run on a hosted service. Which causes many unnecessary web-service calls.

- Unit Test
  - Unit test explorer in Visual Studio 2012 can't discover windows store tests when .NET Framework 4.5.1 is installed.
  - Users that have special characters in the machine name aren't able to discover and run tests, such as the en dash (-) in the beginning of the name.
  - Visual Studio intermittently crashes when you try to discover tests by Test Explorer.

- Web Test
  - Issue 1:

    You can't record or playback actions involving navigation on a page on Internet Explorer 10 or on Internet Explorer 11 together with the latest Internet Explorer GDR updates installed.

  - Issue 2:

    You can't playback the scenario on a page together with AJAX as expected, the playback doesn't complete. For example, when you click attach file, select file and playback recorded steps, the file upload starts but never completes.

    You can't record a web performance test in Internet Explorer 11 because the Enhanced Protection Mode is enabled by default in Internet Explorer 11.

- Coded UI Test and Action Recordings

  - You can't record or playback actions that involve navigation on a page on Internet Explorer 10 or on Internet Explorer 11 when Internet Explorer update is installed.
  
  - You can't play back tests on a web page that uses AJAX, because the playback doesn't complete. For example, when you click **attach file**, **select a file to upload**, or click **upload** in a test, the file upload starts but never completes during playback.

- Test Case Manager
  - Error occurs when you publish the test result in TFS 2012 environment by using MSTest 2010.
  
  - Assume you associate a build with a test plan. When you run a test case from web access, the test runs in Analyze test run tab doesn't show the build number.
  
  - You couldn't select custom long text fields in Microsoft Test Manager (MTM) 2012 and Test Case Management (TCM) web grids.

- Microsoft Test Manager
  - When you create a new SCVMM-based lab environment in Microsoft Test Manager, a product key isn't required during Sysprep (System Preparation) for some operating systems (such as Windows Server 2012 R2). However, you're still prompted for a key, and that's why can't continue.

### Graphics diagnostics

- Graphics debugger may crash when you open a graphics log (.vsglog) file if the shader is too large.

- Adds backward compatibility support for Visual Studio 2012 on the latest Windows for Graphics Debugging.

### Web Tools

- Page Inspector doesn't work on a computer that has Internet Explorer 11 installed.
- WebDeploy 3.5 is shipped together with Visual Studio 2012 Update 4.

### Diagnostic tools

A web project with a project item that has no code (such as web.config or .asmx) doesn't trigger the code analysis check-in policy.

## More information

- [How to download Microsoft support files](https://support.microsoft.com/help/119591)

- Updates for other products in the Visual Studio family can be found on the [Microsoft download site for Visual Studio](https://visualstudio.microsoft.com/downloads/).

### Requirements

> [!NOTE]
> This section applies only to the Visual Studio client. TFS has different system requirements (check the [Visual Studio Team Foundation Server 2012 with Update 4](https://www.microsoft.com/download/details.aspx?id=38185) and [Visual Studio Team Foundation Server Express 2012 with Update 4](https://www.microsoft.com/download/details.aspx?id=38190) download pages for more information), and may require up to two restarts, depending on the state of the computer when you install the update.

#### Restart requirement

You don't have to restart your computer after you install this package.

#### Supported languages

Visual Studio 2012 Update 4 provides updates for the following versions:

- Chinese (Simplified)
- Chinese (Traditional)
- Czech
- English
- French
- German
- Italian
- Japanese
- Korean
- Russian
- Polish
- Portuguese (Brazil)
- Spanish
- Turkish

### Supported architectures

- 32-bit (x86)
- 64-bit (x64) (WOW)

### Hardware requirements

- 1.6 gigahertzes (GHz) or faster processor
- 1 gigabyte (GB) of RAM (1.5 GB if you're running in a virtual machine)
- 1 GB of available hard disk space
- 5,400-RPM hard disk drive
- DirectX nine-capable video card that is running at 1024 × 768 or higher resolution

### Software requirements

To apply this update, you must have one of the supported Visual Studio 2012 programs that are listed in the **Applies to** section installed.

### Support for Visual Studio 2012 Update 4

Informal community support for Visual Studio 2012 Update 4 is available through the [Microsoft Developer Network (MSDN) forums](https://social.msdn.microsoft.com/Forums/home).

## Applies to

- Visual Studio Premium 2012
- Visual Studio Express 2012 for Windows 8
- Visual Studio Express 2012 for Windows Desktop
- Visual Studio Express 2012 for Windows Phone
- Visual Studio 2012 Remote Tools
- Visual Studio Ultimate 2012
- Visual Studio Test Professional 2012
