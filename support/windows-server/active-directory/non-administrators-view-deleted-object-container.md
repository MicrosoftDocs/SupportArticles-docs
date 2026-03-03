---
title: Let nonadministrators view deleted objects
description: Explains how to change permissions so that nonadministrators can view the contents of the Active Directory deleted objects container.
ms.date: 03/02/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-appelgatet
ms.custom:
- sap:active directory\user, computer, group, and object management
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Let nonadministrators view the contents of the Active Directory deleted objects container

This article explains how to change permissions so that nonadministrators can view the Active Directory deleted objects container.

_Original KB number:_ &nbsp; 892806

## Summary

Active Directory Domain Services (AD DS) temporarily stores deleted objects in a hidden "Deleted Objects" container. By default, only the System account and members of the Administrators group can view the contents of this container. For example, Administrators can view the contents of the deleted objects container by using the `LDAP_SERVER_SHOW_DELETED_OID` LDAP command or the Windows PowerShell `Get-ADObject` command. If the [AD Recycle Bin feature](/windows-server/identity/ad-ds/get-started/adac/active-directory-recycle-bin) is enabled, the users who have this access can restore the deleted objects.

This article discusses how to modify the permissions on the deleted objects container. You might have to modify the permissions on the deleted objects container under the following conditions:

- You have enterprise applications or services that use non-System accounts or non-Administrator accounts to bind to Active Directory.
- These enterprise applications or services poll for directory changes.

## More information

When you delete an AD DS object, Active Directory moves the object to the deleted objects container. The object remains in the container for a specified period (`tombstonelifetime` if AD Recycle bin isn't enabled;`tombstonelifetime` plus `msds-deletedobjectlifetime` if AD Recycle Bin is enabled). This action allows time for the deletion to replicate to other domain controllers (DCs). It's possible to [undelete](/openspecs/windows_protocols/ms-adts/4302a2eb-55c8-426c-b310-6791c6ae8307) a deleted object when AD Recycle Bin is enabled, but the object loses some attribute values.

If the AD Recycle Bin feature is enabled, an Administrator-level or System-level account can access the object in the deleted objects container, and then undelete or fully restore it.

For example, a member of the Administrators group can use the following Windows PowerShell command to view the contents of the deleted objects container:

```powershell
Get-ADObject -Filter {Deleted -eq $True} -IncludeDeletedObjects
```

This command lists the objects that are currently in the container:

```output
Deleted           : True
DistinguishedName : CN=Deleted Objects,DC=contoso,DC=com
Name              : Deleted Objects
ObjectClass       : container
ObjectGUID        : 280e5943-08cf-498d-b3f1-19a812d07efd

Deleted           : True
DistinguishedName : DC=..Deleted-_msdcs.contoso.com\0ADEL:f6eb3fb7-597a-458b-8b74-2a46066be220,CN=Deleted
                    Objects,DC=contoso,DC=com
Name              : ..Deleted-_msdcs.contoso.com
                    DEL:f6eb3fb7-597a-458b-8b74-2a46066be220
ObjectClass       : dnsZone
ObjectGUID        : f6eb3fb7-597a-458b-8b74-2a46066be220

Deleted           : True
DistinguishedName : DC=@\0ADEL:8daacf6e-12ab-4f5d-b95c-ec834d490580,CN=Deleted Objects,DC=contoso,DC=com
Name              : @
                    DEL:8daacf6e-12ab-4f5d-b95c-ec834d490580
ObjectClass       : dnsNode
ObjectGUID        : 8daacf6e-12ab-4f5d-b95c-ec834d490580
```

### Grant permissions to the deleted objects container

> [!IMPORTANT]  
> Before you follow these steps, make sure that you enable the AD Recycle Bin feature. For more information, see [Enable and use Active Directory Recycle Bin](/windows-server/identity/ad-ds/get-started/adac/active-directory-recycle-bin).

To modify the permissions on the deleted objects container so that nonadministrators can view this information, use the [DSACLS.exe](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771151(v=ws.11)) tool. Follow these steps:

1. Sign in to a DC by using a user account that is a member of the **Domain Admins** group.
1. Open an administrative Command Prompt window, and then run a command that resembles the following example:

   ```console
   dsacls "CN=Deleted Objects,DC=contoso,DC=com" /takeownership
   ```

   > [!NOTE]  
   > In this command, `CN=Deleted Objects,DC=Contoso,DC=com` is the fully qualified domain name (FQDN) of the deleted objects container for the contoso.com domain. Each domain in the forest has its own deleted objects container.

   This command generates output that resembles the following example:

   ```output
   Owner: Contoso\Domain Admins  
   Group: NT AUTHORITY\SYSTEM  
   Access list:  
   {This object is protected from inheriting permissions from the parent}  
   Allow BUILTIN\Administrators SPECIAL ACCESS  
      LIST CONTENTS  
      READ PROPERTY  
   Allow NT AUTHORITY\SYSTEM SPECIAL ACCESS  
      DELETE  
      READ PERMISSIONS  
      WRITE PERMISSIONS  
      CHANGE OWNERSHIP  
      CREATE CHILD  
      DELETE CHILD  
      LIST CONTENTS  
      WRITE SELF  
      WRITE PROPERTY  
      READ PROPERTY  
   The command completed successfully
   ```

1. To grant a security principal permission to view the objects in the deleted objects container, run a command that resembles the following command:

   ```console
   dsacls "CN=Deleted Objects,DC=Contoso,DC=com" /g CONTOSO\EricLang:LCRP
   ```

   > [!NOTE]  
   > In this command, `CONTOSO\EricLang` represents the security principal to which you want to grant access, and `LCRP` represents the permissions that you want to grant (List Children and Read Property).

   This command generates output that resembles the following example:

   ```output
   Owner: CONTOSO\Domain Admins  
   Group: NT AUTHORITY\SYSTEM  
   Access list:  
   {This object is protected from inheriting permissions from the parent}  
   Allow BUILTIN\Administrators SPECIAL ACCESS  
      LIST CONTENTS  
      READ PROPERTY  
   Allow NT AUTHORITY\SYSTEM SPECIAL ACCESS  
      DELETE  
      READ PERMISSIONS  
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
   ```

In this example, the user ("CONTOSO\EricLang") can view the contents of the deleted objects container, but can't make any changes to objects in the container. These permissions are equivalent to the default permissions that are granted to the Administrators group.

## References

- [Enable and use Active Directory Recycle Bin](/windows-server/identity/ad-ds/get-started/adac/active-directory-recycle-bin)
- [Get-ADObject](/powershell/module/activedirectory/get-adobject)
- [Restore-ADObject](/powershell/module/activedirectory/restore-adobject)
- [Undelete Operation](/openspecs/windows_protocols/ms-adts/4302a2eb-55c8-426c-b310-6791c6ae8307)
- [Tombstone Lifetime and Deleted-Object Lifetime](/openspecs/windows_protocols/ms-adts/1887de08-2a9e-4694-95e2-898cde411180)
- [LDAP_SERVER_SHOW_DELETED_OID control code](/previous-versions/windows/desktop/ldap/ldap-server-show-deleted-oid)
- [Dsacls](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771151(v=ws.11))
