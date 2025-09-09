---
title: Cannot locate the Internet or proxy server when selecting hyperlink in Office
description: Describes issues when you select hyperlinks in Office. Provides solutions.
author: Cloud-Writer
ms.date: 06/06/2024
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open\Links
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Word 2013
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - PowerPoint for Microsoft 365
  - PowerPoint 2019
  - PowerPoint 2016
  - PowerPoint 2013
  - Excel for Microsoft 365
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Microsoft Word 2010
  - Microsoft Outlook 2010
  - Excel 2010
  - PowerPoint 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Outlook 2007
  - Microsoft Office PowerPoint 2007
---

# Error message when selecting hyperlink in Office: "Cannot locate the Internet server or proxy server"

## Symptoms

When you create a hyperlink in an Office document and then select the link, you may receive one of these error messages:

**Unable to open \<URL>. Cannot locate the Internet server or proxy server.** 

**Unable to open \<URL>. Cannot open the specified file.**

**\<URL> = the hyperlink you inserted.**

> [!NOTE]
> The hyperlink does work if you type it directly in the browser, or in the Open box of the Run dialog box (select **Start**, and then select **Run**).

## Cause

This problem occurs when the following conditions are true:

- You are using Microsoft Internet Explorer:

  - As a proxy server -or-
  - With a firewall that doesn't allow HTTP requests to be placed on your local network

- Internet Explorer isn't your default browser.

- The **ForceShellExecute** registry key isn't present in the following location, or isn't set to **1**:

    - For 32-bit versions of office installed on 64-bit operating systems:
    
      `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\9.0\Common\Internet`
    
    - For 32-bit versions of Office installed on 32-bit operating systems, or 64-bit versions of Office installed on 64-bit operating systems:
    
      `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\9.0\Common\Internet` 
      
    > [!NOTE]
    > The registry path doesn't depend on your Office version.
         
## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, select the following article number to view the article in the Microsoft Knowledge Base:

[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

### Add the Internet Subkey to the registry and set the Value data

To work around this issue, either add the ForceShellExecute subkey, if it is not present, and set the Value data, or if it is present, set the Value data of the ForceShellExecute subkey.

1. Quit any programs that are running.   
2. Select **Start**, and then select **Run**. Type **regedit** in the **Open** box, and then select **OK**.   
3. In Registry Editor, browse to one of the following subkeys (create the keys if they do not exist):

    - For a 32-bit version of Office on a 64-bit version of Windows:
    
      `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\9.0\Common\Internet`
    
    - For a 32-bit version of Office on a 32-bit version of Windows:
    
      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\9.0\Common\Internet`
    
    - For a 64-bit version of Office on a 64-bit version of Windows:
    
      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\9.0\Common\Internet`      
    
4. Make sure the Internet subkey is selected. On the **Edit** menu, point to **New**, and then select **DWORD** Value. Add the following registry value:

    **Value Name: ForceShellExecute**

5. Double-click **ForceShellExecute**, and then set the Value data to **1**. Select **OK**.   
6. On the Registry menu, select Exit.   

### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, [contact support](https://support.microsoft.com/contactus/).

## More Information

A hyperlink may not go to a Microsoft Word document or a Microsoft Excel worksheet after you use this workaround. 

Office uses the Urlmon.dll file to handle all Internet transitions.

In this case, the Urlmon.dll file sends a request to get a file via `http://` through the proxy server. The proxy server sees that the request came from Internet Explorer, based upon the HTTP User Agent field of the `http://request`. It then gives an error 403, basically saying "Access Denied." 

The Urlmon.dll file gets this and simply returns the error message mentioned earlier. The error means that the request failed, but it never states why it failed.

The workaround is to use a ShellExecute() on the URL. This allows the operating system to start the URL on the default browser. If the default browser isn't restricted by the proxy server, the proper page is displayed.
