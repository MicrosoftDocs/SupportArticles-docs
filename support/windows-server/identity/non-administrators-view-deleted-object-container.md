---
title: Let non-administrators view deleted objects container
description: Explains how to change permissions so that non-administrators can view the Active Directory deleted objects container.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# How to let non-administrators view the Active Directory deleted objects container

This article explains how to change permissions so that non-administrators can view the Active Directory deleted objects container.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 892806

## Summary

When an Active Directory object is deleted, a small part of the object stays in the deleted objects container for a specified time. It stays there so that other domain controllers that are replicating changes will become aware of the deletion. By default, only the System account and members of the Administrators group can view the contents of this container. This article describes how to modify the permissions on the deleted objects container.

You may have to modify the permissions on the deleted objects container if the following conditions are true:

- You have enterprise applications or services that bind to Active Directory with a non-System account or a non-Administrator account.
- These enterprise applications or services poll for directory changes.

## More information

To modify the permissions on the deleted objects container so that non-administrators can view this container, use the DSACLS.exe program. The DSACLS.exe program is included with the Active Directory Application Mode (ADAM) Administration Tools.

For Windows Server 2008 and newer the tool is included in the operating system.

For Windows 2000 and Server 2003 you can get this done by obtaining and installing the ADAM Administration Tools, follow these steps:

1. Download the ADAM retail package.

    For more information about how to download Microsoft Support files, click the following article number to view the article in the Microsoft Knowledge Base:  
    [119591](https://support.microsoft.com/help/119591) How to obtain Microsoft support files from online services
    Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

    > [!NOTE]
    > This version of the ADAM Administration Tools is an upgrade from the version in the Windows Server 2003 Support Tools. This version of the ADAM Administration Tools is supported by Microsoft Windows Server 2003, Standard Edition; Microsoft Windows Server 2003, Enterprise Edition; Microsoft Windows Server 2003, Datacenter Edition; and Microsoft Windows XP Professional.

2. To extract the contents of the file that you downloaded in step 1, double-click the file, and then specify a directory when you are prompted.
3. In the directory that you extracted the file to in step 2, double-click the `Adamsetup.exe` program to start the Active Directory Application Mode Setup Wizard, and then click **Next**.
4. Review and accept the license terms, and then click **Next**.
5. Select **ADAM administration tools only**, and then click **Next**.
6. Review your selections, and then click **Next**.
7. When Setup has concluded, click **Finish**.

After you have installed the ADAM Administration Tools, you can modify the permissions on the deleted objects container. To do this, follow these steps:

1. Log on with a user account that is a member of the **Domain Admins** group.
2. Click **Start**, point to **All Programs**, point to ADAM, and then click
 **ADAM Tools Command Prompt**.
3. At the command prompt, type a command that is similar to the following example: dsacls "CN=Deleted Objects,DC=Contoso,DC=com" /takeownership.

    - When you type this command, use the name of the deleted objects container for your domain.
    - Each domain in the forest will have its own deleted objects container. Output that is similar to the following example should be displayed:

        > Owner: Contoso\Domain Admins  
          Group: NT AUTHORITY\SYSTEM  
            Access list:  
            {This object is protected from inheriting permissions from the parent}  
            Allow BUILTIN\Administrators SPECIAL ACCESS  
             LIST CONTENTS  
             READ PROPERTY  
            Allow NT AUTHORITY\SYSTEM SPECIAL ACCESS  
             DELETE  
             READ PERMISSONS  
             WRITE PERMISSIONS  
             CHANGE OWNERSHIP  
             CREATE CHILD  
             DELETE CHILD  
             LIST CONTENTS  
             WRITE SELF  
             WRITE PROPERTY  
             READ PROPERTY  
            The command completed successfully

4. To grant a security principal permission to view the objects in the deleted objects container, type a command that is similar to the following example: dsacls "CN=Deleted Objects,DC=Contoso,DC=com" /g CONTOSO\EricLang:LCRP

    Output that is similar to the following example should be displayed:

    > Owner: CONTOSO\Domain Admins  
    Group: NT AUTHORITY\SYSTEM  
    Access list:  
    {This object is protected from inheriting permissions from the parent}  
    Allow BUILTIN\Administrators SPECIAL ACCESS  
     LIST CONTENTS  
     READ PROPERTY  
     Allow NT AUTHORITY\SYSTEM SPECIAL ACCESS  
     DELETE  
     READ PERMISSONS  
     WRITE PERMISSIONS  
     CHANGE OWNERSHIP  
     CREATE CHILD  
     DELETE CHILD  
     LIST CONTENTS  
     WRITE SELF  
     WRITE PROPERTY  
     READ PROPERTY  
     Allow CONTOSO\EricLang SPECIAL ACCESS  
     LIST CONTENTS  
     READ PROPERTY  
    The command completed successfully

In this example, the user "CONTOSO\EricLang" has been granted List Contents and Read Property permissions on the deleted objects container in the "CONTOSO" domain. These permissions let this user view the contents of the deleted objects container, but do not let this user make any changes to objects in the container. These permissions are equivalent to the default permissions that are granted to the Administrators group. By default, only the System account has permission to modify objects in the deleted objects container.
