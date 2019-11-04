---
title: Msvbvm50.exe Installs VB 5.0 Run-Time Files
description: Introduces Msvbvm50.exe file.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: ryoung
appliesto:
- Microsoft Office
---

# FILE: Msvbvm50.exe Installs Visual Basic 5.0 Run-Time Files

## Summary

Msvbvm50.exe is a self-extracting file that installs the latest versions of the Microsoft Visual Basic run-time files that all applications created with Visual Basic 5.0 need in order to run. 

## More Information

For additional information about how to download Microsoft Support files, see [How to Obtain Microsoft Support Files from Online Services](https://support.microsoft.com/help/119591/how-to-obtain-microsoft-support-files-from-online-services).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help to prevent any unauthorized changes to the file. 

Msvbvm50.exe installs the following files, which ship with Visual Basic 5.0 Service Pack 2 and Service Pack 3: 

|FILE| VERSION|
|-----------|---------------|
|Msvbvm50.dll |05.00.8244|
|Oleaut32.dll |2.20.4118|
|Olepro32.dll |5.0.4118|
|Stdole2.tlb |2.20.4118|
|Asycfilt.dll |2.20.4118|
|Comcat.dll |4.71|
  
These files are the base dependencies for any component or application created in Visual Basic 5.0.

### Do I Need Msvbvm50.exe?

Msvbvm50.exe is not intended to replace the Setup Wizard for distributing Visual Basic applications. For example, if your application includes components, such as ActiveX controls or DLLs, you should use the Application Setup Wizard or a third party setup package for distribution. However, if your Visual Basic application only depends upon the files included in Msvbvm50.exe, you can distribute your application by providing end users with the executable (.exe) file and Msvbvm50.exe. 

To determine whether your application requires additional files for distribution, you can use the Setup Wizard to create a set of setup files as a test. If the [Files] section of the resulting Setup.lst file only lists your .exe file, end users should be able to run your application after running Msvbvm50.exe to install the core run-time files. However, if the [Files] section contains multiple files, you should consider using the Setup Wizard or a third-party setup package for distribution instead. 

In addition to distributing simple executables, you can also use Msvbvm50.exe for the following: 

- To minimize the size of Internet downloads of Visual Basic applications. By running Msvbvm50.exe ahead of time, your users can download your application from the Web faster.    
- As a troubleshooting step when installation of Visual Basic or a Visual Basic application fails. 

  If Setup fails with an error message that mentions one of the core files, or if registration of a component fails during Setup, the core files on the target computer may be mismatched. If the versions of the files in Msvbvm50.exe are newer than the versions on the target computer, running Msvbvm50.exe before running Setup may resolve the problem.    

## References

For information about the self-extracting file that contains the Visual Basic 6.0 run-time files, see [Service Pack 6 for Visual Basic 6.0: Run-Time Redistribution Pack (vbrun60sp6.exe)](https://www.microsoft.com/download/details.aspx?id=24417).
