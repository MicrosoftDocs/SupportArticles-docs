---
title: Rename an object after replication collision
description: Describes how to rename an object after a replication collision has occurred.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.subservice: active-directory
---
# How to rename an object after a replication collision has occurred

This article describes how to rename an object after a replication collision has occurred.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 297083

## Summary

When a replication collision occurs, objects that were created on two or more different domain controllers with the same RDN (Relative Distinguished Name) and in the same container may be renamed. For example, the name changes from CN=APPSRV,OU=Domain Controllers,DC=domain,DC=com to the following:  
CN=APPSRVCNF:b9e0025c-f9b0-48f0-ba7b-a77447716911,OU=Domain Controllers,DC=domain,DC=com

Many tools and wizards, including the Active Directory Installation Wizard, may not work correctly because of the length of the new name of the object. Therefore, after the conflicting objects have been manually resolved, it is best to change the name back to the original name.

> [!NOTE]
> If the object that is affected in the collision is a computer or a domain controller, only the RDN that is used to locate the object in Active Directory is changed after the collision. The computer name and the way that the computer is identified on the network are not changed.

## Change the name of the RDN of an object

1. Find the new RDN.

   To get the changed RDN, you can use the LDIFDE utility. This utility can support batch operations that are based on the LDIF (LDAP Data Interchange Format) file format standard. You can export all the information from Active Directory to a file by using this utility.

   For example, if you want to export the following information to a file that is named Bluesky.txt, type the following at a command prompt, and then press ENTER:

   > Computer name: bluesky  
   > Location in Active Directory: OU=Workstations,OU=DELTA,OU=OandM,DC=ad,DC=water,DC=ca,DC=gov  
   > Domain Controller: dc1

   ```console
   ldifde -f c:\bluesky.txt -s dc1 -d  
   "OU=Workstations,OU=DELTA,OU=OandM,DC=ad,DC=water,DC=ca,DC=gov" -r  
   "(&(objectClass=computer)(cn=bluesky*))
   ```

   Running this command exports all information from the Active Directory to the specified file (Bluesky.txt). From the specified text file, you can find the new RDN.

   For more information about LDIFDE utility program, see [Step-by-Step Guide to Bulk Import and Export to Active Directory](/previous-versions/windows/it-pro/windows-2000-server/bb727091(v=technet.10)).

2. Encode the new RDN in base 64.

   The new RDN contains characters that you cannot use in a literal string; therefore, you have to encode the RDN by using Base 64. After the following RDN is encoded in Base 64:

   > CN=APPSRVCNF:b9e0025c-f9b0-48f0-ba7b-a77447716911,OU=Domain Controllers,DC=domain,DC=com

   the result will be the following:

   > Q049QVBQU1JWQ05GOmI5ZTAwMjVjLWY5YjAtNDhmMC1iYTdiLWE3NzQ0NzcxNjkxMSxPVT1Eb21haW4gQ29udHJvbGxlcnMsREM9ZG9tYWluLERDPW

3. Rename the changed RDN. To rename the changed RDN follow these steps:

   1. Create a file with an extension .ldf. When you modify attributes in Active Directory, it is important that the following format be followed:

      > Sample LDIF File to change RDN (changerdn.ldf)  
      \=================  
      #Modify an rdn for ##### APPSRV ########  
      dn::   Q049QVBQU1JWQ05GOmI5ZTAwMjVjLWY5YjAtNDhmMC1iYTdiLWE3NzQ0NzcxNjkxMSxPVT1Eb21haW4gQ29udHJvbGxlcnMsREM9ZG9tYWluLERDPWNvbW==  
      changetype:modrdn  
      newrdn: cn=APPSRV  
      deleteoldrdn: 1

      *dn::* represents the current RDN in base 64. The (::) instructs Ldifde that the following string is Base 64 encoded.

      *newrdn:* represents the new name of the object.

   2. At a command prompt, type `ldifde -i -f c:\changerdn.ldf -s your server name`.

      Running this command changes the RDN, using the LDIFDE utility, to the new RDN that is specified by you in the LDIF file (Changerdn.ldf).

      When you run this command, you may receive an output that is similar to the following:

      > Connecting to "appsrv.domain.com"  
      Logging in as current user using SSPI  
      Importing directory from file "changedc.ldf"  
      Loading entries  
      1:   CN=APPSRVCNF:b9e0025c-f9b0-48f0-ba7b-a77447716911,OU=Domain Controllers,DC=domain,DC=com  
      Entry DN:   CN=APPSRVCNF:b9e0025c-f9b0-48f0-ba7b-a77447716911,OU=Domain Controllers,DC=domain,DC=com
      change: dn  
      Renaming to cn=APPSRV with deleteold of 1  
      Entry modified successfully.  
      1 entry modified successfully.  
      The command has completed successfully.

      This process can change the name back to Appsrv. This change is relational so all references to this object are changed in the Active Directory.

When you correct the name on the domain controllers' objects, ensure that you change the name back to what it had been originally. This change does not rename the domain controller. If you rename a domain controller, it is not supported in Windows 2000.
