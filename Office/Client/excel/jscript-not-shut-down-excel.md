---
title: Excel doesn't shut down when automating from JScript
description: Excel stays in memory after calling the Quit method until you close Internet Explorer or navigate to another page. This issue occurs when you automate Excel from Microsoft JScript.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
ms.custom: 
  - Extensibility\Scripts
  - CSSTroubleshoot
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: chrisjen
appliesto: 
  - Microsoft Excel
ms.date: 05/26/2025
---

# Excel doesn't shut down after calling the Quit method when automating from JScript

## Symptoms

When automating Microsoft Excel from Microsoft JScript, Excel stays in memory after calling the Quit method until you close Internet Explorer or navigate to another page.

## Cause

JScript is holding on to a reference to Excel. Because there is a reference on Excel when you issue the Quit command, Excel does not shut down. JScript is a garbage collecting language, which means the engine cleans up after itself at a certain point, and not when you set the variables to NULL. When you shut down Internet Explorer or move to another page, the engine is destroyed. This behavior forces garbage collection and frees the reference to Excel.

## Resolution

To work around this problem, you can call the CollectGarbage method. This forces JScript's garbage collection to occur immediately, which releases the reference to Excel. The following code snippet illustrates how to use the CollectGarbage method:

```HTML
<HTML> 
<BODY> 
<INPUT type="button" value="Automate Excel" name=AutomateExcel onclick="StartExcel()"> 
<SCRIPT LANGUAGE=Javascript> 
  var idTmr = "";

function StartExcel() { 
    var oExcel; 

oExcel = new ActiveXObject("Excel.Application"); 
    oExcel.Quit(); 
    oExcel = null;
    idTmr = window.setInterval("Cleanup();",1);
  } 

function Cleanup() {
    window.clearInterval(idTmr);
    CollectGarbage();
  }

</SCRIPT> 
</BODY> 
</HTML> 
```

Notice that the CollectGarbage method isn't called directly after Excel's Quit method. You need to give JScript a small amount of time before calling CollectGarbage. A timer is used in this example to show how to wait briefly before forcing garbage collection.

Another workaround is to use VBScript for Automation of Microsoft Excel. Unlike JScript, VBScript isn't a garbage collecting language. Therefore, references are released when you set the variables to Nothing. Using VBScript, Excel shuts down immediately after calling the Quit method and releasing the variables. For more information, see the [References](#references) section.

> [!NOTE]
> The undocumented CollectGarbage method isn't part of the ECMA-262 specification, and may not be available in future versions of the scripting engine. When you force the garbage collector to run by calling CollectGarbage, this may also negatively impact performance.

## Status

Microsoft has confirmed that this is a bug in the Microsoft products that are listed at the beginning of this article.

## Steps to reproduce

1. Start Notepad and paste the following code in the editor:

   ```HTML
    <HTML> 
    <BODY> 
    <INPUT type="button" value="Automate Excel" name=AutomateExcel onclick="StartExcel()"> 
    <SCRIPT LANGUAGE=Javascript> 
      function StartExcel() { 
        var oExcel; 
    
    oExcel = new ActiveXObject("Excel.Application"); 
        oExcel.Quit(); 
        oExcel = null; 
      } 
    </SCRIPT> 
    </BODY> 
    </HTML> 
   ```

2. Save the file as JScriptTest.HTM, and then exit Notepad.
3. Double-click the JScriptTest.HTM file to load the file in Internet Explorer.
4. Start the Windows Task Manager.
5. Click the Automate Excel button on the Web page in Internet Explorer. Examine the Windows Task Manager, and note that Excel starts and stays in memory.
6. Navigate to another page or exit Internet Explorer. Note that Excel quits and no longer appears in Windows Task Manager.

## References

For more information about a VBScript code sample that demonstrates Automation to Excel, see [How to automate Excel from a client-side VBScript](/previous-versions/office/troubleshoot/office-developer/automate-excel-from-client-side-vbscript).
