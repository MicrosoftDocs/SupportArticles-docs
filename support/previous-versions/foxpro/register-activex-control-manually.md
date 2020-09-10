---
title: Register an ActiveX control manually
description: This article describes how to manually register an ActiveX control with the Regsvr32 command.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: Visual FoxPro
---
# Register an ActiveX control (.ocx) manually

This article introduces how to manually register an ActiveX control with the Regsvr32 command.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 146219

## Summary

When you distribute a Microsoft Visual FoxPro application that uses an ActiveX control (.ocx file), the .ocx file must be registered correctly for it to work correctly. The Visual FoxPro Setup Wizard or InstallShield Express in Visual FoxPro 7.0 or a later version of Visual FoxPro will register an .ocx file correctly, provided that you select the **OLE** check box in Step 6 for the .ocx file. If a Visual FoxPro application that uses an .ocx file is distributed by some other method, the .ocx file must be registered manually. This article describes how to register an .ocx file manually.

## More information

You can use the Microsoft Register Server (Regsvr32.exe) to register a 32- bit .ocx file manually on a 32-bit operating system. In Visual FoxPro 3.0 and 3.0b, Regsvr32.exe is located in the \Vfp\Samples\Ole directory, and in Visual FoxPro 5.0, Regsvr32.exe is located in the \Vfp directory. In Visual FoxPro 6.0, Regsvr32.exe is found in the Distrib.src directory of the Visual FoxPro directory. It may be distributed with a Visual FoxPro application. The syntax for using Regsvr32.exe is as follows:

```console
 Regsvr32 [/u] [/s] <OCX File Name>
```  

> [!NOTE]
> /u means Unregister the .ocx file.
/s means Silent Mode (display no messages).

The following example registers the Microsoft MAPI ActiveX Control without displaying any messages:

```console
Regsvr32 /s MSMAPI32.OCX
```

To implement this example in a Visual FoxPro application, use the RUN command as follows:

```console
RUN /N Regsvr32 /s MSMAPI32.OCX
```

> [!NOTE]
> If an error occurs when registering a control, do the following:

1. Verify in the Registry that the control has not been registered before.

2. Verify that the following files are in the Windows\System directory:

    ```console
    mfc30.dll olepro32.dll msvcrt20.dll
    mfc40.dll msvcrt40.dll
    ```

    If one of these files is missing, you may receive the following error message:
    > Error: OLE Error Code 0x80040112: Appropriate license for this class not found.
