---
title: Lync Server Move-CsUser and Move-CsLegacyUser commands fail
description: Lync Server Move-CsUser and Move-CsLegacyUser commands fail. Provides a solution for this issue.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: miadkins
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server
ms.date: 03/31/2022
---

# Lync Server Move-CsUser and Move-CsLegacyUser commands fail with error - SetMoveResourceData failed because the user is not provisioned

## Symptoms

There are two Lync Server migration scenarios where an inter-pool user move can fail:
- The Move-CsUser is used to move Lync Server enabled users between two Lync Server pools   
- The Move-CsLegacyUser is used to move legacy Communications Server enabled users to the Lync Server pool   

The Move-CsUser Lync Server PowerShell cmdlet will fail with the following error:

```adoc
Move-CsUser : SetMoveResourceData failed because the user is not provisioned.
At line:1 char:12 + Move-CsUser <<<<  -Target pool01.contoso.com -Identity bill@contoso.com -Verbose + CategoryInfo: InvalidOperation: (CN=Bill Ander...DC=com:OCSADUser) [Move-CsUser], MoveUserException + FullyQualifiedErrorId :MoveError,Microsoft.Rtc.Management.AD.Cmdlets.MoveOcsUserCmdlet
```

The Move-CsLegacyUser Lync Server PowerShell cmdlet will fail with the following error:

```adoc
Move-CsLegacyUser : SetMoveResourceData failed because the user is not provisioned.
At line:1 char:18 + Move-CsLegacyUser <<<<  -Identity "jeff@contoso.com" -Target "pool01.contoso.com" + CategoryInfo : InvalidOperation: (CN=Jeff Ander...contoso,DC=com:OCSADUser) [Move-CsLegacyUser], MoveUserException + FullyQualifiedErrorId : MoveLegacyUserError,Microsoft.Rtc.Management.AD.Cmdlets.MoveOcsLegacyUserCmdlet  
```

## Cause

The Lync Server User Replicator Service has not completed the initial replication of user information between the Windows Active Directory, directory services Lync Server enabled domain and the Lync Server databases. The Lync Server User Replicator initial synchronization process will occur one time by default when the Lync Server front-end server is started for the first time. The Lync Server User Replicator Service will perform an initial synchronization with the domain controller in each Windows Active Directory, directory services Lync Server enabled domain. This process will synchronize each Lync Server enabled Active Directory, directory services user object with the Lync Server pool databases. The initial synchronization process's time to completion can vary depending on the design of the Active Directory, directory services forest that hosts the Lync server pool. The time it takes for the successful completion of the Lync Server User Replicator Service's initial synchronization depends on:

- The number of domain controllers that are hosted in the Active Directory, directory services forest that hosts the Lync Server pool   
 
## Resolution

1. Use the following steps to locate the migration user information in the Lync Server database:   
2. Install the Lync Server Resource Kit tools locally on one of the Lync Server Pool front-end servers   
3. Open an administrative command prompt window   
4. Browse to **%ProgramFiles%\Microsoft Lync Server 2010\ResKit** or **%ProgramFiles%\Microsoft Lync Server 2013\ResKit**    
5. Use the following Dbanalyze command to verify that the user information has been migrated into the Lync target pool:

    ```powershell
    dbanalyze /sqlserver:<SQL Server Instance Name /report:user /user:sipuri@contoso.com
    ```

    > [!NOTE]
    > Lync 2010 Server 2010 Standard Edition uses the following syntax for the dbanalyze command listed above: dbanalyze /report:user /user:sipuri@contoso.com

1. If the following error is returned, then the specific user information has not been added to the Lync Server database yet:

    ```adoc
    There was an error communicating with the database:
    ###50010:ReportUserData:sipuri@contoso.com is not found in this database
    ```

Use the following steps to make sure that the Lync Server User Replicator initial synchronization process has completed:

1. On the desktop of a Lync Server pool front-end server   
2. Click on Run from the Start menu   
3. Type in eventvwr.exe and Click on the OK button   
4. Expand the Applications and Services logs   
5. Select Communications Server   
6. In the Actions pane of the Event Viewer dialog, click on the Filter Current Log
7. From the Event sources drop down selector choose CS User replicator   
8. Enter the Event ID 30024   
9. Event information that is similar to the information that is listed below should be returned:

    ```adoc
    Log Name:      Communications Server
    Source:        CS User Replicator
    Date:          9/22/2010 5:48:31 PM
    Event ID:      30024
    Task Category: (1009)
    Level:         Information
    Keywords:      Classic
    User:          N/A
    Computer:      LyncServer.contoso.com
    Description:
    User Replicator has completed initial synchronization of domain contoso.com (DN: CN=Configuration,DC=contoso,DC=com) and the database.  Future synchronization for this domain will occur as changes are made in Active Directory. 
    ```

## More Information

After the Lync Server User Replicator initial synchronization has completed, the Lync Server User Replicator will check all the domain controllers in each Lync Server enabled domain of the Active Directory, directory services Forest at a default 60-second interval. If the Lync Server User Replicator locates any user information that has been updated since the completion of the initial synchronization, then it will synchronize the newly updated Lync Server user information with the Lync Server user information that exists in the Lync Server back-end database.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
