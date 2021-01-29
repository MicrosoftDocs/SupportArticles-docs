---
title: Distributed Link Tracking on domain controllers
description: Describes how you can use the Distributed Link Tracking services on Windows-based domain controllers.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Partition and volume management
ms.technology: windows-server-backup-and-storage
---
# Distributed Link Tracking on Windows-based domain controllers

This article describes how you can use the Distributed Link Tracking services in Windows to track the creation and movement of linked files across NTFS-formatted volumes and servers.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 312403

## An overview of Distributed Link Tracking

You can use the Distributed Link Tracking Server service and the Distributed Link Tracking Client service to track links to files on NTFS-formatted partitions. Distributed Link Tracking tracks links in scenarios where the link is made to a file on an NTFS volume, such as shell shortcuts and OLE links. If that file is renamed, moved to another volume on the same computer, moved to another computer, or moved in other similar scenarios, Windows uses Distributed Link Tracking to find the file. When you access a link that has moved, Distributed Link Tracking locates the link; you're unaware that the file has moved, or that Distributed Link Tracking is used to find the moved file.

Distributed Link Tracking consists of a client service and a server service. The Distributed Link Tracking Server service runs exclusively on Windows Server-based domain controllers. It stores information in Active Directory, and it provides services to help the Distributed Link Tracking Client service. The Distributed Link Tracking Client service runs on all Windows 2000-based and Microsoft Windows XP-based computers, including those in workgroup environments or those that are not in a workgroup. It provides the sole interaction with Distributed Link Tracking servers.

Distributed Link Tracking clients occasionally provide the Distributed Link Tracking Server service with information about file links, which the Distributed Link Tracking Server service stores in Active Directory. Distributed Link Tracking clients also may query the Distributed Link Tracking Server service for that information when a shell shortcut or an OLE link cannot be resolved. Distributed Link Tracking clients prompt the Distributed Link Tracking server to update links every 30 days. The Distributed Link Tracking Server service scavenges objects that have not been updated in 90 days

When a file that is referenced by a link is moved to another volume (on the same computer or on a different computer), the Distributed Link Tracking client notifies the Distributed Link Tracking server, which creates a linkTrackOMTEntry object in Active Directory. A linkTrackVolEntry object is created in Active Directory for every NTFS volume in the domain.

> [!NOTE]
> In Windows Server 2008 and newer, the Distributed Link Tracking Server Service is not included in Windows anymore. So you can safely remove the objects from Active Directory.

## Distributed Link Tracking and Active Directory

Distributed Link Tracking objects are replicated among all domain controllers in the domain that is hosting the computer account and all global catalog servers in the forest. The Distributed Link Tracking Server service creates objects in the following distinguished name path:  

CN=FileLinks,CN=System,DC= **domain name** container of Active Directory

Distributed Link Tracking objects exist in the following two tables under the CN=FileLinks,CN=System folder:

- CN=ObjectMoveTable,CN=FileLinks,CN=System,DC= **domain name**:

This object stores information about linked files that have been moved in the domain.

- CN=VolumeTable,CN=FileLinks,CN=System,DC= **domain name**:

    This object stores information about each NTFS volume in the domain.  

Distributed Link Tracking objects consume little space individually, but they can consume large amounts of space in Active Directory when they are allowed to accumulate over time.

If you disable Distributed Link Tracking and delete the Distributed Link Tracking objects from Active Directory, the following behavior may occur:

- Active Directory database size may be reduced (this behavior occurs after the objects have been tombstoned and garbage collected, and after you perform an offline defragmentation procedure).
- Replication traffic between domain controllers may be reduced.

## Distributed Link Tracking Server service defaults on Windows Server-based domain controllers

In Windows 2000, Windows XP, and Windows Server 2003, the start value for the Distributed Link Tracking Client service is set to Automatic. On Windows 2000-based servers, the Distributed Link Tracking Server service starts manually, by default. However, if you use Dcpromo.exe to promote a server to a domain, the Distributed Link Tracking Server service is configured to start automatically.

