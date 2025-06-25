---
title: How to use a setup log to troubleshoot setup problems in Office
description: Explains how to use Office installation log files to troubleshoot Office setup issues.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\SxS\SxSOrPerpetual
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Office Professional 2010
  - Microsoft Outlook 2010
  - PowerPoint 2010
  - Publisher 2010
  - Access 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office PowerPoint 2007
  - Microsoft Office Publisher 2007
  - Microsoft Office Access 2007
  - Microsoft Office Professional Edition 2003
  - Microsoft Office Outlook 2003
  - Microsoft Office PowerPoint 2003
  - Microsoft Office Publisher 2003
  - Microsoft Office Small Business Edition 2003
  - Microsoft Office Basic Edition 2003
  - Microsoft Office Access 2003
ms.date: 06/06/2024
---

# How to use a setup log to troubleshoot setup problems in Office

This step-by-step article describes how to use the Microsoft Office installation log files to troubleshoot Office Setup issues.

Occasionally a problem occurs with Office Setup and you may not receive an error message. Even if you receive an error message, you may have to use an installation log file as one of your tools to determine the issue.

This article discusses several techniques to interpret the information in Office installation log files. The topics are listed in the order that you want to use each technique. This article does not cover every situation that you may experience, but it discusses several examples where the Setup issue is resolved by interpreting a Setup log file.

Many articles in the Microsoft Knowledge Base that relate to installation errors also include sections of log files that help you confirm that the article describes the same issue that you are experiencing.

## How to create a log file

Office Setup automatically creates log files in your \Temp folder. The logs will be stored under %temp% for Sign-in or Activation issues. For installation or patching issues, they use the system account, so you will also want to collect the logs from %windir%\temp. For more information, see [How to enable Microsoft 365 Apps for enterprise ULS logging](/microsoft-365/troubleshoot/authentication/how-to-enable-office-365-proplus-uls-logging).

