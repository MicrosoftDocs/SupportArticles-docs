---
title: Communication panel doesn't load in Omnichannel for Customer Service
description: Provides a resolution for the issue where the communication panel doesn't load in Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: yangao
ms.date: 05/23/2023
---
# Communication panel doesn't load in Omnichannel for Customer Service

This article provides a resolution for the issue where the communication panel doesn't load in the Omnichannel for Customer Service app.

## Symptoms

The communication panel doesn't load in the Omnichannel for Customer Service app.

## Cause

The panel doesn't load when:

- A record doesn't exist in the Channel Integration Framework app.
- Configurations don't sync.

## Resolution

To solve this issue:

- Create a Channel Integration Framework record with the following values.

   | Field | Value |
   |-------------------------------------------|--------------------------------------------------|
   | **Name** | Omnichannel |
   | **Label** | Omnichannel |
   | **Channel URL** | \<Chat control cdn url>?uci=true&env=`<env>`&ocBaseUrl=\<oc endpoint\>&ucilib=\<crm org url\>/webresources/Widget/msdyn_ciLibrary.js |
   | **Enable Outbound Communication** | No |
   | **Channel Order** | 0 |
   | **API Version** | 1.0 |
   | **Select Unified Interface Apps for the Channel** | Omnichannel for Customer Service |
   | **Select the Roles for the Channel** | <li>Omnichannel administrator</li> <li>Omnichannel agent</li> <li>Omnichannel supervisor</li> |

   To learn how to create a record, see [Configure a channel provider for your Dynamics 365 organization](/dynamics365/customer-engagement/developer/channel-integration-framework/configure-channel-provider-channel-integration-framework).

- To sync the configurations, remove the channel and roles, add them again, and save the record.

   1. Sign in to the Dynamics 365 apps.
   2. Select the dropdown button on Dynamics 365 and select **Channel Integration Framework**.
   3. Select the **Omnichannel** record from the list.
   4. Remove **Omnichannel for Customer Service** from the **Select Unified Interface Apps for the Channel** section.
   5. Add **Omnichannel for Customer Service** again in the **Select Unified Interface Apps for the Channel** section.
   6. Remove **Omnichannel agent**, **Omnichannel supervisor**, and **Omnichannel administrator** from the **Select the Roles for the Channel** section.
   7. Add **Omnichannel agent**, **Omnichannel supervisor**, and **Omnichannel administrator** again in the **Select the Roles for the Channel** section.
   8. Select **Save** to save the record.
   9. Sign in to the Omnichannel for Customer Service app and check whether the communication panel loads.
