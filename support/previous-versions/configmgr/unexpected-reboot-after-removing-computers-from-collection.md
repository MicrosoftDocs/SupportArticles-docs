---
title: Unexpected reboot after removing computers from a collection
description: Describes a by-design behavior in which removing computers from a collection in System Center Configuration Manager 2007 may cause an unexpected reboot.
ms.date: 08/20/2020
ms.prod: configuration-manager
ms.prod-support-area-path:
ms.reviewer: elliotsh
---
# Removing computers from a collection in System Center Configuration Manager 2007 may cause an unexpected reboot

This article describes a by-design behavior in which removing computers from a collection in System Center Configuration Manager 2007 may cause an unexpected reboot.

_Original product version:_ &nbsp; System Center Configuration Manager 2007  
_Original KB number:_ &nbsp; 2612955

## Symptoms

Some computers may reboot unexpectedly after they are removed from a collection in System Center Configuration Manager 2007 (ConfigMgr 2007) when that collection has a maintenance window. Looking at a sample log, we can see the following:

1. The maintenance window was deleted at 12:12:46 AM on 8/23/2011:

    > CServiceWindowManager::OnPolicyChange- Policy __InstanceDeletionEvent notification received ServiceWindowManager 8/23/2011 12:12:46 AM  10356 (0x2874)  
    > Service Window Policy Deletion notification received. ServiceWindowManager 8/23/2011 12:12:46 AM  10356 (0x2874)  
    > A Policy Change has occurred. Policy has been deleted. ServiceWindowManager 8/23/2011 12:12:46 AM  10356 (0x2874)  
    > The service window being deleted is not active. Just Deleting... ServiceWindowManager 8/23/2011 12:12:46 AM  10356 (0x2874)  
    > The Next event was found to be either the start/end of the service window just deleted. Recalculating next event... ServiceWindowManager 8/23/2011 12:12:46 AM  10356 (0x2874)  
    > No Service Windows Left. There is no next event.... ServiceWindowManager 8/23/2011 12:12:46 AM  10356 (0x2874)  
    > Sending Message SERVICEWINDOWEVENT:DELETE event ServiceWindowManager 8/23/2011 12:12:46 AM  10356 (0x2874)  
    > Inactive Service Windows List has 0 windows ServiceWindowManager 8/23/2011 12:12:46 AM  10356 (0x2874)

1. The assignment {0A650EE8-0DE5-4D82-AED6-947BD72425D4} was downloaded successfully at 11:10:30 PM on 8/22/2011:

    > DownloadCIContents Job ({39B93D1E-6868-4E2A-B271-BA721753019D}) started for assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4}) UpdatesDeploymentAgent  8/22/2011 11:10:16 PM  11888 (0x2E70)  
    > Progress received for assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4}) UpdatesDeploymentAgent  8/22/2011 11:10:29 PM  14120 (0x3728)  
    > Progress received for assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4}) UpdatesDeploymentAgent  8/22/2011 11:10:30 PM  14120 (0x3728)  
    > Update (Site_C20CCE23-F877-4170-89AB-ED6F54566E97/SUM_ff0863f8-1e9d-4c0b-91a2-7ef1e2faf357) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0 UpdatesDeploymentAgent  8/22/2011 11:10:30 PM PM  14120 (0x3728)  
    > Update (Site_C20CCE23-F877-4170-89AB-ED6F54566E97/SUM_ca765565-04fb-4ece-b64b-5625983c69d7) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0 UpdatesDeploymentAgent  8/22/2011 11:10:30 PM PM  14120 (0x3728)  
    > Update (Site_C20CCE23-F877-4170-89AB-ED6F54566E97/SUM_8be5dea6-87f2-461b-aabb-22a14de30efb) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0 UpdatesDeploymentAgent  8/22/2011 11:10:30 PM PM  14120 (0x3728)  
    > Update (Site_C20CCE23-F877-4170-89AB-ED6F54566E97/SUM_43742f2a-7256-4fd1-9985-859b3aab0bad) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0 UpdatesDeploymentAgent  8/22/2011 11:10:30 PM PM  14120 (0x3728)  
    > Update (Site_C20CCE23-F877-4170-89AB-ED6F54566E97/SUM_457a20a6-3ae0-4ffc-8e2f-677199d22fdd) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0 UpdatesDeploymentAgent  8/22/2011 11:10:30 PM PM  14120 (0x3728)

1. The assignment {0A650EE8-0DE5-4D82-AED6-947BD72425D4} was started triggering installation at 11:11:18 PM on 8/22/2011, however, it failed and will be retried once the service windows is available:

    > Starting install for assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4}) UpdatesDeploymentAgent 8/22/2011 11:11:18 PM 6676 (0x1A14)  
    > This assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4}) will be retried once the service window is available. UpdatesDeploymentAgent 8/22/2011 11:11:27 PM PM 6676 (0x1A14)

1. The policy for the assignment {0A650EE8-0DE5-4D82-AED6-947BD72425D4} was deleted at 12:14:51 AM on 8/23/2011, however, this time the assignment {0A650EE8-0DE5-4D82-AED6-947BD72425D4} has already been triggered. Refer to step 3.

    > OnPolicyDelete for assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4})... UpdatesDeploymentAgent 8/23/2011 12:14:51 AM 10356 (0x2874)

1. Once the maintenance delete event was received in the client side (at 12:12:46 AM on 8/23/2011), the assignment {0A650EE8-0DE5-4D82-AED6-947BD72425D4} was finished downloading and it has been triggered installation, the assignment will be installed immediately once the maintenance window was removed (at 12:12:50 AM on 8/23/2011) for the policy for the assignment that was deleted (at 12:14:51 AM on 8/23/2011).

> Starting install for assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4}) UpdatesDeploymentAgent 8/23/2011 12:12:50 AM 7276 (0x1C6C)  
> Policy object for assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4}) not found. UpdatesDeploymentAgent 8/23/2011 12:12:51 AM 7276 (0x1C6C)  
> Policy object for assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4}) not found. UpdatesDeploymentAgent 8/23/2011 12:12:51 AM 7276 (0x1C6C)  
> Policy object for assignment ({0A650EE8-0DE5-4D82-AED6-947BD72425D4}) not found. UpdatesDeploymentAgent 8/23/2011 12:12:51 AM 7276 (0x1C6C)

## Cause

The problem occurs because the maintenance window is removed after the computers are removed from the collection.

If the assignment was downloaded successfully and was triggered, then once the maintenance window was removed before the policy of assignment was deleted, the assignment will still be installed. It means that there were two important policies that arrived at the ConfigMgr 2007 client in this issue after removing the computers from the collection:

- **Maintenance Window delete**
- **Assignment policy delete**

The reason why the issue occurred is that the **Maintenance Window delete** policy arrived before the **Assignment policy delete** policy. Based on current ConfigMgr 2007 design, the program policy deletion isn't prioritized over maintenance window policy deletion because the policies were evaluated and applied one by one and there is no priority flag in the policies.  

## Resolution

This behavior is by design in ConfigMgr 2007.

## More information

In the current version of ConfigMgr 2007, we need to pay attention when moving computers between collections that have a maintenance window setting because the maintenance window setting means that the computers cannot perform change outside of the maintenance window.

It's recommended that administrators follow the best practice of naming the collections in a specific manner (such as `MW-<window name>`), then the administrator know the collections that have a maintenance window and thus will not remove operations outside of the Maintenance window.

For more information, see [Best Practice Recommendations](/previous-versions/system-center/configuration-manager-2007/bb694295(v=technet.10)#best-practice-recommendations).
