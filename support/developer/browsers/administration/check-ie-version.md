---
title: How to check Internet Explorer version on computers
description: This article provides you the ways to check the Internet Explorer version on a local computer or a remote computer.
ms.date: 03/05/2020
ms.technology: internet-explorer-administration
---
# How to check Internet Explorer version on local and remote computer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article explains the methods you can use to check the Internet Explorer version on local and remote computers.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 556019

## Check settings on local computer

You can use the following methods:

- Connect to Remote Registry Service
- Use a script

The first method is easy but includes many efforts. You can navigate to the following location in the registry after connecting to the remote registry:  
`HKLM\Software\Microsoft\Internet Explorer`

The above registry includes the values in right pane,  which resembles the following:  
svcVersion &nbsp; &nbsp; REG_SZ &nbsp; &nbsp;11.778.18362.0

## Check settings on remote computer

You can use the below script to check the Internet Explorer version on a remote computer:

```dos
@echo off
Srvlist=C:\Temp\Srvlist.txt
Echo Computer Name, Internet Explorer Version >> Result.csv
SET IE_Ver=
For /F "Tokens=*" %%a In (%srvlist%) Do (
Set Comp_name=%%a
Set RegQry="\\%%a\HKLM\Software\Microsoft\Internet Explorer" /v Version
REG.exe Query %RegQry% > CheckCC.txt
Find /i "Version" < CheckCC.txt > StringCheck.txt
FOR /f "Tokens=3" %%b in (CheckCC.txt) DO SET IE_Ver=%%b
Echo %Comp_name, %IE_Ver% >> Result.csv
)
```

The preceding script checks the remote computer for one registry entry, for checking Internet Explorer version, and the results are saved in a CSV format file.

## More information

For more information, see [Which version of Internet Explorer am I using?](https://support.microsoft.com/help/17295) and [Information about Internet Explorer versions](https://support.microsoft.com/help/969393).
