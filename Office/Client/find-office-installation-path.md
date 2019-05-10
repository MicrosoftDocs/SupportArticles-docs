---
title: How to find the installation path of an Office application
description: 
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to find the installation path of an Office application

## Summary

This article demonstrates how to use the Windows Installer to find the installation path of Microsoft Office applications.

## More Information

Versions of Microsoft Office greater than 2000 do not include path information in the shortcut links when installed. This is done so that the "Run on First Use" option can be used. When this option is used, the shortcuts will appear, but the applications will not be installed on the hard disk. When you click on the shortcut for the first time, the applications will be installed.

You can use the Windows Installer to get the path of the installed Office 2000 application. Follow the steps given below to create a console application that reports the directory of an installed Office application. 

### Building the Sample

1. Create a blank console application in Visual C++.   
2. Create a new file called main.cpp and paste the following code in the code window. 

   ```c
   #include <windows.h>
   #include <msi.h>
   #include <ostream.h>

   const char *Word = "{CC29E963-7BC2-11D1-A921-00A0C91E2AA2}";
   const char *Excel = "{CC29E96F-7BC2-11D1-A921-00A0C91E2AA2}";
   const char *PowerPoint = "{CC29E94B-7BC2-11D1-A921-00A0C91E2AA2}";
   const char *Access = "{CC29E967-7BC2-11D1-A921-00A0C91E2AA2}";
   const char *Office = "{00000409-78E1-11D2-B60F-006097C998E7}";

   int main(void)
   {
   DWORD size = 300;
   INSTALLSTATE installstate;
   char *sPath;

   sPath = new char[size];
           installstate = MsiLocateComponent(Word,sPath,&size);

   if ((installstate == INSTALLSTATE_LOCAL) || 
            (installstate == INSTALLSTATE_SOURCE)) 
   cout << "Installed in: " << sPath << endl;
   delete sPath;
   return 0;
   }
   ```

3. Click the Project menu and then click Settings to bring up the project settings dialog box.   
4. Click the Link tab and add msi.lib in the list of Object/library modules.   
5. Run the program. It will display the file path where Microsoft Word is installed. 

> [!NOTE]
> Included in the code are the GUIDS associated with Word, Excel, PowerPoint and Access. To find the path for another Office application, pass in the name of the application as the second parameter of the MsiGetComponentPath function. 

To find the path of an Office XP application, replace the constants above with the following. 

```c
const char *Word = "{8E46FEFA-D973-6294-B305-E968CEDFFCB9}";
const char *Excel = "{5572D282-F5E5-11D3-A8E8-0060083FD8D3}";
const char *PowerPoint = "{FC780C4C-F066-40E0-B720-DA0F779B81A9}";
const char *Access = "{CC29E967-7BC2-11D1-A921-00A0C91E2AA3}";
const char *Office = "{20280409-6000-11D3-8CFE-0050048383C9}";
```

To find the path of an Office 2003 application, replace the constants above with the following. 

```c
const char *Word = "{1EBDE4BC-9A51-4630-B541-2561FA45CCC5}";
const char *Excel = "{A2B280D4-20FB-4720-99F7-40C09FBCE10A}";
const char *PowerPoint = "{C86C0B92-63C0-4E35-8605-281275C21F97}";
const char *Access = "{F2D782F8-6B14-4FA4-8FBA-565CDDB9B2A8}";
const char *Office = "{90110409-6000-11D3-8CFE-0150048383C9}";
```

To find the path of a 2007 Office application, replace the constants above with the following. 
```c
const char *Word = "{0638C49D-BB8B-4CD1-B191-051E8F325736}";
const char *Excel = "{0638C49D-BB8B-4CD1-B191-052E8F325736}";
const char *PowerPoint = "{0638C49D-BB8B-4CD1-B191-053E8F325736}";
const char *Access = "{0638C49D-BB8B-4CD1-B191-054E8F325736}";
const char *Office = "{0638C49D-BB8B-4CD1-B191-050E8F325736}";
```

To find the path of a 32-bit Office 2010 application, replace the constants above with the following. 

```c
const char *Word = "{019C826E-445A-4649-A5B0-0BF08FCC4EEE}"; 
const char *Excel = "{538F6C89-2AD5-4006-8154-C6670774E980}";
const char *PowerPoint = "{E72E0D20-0D63-438B-BC71-92AB9F9E8B54}";
const char *Access = "{AE393348-E564-4894-B8C5-EBBC5E72EFC6}";
const char *Office = "{398E906A-826B-48DD-9791-549C649CACE5}";

```
To find the path of a 64-bit Office 2010 application, replace the constants above with the following. 
```c
const char *Word = "{C0AC079D-A84B-4CBD-8DBA-F1BB44146899}"; 
const char *Excel = "{8B1BF0B4-A1CA-4656-AA46-D11C50BC55A4}";
const char *PowerPoint = "{EE8D8E0A-D905-401D-9BC3-0D20156D5E30}";
const char *Access = "{02F5CBEC-E7B5-4FC1-BD72-6043152BD1D4}";
const char *Office = "{E6AC97ED-6651-4C00-A8FE-790DB0485859}";

```