For Windows Server 2003-based servers, the Distributed Link Tracking Server service is disabled by default. When you use Dcpromo.exe to promote a server to a domain, the Distributed Link Tracking Server service is not configured to start automatically. When a Windows 2000-based domain controller is upgraded to Windows Server 2003, the Distributed Link Tracking Server service is also disabled during the upgrade. If you are an administrator and you want to use the Distributed Link Tracking Server service, you must either use Group Policy or you must manually set the service to start automatically. In addition, the Distributed Link Tracking Client service on computers that are running Windows Server 2003 or Windows XP SP1 does not try to use the Distributed Link Tracking Server service by default. If you want to configure those computers to take advantage of the Distributed Link Tracking Server service, enable the Allow Distributed Link Tracking clients to use domain resources policy setting. To do so, open the Computer Configuration/Administrative Templates/System node in Group Policy.

## Microsoft recommendations for Distributed Link Tracking on Windows 2000-based servers

Microsoft recommends that you use the following settings with Distributed Link Tracking on Windows 2000-based servers:

1. Turn off the Distributed Link Tracking Server service on all domain controllers (this is the default configuration on all Windows Server 2003-based servers).

    Because of replication overhead and the space that FileLinks tables uses in Active Directory, Microsoft recommends that you turn off the Distributed Link Tracking Server service on Active Directory domain controllers. To stop the service, use any of the following methods:

   - In the Services snap-in (Services.msc or compmgmt.msc), double-click the **Distributed Link Tracking Server** service, and then click **Disabled** in the **Startup type** box.
   - Define the Startup value in the Computer Configuration/Windows Settings/System Services node of Group policy.

   - Define the policy settings on an organizational unit that hosts all Windows 2000 domain controllers.

    Restart the domain controllers after the policy has replicated so that the policy will be applied. If you do not restart the domain controllers, you will have to manually stop the service on each domain controller.
2. Delete Distributed Link Tracking objects from Active Directory domain controllers.

    See the "How to Delete Distributed Link Tracking Object" section of this article for more information about how to delete Distributed Link Tracking objects. It is recommended that you delete objects after you disable the Distributed Link Tracking Server service.

    > [!NOTE]
    > The Directory Information Tree (DIT) size on domain controllers is not reduced until the following actions are completed.

    1. Objects are deleted from the directory service.

        > [!NOTE]
        > Deleted objects are stored in the Deleted Objects container until the tombstone lifetime expires. The default value for a tombstone lifetime is 60 days. The minimum value is two days. By default, the value is 180 days for new forests that are installed together with Windows Server 2003 Service Pack 1 or a later version of Windows Server 2003.

        Unless you have strong Active Directory replication monitoring, we recommend that you use the 180-day value. Do not reduce this value to handle DIT size problems. If you have problems with database size, contact Microsoft Customer Support Services.

    2. Garbage collection has run to completion.
    3. You use Ntdsutil.exe to defragment the Ntds.dit file in Dsrepair mode.

## How to delete Distributed Link Tracking objects

It is not critical that you manually delete the Distributed Link Tracking objects after you stop the Distributed Link Tracking server service unless you have to reclaim the disk space that is being consumed by these objects as quickly as possible. Distributed Link Tracking clients prompt the Distributed Link Tracking server to update links every 30 days. The Distributed Link Tracking Server service scavenges objects that have not been updated in 90 days.

When you run the Dltpurge.vbs VBScript, all Active Directory objects that are used by the Distributed Link Tracking Server service are deleted from the domain where the script is run. You must run the script on one domain controller for each domain in a forest. To run Dltpurge.vbs:

