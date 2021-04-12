---
title: Unable to integrate Yammer
description: This article provides a resolution for the problem where you are unable to integrate Yammer with Microsoft Dynamics CRM 2011 Online.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to integrate Yammer with Microsoft Dynamics CRM 2011 Online

This article helps you resolve the problem where you are unable to integrate Yammer with Microsoft Dynamics CRM 2011 Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2852087

## Symptoms

During the integration setup, a user will go through the following steps:

1. Click on **Administration** tab in CRM Online.
2. Click on **Yammer Configuration**.
3. Agree to the terms and conditions.
4. Once the terms and conditions are accepted, the user will be asked to authorize his Yammer account.
5. After clicking on **Authorize Microsoft Dynamics CRM Online to connect to Yammer**, the user will get the following error:

   > An error has occurred. Try this action again. If the problem continues, check the Microsoft Dynamics CRM Community for solutions or contact your organization's Microsoft Dynamics CRM Administrator. Finally, you can contact Microsoft Support

## Cause

In the Yammer portal, Third Party Applications checkbox was unchecked under the Enabled Features area of the Admin tab.

## Resolution

1. Log into the Yammer portal as Yammer Network Administrator.  
2. Click on the **Admin** tab.  
3. Under **Enabled Features**, select **Third Party Applications**.  
4. Check the **Checkbox** for **Third Party Applications**.
5. Save the settings.

## More information

Even the System Administrator of CRM Online will get the same error message if this is unmarked.
