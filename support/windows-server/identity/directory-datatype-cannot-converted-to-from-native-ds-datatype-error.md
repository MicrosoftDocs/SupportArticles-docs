---
title: The directory datatype cannot be converted to or from a native DS datatype error
description: Describes a problem that occurs when Active Directory applications use information for linked attributes. Provides a resolution.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# "The directory datatype cannot be converted to or from a native DS datatype" error

This article helps to fix the error "The directory datatype cannot be converted to or from a native DS datatype".

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 907462

## Symptoms

You are running or managing applications that use information from the Active Directory directory service in Windows. You may receive errors when the applications use information for linked attributes. For example, you may receive the following error:  
>The directory datatype cannot be converted to / from a native DS datatype.  

In this case, when you export the affected object by using the LDIFDE utility (Ldifde.exe), an attribute is listed. However, the attribute has no value.

This may be the expected behavior when the value is long. But the next line in the output has the next attribute. For a group and its managedBy attribute, the output may resemble the following:  
...  
showInAddressBook: \<Address Book object DN>  
managedBy:  
legacyExchangeDN: \<X500 name>  
groupType: -2147483640  
...

In a database dump with the RootDSE command verb **dumpdatabase**, the affected groups will be shown as follows:  

>38661 29827 1 1790 true - - 4 3 Group-DN Group-DN - 655368 6d03f309-ded2-41d5-9794-081d40343876 4  
objectclass: 655368, 65536  
DNT Base BDNT DelTime DeactiveTime USNChanged NCDNT Data  
38661 1 38662 - - 55247898 1790 -   
38661 36 2 - - - - -

The link attribute ID is always 36, and the link partner is always 2.  
 For information about how to dump the database, see [How to Use the Online Dbdump feature of Active Directory](https://support.microsoft.com/help/315098). 

## Cause

An application can add an object link that refers to the internal root object of the Active Directory database. This object does not have a name or any other properties that are usable for applications. Therefore, the client applications display error messages that do not indicate the cause of a problem.

## Resolution

If you use domain controllers that are running Windows Server 2003 with Service Pack 1, the problem does not occur. But the object with this invalid link is still in the database. You can find the groups affected for a domain controller when you search the NTDS.DMP file, as follows:  
>findstr /i /c:" 36 2 - - " ntds.dmp  
38661 36 2 - - - - -

**Windows Server 2003:**

 You cannot resolve the problem by deleting the attribute. If you delete the attribute, the following error is logged in the Application Directory Services log:  
>Event Type: Error  
Event Source: NTDS Replication  
Event Category: Replication  
Event ID: 1694  
Description:  
Active Directory could not update the following object with an attribute value change received from the following source domain controller. This is because an error occurred during the application of the changes to Active Directory on the local domain controller.  
Object:  
**\<group DN>**  
Object GUID:  
**\<GUID>**  
Source domain controller:  
**\<GUID-based DC name>**  
Attribute:  
managedBy:  
Attribute value:  
[]  
Attribute value GUID:  
00000000-0000-0000-0000-000000000000  
Present:  
0  
This operation will be tried again at the next scheduled replication. The synchronization of the local domain controller with the source domain controller is blocked until the update problem is corrected.  
Additional Data  
Error value:  
The replication system encountered an internal error.

If this error is logged, the object is in a broken state. To achieve the original state or to delete the object, you can only run an authoritative restore on the object. To repair objects that exhibit this behavior, we recommend that you delete and rebuild the object by using the LDIFDE utility.

> [!CAUTION]
> All back-links are removed when you delete an object.

If you have to keep certain attributes that you cannot set the value on, such as the objectSid attribute or the SidHistory attribute, delete and then undelete the object. (Windows Server 2003 Service Pack 1 retains the **SidHistory** attribute on when you delete an object.) When you delete and undelete an object, you do not have to run a semantic checker.

However, no tools currently exist to recover the attributes and the back-links. To restore group memberships, you can use the Groupadd.exe tool. For more information, click the following article number to view the article in the Microsoft Knowledge Base:  

[840001](https://support.microsoft.com/help/840001) How to restore deleted user accounts and their group memberships in Active Directory

If you use the Microsoft Provisioning System, you can use the system to recover the attributes and the back-links.

Some backup and recovery applications may offer a more convenient way of removing these problematic attributes. The application must let you select attributes during a restore operation. For example, an application must let you exclude the managedBy attribute when you restore a deleted object.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. This problem was first corrected in Microsoft Windows Server 2003 Service Pack 1.
