---
title: The specified subscription does not exist error when going offline
description: The specified subscription does not exist - this error occurs when you try to go offline with Microsoft Dynamics CRM for Outlook. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# "The specified subscription does not exist" error when going offline with Microsoft Dynamics CRM for Outlook

This article provides a resolution for the error **specified subscription does not exist** that occurs when you try to go offline with the Microsoft Dynamics CRM for Outlook client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2779306

## Symptoms

When you try to Go Offline with the Microsoft Dynamics CRM for Outlook client, you receive the following error message:

> The specified subscription does not exist

## Cause

When having recently purchased an extra license or extra memory space, this additional license or memory space doesn't get synchronized to the organization immediately with the Microsoft Dynamics CRM Online server. Therefore, it's not displayed under the Subscription Management page in the Microsoft Dynamics CRM Online organization. When trying to configure a new user, they're not getting registered within the subscription table of Microsoft Dynamics CRM, as there are no available subscriptions.

## Resolution

1. Sign in to the Microsoft Dynamics CRM Online organization through the web client.

2. Go to **Settings**, select **System**, select **Administration**, and select **Subscription Management**.

3. Check whether the newly purchased license or the extra memory space is added to the Subscription Management page in the Microsoft Dynamics CRM Online organization. If this doesn't appear, this process can take several minutes to synchronize.

4. Once this appears, follow the steps below:

    1. Remove the configuration for the Microsoft Dynamics CRM for Outlook client and reconfigure.
    2. After reconfiguring, try to Go Offline.

5. Now while going offline, the user can see a line that says, **Registering machine** in the synchronizing window and the sync should continue on without any further issues.
