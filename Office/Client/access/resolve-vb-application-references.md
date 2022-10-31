---
title: Resolve Visual Basic for Applications references
description: Describes steps that Access takes to resolve the references in Visual Basic for Applications (VBA). Also discusses the BrokenReference property that you can use to check broken references.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# How Access resolves Visual Basic for Applications references

_Original KB number:_ &nbsp; 824255

> [!NOTE]
> This article applies to a Microsoft Access database (.mdb) and to a Microsoft Access project (.adp). Requires expert coding, interoperability, and multiuser skills.

## Summary

This article discusses the sequence of tasks that Microsoft Office Access 2007, Microsoft Office Access 2003, Microsoft Access 2002, Access 2000, or Access 97 performs to resolve the references in Microsoft Visual Basic for Applications (VBA).

## More Information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

In Access, you can view the VBA references that are currently selected by using the Visual Basic Editor. To do this, follow these steps:

1. Start Access.
2. Open an Access database.
3. Press ALT+F11 to open the Visual Basic Editor.
4. In the Visual Basic Editor window, click **References** on the **Tools** menu.

   In the **References** dialog box, you can see the references that are selected.
   
> [!NOTE]
> When you select a reference, you can also view the information that corresponds to the file that must be loaded to use the reference.

The pertinent file may be a type library, an object library, or a control library. The pertinent file for each reference is loaded according to the information that appears in the **References** dialog box. However, if the file is not found, Access searches for the file in different locations on your computer.

For each VBA reference that is selected, Access performs the following tasks:

- Access verifies whether the referenced file is already loaded.
- Access verifies whether the `RefLibPaths` registry key exists if the referenced file is currently not loaded.

  If the `RefLibPaths` registry key exists, Access searches for a named value that has the same name as the reference. If there is a match, Access loads the reference from the path that is mentioned in the named value.

  > [!NOTE]
  > You can manually add the `RefLibPaths` registry key to the registry and, then you can add the names and the locations of any add-ins or of any libraries that are under the `RefLibPaths` registry key. To do this, follow these steps:

  1. Click**Start**, and then click **Run**.
  2. In the **Open** box, type regedit, and then click **OK**.
  3. In the Registry Editor window, locate the following registry key:
    
     Access 2007:
     `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\12.0\Access`

     Access 2003:
     `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\11.0\Access`

     Access 2002:
     `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\10.0\Access`

     Access 2000:
     `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\9.0\Access`

     Access 97:
     `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\8.0\Access`

  4. Right-click the **Access** registry key, point to **New**, and then click **Key**.
  5. Name the newly created key `RefLibPaths`.
  6. Click **RefLibPaths**.
  7. Right-click anywhere in the right pane, and then click **String value**.
  8. Name the newly created String value by using the same name as the VBA reference.
  9. Right-click the String value that you created in step 8, and then click **Modify**.
  10. In the **Edit String** dialog box, type the location of the file that must be loaded to correspond to the reference in VBA.

      The registry value name must be the file name plus the extension. The location (value data) must be the path plus the file name. For example, if you set a reference to the Northwind sample database, you can add the following values:

      - Value Name: Northwind.mdb
      - Value Data: `C:\Program Files\Microsoft Office\Office11\Samples\Northwind.mdb`

  11. Repeat step 7 through step 10 to add the names and to add the locations of the appropriate add-ins or of the appropriate libraries as String values.
  12. On the **File** menu, click **Exit**.

- Access uses theSearchPathAPI to search for the referenced file if the **RefLibPaths** registry key does not exist or does not contain a correct reference. The following searches are performed.

  |Search Area|Description|
  |---|---|
  |Application Directory|Location of Msaccess.exe.|
  |Current Directory|Directory that you see if you click **Open** on the **File** menu.|
  |System Directory|The System folder and the System32 folder that are located in the Windows folder or in the WINNT folder.|
  |WinDir|The folder where the operating system files run. This is typically the Windows folder or the WINNT folder.|
  |PATH Environment Variable|This system variable contains a list of folders that are directly accessible by the system. Microsoft Windows NT 4.0: In Control Panel, double-click **System**, and then click the **Environment** tab. The PATH variable is in the **System Variables** list. Microsoft Windows 2000, Microsoft Windows XP, and Microsoft Windows Server 2003: In Control Panel, double-click **System**, click the **Advanced** tab, and then click **Environment Variables**. The PATH is in the **System Variables** list. Microsoft Windows Vista: In Control Panel, open the "System and Maintenance" item. Click **System**, click **Advanced system settings**, click the **Advanced** tab, and then click **Environment Variables**. The PATH is in the **System Variables** list|
  |File Directory|The folder that contains the .mdb file, the .mde file, the .adp file, or the .ade file, and any subfolders.|

> [!NOTE]
> Access does not require the `RefLibPaths` registry key if the file that you want to reference is located in any of the directories that are mentioned in the table.

If Access cannot find the reference, you receive the following error message when you compile the project or when you try to run a procedure:

> Your Microsoft Office Access database or project contains a missing or broken reference to the file **file name**.<br/>
> *To ensure that your database or project works properly, you must fix this reference.

> [!NOTE]
> While the database is open, you receive the previous error message one time for each broken reference.

For example, if you open MyDatabase.mdb and MyDatabase.mdb is missing a reference to the Microsoft Calendar Control and to the Microsoft DAO library, you receive two error messages, one for each missing reference. You do not receive the error messages again unless you do not fix the references, you close the database, and then you reopen the database. If you fix the references and then you save the database, you do not receive the error messages the next time that you open the database.

### The BrokenReference property

The Application object for Access has a `BrokenReference` property that tells you if any references are broken. To check the `BrokenReference` property, follow these steps:

1. Start Access.
2. Open an Access database.
3. Press ALT+F11 to open the Visual Basic Editor.
4. Press CTRL+G to open the Immediate window.
5. In the Immediate window, type the following command, and then press ENTER:
   
   `?Application.BrokenReference`

   Notice that the `BrokenReference` property for the Application object returns **True** if there are missing references. Otherwise, the `BrokenReference` property returns **False**.

## References

For more information about references, click **Microsoft Visual Basic Help** on the **Help** menu, type *References Collection* in the **Search for** box in the Assistance pane, and then click **Start searching** to view the topic.

For more information about missing references, click the following article number to view the article in the Microsoft Knowledge Base:

[283806](https://support.microsoft.com/help/283806) Visual Basic for Applications (VBA) functions break in a database with missing references