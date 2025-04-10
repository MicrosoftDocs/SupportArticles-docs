---
title: Resource Not Found Error When Configuring WhatsApp Channel
description: Solves the Resource not found for the segment error when configuring the WhatsApp channel in Microsoft Dynamics 365 Customer Service or Dynamics 365 Contact Center.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/31/2025
ms.reviewer: parkmermel
ms.custom: sap:WhatsApp via Twilio, DFM
---
# Resource not found error when configuring WhatsApp channel

This article provides guidance on resolving the "A Resource not found for the segment 'msdyn\_UpdatePrivacyTerms'" error that may occur when you configure the WhatsApp channel in Dynamics 365 Customer Service or Dynamics 365 Contact Center.

## Symptoms

When you try to [configure the WhatsApp channel](/dynamics365/customer-service/administer/configure-whatsapp-channel) in Dynamics 365 Customer Service or Dynamics 365 Contact Center, you receive the following error message:

> A Resource not found for the segment 'msdyn\_UpdatePrivacyTerms'.

## Cause

This issue occurs when certain required Omnichannel-related plugins are disabled.

## Resolution

To resolve this issue, follow these steps:

### Step 1: Access the Customization Settings

1. Open the **Dynamics 365 model-driven app**.

2. Navigate to the following path: **Settings** > **Advanced Settings** > **Customizations** > **Customize the System**.

### Step 2: Locate SDK Message Processing Steps

1. Within the **Customize the System** window, expand the left-hand navigation panel.

2. Select **SDK Message Processing Steps** under the **Components** section.

### Step 3: Activate the Required Plugins

1. In the **SDK Message Processing Steps** list, look in the **Name** column to locate the following plugins:

    - **Microsoft.Dynamics.OmnichannelSharedBase.Plugins.PostOperationUpdatePrivacyTermsPlugin**: `msdyn_UpdatePrivacyTerms` of any Entity.
    - **Microsoft.Dynamics.OmnichannelBase.Plugins.PostOperationUpdatePrivacyTermsPlugin**: `msdyn_UpdatePrivacyTerms` of any Entity.

2. Verify the **Status** column for each plugin:

    - If the plugin is disabled, select it by selecting the checkbox next to its name.

    - Select the **Activate** button in the toolbar.

### Step 4: Save and Publish Customizations

1. Once the necessary plugins are activated, select **Save** in the toolbar.

2. Then, select **Publish All Customizations** to apply the changes.
