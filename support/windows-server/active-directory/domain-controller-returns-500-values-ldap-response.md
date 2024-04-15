---
title: DC returns only 5000 values in LDAP response
description: Provides a solution to an issue where the Windows Server 2008 R2 or newer domain controller only returns 5000 values for an LDAP response.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nedpyle, rolandw, aconkle
ms.custom: sap:Active Directory\LDAP configuration and interoperability, csstroubleshoot
---
# Windows Server 2008 and newer domain controller returns only 5000 values in an LDAP response

This article provides a solution to an issue where the Windows Server 2008 R2 or newer domain controller only returns 5000 values for an LDAP response.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2009267

## Symptoms

An LDAP application may return less information when a query is sent to a Windows Server 2008 or Windows Server 2008 R2 domain controller than when sent to a Windows Server 2003 domain controller. The query results may appear truncated or incomplete. In some occasions, you may not get any results.
For example, if an LDAP application queries the members of a group, the Windows Server 2008 R2 or Windows Server 2008 domain controller only returns 5000 members, while the Windows Server 2003 domain controllers return many more members.
In both cases, you may realize the same extended LDAP policy setting in NTDSUTIL required for the LDAP application. For more information about viewing the LDAP policy settings, click the following article number to view the article in the Microsoft Knowledge Base:

[315071](https://support.microsoft.com/kb/315071) How to view and set LDAP policy in Active Directory by using Ntdsutil.exe

Sample output:

> ldap policy:  show values
>
> Policy                          Current(New)
>
> MaxPoolThreads                  4  
MaxDatagramRecv               4096  
MaxReceiveBuffer                10485760  
InitRecvTimeout                  120  
MaxConnections                  5000  
MaxConnIdleTime               900  
MaxPageSize                      50000  
MaxQueryDuration               120  
MaxTempTableSize             10000  
MaxResultSetSize                262144  
MinResultSets                      0  
MaxResultSetsPerConn         0  
MaxNotificationPerConn        5  
MaxValRange                      25000

> [!Note]
> On both domain controllers, the setting MaxPageSize is set to 50000 (default 1000) and MaxValRange to 25000 (default 1500).

## Cause

Internal LDAP limitations have been introduced in Windows Server 2008 R2 and Windows Server 2008 to prevent overloading the domain controller. These limits overwrite the LDAP policy setting when the policy value should be higher.

| **LDAP setting**| **maximum value (hardcoded)** |
|---|---|
| MaxReceiveBuffer| 20971520|
| MaxPageSize| 20000|
| MaxQueryDuration| 1200|
| MaxTempTableSize| 100000|
| MaxValRange| 5000|

Therefore the effective setting for the above LDAP policy is MaxPageSize=50000 and MaxValRange=25000 on a Windows Server 2003 domain controller as configured in the LDAP policy but on a Windows Server 2008 R2 or Windows Server 2008 domain controller the hardcoded limits dictate MaxPageSize=20000 and MaxValRange=5000.  
MaxValRange affects the number of attributes returned for a query. If you perform an LDAP query for the multi-valued attribute Member for a group object with more than 5000 members the Windows Server 2008 R2 or Windows Server 2008 domain controller will only return 5000 of them.

## Resolution

The new maximum limits introduced with Windows Server 2008 R2 and Windows Server 2008 try to enforce the message that applications should adopt to the policies AD wants to enforce. You should adapt your LDAP application accordingly.
For the MaxValRange limitation you may consider the following MSDN information and samples for using ranged queries:
Range Retrieval of Attribute Values
 [https://msdn.microsoft.com/library/cc223242(PROT.10).aspx](https://msdn.microsoft.com/library/cc223242%28PROT.10%29.aspx)  
The following code example uses ranging to retrieve the members of a group using the IDirectoryObject interface:
Example Code for Ranging with IDirectoryObject
 [https://msdn.microsoft.com/library/aa705923(VS.85).aspx](https://msdn.microsoft.com/library/aa705923%28VS.85%29.aspx)  
The following code example uses ranging to retrieve the members of a group using the IDirectorySearch interface:
Example Code for Ranging with IDirectorySearch
 [https://msdn.microsoft.com/library/aa705924(VS.85).aspx](https://msdn.microsoft.com/library/aa705924%28VS.85%29.aspx)  
For MaxPageSize it is recommended to used paged queries, outlined on MSDN as follows:
Paging Search Results
 [https://msdn.microsoft.com/library/aa367011(VS.85).aspx](https://msdn.microsoft.com/library/aa367011%28VS.85%29.aspx)  
ldap_create_page_control Function
 [https://msdn.microsoft.com/library/aa366547(VS.85).aspx](https://msdn.microsoft.com/library/aa366547%28VS.85%29.aspx)  
There is a way to override these limitations, but we encourage to discuss the requirements with Microsoft customer technical support to decide if modifying the policies is the correct approach.  

## More information

For more information about LDAP policies, visit
LDAP Policies
 [https://msdn.microsoft.com/library/cc223376(PROT.10).aspx](https://msdn.microsoft.com/library/cc223376%28PROT.10%29.aspx)
