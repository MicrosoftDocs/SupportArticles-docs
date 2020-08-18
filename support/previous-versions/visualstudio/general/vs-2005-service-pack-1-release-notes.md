---
title: VS 2005 Service Pack 1 release notes
description: Contains the contents of the release notes from Visual Studio 2005 Service Pack 1 (SP1).
ms.date: 06/11/2020
ms.prod-support-area-path: 
ms.topic: article
---
# Visual Studio 2005 Service Pack 1 release notes  

This article lists known issues with the installation and uninstallation of Visual Studio 2005 Service Pack 1 (SP1).

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 928957

> [!NOTE]
> For information about the functional changes that are included in Visual Studio 2005 SP1, see [Visual Studio 2005 Retired documentation](https://www.microsoft.com/download/details.aspx?id=55984).

## Get Visual Studio 2005 SP1

- [Microsoft® Visual Studio® 2005 Team Suite Service Pack 1](https://www.microsoft.com/download/details.aspx?id=5553)

    This download installs the service pack for Microsoft Visual Studio 2005 Standard, Professional, Team Editions.

- [Microsoft® Visual Studio® 2005 Team Foundation Server Service Pack 1](https://www.microsoft.com/download/details.aspx?id=15789)

    This download installs the service pack for Microsoft Visual Studio 2005 Team Foundation Server.

- [Microsoft® Visual Studio® 2005 Express Editions Service Pack 1](https://www.microsoft.com/download/details.aspx?id=804)

    This download installs the service pack for Microsoft Visual Studio 2005 Express Editions.

## Supported languages

Visual Studio 2005 SP1 provides updates for all Visual Studio 2005 language products:

- Chinese (Simplified)
- Chinese (Traditional)
- English (United States)
- French
- German
- Italian
- Japanese
- Korean
- Russian
- Spanish

## Supported operating systems

- Microsoft Windows 2000 Professional SP4
- Microsoft Windows 2000 Server SP4
- Microsoft Windows 2000 Advanced Server SP4
- Microsoft Windows 2000 Datacenter Server SP4
- Microsoft Windows XP Professional x64 Edition (WOW)
- Microsoft Windows XP Professional SP2
- Microsoft Windows XP Home Edition SP2
- Microsoft Windows XP Media Center Edition 2002 SP2
- Microsoft Windows XP Media Center Edition 2004 SP2
- Microsoft Windows XP Media Center Edition 2005
- Microsoft Windows XP Tablet PC Edition SP2
- Microsoft Windows Server 2003, Standard Edition SP1
- Microsoft Windows Server 2003, Enterprise Edition SP1
- Microsoft Windows Server 2003, Datacenter Edition SP1
- Microsoft Windows Server 2003, Web Edition SP1
- Microsoft Windows Server 2003, Standard x64 Edition SP1 (WOW)
- Microsoft Windows Server 2003, Enterprise x64 Edition SP1 (WOW)
- Microsoft Windows Server 2003, Datacenter x64 Edition SP1 (WOW)
- Microsoft Windows Server 2003 R2, Standard Edition
- Microsoft Windows Server 2003 R2, Standard x64 Edition (WOW)
- Microsoft Windows Server 2003 R2, Enterprise Edition
- Microsoft Windows Server 2003 R2, Enterprise x64 Edition (WOW)
- Microsoft Windows Server 2003 R2, Datacenter Edition
- Microsoft Windows Server 2003 R2, Datacenter x64 Edition (WOW)
- Microsoft Windows Vista

## Installation requirements

- A licensed copy of one of the supported Visual Studio 2005 products must be installed on the target computer.
- 192 MB of RAM is required. 256 MB or greater is recommended.

## Visual Studio 2005 SP1 support

Informal community support is available through the [MSDN Forums](https://social.msdn.microsoft.com/Forums/home).

## Installation issues – all platforms

- **Service pack installation takes longer than the original product installation**

    Installing Visual Studio 2005 SP1 takes longer than installing the original release version because the SP1 installation is much like a product installation, but with additional installation tasks. Installation time depends on which product is installed and the computer's configuration.

- **Installation requires significant disk space**

    Disk space equal to the taken by the original product installation may be needed to install a service pack. If you've more than one Visual Studio product installed, you'll need disk space for each service pack installation. You can find an estimate of the required disk space on the download page for the service pack.

- **Visual Studio 2005 SP1 tries to install multiple times**

    The service pack will run multiple times if you have multiple Visual Studio products installed on your computer. Don't start the installation more than once.

- **Dialog boxes are partially hidden during installation**

    This problem occurs if you move the **Configuring ...** dialog box away from the center of the screen. Subsequent dialog boxes are centered on the **Configuring ...** dialog box. If the **Configuring ...** dialog box is near the corner of the screen, larger dialog boxes that display later may be partially off the screen.

    To resolve this issue, leave the **Configuring ...** dialog box in the center of the screen.

    Visual Studio 2005 SP1 won't install immediately after a Visual Studio compilation:
    You can't install Visual Studio 2005 SP1 until the debugger service closes.

    To resolve this issue, do one of the following steps:

  - Finish compilations that are in progress and wait for the debugger service to close. Which could take up to 10 minutes.
  
  - Use the Task Manager to end all instances of the mspdbsrv.exe service.

- **Team Foundation Server prerequisites**

    You must install the update from KB919156 before you install Visual Studio 2005 SP1. This update makes sure that the server doesn't process client requests during the installation of SP1.

- **Visual Studio 2005 Team Foundation Server SP1 fails to install or uninstall if network isn't available**

    Visual Studio 2005 Team Foundation Server SP1 fails to install or uninstall when the network isn't available. It's an issue with a custom action that is dependent on Active Directory.

    Scenario:

    1. Install Visual Studio 2005 Team Foundation Server from a network share.
    2. Install the required update from KB919156.
    3. Copy Visual Studio 2005 Team Foundation Server SP1 locally.
    4. Disable the network.
    5. Install the service pack from the local path. The service pack fails to install.

    To resolve this issue, make sure that the network is available before trying to install or uninstall the service pack.

- **Uninstallation of Visual Studio 2005 web application projects required**

    Follow these steps to install Visual Studio 2005 SP1 if you have Visual Studio 2005 Web Application Projects installed:

    1. Uninstall the Visual Studio 2005 Web Application Projects add-in.
    2. Install Visual Studio 2005 SP1.

- **SQL Server Compact Edition Tools and runtime**

    Visual Studio 2005 SP1 includes updates of the SQL Server Compact Edition 3.1 design time utilities. The SQL Server Compact Edition Tools for Visual Studio 2005 SP1 include UI/Dialogs, device CAB files, DataDirectory feature, and ClickOnce support for the Smart Device Development components.

- **Hotfix update to Visual Basic 2005 command-line compiler (Vbc.exe) available**

    Visual Studio 2005 SP1 provides improvements to the Visual Basic 2005 design time compiler, including improved responsiveness, stability, and performance.

    After installing Visual Studio 2005 SP1, install this hotfix to development and deployed machines to get the service pack fixes for the command-line compiler if any of the following apply:

  - You're developing web sites with ASP.NET 2.0 in Visual Basic 2005.
  - You're deploying ASP.NET 2.0 web sites written in Visual Basic 2005.
  - You're building Visual Basic 2005 projects outside the IDE using the command-line compiler.

- **Uninstall Visual Studio 2005 SP1 Beta before you install the release version**

    Before installing the release of Visual Studio 2005 SP1, you must uninstall the Visual Studio 2005 SP1 Beta. If you don't uninstall the beta first, you'll receive the following error message:

    > The upgrade patch cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade patch may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade patch.

    To uninstall the beta version from Windows 2000, Windows XP, Windows XP SP1, Windows Server 2003 RTM:

    1. Click **Start**.
    2. Click **Control Panel**.
    3. Open **Add/Remove Programs**.
    4. Select the service pack beta for each product to which it's applied, and click **Change/Remove**.

    To uninstall the beta version from Windows XP SP2 and Windows Server 2003 SP1:

    1. Click **Start**.
    2. Click **Control Panel**.
    3. Open **Add/Remove Programs**.
    4. Check **Show Updates** if it's not already checked.
    5. Select the service pack beta nested under each product to which it's applied, and click **Remove**.

    To uninstall the beta version from Windows Vista:

    1. Click **Start**.
    2. Click **Control Panel**.
    3. Click **Programs**.
    4. Click **View installed updates** in the **Programs and Features** section.
    5. Select the service pack beta for each product to which it's applied, and click **Uninstall**.

## Installation issues – Windows Vista

- **Installation on Windows Vista requires elevated privileges**

    If you're installing Visual Studio 2005 SP1 on Windows Vista, we recommend that you right-click the SP1 executable and then select **Run as administrator**. Instead, you can launch the executable from a privileged console window.

- **Setup dialog box fails to appear**

    The verification that occurs under User Account Control (UAC) with all installations delays the appearance of the initial setup dialog box. Delays of more than one hour have been reported.

- **Visual Studio 2005 Service Pack 1 Update for Windows Vista**

    We're releasing an update for Visual Studio 2005 SP1 to address issues specific to the Vista platform. For more information, see [Visual Studio for Windows Vista](https://social.msdn.microsoft.com/Forums/vstudio/c0a26710-95af-4b97-9a2e-2c0f6e5b0bbb/visual-studio-for-windows-vista?forum=vssetup).

## Installation issues – Windows Server 2003

Installation fails on Windows Server 2003 editions with Windows Server 2003 SP1 installed. The error reported is:

> Error 1718. File \<Filename> was rejected by digital signature policy.

This problem occurs when the computer has insufficient contiguous memory for Windows Server 2003 or Windows XP to verify that the .msi package or the .msp package is correctly signed.

To resolve this issue, refer to [Error message when you try to install a large Windows Installer package or a large Windows Installer patch package in Windows Server 2003 or in Windows XP: Error 1718. File was rejected by digital signature policy](https://support.microsoft.com/help/925336).

## Uninstall issues

- **Error 33088 is shown while uninstalling Visual Studio 2005 SP1**

    This error occurs in the following scenario:

    1. Install a Visual Studio 2005 Team Test edition.
    2. Install the Distributed Test Execution Controller or the Distributed Test Execution Agent component.
    3. Install the corresponding service pack.
    4. Uninstallation of the service pack fails with

        > Error 33088: There is a problem in the setup package.

    To resolve this issue, follow these steps:
    1. Uninstall the component by using **Add or Remove Programs**.
    2. Uninstall the Visual Studio service pack.
    3. Reinstall the component.

- **Uninstalling Visual Studio Team Suite 2005 SP1 breaks Visual Basic Express 2005 installation**

    This error occurs in the following scenario:

    1. Install Visual Studio Professional 2005.
    2. Install Visual Studio 2005 SP1 for Visual Studio Professional.
    3. Install Visual Basic Express 2005.
    4. Install Visual Basic Express 2005 SP1.
    5. Uninstall Visual Studio Professional 2005.
    6. Running Visual Basic Express fails. It's because there are two missing assemblies.

    To resolve this issue, follow these steps:

    1. Reinstall Visual Basic Express 2005 by selecting the **Repair** option.
    2. Reinstall Visual Basic Express 2005 SP1 by selecting the **Repair** option.

- **Visual Web Developer Express SP1 fails to uninstall**

    This error occurs in the following scenario:

    1. Install Visual Web Developer Express.
    2. Install Visual Web Developer Express SP1.
    3. Uninstall Visual Web Developer Express.
    4. Install Visual Web Developer Express.
    5. Install Visual Web Developer Express SP1.
    6. Uninstall Visual Web Developer Express SP1.
    7. An error will be met.

    To return to a known system state, follow these steps:

    1. Uninstall Visual Web Developer Express.
    2. Install Visual Web Developer Express.
    3. Install Visual Web Developer Express SP1.

- **Uninstalling Visual Studio 2005 Team Suite SP1 removes symbols**

    Uninstalling Visual Studio 2005 Team Suite SP1 removes symbol files and can break the original Visual Studio 2005 product installation.

    To resolve this issue, repair Visual Studio 2005. A product repair of Visual Studio 2005 will replace all of the missing files.

- **Uninstalling Visual Studio 2005 SP1 in a side-by-side scenario can break the other service pack installation**

    When two Visual Studio 2005 editions are installed on the same computer and are updated by with the service pack, uninstalling the service pack for one of the editions will revert files to the non-service pack level for the other edition.

    To resolve this issue, reinstall the service pack on the other edition.

- **The Knowledge Base (KB) numbers associated with some of the service packs are incorrect**

    The KB numbers associated with some of the service packs appear incorrectly on the product **Add/Remove Programs** or **Uninstall a Program** in the Control Panel. The **Help** or **More Information** button displays a link to a specific KB article, which may contain an incorrect KB number in its Uniform Resource Locator (URL). Refer to the table below for the correct KB numbers.

    |Actual KB Number|Uninstall KB Number|Language|Product Family|
    |---|---|---|---|
    |926601|926601|English|Visual Studio 2005 Team Suite|
    |926602|926602|Japanese|Visual Studio 2005 Team Suite|
    |926603|926603|Chinese (Traditional)|Visual Studio 2005 Team Suite|
    |926604|926603|Chinese (Simplified)|Visual Studio 2005 Team Suite|
    |926605|926603|Korean|Visual Studio 2005 Team Suite|
    |926606|926603|German|Visual Studio 2005 Team Suite|
    |926607|926607|French|Visual Studio 2005 Team Suite|
    |926608|926608|Italian|Visual Studio 2005 Team Suite|
    |926609|926608|Spanish|Visual Studio 2005 Team Suite|
    |926738|922996|English|Visual Studio 2005 Team Foundation Server|
    |926739|922996|Japanese|Visual Studio 2005 Team Foundation Server|
    |926740|922996|Chinese (Traditional)|Visual Studio 2005 Team Foundation Server|
    |926741|922996|Chinese (Simplified)|Visual Studio 2005 Team Foundation Server|
    |926742|922996|Korean|Visual Studio 2005 Team Foundation Server|
    |926743|922996|German|Visual Studio 2005 Team Foundation Server|
    |926744|922996|French|Visual Studio 2005 Team Foundation Server|
    |926745|922996|Italian|Visual Studio 2005 Team Foundation Server|
    |926746|922996|Spanish|Visual Studio 2005 Team Foundation Server|
    |926747|918525|Multi-Language|Visual Studio 2005 Express Editions|
    |926748|926748|Multi-Language|Visual Studio 2005 Express Editions|
    |926749|918525|Multi-Language|Visual Studio 2005 Express Editions|
    |926750|922995|Multi-Language|Visual Studio 2005 Express Editions|
    |926751|926751|Multi-Language|Visual Studio 2005 Express Editions|
    |928425|926601|Russian|Visual Studio 2005 Team Suite|
    |||||

## Known issues and workarounds

- **Users are prompted for permission to install hotfixes for Visual Studio 2005 SP1 on Windows Vista**

    If hotfixes for Visual Studio 2005 SP1 are released in the future, you'll be prompted for permission to install them. In Windows Vista, permission is required in both the UI mode and the silent mode. If you have to automate hotfix installation on Windows Vista, then you must install hotfixes by using the Administrator account. For more information, see [Visual Studio 2005 Service Pack 1 Update for Windows Vista](https://www.microsoft.com/download/details.aspx?displaylang=en&id=7524).

- **Debugging on 64-Bit Windows installations**

    Visual Studio 2005 SP1 contains several debugger fixes that work when you debug 32-bit applications on 64-bit Windows installations. Only a subset of these fixes works when you debug 64-bit applications on 64-bit installations. It's because Visual Studio 2005 SP1 doesn't change many of the 64-bit debugging components.

- **Debugging 64-bit native Visual Basic applications on 64-bit Windows installations**

    While debugging a Visual Basic application in Visual Studio 2005 SP1 on a 64-bit computer, you may receive the following error when the debugger tries to evaluate a partially qualified name (**MyName**, for example) in the Watch window or Immediate window:

    > BC 30699 "**MyName** is not declared or the module containing it is not loaded in the debugging session."

    It only applies to applications compiled using **Any CPU** or **x64** as the **Platform Type**. An optimization to the Protein Data Bank (PDB) format has been made in Visual Studio 2005 SP1. The optimized PDB format can only be used by the Visual Basic compiler that ships with Visual Studio 2005 SP1. Debugging on a 64-bit Windows installation is done through the remote debugging components, but those components haven't been updated to understand the optimized PDB format.

    To resolve this issue, provide a full qualification for the name in the debugger windows. For example, *ConsoleApplication1.MyClass.MyName*.

- **Remote debugging**

    Visual Studio 2005 SP1 can't be installed on a system that doesn't contain an installation of Visual Studio 2005. So computers that contain only remote debugging components and that don't have Visual Studio 2005 can't be updated by Visual Studio 2005 SP1.

    To resolve this issue, do one of the following steps:

  - Apply Visual Studio 2005 SP1 changes to the computers that contain the remote debugging components by replacing them with the components in `C:\Program Files\Microsoft Visual Studio 8\Common7\IDE\Remote Debugger\x86\`.

  - Share the `C:\Program Files\Microsoft Visual Studio 8\Common7\IDE\Remote Debugger\x86\` directory on your network so that remote computers can run msvsmon.exe directly from that share.

    > [!NOTE]
    > The debugging fixes in Visual Studio 2005 SP1 aren't installed on 64-bit computers because none of the files in `C:\Program Files\Microsoft Visual Studio 8\Common7\IDE\Remote Debugger\` are changed. If you want to apply the debugger fixes on remote systems, use a 32-bit system as the source for the debugging components.

- **Installing multiple Windows Embedded CE 6.0 software development kits (SDKs)**

    When you install multiple Windows Embedded CE 6.0 SDKs that are based on same operating system design, you'll see only one SDK in the Visual Studio 2005 SP1 Native Projects Creation Wizard.

    Scenario:
    1. Install Visual Studio 2005 SP1.
    2. Install multiple WINCE6.0 SDKs that are based on the same operating system design.
    3. Create new native projects and then click Platforms to select the platform SDKs. Only one SDK will be listed.

- **Managed Resource Editor**

    Trying to add a new image, icon or text file, or an existing file that isn't in the project folder or one of its subfolders, will cause Visual Studio to display this error message:

    > Attempted to read or write protected memory. This is often an indication that other memory is corrupt.

    To resolve this issue:
    1. Move or copy the bitmap or other file to the destination folder in the project (usually the **Resources** folder).
    2. Drag the file from there to the managed resource editor.

- **Recent versions of the Qt library source give errors on compilation**

    A fix to the VC++ compiler has caused certain template code not to compile with Visual Studio 2005 SP1 and to give a C2244 error. The code that does compiles without SP1 uses inherited template classes and nested types. In particular, current versions of the Qt library source that use such template code are affected by this change.

    The most basic form of the problematic code looks like this:

    ```csharp
    template <class T>
    class A
    {
        public:
        typedef int N_A;
    };
    template <class T>
    class B : public A<T>
    {
        public:
        typename A<T>::N_A test();
    };
    template <class T>
    typename A<T>::N_A B<T>::test()    /* 1 */
    {
        return 0;
    }
    ```

    Template class B inherits from template class A. `A<T>` has a nested type, `N_A`, that `B<T>::test()` returns. The Visual Studio 2005 SP1 compiler produces a C2244 error on the line marked /* 1 */. The workaround is to introduce a typedef for `A<T>::N_A` in `B<T>` and the use that typedef throughout `B<T>`. With the workaround, the code above is changed to:

    ```csharp
    template <class T>
    class A
    {
        public:
        typedef int N_A;
    };
    template <class T>
    class B : public A<T>
    {
        public:
        typedef A<T>::N_A N_B;  // typedef definition
        typename N_B test(); // use of the typedef in the return type
    };
    template <class T>
    typename B<T>::N_B B<T>::test()    // use of the typedef in the return type
    {
        return 0;
    }
    ```

- **Viewing Visual Basic application events crashes Visual Studio**

    Clicking **View Application Events** in the Application property page in a Visual Basic project will cause Visual Studio to crash if the ApplicationEvents.vb file doesn't already exist.

    To resolve this issue, create a file named *ApplicationEvents.vb* in the root of the Visual Basic project and then insert the following text:

    ```vb
    Namespace My
    ' The follow events are available for MyApplication:
    ' Startup: Raised when the application starts, before
    ' the startup form is created.
    ' Shutdown: Raised after all application forms are closed.
    ' This event is not raised if the application terminals
    ' abnormally.
    ' UnhandledException: Raised if the application encounters
    ' an unhandled exception.
    ' StartupNextInstance: Raised when launching a single-
    ' instance application and the application is already
    ' active.
    ' NetworkAvailabilityChanged: Raised when the network
    ' connection is connected or disconnected.

    Partial Friend Class MyApplication

    End Class

    End Namespace
    ```

- **XML Designer crashes when the TargetNamespace property of an XML schema is empty**

    When XML schemas contain an `<Include>` that references other XML schemas, the XML Designer might crash if the Namespace (`xmlns`) or TargetNamespace (`targetNamespace`) is a value that differs from the namespace that is referenced in the associated schema. In other words, when schemas include other schemas, they must reference the same namespace.

    To resolve this issue, follow these steps:
    1. Right-click the schema file in Solution Explorer and then select **View Code** to open the schema in the editor.
    2. Set `targetNamespace` and `xmlns` to the same namespace.

- **Team Foundation Server**

    For more information, see [Microsoft Team Foundation Server 2010 Service Pack 1](https://support.microsoft.com/help/2182621).

- **Profiler driver becomes unusable on Windows 2000**

    The profiler driver will sometimes stop working on Windows 2000 platforms. Trying to start the monitor in sampling mode will report an error. Trying to start the monitor in trace mode will report a warning about can't run the driver.

    To resolve this issue, follow these steps:
    1. Reboot the computer.
    2. Run these commands:

        ```console
        vsperfcmd -driver:uninstall
        vsperfcmd -driver:start
        ```

    3. Sign out of the computer.
    4. Sign in to the computer.
    5. Start the monitor as before.

- **CFindReplaceDialog isn't localized in native Smart Device projects**

    The `CFindReplaceDialog` displays English text when called from a native C++ Smart Device application on a non-English device. The resources for `CFindReplaceDialog` aren't localized, and there's no resolution for this issue.

- **Existing Windows Mobile SDK samples and Smart Device native applications may not compile**

    Many existing samples and native user applications when built using Visual Studio 2005 SP1 will fail to compile with this error message:

    > Error LNK2019: unresolved external symbol __GSHandlerCheck

    Samples in both the Windows Mobile 5.0 SDK for Pocket PC and the Windows Mobile 5.0 SDK for Smartphone are affected by this issue.

    Visual Studio 2005 SP1 updates the Visual Studio compilers with the **/GS** support that is already available in Windows CE 6.0 compilers. Link errors will occur in native C++ Smart Device projects that don't explicitly link to *libcmt.lib* or that have turned off **/GS**, and that are running on pre-Windows Embedded CE 6.0 platforms.

    To resolve this issue:
    1. Explicitly include *libcmt.lib* in the list of additional libraries to link against.
    2. Turn off the linker warning (/nowarn:4099)

- **Databinding fails on coded Web tests in Visual Studio Team Suite for Software Testers**

    This error occurs when coded Web tests that are bound to different data sources are run from the same load test.

    Scenario:
    1. Create two coded Web tests that use databinding and are bound to different data sources.
    2. Add the two tests to a single load test.
    3. Run the load test.

    An error indicates that that data for one of the two data sources can't be found.

    It's no resolution at this time. We'll release a hotfix during the first quarter of 2007.

### Web applications and projects

- **Refactoring performance in ASP.NET Website projects is improved**

    Invoking a refactoring operation in a solution that contains an ASP.NET website now does better.

    Before determining if an .aspx page should be loaded, the refactoring operation will:

  - Do a lexical search on the element that is being refactored to determine if it exists in an .aspx page.
  
  - Determine if a reference is accessible from the current scope. In Web Application projects, rename refactoring and find-all references aren't supported from within .aspx files. However, refactoring in code-behind files is fully supported.

- **Web application project conversion issues**

    Conversion of a mixed solution that contains both Visual C# and Visual J# projects may fail or may produce an empty project. The workaround is to convert each project individually by starting with a new instance of Visual Studio for each conversion.

    Canceling the conversion of a project to a Web Application project may cause an error and leave the project in a half-converted state.

    Upgrading a 2003 Visual Basic 6 WebClass project may fail to complete. The workaround is to close the project, and then reopen it and rerun the upgrade.

    In Web Application Projects, when you convert Visual Basic files or .aspx files, the designer file may not be updated correctly. The workaround is to manually correct the files.

- **Web site projects and web application project general issues**

    The Web Applications project system doesn't detect missing *web.config* files. Adding a control that requires configuration information will cause a false folder to appear in Solution Explorer. The workaround is to add a *web.config* file manually before you add any controls to a Web Application project.

    Web Application projects that contain subprojects that reference controls in the root project may hang the IDE.

    If a Web site solution that contains .pdb and .xml files is added to TFS source control, the .pdb files and .xml files may not be added correctly.

    Visual Studio will leak memory when you operate a Wizard inside a View inside a Multi-view. The workaround is to save the solution and then restart Visual Studio.

    Changes to the bin folder in Web site and Web Application projects can cause Visual Studio to create a shadow copy of the entire bin folder. This copying can slow the performance of Visual Studio and consume disk space.

    If your page and user controls exist in different namespaces that are under the same root namespace, the generated code won't compile because the namespace that the designer creates for the declaration of the user control inside the page is wrong. The workaround is to delete the declaration from the designer file and then put it in the code-behind file. Once it's moved to the code-behind file, it will remain the unaltered even if you change the page.

    Installing and uninstalling third-party browsers may cause running by pressing F5 and the View in Browser command to stop working for web application projects. You can check to see if the following registry key is still available:

    > [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\IEXPLORE.EXE] @=""C:\\Program Files\\Internet Explorer\\iexplore.exe"" ""Path""=""C:\\Program Files\\Internet Explorer;"""

    After you install the service pack, Web Application projects on Windows 2000 may fail to connect to the client-side ASP.NET development server. Which may cause the build to fail and may hang Visual Studio. The problem is the result of a race condition between the project system and the development server. The workaround is to configure the project to use IIS on Windows 2000 and thereby avoid the development server.

    In a web application project, attempting to create an event handler by double-clicking the event in the designer may fail when the page class contains one or more overloaded methods. Which doesn't happen when you use a Web Site project.

    Publishing a web application project to a read-only share will cause Visual Studio to crash. The workaround is to make sure that the share is writable.

    Third-party firewalls may cause Visual Studio to crash.

    In a Web Application project, every use of CTRL+F5 or View in Browser will cause a new instance of Internet Explorer to be launched.

    Web site projects fail to nest properly in Web Application Projects.

    Adding an image through the properties resource page may cause a false error message to be displayed.

    WSE 3.0 tracing doesn't work with projects that were created by using the Visual Studio 2005 Web Application project. Tracing does work as expected in WSE 3.0 for Web Site Projects.

- **Enabling trace profiling of web application projects or web service applications**

    Trace profiling from the Visual Studio IDE doesn't work for Web Application projects or Web Service applications. User code isn't seen in the reports.

    To resolve this issue:
    1. Open the project properties page.
    2. For Visual C# projects, add the following to the **Post-build event command-line** window:  
    `$(DevEnvDir)\..\..\team tools\performance tools\vsinstr$(TargetPath)`

    3. For Visual Basic projects, click **Build Events** to open the **Build Events** dialog box. Add the following to the **Post-build event command line** window:  
    `$(DevEnvDir)\..\..\team tools\performance tools\vsinstr$(TargetPath)`

    4. Profile as usual from the IDE. If you want to run sampling profiling, remove this line from the property page.

- **Unspecified error when checking in Visual Studio 2003 web application after conversion in Visual Studio 2005 SP1**

    This error occurs in the following scenario:
    1. In Visual Studio 2003, create a solution, add a Web application, and then add it to source control.
    2. In Visual Studio 2005, on the **File** menu, click **Open** from source control and then select the Visual Studio 2003 solution.
    3. In the **Migration** dialog box that appears, click **Finish** to migrate the solution to Visual Studio 2005.
    4. This warning appears during migration:

        > One or more projects in the solution could not be loaded for the following reason(s): The project file or web has been moved, rename or is not on your computer. These projects will be labeled as unavailable in Solution Explorer. Expand the project node to show the reason the project could not be loaded.

    5. Click **OK**. The solution will be migrated successfully, but the project won't be migrated and it will be unavailable in **Solution Explorer**.

    To resolve this issue, follow these steps:
    1. Install Visual Studio 2003.
    2. Create a solution in Visual Studio 2003.
    3. Install Visual Studio 2005.
    4. Load the solution in Visual Studio 2005 and then save it.
    5. Install Visual Studio 2005 SP1.
    6. Load the solution that you saved in step 4.

## Hardware notes

- **Customers working with ARMV4i and ARMV4T board types**

    If you're working with ARMV4i and ARMV4T board types with instruction set IDs of 84017153 and 84082689, then you can't use Visual Studio to deploy applications, debug, or test on devices.

    To resolve this issue, follow these steps:
    1. Make a backup copy of *Microsoft.TypeMaps.8.0.xsl*, which is located in `C:\Documents and Settings\All Users\Application Data\Microsoft\corecon\1.0\addons\`.

        In *Microsoft.TypeMaps.8.0.xsl*, after `<QISCONTAINER>` (line 6), add the following lines:

        ```xml
        <QIS ID="84017153">
            <PROPERTYCONTAINER>
                <PROPERTY ID="default" Protected="true">ARMV4I</PROPERTY>
            </PROPERTYCONTAINER>
        </QIS>
        <QIS ID="84082689">
            <PROPERTYCONTAINER>
                <PROPERTY ID="default" Protected="true">ARMV4I</PROPERTY>
            </PROPERTYCONTAINER>
        </QIS>
        ```

    2. Save the file.

## Related products

- Microsoft Device Emulator version 2.0

    Visual Studio 2005 SP1 doesn't update the installed Device Emulator. Device Emulator 2.0 will be released in January 2007. With Device Emulator 2.0, users can benefit from much higher performance and target device application development for the recently released Windows Embedded CE 6.0 platform.

- Crystal Reports for Visual Studio 2005 Service Pack 1

    Crystal Reports for Visual Studio 2005 Service Pack 1 will be released in Spring 2007. The service pack will increase the overall quality of the existing product features and maintain a high level of compatibility with Visual Studio 2005 SP1 and Windows Vista. The service pack will address issues raised by customer feedback and internal testing. Business Objects is committed to increasing the quality of our products.

- Dotfuscator Community Edition

    Dotfuscator Community Edition has been updated since the Visual Studio 2005 original release version. Visit [PreEmptive Solutions](https://www.preemptive.com/support/dotfuscator/vs2005.html) to read about the changes and to obtain a free update.
