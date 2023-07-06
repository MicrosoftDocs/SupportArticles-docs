---
title: Troubleshooting problems with Microsoft Web Platform Installer
description: This article helps you resolve problems with troubleshooting with Microsoft Web Platform Installer. 
ms.date: 03/18/2009
author: padmajayaraman
ms.author: v-jayaramanp
ms.reviewer: riande, johnhart
ms.topic: troubleshooting
---

# Troubleshooting problems with Microsoft Web Platform Installer

_Applies to:_ &nbsp; Internet Information Services 7.0, Internet Information Services 7.5

## Introduction

Microsoft® Web Platform Installer (Web PI) makes it simple to download and install the latest Microsoft® Web Platform components, including Internet Information Services (IIS), Microsoft® SQL Server® 2008/R2 Express, Microsoft® ASP.NET Model View Controller (MVC3), and Microsoft® Visual Web Developer 2008/SP1 Express Edition. Web PI also helps to install popular Web applications such as WordPress, DasBlog, or Silverstripe. This article presents some troubleshooting advice for issues that may arise with Microsoft Web PI.

Web PI runs on the following operating systems:

- Windows Server® 2008 and Windows Server® 2008 R2
- Windows® XP Professional Edition Service Pack 3
- Windows Server® 2003 SP2
- Windows Vista® SP 1
- Windows® 7

While it's possible to install Web PI on Windows® XP Home Edition, this operating system version doesn't include IIS. Web PI is therefore not supported on Windows XP Home Edition.

Web PI tasks can be divided into three phases:

- **Launch phase** - In this phase, Web PI retrieves the most current product catalog and compares the catalog components with the currently installed products.
- **Product selection phase** - In this phase, Web PI checks dependencies of the products selected to install and builds the list of dependent products that need to be installed.
- **Installation phase**

Web PI helps you install products using one of three technologies:

