---
title: Deleting Active Directory objects that have many links causes replication failures
description: Discusses an issue in which deleting Active Directory objects that have many links causes replication failures. Provides a workaround.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Deleting Active Directory objects that have many links causes replication failures

This article provides a workaround for an issue that occurs when you delete Active Directory objects that contain many forward links.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3149779

## Summary

This article discusses an issue that occurs when you delete Active Directory objects that contain many forward links. Here are some common examples:

- Group memberships (the member attribute)
- Roaming user credentials (the ms-PKI-AccountCredentials attribute)
- Read-only domain controller (RODC) exposed user links (the mds-revealedusers attribute)

The number of links where you start seeing problems may be as low as 50,000. On a single object, there may be several millions of links.

The registry key that is discussed in this article should be applied only to domain controllers (DCs) and Lightweight Directory Services (LDS) servers that are experiencing the issue that is described in the "Symptoms" section. This issue is likely to occur on Windows Server 2012, Windows Server 2012 R2, and Windows Server 2016 DCs. By following the recommendations that are given here, you may decrease Active Directory replication performance but increase the reliability of correctly processing the deletion of such large objects.

## Symptoms

When you delete Active Directory objects that contain many forward links, you may encounter replication failure. For example, you delete groups with large membership sets, or you demote and then delete RODC computer accounts that have many links to users accounts that have their password exposed on the RODC.

The following conditions are the key indicators that this solution applies to the issue:

- The forest functional level is Windows Server 2003 or later version of Windows Server, so link value replication is used.
- Event 2094 (replication delay) occurs several times, referencing the same deleted object.
- Events 1083 and 1955 (Write conflict) are logged in close time proximity to the logging of the 2094 event referencing the same deleted object.
- The affected domain controller (DC) may also report that the version store is exhausted (Event ID 623). Exhaustion of version store doesn't always occur in this scenario. Other factors that increase the likelihood of version store exhaustion include a high rate of changes to Active Directory objects, both local and replicated, as well as other long running operations such as deep queries.
- Active Directory replication fails with error 8409, error "A database error has occurred", or other events cite related status codes that are mentioned in the following table:

    |Hex|Decimal|Symbolic|Friendly|
    |---|---|---|---|
    |000020D9|8409|ERROR_DS_DATABASE_ERROR|A database error has occurred|

  If the Active Directory recycle bin is enabled, the replication errors may not occur for 60 to 180 days (deleted object lifetime) after the object is deleted. The issues occur when the object transitions from the deleted status to the recycled status.

### Event log entries

When the issue occurs, the following events are logged:

> Log Name:      Directory Service  
Source:        Microsoft-Windows-ActiveDirectory_DomainService  
Event ID:      2094  
Task Category: Replication  
Level:         Warning  
Keywords:      Classic  
Description: Performance warning: replication was delayed while applying changes to the following object. If this message occurs frequently, it indicates that the replication is occurring slowly and that the server may have difficulty keeping up with changes.  
Object DN: \<object name>  
Object GUID: \<object GUID>  
Partition DN: DC=contoso,DC=com  
Server: xxxx-xxxx-xxxx-xxxx-xxxxxxx._msdcs.contoso.com  
Elapsed Time (secs): 11  
User Action  
A common reason for seeing this delay is that this object is especially large, either in the size of its values, or in the number of values. You should first consider whether the application can be changed to reduce the amount of data stored on the object, or the number of values.  If this is a large group or distribution list, you might consider raising the forest functional level to Windows Server 2003 or greater, since this will enable replication to work more efficiently. You should evaluate whether the server platform provides sufficient performance in terms of memory and processing power. Finally, you may want to consider tuning the Active Directory Domain Services database by moving the database and logs to separate disk partitions.  
If you wish to change the warning limit, the registry key is included below. A value of zero will disable the check.  
Additional Data  
Warning Limit (secs): 10  
Limit Registry Key: System\\CurrentControlSet\\Services\\NTDS\\Parameters\\Replicator maximum wait for update object (secs)  
Log Name:      Directory Service  
Source:        Microsoft-Windows-ActiveDirectory_DomainService  
Event ID:      1083  
Task Category: Replication  
Level:         Warning  
Keywords:      Classic  
Description:  
Active Directory Domain Services could not update the following object with changes received from the directory service at the following network address because Active Directory Domain Services was busy processing information.  
Object: \<object name>  
Network address: xxxxx-xxxx-xxxx-xxxx-xxxxxxx._msdcs.contoso.com  
This operation will be tried again later.  
Log Name:      Directory Service  
Source:        Microsoft-Windows-ActiveDirectory_DomainService  
Event ID:      1955  
Task Category: Replication  
Level:         Information  
Keywords:      Classic  
User:          ANONYMOUS LOGON  
Description: Active Directory Domain Services encountered a write conflict when applying replicated changes to the following object.  
Object: \<object name>  
Time in seconds: 48  
Event log entries preceding this entry will indicate whether or not the update was accepted.  
A write conflict can be caused by simultaneous changes to the same object or simultaneous changes to other objects that have attributes referencing this object. This commonly occurs when the object represents a large group with many members, and the functional level of the forest is set to Windows 2000. This conflict triggered additional retries of the update. If the system appears slow, it could be because replication of these changes is occurring.  
User Action  
Use smaller groups for this operation or raise the forest functional level to Windows Server 2003.  

