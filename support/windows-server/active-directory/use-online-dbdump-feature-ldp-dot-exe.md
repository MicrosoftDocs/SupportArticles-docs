---
title: Use the online dbdump feature in Ldp.exe
description: Describes how to use the online dbdump feature of Active Directory.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ROLANDW, oweindl
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# How to use the online dbdump feature of Active Directory

This article describes how to use the online dbdump feature of Active Directory.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 315098

## Summary

You can use the online dbdump feature in Ldp.exe to view the values that are stored in the database while a domain controller is running. You trigger the online dbdump feature by modifying the dumpDatabase attribute on the rootDSA.

The values that you specify for this attribute are the attributes other than the default attributes that you want to dump. The values that you specify are the name for this attribute. The dumpDatabase feature first checks that you have enough rights for dumping the database. It then dumps the database into the Ntds.dmp file. The Ntds.dmp file is located in the same folder as the database file (.dit). The default attributes are:

- DNT
- PDNT
- OBJ
- RDNTyp
- CNT
- ABCNT
- DelTime
- NCDNT
- ABVis

## Usage example: Investigate an SPN issue with conflicting CNF or deleted DEL attributes

To create the Ntds.dmp file, follow these steps:

1. Start Ldp.exe on the domain controller that is logging the NTDS event 1645.
2. Connect locally, and then bind as an Enterprise administrator.
3. Click **Modify** on the **Browse** menu.
4. Edit for **Attribute**: dumpdatabase.
5. Edit for **Values**: name ncname objectclass objectguid instancetype. You must leave one space between the attributes.
6. Click **Enter**. The **Entry List** box contains the following entry:  
    [Add]dumpdatabase: name ncname objectclass objectguid instancetype

7. Click the **Extended and Run** options.
8. The %systemroot%\NTDS\Ntds.dmp file is created, or you receive an error message in Ldp.exe that you must investigate.

You can also get this triggered by using an LDIFDE import file dump-db.txt like:

> Dn:  
Changetype: modify  
Add: dumpdatabase  
Dumpdatabase: name ncname objectclass objectguid instancetype  
\-

To import the file with LDIFDE, use a command line like `ldifde /s \<targetserver> /i /f dump-db.txt`.

## Use the output

The Ntds.dmp file is a text file. Look for the conflicting or deleted GUID that was reported in event 1645 to see the internal reference mismatch.

## Sample Dump File

The following sample shows that the CROSSREF object for domain PDT is pointing to a wrong object that has already been deleted:

> 3953 2326 true 3 1 0 - 1163 - 4  
3947 196619 56.6E.52.8A.2E.B4.00.43.BE.B1.B3.57.91.AD.F5.BE PDT  
...  
3947 1161 false 1376281 2 0 2001-08-04 11:02.47 - -  
\- - - 9E.4C.AB.36.81.65.2B.4F.A0.31.59.D5.C2.74.68.F2 pdt  
DEL:36ab4c9e-6581-4f2b-a031-59d5c27468f2  
...  
3958 1161 false 1376281 3 0 2001-08-04 23:02.47 - -  
\- - - 85.0B.3B.A1.EC.68.37.46.9E.D0.FF.F6.66.BA.FB.84 pdt

The internal reference points to 3947, although it should point to the new 3958 object for dc=pdt,dc=net.

You may resolve this issue with the semantic checker of the latest version of the Ntdsutil.exe tool.