1. Obtain the Dltpurge.vbs script from Microsoft Product Support.  
2. Stop the Distributed Link Tracking Server service on all domain controllers in the domain that is being targeted by Dltpurge.vbs.
3. Use administrator privileges to log on to the console of a domain controller or a member computer in the domain that is being targeted by Dltpurge.vbs.
4. Use the following syntax to run Dltpurge.vbs from a command line:  

    ```vbscript
    cscript dltpurge.vbs -s myserver -d dc=mydomain,dc=mycompany,dc=com  
    ```

    In this command line:

    - -s is the DNS host name of the domain controller on which you want to delete Distributed Link Tracking objects.
    - -d is the distinguished name path of the domain on which you want to delete Distributed Link Tracking objects.  

5. Perform an offline defragmentation procedure of the Ntds.dit file after the objects have been tombstoned and garbage collected.
 For more information about the garbage collection process, click the following article number to view the article in the Microsoft Knowledge Base:

    [198793](https://support.microsoft.com/help/198793) The Active Directory database garbage collection process  

## A sample customer experience

The worst-case scenario that is described in this section illustrates some issues to consider when you delete a large number of Distributed Link Tracking objects in a large production domain.

Trey Research, a fictitious Fortune 500 customer with over 40,000 employees worldwide deploys a single Active Directory forest that consists of an empty root domain with child domains that map major geographic regions of the world (North America, Asia, Europe, and so on). The largest domain in the forest contains about 35,000 user accounts and the same number of computer accounts.

The Ntds.dit files were placed on 18-gigabyte (GB) raid arrays. Since the initial deployment of Windows 2000, the global catalog files have grown to 17 GB.

Trey Research wants to deploy Windows Server 2003 within the next 10 days but needs at least 1.5 GB of available disk space on the database partition before they initiate the upgrade. They need this much disk space because Adprep.exe is known to add three to five inherited aces depending on the hotfixes and service packs that have been previously installed. The following conditions contribute to the large global catalog size or the lack of disk space:

- Condition 1: Trey Research was an early adopter of Windows 2000 and the largest drives that they received from their preferred hardware vendor were 9 GB or 18 GB when they were configured in a raid array. Current drives are double the size for half the cost.
- Condition 2: DNS scavenging was not enabled on Active Directory-integrated DNS zones that were delegated to each domain in the forest.
- Condition 3: Domain users were allowed to create computer accounts in the domain. Administrators did not have a recurring process to identify and delete orphaned computer accounts.
- Condition 4: Over the course of time, security descriptors were defined by administrators, service packs, and hotfixes on root naming context (NC) heads (cn=schema, cn=configuration, cn= **domain**) and other containers that host thousands of objects in Active Directory. In addition, auditing was enabled on the same partitions. When you set permissions and enable auditing on objects in Active Directory, the size of the database increases. The tool that prepares Windows 2000 forests and domains for Windows Server 2003-based domain controllers (Adprep) also adds inherited aces; therefore, Trey Research needed to free space on the disk drive before they upgraded the domain.
- Condition 5: Trey Research did not regularly perform offline defragmentation procedures of Ntds.dit files in Dsrepair mode.
- Condition 6: When the CN=FileLinks,CN=System,DC= **domain name** container in the largest domain was reviewed, it revealed over 700,000 Distributed Link Tracking objects. The security descriptor on each Distributed Link Tracking object was approximately 2 kilobytes (KBs). Each of these conditions was evaluated for its contribution to the 17-GB .dit file:

- Condition 1: Trey Research decided not to deploy new drives because of the cost and the time it would take to do so. Also, they only needed the disk space temporarily because they expected the Active Directory Database to shrink after they upgraded to Windows Server 2003 and the Single Instance Store (SIS) process was completed (SIS implements a more efficient storage of permissions in Active Directory databases).
- Conditions 2 and 3: Trey Research decided that these conditions were the best practices; however, even if Trey Research implemented them, they would not achieve the needed results. They decided to enable DNS scavenging because it is easily implemented.  
- Condition 4: Trey Research realized that if they redefined security descriptors and system access control lists (SACLs), they would achieve the results they are looking for, but they decided that this procedure would be time consuming to implement until they could thoroughly test the size reduction, replication overhead and, most importantly, program/administration compatibility in the lab scenario that mirrors the production environment.

    Because Trey Research has deployed Windows 2000 SP2 and a few hotfixes, they expected that the incremental inherited aces that were added by Adprep (to objects in the domain NC) could be as small as 300 megabytes (MBs). They could verify this behavior in a lab environment that is used to test upgrades of the production forest.
- Condition 5: Trey Research realized that if they performed an offline defragmentation procedure, they might not recover "whitespace" in the Ntds.dit file. In fact, Trey Research administrators noticed an increase in database size immediately after they completed the offline defragmentation procedure. This behavior occurred because of an inefficiency in the Windows 2000 database engine; this engine is enhanced in Windows Server 2003.

- Condition 6: Trey Research agreed that the obvious course of action would be to perform a simple bulk deletion of all of the Distributed Link Tracking objects from the CN=FileLinks,CN=System,DC= **domain name** container on a domain controller in each domain in the forest. However, they realized that if they did so, additional disk space would not be freed up until the objects had been tombstoned and garbage collected, and until they completed an offline defragmentation procedure on each domain controller in that domain. While the tombstone lifetime value can be set to values as low as two days, several domain controllers in the Trey Research forest were offline as they awaited hardware and software updates. If objects are tombstoned before end-to-end replication can take place, deleted objects may be reanimated or inconsistent data may be reported among global catalog servers in the forest. To provide immediate relief, Trey Research performed the following procedure:

1. They removed the default security descriptor for Distributed Link Tracking schema class objects and replaced it with a single security principal (user account).
2. They wrote a VBScript program that removed all of the existing security descriptors, and then replaced them with an explicit ace for a single security principal.
3. They deleted Distributed Link Tracking objects in 10,000-unit increments with a three-hour delay between each object deletion.
4. They performed an offline defragmentation procedure on each domain controller in the domain after all Distributed Link Tracking objects were deleted. When Trey Research removed the descriptor and performed the defragmentation procedure, the database recovered about 1.5 GB of disk space on all domain controllers in the domain. This amount of space was enough to comfortably run the Adprep tool and upgrade all Windows 2000-based domain controllers and global catalogs to Windows Server 2003.

After Trey Research upgraded the operating system to Windows Server 2003, more disk space was freed when the single instance store feature in Windows Server 2003 reduced database size to about 8 GB (you must perform an offline defragmentation procedure to get these results). More space was recovered after the TSL interval expired, Distributed Link Tracking objects were garbage collected, and they performed an offline defragmentation procedure.

Trey Research promoted a new replica Windows 2000-based domain controller into the domain and placed the computer account in a different organizational unit than they typically used. In two days, around 8,000 Distributed Link Tracking objects were present on the Windows 2000-based domain controller. Trey Research either stopped Distributed Link Tracking or created a policy to stop the service, and then linked the policy to organizational units that host Windows 2000-based domain controllers. Finally, Trey Research used Dltpurge.vbs to mark the remaining Distributed Link Tracking objects for deletion.

## Anatomy of DLT object deletion

DLT objects themselves contain few attributes and use little space in Active Directory. When an object is marked for deletion (tombstoned), all the unnecessary attributes are stripped away, except for those necessary to track the object until it is purged from Active Directory.

In the case of the link-tracking objects, marking the object for deletion only amounts to two attributes being removed: dscorepropagationdata and objectcategory. The deletion of the two attributes results in an initial savings of 34 bytes. However, the process of marking the link-tracking object for deletion also updates the object by adding an IS_DELETED attribute (4 bytes), and by mangling the RDN and the "common name" attributes, causing each of those attributes to grow by about 80 bytes. In addition, the "replication metadata" attribute also grows by about 50 bytes to reflect the updates performed on this object. So, by marking a link-tracking object for deletion, the object will end up growing by approximately 200 bytes. The NTDS.DIT will not exhibit a reduction in size until the deleted objects have tombstoned, been garbage collected and an offline defragmentation performed.

> [!NOTE]
> If the service is turned off as this article recommends, the autocleanup does not occur.
