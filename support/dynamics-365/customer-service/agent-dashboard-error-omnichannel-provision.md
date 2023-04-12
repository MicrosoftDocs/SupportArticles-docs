---
title: Agent dashboard displays authentication error after provisioning Omnichannel for Customer Service
description: Provides a solution to an authentication error that displays on agent dashboard after provisioning Omnichannel for Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# After Omnichannel for Customer Service is provisioned, the agent dashboard displays an authentication error.

This article provides a solution for when the agent dashboard displays an authentication error after you provision Omnichannel for Customer Service

## Symptom

The following error message is displayed on the agent dashboard after provisioning Omnichannel for Customer Service:

**Something went wrong while authenticating—please try again. If this continues, have your administrator contact Microsoft Support with the client session ID.**

## Cause

The issue occurs when you rename the org URL but don’t update the channel URL after you've provisioned Omnichannel for Customer Service.

## Resolution

1. Go to [https://make.powerapps.com](https://make.powerapps.com).

2. On the left pane, select **Apps**, and then from the applications list, select **Omnichannel for Customer Service**. 
3. Select the ellipsis (...) button, scroll down the list, and select **App profile manager**.

4. Select the admin app like Customer Service admin center, and then select **Channel provider**.
   The Active Channel Providers list is displayed.

5. Do the following steps:
    - Make sure that the omnichannel channel provider record is listed and is in the active state. 
     If the omnichannel record isn't active, select the record, and then select **Activate** on the menu bar.
    - On the **General** tab of the omnichannel record, make sure that the **Channel URL** field includes the org information as shown in the following example: <br>
   `https://oc-cdn-ocprod.azureedge.net/convcontrol/ChatControl.htm?uci=true&clientName=zfp&cloudType=Public&env=prod&ocBaseUrl=https://org749544d7-crm.omnichannelengagementhub.com&ucilib=https:// <org>.crm.dynamics.com/webresources/Widget/msdyn_ciLibrary.js`
