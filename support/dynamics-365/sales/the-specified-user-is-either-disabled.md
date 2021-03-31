---
title: Error when trying to save a record in Microsoft Dynamics CRM
description: Provides a solution to an error that occurs when trying to save a record in Microsoft Dynamics CRM.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# "The specified user is either disabled or is not a member of any business unit" error when trying to save a record in Microsoft Dynamics CRM

This article provides a solution to an error that occurs when trying to save a record in Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2755914

## Symptoms

Error displays when trying to save a record in Microsoft Dynamics CRM:
> "The specified user is either disabled or is not a member of any business unit"

## Cause

It can happen when there's a custom plugin installed for the affected entity and the plugin is set to execute under the context of a user that is no longer enabled in the system. For example, there could be a plugin that fires when an Account is saved. The actions performed by the plugin are executed under the context of the user named in the identity of the plugin, not the user that is performing the Save action. If the user named in the execution context of the plugin is disabled, which can cause record saving actions to fail for other users.

## Resolution

Locate the plugins for the affected entity by following the steps outlined below:

1. Open Advanced Find in Dynamics CRM.

2. Change the **Look For** drop down in Advanced Find to: **SDK Message Processing Steps**.

3. Under **SDK Message Processing Steps**, select **Impersonating User field - Contains Data** and select **Results**.

4. Locate the affected entity under the Primary Object Type Code column

5. Check the custom plugin which is installed for the affected entity in the first column.

6. Note the Impersonating User for this custom plugin, and close the Advanced Find window

Check to see if the impersonating user for this custom plugin is disabled in CRM Online by following the steps outlined below:

1. Within the Dynamics CRM web interface, select **Settings**, select **Administration**, select **Users**.

2. Change the view to **Disabled Users**, and check for the user that was listed as the Impersonating User on the plugin.

Enable this disabled user by following the steps outlined below:

1. Select this disabled user.

2. On the ribbon, you'll find **enable** button.

3. select the **enable** button.

## More information

1. You can also find all the custom plugins installed in your CRM Online instance under Settings, click on Customizations, click on Customize the System, and select Plug-in Assemblies.

2. Even the System Administrator will get the same error message.
