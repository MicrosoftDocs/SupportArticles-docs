---
title: Determine the version of MSXML parser
description: This article describes how to determine the version of MSXML parser installed on a computer.
ms.date: 10/20/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: .net
---
# Determine the version of MSXML parser installed on a computer

This article describes how to determine the version of Microsoft Core XML Services (MSXML) parser installed on a computer.

_Original product version:_ &nbsp; Microsoft Core XML Services  
_Original KB number:_ &nbsp; 278674

## Summary

Some recently released MSXML parsers, such as the MSXML 3.0 parser, can be installed in side-by-side mode so that previous versions of the parser are not replaced. The MSXML 3.0 parser can also be run under Replace mode so that previously released products such as Internet Explorer can take advantage of the new features. This flexibility may result in multiple parsers installed on a computer.

In this article, the XMLVersion tool is provided to help developers detect which MSXML parsers are installed on a computer and the mode of the installation (that is, Replace mode or side-by-side mode) of each parser.

## More information

The following files are available for download from the Download Center:  

[Xmlversion.exe](https://download.microsoft.com/download/b/b/e/bbe50ceb-1783-4e53-a489-e17dc5aaefb3/xmlversion.exe) Release Date: June 11, 2003

For more information about how to download Support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help to prevent any unauthorized changes to the file.

[Xmlversiontext.exe](https://download.microsoft.com/download/d/4/4/d4438178-548f-4251-bc9c-0a3bde63681c/xmlversiontext.exe) Release Date: June 11, 2003

For more information about how to download Support files, see [How to Obtain Microsoft Support Files from Online Services](https://support.microsoft.com/help/119591)
Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help to prevent any unauthorized changes to the file.  

[Versions.exe](https://download.microsoft.com/download/c/9/e/c9e4829a-1da7-482a-8292-d47da81eef4e/versions.exe) Release Date: June 11, 2003

For more information about how to download Microsoft Support files, see [How to Obtain Microsoft Support Files from Online Services](https://support.microsoft.com/help/119591).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help to prevent any unauthorized changes to the file.  

There are two versions of this tool. Xmlversion.exe contains a built-in user interface (UI) for the .ocx file; Xmlversiontext.exe does not. Xmlversiontext.exe was created because some computers do not have the minimum requirements for Xmlversion.exe. The minimum requirements for Xmlversion.exe are Internet Explorer 4.01, Microsoft Script Runtime (Scrrun.dll), and Windows Common Controls 1 and 2. The minimum requirement for Xmlversiontext.exe is Internet Explorer 4.01.

The downloads contain the following files:

|XmlVersion File Name|XmlVersionText File Names|Versions File Names|
|---|---|---|
|Xmlversion.htm|Xmlversiontext.htm|Versions.xml|
|Xmlversion.ocx|Xmlversiontext.ocx|
|Versions.xml|Versions.xml|
||||

## Use the tool

1. Extract the file to a folder and register the *Xmlversion.ocx* or *Xmlversiontext.ocx* file. Make sure that you see the message box that confirms that the .ocx registration was successful. To register the *Xmlversion.ocx* file, click **Start**, click **Run**, and then type *regsvr32 <pathofocx>\xmlVersion.ocx* (where `<pathofocx>` is the path to the .ocx file).

   To register the *Xmlversiontext.ocx* file, click **Start**, click **Run**, and then type *regsvr32 <pathofocx>\xmlVersionText.ocx* (where `<pathofocx>` is the path to the .ocx file).

   > [!NOTE]
   > If `<pathofocx>` contains spaces, you must enclose the path and the .ocx file in quotation marks (").

2. In Internet Explorer, open *Xmlversion.htm* or *Xmlversiontext.htm*.

## Description of the XMLVersion tool

> [!NOTE]
> This description applies to Xmlversion.exe only; it does not apply to Xmlversiontext.exe.

- Versions collect information on currently installed MSXML parsers and their installation modes.
- The default MIME version shows the parser that Internet Explorer uses.
- Proxy shows the current proxy server setting, which is useful when you diagnose issues with the `ServerXMLHTTP` object.
- ProgIDs displays all MSXML objects that are registered in the registry, along with their threading models and inprocsvr32 keys.
- Copy Text copies the ProgId to the clipboard for easy programming.
- Search Registry Searches the registry for the key.
- Report generates a *Results.htm* file to summarize the findings.

## Description of the XMLVersionText tool

> [!NOTE]
> This description applies to Xmlversiontext.ocx only; it does not apply to Xmlversion.ocx.

Although the tool displays everything when you first load the XmlVersionText.ocx in the browser, you can click the .ocx file at any time to see those values again.

## Description of the versions file

> [!NOTE]
> This description applies to the Versions.exe file only.

Because Microsoft is producing different versions of MSXML, the list of the versions has been separated in an .xml file. Every effort is made to keep this file updated. You can modify this file yourself, or, when a new file is available, you can download it from this site and replace the XML file in the Ocx directory with the file that you download. Updates to the file are most likely to occur when a new version of MSXML is published.

- In MSXML 2.6 and later, version-dependent ProgIds are introduced for side-by-side installation mode. Developers are encouraged to use these version-dependent ProgIds in MSXML object creation.

- If you reregister the former Msxml.dll or apply a Windows 2000 service pack or an Internet Explorer 5.0 and later service pack, the Msxml.dll file may be registered and the installation may revert to side-by-side mode.

- To get updated information after you change any XML configurations, you must either close the browser and reopen the HTML page, or click Refresh in the browser. This applies to both versions of the tool.

- Although Microsoft has made an effort to make this tool work on all versions of Windows, both .ocx versions will not run on all computers. For example, the tool will not run on computers that do not have XML installed or on computers that are using a version of Internet Explorer that is earlier than version 4.01. The HTML file also includes a list of DLLs that the .ocx file is dependent on.