- Windows® operating system components (for example, IIS) - Web PI uses Windows operating system [tools and interfaces](https://technet.microsoft.com/library/cc776554(WS.10).aspx) such as [PKGMGR](https://technet.microsoft.com/library/cc749302(WS.10).aspx).
- Non-operating system platform components, (for example, SQL Server 2008/R2 Express) - Web PI uses the Windows® Installer technology (also known as MSI).
- Web applications (for example, WordPress, Silverstripe, or DasBlog) - Web PI uses the Microsoft® Web Deployment Tool.

## Problems with Visual Web Developer 2010 or Visual Studio 2010 SP1 install

There are instances where, after installing VWD 2010/SP1 or VS 2010/SP1, Web PI still shows the bundle as being available for install. This is due to issues with the detection logic (discoveryHints in WebPI terms) that need revisions. If you perform an installation of VWD 2010/SP1 or VS 2010/SP1 and everything shows as successfully installed after the process is complete, then there's no additional work on your part. You can safely ignore the option to install the bundle again.

## Troubleshooting problems during the Launch phase

Most common problems during the Web PI Launch phase involve connectivity. Web PI downloads the newest product catalog from a Microsoft website. If this fails, the following error message appears:

:::image type="content" source="media/troubleshooting-problems-with-microsoft-web-platform-installer/error-message-unable-to-download-product-list.png" alt-text="Screenshot that shows the Microsoft Web Platform Installer dialog box displaying an error message.":::

### Unable to download Web Platform error message

- **Behind Proxy**: If the computer is behind a proxy, ensure that the proxy settings for Windows® Internet Explorer® are set correctly and retry accessing the URL through Internet Explorer and then through Web PI.  
- **Behind Firewalls**: When third-party firewalls are installed on the computer, try disabling them before launching Web PI. You can also add exceptions for *WebpiLauncher.exe* and *WebPlatformInstaller.exe* to the firewall settings. If the issue isn't resolved, it should be possible to fix the problem by following the steps described in [How to troubleshoot network connectivity problems in Internet Explorer](https://support.microsoft.com/kb/936211).

If the URL can be accessed in Internet Explorer but not through Web PI, use [Fiddler](http://www.fiddlertool.com/fiddler/ "Fiddler Web Debugger"), a Web debugger that monitors which HTTP requests are made from a computer.

## Troubleshooting problems during the installation phase

Web PI installs components and applications "silently" (without displaying a user interface), and install failures are written to log files. There are many log files because of the large number of supported setup technologies and platforms.

The setup technologies can be categorized as:

- Operating system components
- Products installed with the Windows Installer (MSI) technology
- Web applications using the Microsoft Web Deployment Tool deployment technology

### Operating system components

Operating system components, such as IIS, are installed with Windows setup technologies. The locations for the setup log files are described in the next few sections.

**Windows Vista, Windows 7, Windows Server 2008, and Windows Server 2008 R2**

Operating system components on Windows Vista, Windows 7, Windows Server 2008, and Windows Server 2008 R2 use component-based setup. The log file for operating system components is stored in the *%windir%\logs\cbs* directory. You can open it with the command:

```Console
notepad %windir%\logs\cbs\cbs.log
```

For more information, see [Optional Component Setup Log Diagnoser](https://technet.microsoft.com/library/cc732334.aspx).

IIS 7.0 (Windows Vista and Windows Server 2008) and IIS 7.5 (Windows 7 and Windows Server 2008 R2) setup generates a separate setup log file, located in the `%windir%` directory. You can open this log file with the command:

```Console
notepad %windir%\iis7.log
```

### Products installed using Windows Installer (MSI) technology

You can use the [Windows Installer technology](https://msdn.microsoft.com/library/aa371366(VS.85).aspx) for Web platform components such as Microsoft® SQL Server® and Visual Web Developer 2008 Express Edition. To look at the logs, open Internet Explorer and type the following into the address bar:

```Console
%localappdata%\Microsoft\Web Platform Installer\logs\install
```

Web PI also displays a link to the log file that failed in the summary screen. For more information,  see the [detailed description of Windows Installer error codes](https://msdn.microsoft.com/library/aa372835(VS.85).aspx).

### Products installed using the Microsoft Web Deployment Tool technology

The Web Deployment tool offers a way for Web applications to join the Web PI ecosystem by adding a few manifest files to an existing compressed file (Zip) package. Web PI calls the Web Deployment tool and installs the Web application on an IIS Web site. The Web Deployment Tool technology is used for all Web applications found in the Windows Web App Gallery. Note that the Web Deployment Tool logs all its information into a file named *x86_msdeploy.txt* (32-bit system) or *x64_msdeploy.txt* (64-bit system).

### Known issues

Following are some known issues:

### Web PI cannot install additional IIS components if shared configuration is enabled

If IIS is configured for Shared Configuration, Web PI can't install most additional IIS components. For more information, see [Troubleshooting IIS 7.x Installation Issues](/iis/troubleshoot/installation-issues/troubleshooting-iis-7x-installation-issues).

### Issues during application installation using Web PI

- **Web PI does not automatically create physical directories when an application is installed to a new site**.
 Create the directory manually or use the '...' button next to the Physical path text box to create a new folder.
- **Web PI requires password fields to be filled in and does not allow them to be empty**.
 If an application allows an empty password, the password does not work when the application is installed in Web PI.

### Issues with Microsoft SQL Server during application installation

- **Applications do not work without SQL "Mixed mode authentication."**

    For most Web applications, SQL Server user accounts are required in order to access a database. If only integrated or Windows authentication for SQL Server are selected, you cannot install some of the applications in the gallery.

- **SQL Server passwords are not accepted if they do not meet strength requirements**.

  However, Web PI doesn't validate passwords for strength or other criteria. The failure to create an account with a weak password occurs during application installation, and the installation fails. Use a [strong password](https://msdn.microsoft.com/library/ms161959.aspx) according to the SQL Server policy.

- **SQL Server user names cannot be longer than 16 characters**.

  However, Web PI doesn't validate user fields for length or other criteria. The failure to create an account with a user name that's longer than 16-characters long happens during application installation, and the installation fails. Use a name that's no more than 16-characters long.

- **Other Microsoft SQL Server issues.**
  
  Check the SQL Server log files in the following directory for more information:  

   *%programfiles%\microsoft sql server\100\setup bootstrap\log*

  For information on how to troubleshoot SQL issues, see [View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files).

- **Custom Installation of SQL Server**  

  For customers who want to customize their SQL Server install outside of Web PI, see [SQL Server Express WebLog](https://stackoverflow.com/questions/2196018/web-platform-installer-and-sql-express-database-setup).

### Issues with Visual Web Developer installation

- For more information, see [troubleshooting guide for failures during Visual Web Developer Installations](https://stackoverflow.com/questions/24910301/issues-when-installing-visual-web-developer-2010).

## Additional troubleshooting tools, tips, and tricks

The following information contains some additional useful tips and tricks for solving problems you might encounter when installing parts of the Microsoft Web Platform stack with Web PI.

### Fiddler

Web PI downloads its product catalog and the product packages through HTTP requests. [Fiddler](http://www.fiddler2.com/fiddler2/) is a Web debugger that can help determine if these requests succeed and if the requested resources are still available. Fiddler monitors all HTTP requests that are made from the Windows-based computer that runs Web PI.

### Process Monitor

[Process Monitor](https://technet.microsoft.com/sysinternals/bb896645.aspx) is an advanced monitoring tool for Windows that shows real-time file system, registry, and process or thread activity. In case of Web PI, use Process Monitor to monitor the activity of install programs.

### Windows Event Log

Windows has a central repository for errors, informational messages, and warnings called the Windows Event Log. Though sometimes overlooked, Event Log often provides the solution to many problems and is worth exploring. To open the Windows Event Log, type the following command at a command prompt or in the **Run** menu:

```Console
eventvwr.msc
```

### Web PI Tracing

Web PI has an additional built-in tracing mechanism. It can be activated by saving the following configuration file as *webplatforminstaller.exe.config* in the *%programfiles%\Microsoft\Web Platform Installer* directory.

```xml
<?xml version='1.0' encoding='UTF-8' ?>
<configuration>
  <system.diagnostics>
    <trace autoflush='true' />
    <sources>
      <source name='DownloadManager'>
        <listeners>
          <add name='TextFile'/>
        </listeners>
      </source>
    </sources>
    <sharedListeners>
      <add name="TextFile"
           type="System.Diagnostics.TextWriterTraceListener"
           initializeData="WebPI.log"/>
    </sharedListeners>
    <switches>
      <add name='mySwitch' value='Verbose' />
    </switches>
  </system.diagnostics>
</configuration>
```

The trace file called *WebPI.log* file is also written to the *%programfiles%\Microsoft\Web Platform Installer* directory.

### Cleaning the Web PI Cache

Web PI is caching the product catalog and other files to optimize startup time. If the product catalog seems to be outdated or if incorrect data is displayed in Web PI, delete the cache with:

```Console
del /q "%localappdata%\Microsoft\web platform installer\*"
```

## Additional help

If you have exhausted the troubleshooting tips and tricks in this article and are still having problems, visit the Web Platform Installer forum at <https://forums.iis.net/1155.aspx>.
