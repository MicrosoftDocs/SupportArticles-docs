---
title: Troubleshooting IIS 7.x installation problems by checking the log files
description: This article helps you troubleshoot IIS 7.x installation issues.
ms.date: 04/09/2012
ms.reviewer: puneetg, johnhart, senyum, v-jayaramanp
ms.topic: troubleshooting
---

# Troubleshooting IIS 7.x installation problems

This article provides information related to troubleshooting installation issues in IIS 7.x by reviewing the log files. Although this article is for IIS 7.x the same concepts can be applied to other versions of IIS.

_Applies to:_&nbsp; Internet Information Services 7.0 and later versions

## Reviewing the IIS setup log files

The installation process does its own logging in the *IIS7.log* text file (typically in *c:\windows\iis7.log*). The first thing to look for is "FAIL" errors in the log file.

Here is an example of an entry in *IIS7.log*:

```output
[11/12/2010 19:48:13] [ ***** IIS 7.0 Component Based Setup ***** ] 
[11/12/2010 19:48:13] "C:\Windows\System32\inetsrv\iissetup.exe" /install FTPServer 
[11/12/2010 19:48:13] < !!FAIL!! > METABASE_UTIL::InstallFtpMetabaseEntries result=0x800708c5 
[11/12/2010 19:48:13] < !!FAIL!! > Install of component FTPServer result=0x800708c5 
[11/12/2010 19:48:13] < !!FAIL!! > COMPONENT::ExecuteCommand result=0x800708c5 
[11/12/2010 19:48:13] [ End of IIS 7.0 Component Based Setup ]
```

The log tells you the setup ran and if it succeeded. With the error message and installation command line, search the web for the error "InstallFtpMetabaseEntries result=0x800708c5".

You could rerun the setup. This helps you isolate the issue and collect right data such as process monitor for just the failure, and you need not run the setup frequently.

Try stopping all third party (non-Microsoft services from startup) services and reboot the computer before trying the next installation or uninstallation of IIS.

To quickly identify and disable these services:

1. Go to **Start** menu and type *msconfig*.
1. In the **System Configuration** dialog box, go to the **Services** tab, and select the **Hide all Microsoft services** checkbox at the bottom.
1. Disable all third party services that can be stopped without affecting the server's reboot. Usually, these are anti-virus software and backup software.

Another common but important step is to uninstall WPAS "Windows Process Activation Services" especially when you try to uninstall and reinstall IIS. When you install IIS, the installer adds WPAS automatically as one of the dependencies. However, when you uninstall IIS, WPAS doesn't get uninstalled automatically leaving the core binaries intact. This is done for a reason and isn't a bug. It is left in place to prevent breaking any other services on the machine that specifically use this process paradigm, such as WCF services. Make sure that WPAS is explicitly uninstalled by going to **Features** under **Server Manager** and selecting **Windows Process Activation Services**.

> [!NOTE]
> This was changed in IIS 7.5. In IIS 7.5, the uninstaller will check for other dependencies for WAS (such as WCF), and if none are found, then the IIS uninstallation process will remove WAS.

## Reviewing the CBS (Component based Setup) logs

If *IIS7.log* is clean, then there's a good chance that the problem is with the CBS (Component Based Setup) engine. CBS logs can be found at *C:\Windows\Logs\CBS folder*.

Just like *IIS7.log* file, *CBS.log* file is a text file and can be opened using any text editor (You have to open this file from administrative command prompt). You can get some useful information from these logs by keeping the time frame of the installation failure in mind and searching for "Failure will not be ignored: A rollback will be initiated" string in the *CBS.log* file. Here's an example of one such instance.

```output
2010-07-08 14:04:08, Info CSI 00000047 Calling generic command executable (sequence 2): [40]"C:\Windows\System32\inetsrv\iissetup.exe" CmdLine: [151]""C:\Windows\System32\inetsrv\iissetup.exe" /launch C:\Windows\System32\inetsrv\appcmd.exe reset config -section:system.applicationHost/listenerAdapters" 
2010-07-08 14:04:08, Error CSI 00000048 (F) Done with generic command 2; CreateProcess returned 0, CPAW returned S_OK Process exit code 16386 (0x00004002) resulted in success? FALSE Process output: [l:22 [22]"Failed = 0x80004002"][gle=0x80004005] 
2010-07-08 14:04:09, Info CSI 00000051@2010/7/8:18:04:09.688 CSI Advanced installer perf trace:CSIPERF:AIDONE; {81a34a10-4256-436a-89d6-794b97ca407c};Microsoft-Windows-IIS-SharedLibraries, Version = 6.1.7600.16385, pA = PROCESSOR_ARCHITECTURE_AMD64 (9), Culture neutral, VersionScope = 1 nonSxS, PublicKeyToken = {l:8 b:31bf3856ad364e35}, Type neutral, TypeName neutral, PublicKey Neutral;6148228 
2010-07-08 14:04:09, Error [0x018007] CSI 00000052 (F) Failed execution of queue item Installer: Generic Command ({81a34a10-4256-436a-89d6-794b97ca407c}) with HRESULT HRESULT_FROM_WIN32(14109). Failure will not be ignored: A rollback will be initiated after all the operations in the installer queue are completed; installer is reliable (2)[gle=0x80004005] 
2010-07-08 14:04:10, Info CSI 00000053 End executing advanced installer (sequence 75) Completion status: HRESULT_FROM_WIN32(ERROR_ADVANCED_INSTALLER_FAILED)
```

As before, search the web for additional clues about the error.

> [!TIP]
> Try other ROLES and see if they fail. If they do, IIS is just a victim and you can engage Platforms setup for assistance if you don't want to follow the next steps.

Run the [System Update Readiness Tool](../../../../windows-server/deployment/fix-windows-update-errors.md) (short name CHECKSUR). This tool is available for Windows Vista, Windows Server 2008, Windows 7, and  Windows Server 2008 R2. If installation of this tool fails, then there are some other issues with the computer and you can contact Microsoft Support.

Run `sfc /scannow` from an elevated command prompt. This command can take five to ten minutes and if this tool detects corruption, it tries to fix it too. If there are errors and this tool fixed them, then you may see something like this.

```Console
C:\>sfc /scannow 
Beginning system scan. This process will take some time. 
Beginning verification phase of system scan. 
Verification 100% complete. 
Windows Resource Protection found corrupt files and successfully repaired 
them. Details are included in the CBS.Log windir\Logs\CBS\CBS.log. For example C:\Windows\Logs\CBS\CBS.log
```

If this command reports errors that the tool can't fix, you may see something like the following message. In this case, contact Microsoft Support for assistance.

```output
Windows Resource Protection found corrupt files but was unable to fix some of them. 
Details are included in the CBS.Log windir\Logs\CBS\CBS.log. For example 
C:\Windows\Logs\CBS\CBS.log
```

Only when both the tools run successfully, proceed with your troubleshooting. There's a good chance that running these steps could fix whatever corruption was present in CBS. If these tools do find problems in CBS engine, it can help you narrow down the issue and save time in troubleshooting.

