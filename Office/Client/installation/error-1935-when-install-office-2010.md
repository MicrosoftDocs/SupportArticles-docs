---
title: Error 1935 when you try to install Microsoft Office 2010 or 2007
description: Provides steps to fix 1935 setup errors you may see when you install Office 2010 or 2007 suites or stand-alone products.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
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
---

# Error 1935 when you try to install Microsoft Office 2010 or 2007

## Resolution

If you see "Error 1935. An error occurred during the installation of assembly component" when you install Office 2010 or 2007 or one of the Office stand-alone products like Excel, restart the computer and try to run setup again as a quick first step.

If the error still appears after restarting the computer, try these other methods to fix the problem: 

### Run the System Update Readiness tool

> [!IMPORTANT]
> The System Update Readiness tool can only be used on Windows 7 or Windows Vista operating systems. If you have Windows XP, try one of the other methods in this article.

Select and download the System Update Readiness tool for your version of Windows:

- [Download for the 32-bit version of Windows 7](https://go.microsoft.com/fwlink/?linkid=181491)    
- [Download for the 64-bit version of Windows 7](https://go.microsoft.com/fwlink/?linkid=181492)    
- [Download for the 32-bit version of Windows Vista](https://go.microsoft.com/fwlink/?linkid=181487)    
- [Download for the 64-bit version of Windows Vista](https://go.microsoft.com/fwlink/?linkid=181490)    

### Repair or update Microsoft .NET Framework components

First, check installed programs to see if the latest version of .NET Framework is installed. To do this, follow these steps: 
 
1. Click Start (or Start > Run in Windows XP).    
2. Type appwiz.cpl, and then press Enter. 
3. Look for Microsoft .NET Framework 4 Client Profile in the list of installed programs. See image. 

    ![Look for Microsoft .NET Framework 4 Client Profile in the list of installed programs](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4021779_en_1)
 
If you find Microsoft .NET Framework 4 Client Profile, follow these steps to repair it: 
 
1. Close all applications.    
2. Click Start (or Start > Run in Windows XP).    
3. Type appwiz.cpl, and then press Enter. 
4. Click Microsoft .NET Framework 4 Client Profile and click Uninstall/Change (or Change/Remove in Windows XP). See image. 

    ![Click Microsoft .NET Framework 4 Client Profile and click Uninstall/Change (or Change/Remove in Windows XP).](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4021780_en_1)
1. Choose the option to Repair .NET Framework 4 Client Profile to its original state, and then click Next. See image. 

    ![Choose the option to Repair .NET Framework 4 Client Profile to its original state, and then click Next.](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4021782_en_1)
1. When the repair is complete, click Finish, and then click Restart Nowto restart the computer.    
 
If you can't find Microsoft .NET Framework 4 Client Profile, download and install it to update the computer. You can download the file from:

[Microsoft .NET Framework 4 (Web Installer)](https://www.microsoft.com/download/en/details.aspx?id=17851)
 
Try to install Microsoft Office again. If error 1935 continues to occur, follow the steps to uninstall and reinstall .NET Framework from the computer.

### Uninstall and reinstall Microsoft .NET Framework components

Uninstall and reinstall Microsoft .NET Framework components IMPORTANT The .NET Framework Setup Cleanup Utility provided here should only be used only after you've tried the previous options.

To uninstall .NET Framework components from the computer follow these steps: 
 
1. Create a temporary folder on your desktop.    
2. Visit the [.NET Framework Cleanup Tool User's Guide](https://blogs.msdn.com/b/astebner/archive/2008/08/28/8904493.aspx) blog and download the [dotnetfx_cleanup_tool.zip](https://mirrors.download3k.com/token/d82bf18323611beff3110e6910e6db1d/dotnetfx_cleanup_tool.zip) file.    
3. When prompted, click Open, and then click Extract Now. Extract the files to the folder you created.    
4. Find cleanup_tool.exe in the folder you created and double-click it.    
5. In the "Do you want to run the .NET Framework Setup Cleanup Utility?" message, click Yes.    
6. Click Yes to accept the license agreement.    
7. In the Product to cleanup window, choose a .NET Framework version that you want to remove.

    > [!NOTE]
    > You can't remove .NET Framework versions that are part of the Windows operating system. If you have Windows 7, you can't remove .NET Framework versions 3.5 or lower. If you have Windows Vista, you can't remove .NET Framework versions 3.0 or lower. If you have Windows XP, you can't remove .NET Framework versions 2.0 or lower.    
8. Click Cleanup Now.    
9. Restart the computer once the .NET Framework component is removed.    
10. Download and install the following components, one at a time, based on your operating system:  
  
    - [.NET Framework 1.1](https://www.microsoft.com/downloads/details.aspx?familyid=262d25e3-f589-4842-8157-034d1e7cf3a3) - For Windows XP only.    
    - [.NET Framework 1.1 SP1](https://www.microsoft.com/downloads/details.aspx?familyid=a8f5654f-088e-40b2-bbdb-a83353618b38) - For Windows XP only.    
    - [.NET Framework 3.5 SP1](https://www.microsoft.com/downloads/details.aspx?familyid=ab99342f-5d1a-413d-8319-81da479ab0d7) - For Windows XP, Windows Vista, and Windows 7.
    - [.NET Framework 4.0](https://www.microsoft.com/download/details.aspx?id=17851) - For Windows XP, Windows Vista, and Windows 7.

11. Restart the computer, and run Windows Update to install updates.    
   
Need More Help?

Get help from the [Microsoft Community](https://answers.microsoft.com/) online community, search for more information on [Microsoft Support](https://support.microsoft.com/) or [Office Help and How To](https://office.microsoft.com/support/), or learn more about [Assisted Support](https://support.microsoft.com/contactus/) options.

## More Information

If error 1935 happens when you install Office 2010 Service Pack 1 (SP1), follow the steps in the [Description of Office 2010 update: September 13, 2011](https://support.microsoft.com/help/2553092) knowledge base article.

For related information about the 1935 error, read [Error 1935 during install of the .NET Framework](https://support.microsoft.com/help/308096).

You may experience error 1935 when you install Office 2010 Service Pack 2 (SP2). As Office 2010 includes .NET Programmability Support, this issue may be caused by the interference between Windows Installer (msiexec.exe) and Windows Search (SearchIndexer.exe) or another module in the assembly file copy process. This issue may also occur when you apply other updates, for example, a hotfix for Microsoft .NET Framework components. To work around this issue, use one of the following steps:

- Method 1: Retry installation of Office 2010 SP2   
- Method 2: Stop Windows Search Service, and apply Office 2010 SP2

  To stop Windows Search Service, follow these steps:

     1. Click Start, type services.msc in the Search programs and filestext box, and then click services.msc in the search results.

     1. In the list of services, right-click Windows Search, and then click Stop.   
   
- Method 3: Perform a clean startup, and apply Office 2010 SP2   
- Method 4: Install all available updates by using Microsoft Update and apply Office 2010 SP2   