## More information

By default, when you delete an Active Directory object that has an exceptionally large number of forward and backward links, 10,000 links are deleted at a time. During this time, if other threads update the target objects of these links, the link deletion transaction is suspended until the objects are available again. This suspension can cause the whole deletion transaction to take a long time to finish. During this time, other replication tasks are held up by this long-running task. For example, you may notice that passwords and group membership updates aren't progressing throughout the forest.

While this update is pending, admins may see write conflicts and transaction failure events. Also, as additional objects are processed by replication, more and more version store is allocated because the pending large transaction doesn't release its allocated versions store until the deletion transaction is finished. This can cause version store errors and replication warnings events.

> [!Note]
>
> - Garbage collection isn't related to the processing of group membership link deletions.
> - Decreasing TSL isn't a valid method of accelerating link deletions.
> - The legacy value for **Links process batch size**  is 1,000 in versions before Windows Server 2008 R2. In later versions, the batch size is increased to 10,000 to improve the performance of undeleting in forests that have the Recycle Bin enabled.
> - Check values of the **Links process batch size** parameter. If it's nondefault, set the value back to its default or an even smaller value such as 1,000 or 100.
>
> Smaller values decrease version store usage by deleting a smaller number of objects per deleting thereby reducing the total time to perform a single delete transaction. This has the positive side effect of reducing version store and time window for write conflicts while you increase the time that's required to accurately reflect the group membership in the directory.

Active Directory services check for the following registry key.

For AD DS:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters\Links process batch size`

For AD LDS:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\<adam instance>\Parameters\Links process batch size`  
**Type**: DWORD  
**Min Value**: 100  
**Max Value**: 10000  

This value overrides the default value of 10,000 as the number of atomic links to process at one time. You don't have to restart the NTDS or LDS instance service, or restart the computer to make the setting effective.

After each atomic operation, the corresponding version store is released. The version store is reacquired only during the next atomic operation that continues to process the same object. You may have second thoughts about turning down the link batch size by a great degree. You can combine it with an increase of the ESE version store. If maybe for a reason that you have increased version store, you may decide to increase version store some more or not decrease the **Links process batch size** value so much.

For more information, see the following articles:

- [The Version Store Called, and They're All Out of Buckets](https://blogs.technet.microsoft.com/askds/2016/06/14/the-version-store-called-and-theyre-all-out-of-buckets/)
- [The domain controller runs slower or stops responding when the garbage collection process runs](https://support.microsoft.com/help/974803/)

## Workaround

To work around this issue, set the value of **Links process batch size** lower than 10,000. This decreases the potential for an object access collision to occur. By doing this, you make the replication process of large object deletion more reliable. Also, it now takes a longer time to complete the whole transaction. This also helps you avoid version store depletion.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## References

For more information, see the following articles:

- [Introduction to credential roaming](https://learn.microsoft.com/archive/technet-wiki/11483.windows-credential-roaming)
- [Introduction to Read-Only DCs](https://technet.microsoft.com/library/dd734758%28v=ws.10%29.aspx)
