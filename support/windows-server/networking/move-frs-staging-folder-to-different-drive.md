---
title: reset the File Replication service staging folder to a different logical drive
description: Describes how to reset the File Replication service (FRS) staging folder to a different logical drive or folder for existing FRS replica members.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:frs, csstroubleshoot
---
# How to reset the File Replication service staging folder to a different logical drive

This article describes how to reset the File Replication service (FRS) staging folder to a different logical drive or folder for existing FRS replica members.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 291823

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows.

The FRS is a multi-threaded, multi-master replication engine that replaces the LMRepl service in Microsoft Windows NT version 3.0 and Windows NT version 4.0. Whistler-based and Microsoft Windows 2000-based domain controllers use FRS to replicate policies and logon scripts that reside in the System Volume (SYSVOL) for Whistler-based and down-level clients.

FRS can also replicate the content between servers that host the same fault-tolerant Distributed file system (Dfs) roots or child node replicas.

The FRS staging folder is a temporary store for files that replicate to downstream partners of SYSVOL or Dfs replica sets. Files in the FRS staging folder may consume disk space up to the limit assigned in the **Staging Space Limit in KB** option [(REG_DWORD) registry entry ( Default = 660 MB)], or up to the amount of free disk space on the hosting drive, whichever is less.

For FRS replica sets that host gigabytes of content, it may be necessary to relocate the FRS staging folder to a different logical or physical drive to:

- Prevent the FRS staging folder from consuming all available disk space on the hosting drive, which can potentially affect the stability of other components including the base operating system.
- Locate the operating systems on different physical drives to enhance component or operating system performance.
- Provide sufficient space to host the desired staging space limit.

> [!NOTE]
> Windows 2000-based and Windows 2000 Service Pack 2-based clients must perform an authoritative restore task to relocate the FRS staging path.

For computers that are running Windows Server 2003, Windows 2000 Service Pack 3 (SP3) or an equivalent (including the Q321557 and Q321557 versions of Ntrfs.exe on Windows 2000-based computers), you can set the staging path by using the Ldp.exe program or the Adsiedit.msc utility by modifying the FrsStagingPath attribute on the **NTFRS subscriber** object under the host computer account in Active Directory.

To modify the FrsStagingPath attribute using the Adsiedit.msc tool that is included with the Windows. NET Support tools:

> [!WARNING]
> If you use the ADSI Edit snap-in, the LDP utility, or any other LDAP version 3 client, and you incorrectly modify the attributes of Active Directory objects, you can cause serious problems. These problems may require you to reinstall Microsoft Windows 2000 Server, Microsoft Exchange 2000 Server, or both. Microsoft cannot guarantee that problems that occur if you incorrectly modify Active Directory object attributes can be solved. Modify these attributes at your own risk.

1. Start the Adsiedit program.
2. Under Domain NC, locate the NTFRS subscriber object under the host computer account in Active Directory. The generic path for this attribute is: CN= **Replica Set Name**, CN=NTFRS Subscriptions, CN= **Computername**, DC= **Domain Name**,DC=COM

    For example, to reset the staging path for the SYSVOL replica set of domain controller `\\DC1` in the `A.com` domain, the Distinguished Name (DN) path for the FrsStagingPath attribute is:

    > CN=Domain System Volume (SYSVOL share), CN=NTFRS Subscriptions, CN=DC1, DC=A,DC=COM

    Where (when you read the DN path from right to left):

    DC=A,DC=COM is the domain hosting the computer account.
    CN=DC1 is the host computer account in the domain nc (domain naming context).
    CN=Domain System Volume (SYSVOL share) is the FRS subscriber object.
    CN=NTFRS Subscriptions is the NtfrsSubscriber object that holds the FrsStagingPath attribute.
