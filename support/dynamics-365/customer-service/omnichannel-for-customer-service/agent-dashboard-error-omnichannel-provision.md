---
title: Agent dashboard shows authentication error after provisioning Omnichannel for Customer Service
description: Provides a resolution for the authentication error that occurs on the agent dashboard after provisioning Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: vamullap
ms.date: 05/23/2023
---
# An authentication error occurs on the agent dashboard after Omnichannel for Customer Service is provisioned

This article provides a resolution for the issue where the agent dashboard displays an authentication error after you provision Omnichannel for Customer Service.

## Symptoms

The following error message is displayed on the agent dashboard after provisioning Omnichannel for Customer Service:

> Something went wrong while authenticating—please try again. If this continues, have your administrator contact Microsoft Support with the client session ID.

## Cause

The issue occurs when you rename the org URL but don't update the channel URL after you've provisioned Omnichannel for Customer Service.

## Resolution

To resolve this issue,

1. Go to [Power Apps](https://make.powerapps.com).
2. On the left pane, select **Apps**, and then from the applications list, select **Omnichannel for Customer Service**.
3. Select the ellipsis (**...**) button, scroll down the list, and select **App profile manager**.
4. Select an admin app, like Customer Service admin center, and then select **Channel provider**. The **Active Channel Providers** list is displayed.
5. Do the following steps:

   1. Make sure that the omnichannel channel provider record is listed and is in the active state. If the omnichannel record isn't active, select the record and then select **Activate** on the menu bar.
   2. On the **General** tab of the omnichannel record, make sure that the **Channel URL** field includes the org information as shown in the following example:

      `https://oc-cdn-ocprod.azureedge.net/convcontrol/ChatControl.htm?uci=true&clientName=zfp&cloudType=Public&env=prod&ocBaseUrl=https://org749544d7-crm.omnichannelengagementhub.com&ucilib=https:// <org>.crm.dynamics.com/webresources/Widget/msdyn_ciLibrary.js`
