---
title: Let non-administrators view deleted objects container
description: Explains how to change permissions so that non-administrators can view the Active Directory deleted objects container.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\user,computer,group,and object management
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# How to let non-administrators view the Active Directory deleted objects container

This article explains how to change permissions so that non-administrators can view the Active Directory deleted objects container.

_Original KB number:_ &nbsp; 892806

## Summary

When an Active Directory object is deleted, by default the object is moved to the deleted objects container. You can undelete or reactivate it from there when AD Recycle is enabled. It is there for a specified time (tombstonelifetime, plus msds-deletedobjectlifetime when AD recycle bin is enabled). The purpose it that other domain controllers that are replicating changes will become aware of the deletion.

By default, only the System account and members of the Administrators group can view the contents of this container. This article describes how to modify the permissions on the deleted objects container. Administrators can see it for example when they ask LDAP to return deleted objects.

You may have to modify the permissions on the deleted objects container if the following conditions are true:

- You have enterprise applications or services that bind to Active Directory with a non-System account or a non-Administrator account.
- These enterprise applications or services poll for directory changes.

## More information

To modify the permissions on the deleted objects container so that non-administrators can view this container, use the DSACLS.exe program. Follow these steps:

1. Log on with a user account that is a member of the **Domain Admins** group.
2. Click **Start**, type **Command Prompt**, and open it in elevated mode when you run this task in an interactive session on a Domain Controller.
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
**     Allow CONTOSO\EricLang SPECIAL ACCESS  
     LIST CONTENTS  
     READ PROPERTY  **
    The command completed successfully

In this example, the user "CONTOSO\EricLang" has been granted List Contents and Read Property permissions on the deleted objects container in the "CONTOSO" domain. These permissions let this user view the contents of the deleted objects container, but do not let this user make any changes to objects in the container. These permissions are equivalent to the default permissions that are granted to the Administrators group. By default, only the System account has permission to modify objects in the deleted objects container.

## References
[Enable and use Active Directory Recycle Bin]([url](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/adac/active-directory-recycle-bin?tabs=adac))
[Restore-ADObject]([url](https://learn.microsoft.com/en-us/powershell/module/activedirectory/restore-adobject?view=windowsserver2025-ps))
[Deleted Object Lifetime]([url](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-adts/1887de08-2a9e-4694-95e2-898cde411180))#
[Show deleted objects LDAP Control]([url](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/ldap/ldap-server-show-deleted-oid))
