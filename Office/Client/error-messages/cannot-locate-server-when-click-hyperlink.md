---
title: Cannot locate the Internet or proxy server when selecting hyperlink in Office
description: Describes issues when you select hyperlinks in Office. Provides solutions.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Word for Office 365
- Word 2019
- Word 2016
- Word 2013
- Outlook for Office 365
- Outlook 2019
- Outlook 2016
- Outlook 2013
- PowerPoint for Office 365
- PowerPoint 2019
- PowerPoint 2016
- PowerPoint 2013
- Excel for Office 365
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

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you create a hyperlink in an Office document and then select the link, you may receive one of these error messages:

**Unable to open \<URL>. Cannot locate the Internet server or proxy server.** 

**Unable to open \<URL>. Cannot open the specified file.**

**\<URL> = the hyperlink you inserted.**

> [!NOTE]
> The hyperlink does work if you type it directly in the browser or in the Open box of the Run dialog box (select Start, and then select Run).

## Cause

This problem occurs when the following conditions are true:

- You are using Microsoft Internet Explorer:

  - A proxy server -or-
  - A firewall that does not allow HTTP requests to be placed on your local network

- Internet Explorer is not your default browser.

- The ForceShellExecuteregistry key is not present in the following location or is not set to 1:

    For 32-bit Office Versions installed on 64-bit OperatingSystems
    
    HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\9.0\Common\Internet
    
    For 32 Bit Office Versions installed on 32 bit Operating Systems or 64 Bit Office Versions installed on 64-bit Operating Systems
    
    HKEY_LOCAL_MACHINE \Software\Microsoft\Office\9.0\Common\Internet   

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, select the following article number to view the article in the Microsoft Knowledge Base:

[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To have us work around this problem for you, go to the "Here's an easy fix" section. If you prefer to fix this problem manually, go to the "Let me fix it myself" section.

### Here's an easy fix 

To fix this problem automatically, select the **[Download](https://download.microsoft.com/download/2/7/4/2746551A-B7FF-4DF9-9EF0-1D81FC7DF272/MicrosoftEasyFix50655.msi)** button. In the **File Download** dialog box, select **Run** or **Open**, and then follow the steps in the easy fix wizard.

- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.   
- If you're not on the computer that has the problem, save the easy fix solution to a flash drive or a CD, and then run it on the computer that has the problem.   

### Let me fix it myself

To work around this issue, either add the ForceShellExecute subkey, if it is not present, and set the Value data, or if it is present, set the Value data of the ForceShellExecute subkey.

### Adding the Internet Subkey to the Registry and Setting the Value Data

1. Quit any programs that are running.   
2. select Start, and then select Run. Type regedit in the Open box, and then select OK.   
3. In Registry Editor, browse to one of the following subkeys (create the keys when they do not exist):

    For a 32-Bit version of Office on 64-bit version of Windows
    
    HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\9.0\Common\Internet\
    
    For a 32-Bit version of Office on 32-bit version of Windows
    
    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\9.0\Common\Internet
    
    For a 64-Bit version of Office on 64-bit version of Windows
    
    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\9.0\Common\Internet

4. Make sure the Internet subkey is selected. On the Edit menu, point to New, and then select DWORD Value. Add the following registry value:

    Value Name: ForceShellExecute

5. Double-click ForceShellExecute, and then set the Value data to 1. Select OK.   
6. On the Registry menu, select Exit.   

### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus/).

## More Information

A hyperlink may not go to a Microsoft Word document or a Microsoft Excel worksheet after you use this workaround. 

Office uses the Urlmon.dll file to handle all Internet transitions.

In this case, the Urlmon.dll file sends a request to get a file via http:// through the proxy server. The proxy server sees that the request came from Internet Explorer, based upon the HTTP User Agent field of the http://request. It then gives an error 403, basically saying "Access Denied." 

The Urlmon.dll file gets this and simply returns the error message mentioned earlier. The error means that the request failed, but it never states why it failed.

The workaround is to use a ShellExecute() on the URL. This allows the operating system to start the URL on the default browser. If the default browser is not restricted by the proxy server, the proper page is displayed.