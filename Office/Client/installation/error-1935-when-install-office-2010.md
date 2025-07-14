---
title: Error 1935 when you try to install Microsoft Office
description: Provides steps to fix 1935 setup errors you may see when you install Office 2010 or 2007 suites or stand-alone products.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\SxS\SxSOrPerpetual
  - CSSTroubleshoot
  - CI 105976
appliesto: 
  - Microsoft Office 2016
  - Microsoft Office 2013
  - Microsoft Office Access 2007
  - Microsoft Office Excel 2007
  - Microsoft Office InfoPath 2007
  - Microsoft Office Outlook 2007
  - Microsoft Office PowerPoint 2007
  - Microsoft Office Publisher 2007
  - Microsoft Office Visio Professional 2007
  - Microsoft Office Visio Standard 2007
  - Office Professional Academic 2010
  - Office Home and Business 2010
  - Office Home and Student 2010
  - IIS Media Services 2.0
  - Office Professional 2010
  - Office Professional Plus 2010
  - Office Professional Plus 2010 Home Use Program
  - Office Standard 2010
  - Office Starter 2010
ms.date: 06/06/2024
---

# Error 1935 when you try to install Microsoft Office

If you see "Error 1935. An error occurred during the installation of assembly component" when you install Office 2010 or 2007 or one of the Office stand-alone products like Excel, restart the computer and try to run setup again as a quick first step.

If the error still appears after restarting the computer, try these other methods to fix the problem.

## Delete the APPMODEL registry subkey

Deleting the `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\APPMODEL` subkey should allow you to install Office.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly. These problems could cause you to have to reinstall the operating system or even prevent your computer from starting. Microsoft can't guarantee that these problems can be solved. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur. Modify the registry at your own risk.

1. Select Start, type *`regedit`* and press Enter, then select Registry Editor from the search results.
1. Navigate to the `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\APPMODEL` subkey.
1. Right-click the subkey, and then select **Delete**.
1. Select **Yes** to confirm the deletion.

Restart the device and then try installing Office again. If you still get the error, try the next method.

## Run the System Update Readiness tool

> [!IMPORTANT]
> The System Update Readiness tool can only be used on Windows 7 or Windows Vista operating systems. If you're using a different version of Windows, try one of the other methods in this article.

Select and download the System Update Readiness tool for your version of Windows:

- [Download for the 32-bit version of Windows 7](https://www.microsoft.com/download/details.aspx?id=43524)
- [Download for the 64-bit version of Windows 7](https://www.microsoft.com/download/details.aspx?id=43484)
- [Download for the 32-bit version of Windows Vista](https://go.microsoft.com/fwlink/?linkid=181487)
- [Download for the 64-bit version of Windows Vista](https://go.microsoft.com/fwlink/?linkid=181490)

## Repair or update Microsoft .NET Framework components

First, check installed programs to see if the latest version of .NET Framework is installed:

1. Click **Start**.
2. Type *`appwiz.cpl`*, and then press Enter.
3. Look for Microsoft .NET Framework 4 Client Profile in the list of installed programs.

    :::image type="content" source="media/error-1935-when-install-office-2010/list-of-installed-programs.png" alt-text="Screenshot to look for the Microsoft .NET Framework 4 Client Profile item in the list of installed programs.":::

If you find Microsoft .NET Framework 4 Client Profile, follow these steps to repair it:

1. Close all applications.
2. Click **Start**.
3. Type `appwiz.cpl`, and then press Enter.
4. Click Microsoft .NET Framework 4 Client Profile, and then select Uninstall/Change.

    :::image type="content" source="media/error-1935-when-install-office-2010/uninstall-change.png" alt-text="Screenshot to select Uninstall/Change after selecting the Microsoft .NET Framework 4 Client Profile item.":::
5. Choose the option to Repair .NET Framework 4 Client Profile to its original state, and then select **Next**.

    :::image type="content" source="media/error-1935-when-install-office-2010/client-profile-maintenance.png" alt-text="Screenshot to select the Next option after selecting the Repair .NET Framework 4 Client Profile to its original state option." border="false":::
6. When the repair is complete, select **Finish**, and then select **Restart Now** to restart the computer.

If you can't find Microsoft .NET Framework 4 Client Profile, download and install [Microsoft .NET Framework 4 (Web Installer)](https://www.microsoft.com/download/en/details.aspx?id=17851) to update the computer.

> [!NOTE]
> You can use the [Microsoft .NET Framework Repair Tool](https://support.microsoft.com/topic/microsoft-net-framework-repair-tool-is-available-942a01e3-5b8b-7abb-c166-c34a2f4b612a) to repair Microsoft .NET Framework components. For more information, see [.NET Framework Cleanup Tool User's Guide](/archive/blogs/astebner/net-framework-cleanup-tool-users-guide).

Need More Help?

Get help from the [Microsoft Community](https://answers.microsoft.com/) online community, search for more information on [Microsoft Support](https://support.microsoft.com/) or [Office Help and How To](https://office.microsoft.com/support/), or learn more about [Assisted Support](https://support.microsoft.com/contactus/) options.

## More Information

If error 1935 happens when you install Office 2010 Service Pack 1 (SP1), follow the steps in [Description of Office 2010 update: September 13, 2011](https://support.microsoft.com/help/2553092).

You may experience error 1935 when you install Office 2010 Service Pack 2 (SP2). As Office 2010 includes .NET Programmability Support, this issue may be caused by the interference between Windows Installer (msiexec.exe) and Windows Search (SearchIndexer.exe) or another module in the assembly file copy process. This issue may also occur when you apply other updates, for example, a hotfix for Microsoft .NET Framework components. To work around this issue, use one of the following methods:

- Method 1: Retry installation of Office 2010 SP2
- Method 2: Stop Windows Search Service, and apply Office 2010 SP2

  To stop Windows Search Service, follow these steps:

     1. Click **Start**, type `services.msc` in the Search programs and files text box, and then click services.msc in the search results.

     1. In the list of services, right-click **Windows Search**, and then click **Stop**.

- Method 3: Perform a clean startup, and apply Office 2010 SP2
- Method 4: Install all available updates by using Microsoft Update and apply Office 2010 SP2