3. Open the properties for the NTFRS subscriber object [in this example, it's Domain System Volume (SYSVOL share)], by right-clicking the object, and then clicking Properties.
4. Click fRSStagingPath in the list of attributes and click the Edit button.
5. Enter the path to the new location for the FRS staging folder and click OK.
6. Click OK to close the Properties window.
7. Update the staging path in the registry:
   1. Start Registry Editor (Regedt32.exe) on the server where you're changing the staging path.
   2. Locate the following subkey: `HKEY_LOCAL_MACHINE\System\CCS\Services\NTFRS\Parameters\Replica Sets`

8. Locate the replica set you are updating the staging area for. All replica sets are displayed as a GUID. If you click a GUID, one of the values on the right is Replica Set Name. After you locate the correct replica set, change the value of Replica Set Stage to the new staging area path. When the service detects a change in the staging path, the following Event 13563 is logged with a series of self-explanatory steps on how to proceed:

    > Event Type:Warning  
    Event Source:NtFrs  
    Event Category:None  
    Event ID:13563  
    Date:*\<DateTime>*  
    Time:*\<DateTime>*  
    User:N/A  
    Computer:AC2  
    Description: The File Replication service has detected that the staging path for the replica set DOMAIN SYSTEM VOLUME (SYSVOL SHARE) has changed.  
    >
    > Current staging path = E:\Windows\Sysvol\Staging\Domain  
    New staging path = E:\Frsstage  
    >
    > The service will start using the new staging path after it restarts. The service is set to restart after every restart.  
    >
    > It is recommended that you manually restart the service to prevent loss of data in the staging folder.  
    >
    > To manually restart the service do the following:  
    >
    > [1] Run "net stop ntfrs" or use the Services snap-in to stop File Replication service.  
    [2] Move all the staging files corresponding to replica set DOMAIN SYSTEM VOLUME (SYSVOL SHARE) to the new staging location. If more than one replica set are sharing the current staging folder then it is safer to copy the staging files to the new staging folder.  
    [3] Run "net start ntfrs" or use the Services snap-in to start File Replication service, followed by "net start ntfrs".  
    >
    > For more information, visit Help and Support Services at `http://search.support.microsoft.com/search/?adv=1`.  

Microsoft recommends that you follow step 2 in the preceding event message because the FRS staging folder may contain thousands or tens of thousands of files in the original staging folder all of which may be destined for one or more downstream partners. In Windows Explorer, you can view the files in the staging folder. On the Folder Options menu, click the View tab, and then click to select the **Show hidden files and folders** check box. Copy the files to the new staging folder, and then follow the remaining steps in the event log message.

### Update domain junction point

Resetting the FRS staging location also requires that you update the domain junction point under staging areas.

#### Set the staging area path

Use the following method to modify the fRSStagingPath parameter for a domain controller in Active Directory to change the location of the staging area folder on that domain controller. Perform this procedure at the console of the domain controller that is hosting the SYSVOL that you must reconfigure.

> [!NOTE]
> The following credentials and tools are required to set the staging area path:
>
> - Credentials: Domain Administrator
> - Tools: Registry Editor, Active Directory Service Interfaces (ADSI) Edit, Linkd.exe

To set the staging area path, follow these steps:

1. Click **Start**, click **Run**, type Adsiedit.msc and press ENTER.

2. Locate the following object, as follows:  
    **CN=Domain System Volume(SYSVOL share)**  

    1. Expand **Domain [**ComputerName**.**DomainName**.**suffix**]**  
    2. Expand **DC=**DomainName**, DC=**suffix****  
    3. Expand **OU=Domain Controllers**  
    4. Expand **CN=**ComputerName****  
    5. Expand **CN=NTFRS Subscriptions**.
3. Right-click **CN=Domain System Volume(SYSVOL share)**, and then click **Properties**  
4. Click to select the **Show Mandatory attributes** check box.
5. Locate and then click **fRSStagingPath** in the list of attributes, and then click **Edit**  
6. Type the complete path of where you want to locate the **Staging Area** folder, and then click OK.

    This path is the path of the new folder that you created earlier. Include the drive letter.
7. At a command prompt, change the directory to `%systemroot%\SYSVOL\staging` areas.
8. Type dir in the list the contents. Verify that `<JUNCTION>` appears in the DIR output.
9. Update the junction so that the junction points to the new location. Type the following command:  
    `linkd junctionname Newpath`  
    > [!NOTE]
    > **Newpath** is the same value that you entered for fRSStagingPath.
10. Press ENTER.

> [!NOTE]
> The Active Directory Product Operations Guide includes these procedures.