|Log file for|Log file name
|---|---|
|Setup.exe|Microsoft Office Setup(####).txt|
|Windows Installer (System Files Update)|Microsoft Office Setup(####)_Task(0001).txt|
|Windows Installer (Office installation)|Microsoft Office Setup(####)_Task(0002).txt|

The #### characters in the log file names are numbers that start with 0001. They increment by one each time that you run Setup. Therefore, the log file that has the highest number is the log file for the most recent time that you ran Setup.

> [!NOTE]
> You may have only a Microsoft Windows Installer log file for the Office installation. In this situation, the Windows Installer log file for the Office installation has Task(0001) appended to the log file instead of Task(0002).

## How to interpret log files

Depending on the problem that you are experiencing, you may have to view the Setup log file or the Windows Installer log file for the Office installation.

### Setup log files

The log file for the Setup.exe file is very short because the number of tasks that Setup.exe performs is limited to tasks like the following:

- Read the Setup.ini file.
- Parse the command line for properties and switches that have to be passed to the Windows Installer. A common mistake is to include `Transform=<path>\<transform file name>.mst` on a command line. Using this on the command line doesn't produce an error message during the installation, but the transform won't be applied to the installation. The correct command line is `Transforms=<path>\<transform file name>.mst`.

  The Setup.exe log file contains the command line that you specified for the installation, so you must check the log file for typographical errors, such as the one shown in the previous example (the letter **s** is missing from the end of **Transform** in the first command line).
- Verify that the correct operating system and service pack are being used.
- Check the version of the Msi.dll file.
- Start the Instmsi(w).exe file to install the Windows Installer.
- Check for installed beta versions of Office.
- Check the version of the Tahoma and TahomaBD fonts.

By default, Setup creates a local installation source in Office, but only when you install Office from the CD or a compressed CD image. If sufficient hard disk space exists on the local computer, Setup caches the whole installation source by default. Windows Installer uses this local installation source to install Office, and the local source remains available for repairing, reinstalling, or updating Office later. Users can install features on demand or run Setup in maintenance mode to add new features. Because Setup creates the local installation source by default, you do not have to set any additional options. Setup creates the local installation source in the following hidden folder on users' computers:

\<drive>\Msocache\Downloadcode

By default, Setup caches the whole source in Office. If the user's computer doesn't have sufficient disk space, Setup caches installation file for only the selected features. Setup retains the local installation source after the installation is complete.

The following information may be contained in the Setup log:

- Listing of files to be copied to the \MSOCACHE folder: Files to Download:

    ```output
    File: FILES\WINDOWS\INF\AER_1033.ADM (DW20.ADM_1033)
    File: FILES\PFILES\COMMON\MSSHARED\DW\DW20.EXE (DW20.EXE_0001)
    File: FILES\PFILES\COMMON\MSSHARED\DW\DWDCW20.DLL (DWDCW20.DLL)
    File: FILES\PFILES\COMMON\MSSHARED\DW\1033\DWINTL20.DLL (DWINTL20.DLL_0001_1033)
    File: FILES\PFILES\COMMON\MSSHARED\DW\DWTRIG20.EXE (DWTRIG20.EXE)
    File: FILES\PFILES\MSOFFICE\OFFICE11\OCLEAN.DLL (OCLEAN.DLL_1033)
    File: FILES\PFILES\MSOFFICE\OFFICE11\OCLNCORE.OPC (OCLNCORE.OPC_1033)
    File: FILES\PFILES\MSOFFICE\OFFICE11\OCLNCUST.OPC (OCLNCUST.OPC_1033)
    File: FILES\PFILES\MSOFFICE\OFFICE11\1033\OCLNINTL.OPC (OCLNINTL.OPC_1033)
    File: FILES\PFILES\MSOFFICE\OFFICE11\OFFCLN.EXE (OFFCLN.EXE_1033)
    File: FILES\SETUP\OSE.EXE (OSE.EXE)
    File: PRO11.MSI (PRO11.MSI)
    File: FILES\PFILES\MSOFFICE\OFFICE11\1033\PSS10O.CHM (PSS10O.CHM_1033)
    File: FILES\PFILES\MSOFFICE\OFFICE11\1033\PSS10R.CHM (PSS10R.CHM_1033)
    File: FILES\PFILES\MSOFFICE\OFFICE11\1033\SETUP.CHM (SETUP.CHM_1033)
    File: SKU011.XML (SKU011.XML_0002_1033)
    File: A2561405.CAB (A2561405.CAB)
    File: A3561405.CAB (A3561405.CAB)
    File: A4561405.CAB (A4561405.CAB)
    File: AV561403.CAB (AV561403.CAB)
    File: CC561401.CAB (CC561401.CAB)
    ```

- Confirmation of Local Install Source settings:

    ```output
    Using Local Cache Drive of already installed product: C:\.
    Found enough space on drive "C:\" to cache all feature cabinets.
    (CDCACHE=AUTO) - There is enough space to cache some or all of the image. Drive for this download is C:\
    ```

- Confirmation of completed task:

    ```output
    Package was: E:\5614.0_o11pro_CBXS_ENG\PRO11.MSI.
    Setting Package to: C:\MSOCache\All Users\90000409-6000-11D3-8CFE-0150048383C9\PRO11.MSI.
    Done with CD Caching, cached MSI to: C:\MSOCache\All Users\90000409-6000-11D3-8CFE-0150048383C9\PRO11.MSI    
    ```

If you suspect problems with the command-line properties and switches that you are using, these items are also listed in the Setup log file. For example, if you use the following command line to run Setup:

```powershell
f:\Setup.exe companyname="contoso" /qb
```

The following text is included in the Setup log:

```output
Launch Setup 
9/22/03 1:49:46 PM 
companyname="contoso" /qb
Detected Windows Info:
 PlatformId = 2
 MajorVersion = 4
 MinorVersion = 0
Setup path: \\server\share\2003_Admin\SETUP.EXE
Adding property...companyname="contoso"

Recognized command line switch: /qb -and-Office-specific properties added: companyname="contoso"
General properties added: LAUNCHEDFROMSETUP=1 SETUPEXEPATH=\\server\share\2003_Admin\ 
Writing Task:
D:\WINNT\System32\msiexec.exe
 /I \\server\share\2003_Admin\PRO11.MSI
 METRICSSOURCE="\\server\share\2003_Admin companyname=""contoso"" /qb"
 companyname="contoso" LAUNCHEDFROMSETUP=1 
SETUPEXEPATH=\\server\share\2003_Admin\ /qb 
```

> [!NOTE]
> Setup.exe doesn't actually use these command-line switches and properties. It just passes them to the Msiexec.exe file (the Windows Installer).

If the log file for Setup.exe ends in text that is similar to the following (return code: 1603), there was a problem with the Windows Installer portion of the installation:

```AsciiDoc
9/22/03 3:34:27 PM Chained install return code: 1603
Shutting down chained setup processing.
Set Verbose logging for subsequent setup.

***** Setup exits 
9/22/03 3:34:27 PM 
(return = 1603)  
```

In this case, you must review the Windows Installer log files for the Office installation.

### Windows Installer log files

The Windows Installer log files are significantly larger than the Setup log file and can appear to be unreadable at first. However, the following guidelines can help you narrow down the issue:

- If you receive an error message during Setup, search for the error number in the log file. For example, if you receive "Error 1327" during Setup, search for "1327" in the log. You may find text that's similar to the following example:

    ```output
    MSI (c) (41:90): Note: 1: 1327 2: C:\
    Error 1327. Invalid Drive: C:\ 
    
    MSI (c) (41:90): Product: System Files Update -- Error 1327. Invalid Drive: C:\
    
    Action ended 15:34:26: CostFinalize. Return value 3.
    ```

    The key text in these log entries is **Invalid Drive**. The problem in this case is that you used a utility like Disk Administrator to change the drive letter of the location where Windows is installed. Although the drive letter was changed, some registry keys still refer to the original drive letter.
- If the Microsoft Knowledge Base doesn't have an article that matches your specific error message, follow these steps to diagnose the issue:

  1. Search the log file for the error number.
  2. Read each line up from the line with the error number. Typically you see a line that failed, with the ultimate result being a Setup error.

     For example, a log file was searched for "error 2737". The following text was located at or above the line with the 2737 error:

     ```output
     MSI (c) (B7:A7): Note: 1: 2737 2: CheckCAServer 3: 
     c:\windows\TEMP\MSI82D6.TMP 4: CheckCAServer
     Info 2898. An internal error has occurred. (Tahoma8 Tahoma 1)
     Error 2737. An internal error has  occurred. (CheckCAServer c:\windows\TEMP\MSI82D6.TMP CheckCAServer )
     MSI (c) (B7:A7): Product: Microsoft Office Professional 2003 -- Error 2737. An internal error has occurred. (CheckCAServer c:\windows\TEMP\MSI82D6.TMP CheckCAServer )
    
     Action ended 9:58:55: CheckCAServer. Return value 3. 
     ```

     Looking at this text, you see that Setup failed on the call to CheckCAServer.
- All log files contain one or more errors that typically can be ignored. The following errors may appear in any log file and typically don't indicate a Setup problem:

  - **Info 2898. An internal error has occurred. Contact your Information Technology department for assistance.**  
  - **Info 2743. An internal error has occurred. Contact your Information Technology department for assistance.**  
  - **Info 2726. An internal error has occurred. Contact your Information Technology department for assistance.**

- One thing to search for is the string "Note". In one case where Setup failed with a 2755 error, the actual resolution for the case was derived from the Note several lines above the error:

   ```output
   MSI (s) (EC:BC): Note: 1: 2336 2: 5 3: C:\WINNT\Installer\ 
   MSI (s) (EC:BC): MainEngineThread is returning 1632
   MSI (c) (F8:F4): Note: 1: 2755 2: 1632 3: \\server\share\2003_Admin\PRO11.MSI 
   Error 2755. An internal error has occurred. (1632 \\server\share\2003_Admin\PRO11.MSI) Contact your Information Technology department for assistance.
   ```

   In this example, the following two lines indicate a problem with permissions on the \Winnt\Installer folder:

    > MSI (s) (EC:BC): Note: 1: 2336 2: 5 3: C:\WINNT\Installer\  
    > MSI (s) (EC:BC): MainEngineThread is returning 1632

   After the permissions were corrected on this folder, the 2755 error didn't occur.

   > [!NOTE]
   > The line that contains "1632" is the determining factor that this issue deals with permissions.  
   >
   > In log entries that contain **Note**, the four-digit number that follows **Note** can be mapped directly to the Windows Installer errors that are listed in the Knowledge Base articles cited earlier in this article.
- Another string to search for in the log file is **Return Value 3**. If you don't have or remember an error number, but you locate **Return Value 3** in the log file, it's the area to focus your troubleshooting. When an action is performed during Setup, the action is noted in the log files. When that action is complete, a return value is subsequently noted. If the return value is 1, the action was successful. If the action failed, the return value will be 3.

    ```output
    Action start 9:56:45: SetW2kMill_WFP.
    Action ended 9:56:45: SetW2kMill_WFP. Return value 1.
    MSI (c) (B7:A7): Doing action: CheckCAServer
    Action start 9:56:45: CheckCAServer.
    MSI (c) (B7:A7): Creating MSIHANDLE (3) of type 790542 for thread -183129
    MSI (c) (B7:A7): Closing MSIHANDLE (3) of type 790542 for thread -183129
    MSI (c) (B7:A7): Note: 1: 2737 2: CheckCAServer 3: 
    c:\windows\TEMP\MSI82D6.TMP 4: CheckCAServer
    Info 2898. An internal error has occurred. (Tahoma8 Tahoma 1 
    )
    Error 2737. An internal error has occurred. (CheckCAServer 
    c:\windows\TEMP\MSI82D6.TMP CheckCAServer )
    MSI (c) (B7:A7): Product: Microsoft Office Standard 2003 -- Error 2737. An 
    internal error has occurred. (CheckCAServer c:\windows\TEMP\MSI82D6.TMP 
    CheckCAServer )
    
    Action ended 9:58:55: CheckCAServer. Return value 3. 
    ```

    In this case, the SetW2kMill_WFP action succeeds, because the return value is 1. However, the next action, CheckCAServer, fails because its return value is 3.
- Sometimes when you review a log file, you don't find "Note", "Return Value 3", or an error number. Instead, you may see text that's similar to the following example:

    ```output
    MSI (c) (A5:65): Looking for file transform: c:\test.mst
    MSI (c) (A5:65): Note: 1: 2203 2: c:\test.mst 3: -2147287038 
    MSI (c) (A5:65): Couldn't find cached transform c:\test.mst. Looking for it at the source.
    MSI (c) (A5:65): Looking for file transform: \\server\share\2003_ADMIN\test.mst
    MSI (c) (A5:65): Note: 1: 2203 2: \\server\share\2003_ADMIN\test.mst 3: -2147287038 
    MSI (c) (A5:65): Note: 1: 2729 
    1: 2203 2: \\server\share\2003_ADMIN\test.mst 3: -2147287038 
    Error applying transforms. Verify that the specified transform paths are valid.
    \\server\share\2003_ADMIN\test.mst
    MSI (c) (A5:65): MainEngineThread is returning 1624 
    ```

    In this case, Setup is having a problem applying a transform, because the transform can't be located on the specified path (C:\test.mst). Therefore, Setup also tries to locate the transform on the root of the Office source location. When the transform can't be located in either place, the installation stops.

### Verbose log files

All the techniques that are listed in the [Windows Installer log files](#windows-installer-log-files) section can be used on verbose log files. However, verbose logging increases Setup times. Only use verbose logging if you're having Setup problems that can't be diagnosed with a default log file.

- Generate a verbose log file

    On the initial install of Office, verbose logging isn't used. If a Setup failure occurs, the second try to install will generate a verbose log file. However, the logging options that are used for these verbose log files aren't all the options that are available to the Windows Installer. To create a more detailed Windows Installer log file with all the logging options, you can use the *v parameter combination for the /L switch.

    > [!NOTE]
    > You can create a verbose log file when you perform an administrative installation of Office by using a command line that's similar to the following:
    >
    > `<path>\setup.exe /a <path>\Pro11.msi /L*v C:\Verboselog.txt`

- Diagnose when setup stops responding

    At times, Office Setup stops responding (hangs), and you don't receive any error message. The best thing to do in this situation is to restart your computer, and run Office Setup again with complete verbose logging turned on (with one additional option). To do so, follow these steps:

     1. Click **Start**, and then click **Run**.
     2. In the **Open** box, type the following command line, and then click **OK**:

        `<path>\Setup.exe /L*v! C:\Verboselog.txt`

        Here \<path> is the full path of your Office source location.

    Typically, 19 lines of logging information are cached in memory before being written to the verbose log file. If you don't use the ! option for the /L (logging) switch, you may lose some of the cached information or all the cached information if Setup stops. If you use the ! option, the most you lose is one line, because the ! option forces Setup to write logging information to the log file one line at a time (there is no caching of information).

    After you create the verbose log file, scroll to the end and look at the last one or two lines. These lines tell you what Setup was trying to do when it stopped. For example, you may see text that's similar to the following example:

    ```output
    ComponentRegister(ComponentId={71CE92CC2CB71D119A12000A9CE1A22A},
    KeyPath=C:\Program Files\Common Files\Microsoft Shared\Web
    Components\11\1033\OWCDCH11.CHM,State=3,,Disk=1,SharedDllRefCount=0)
    1: {90170409-6000-11D3-8CFE-0050048383C9} 2:
    {71CE92CC2CB71D119A12000A9CE1A22A} 3: C:\Program Files\Common
    Files\Microsoft Shared\Web Components\11\1033\OWCDCH11.CHM 
    ```

    This indicates a problem with the registration (in the Windows registry) of the component (71CE92CC2CB71D119A12000A9CE1A22A), whose key path is OWCDCH11.CHM.

    The resolution for this particular issue is to repair the Windows registry before you run Office Setup again.

    In another case, you may see text that is similar to the following example in your log file:

    ```output
    MSI (c) (EB:1F): Doing action: OPCRemove
    Action start 11:42:57: OPCRemove.
    MSI (c) (EB:1F): Creating MSIHANDLE (504) of type 790542 for thread -194273 
    ```

    This indicates a problem with an Office Removal Wizard operation. This problem may occur when Office Setup is having a problem removing your earlier version of Microsoft Office. Try to remove the earlier version of Office, and then run Office 2003 Setup again.

    > [!NOTE]
    > Office Setup uses the following prefixes for custom actions. If the log file indicates a problem with a custom action, these prefixes indicate where to start your troubleshooting.
    >
    > - OLCA: Outlook Custom Action
    > - OPC: Office Removal Wizard
    > - CAG, CaMMC: Associated with Clip  
    > - IE: Internet Explorer
