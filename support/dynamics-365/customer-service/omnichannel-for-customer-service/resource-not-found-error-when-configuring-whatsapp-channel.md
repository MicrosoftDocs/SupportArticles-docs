---
title: Resource not found error when configuring WhatsApp channel
description: Solves the error "A Resource not found for the segment" when configuring the WhatsApp channel in Dynamics 365 Customer Service or Contact Center.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/27/2025
ms.reviewer: parkmermel
ms.custom: sap:WhatsApp via Twilio, DFM
---
# Resource not found error when configuring WhatsApp channel

This article provides guidance on resolving the error "A Resource not found for the segment 'msdyn\_UpdatePrivacyTerms'" that may occur when configuring the WhatsApp channel in Dynamics 365 Customer Service or Contact Center.

## Symptoms

Users attempting to configure the WhatsApp channel in Dynamics 365 Customer Service (Omnichannel) encounter the error message:

> A Resource not found for the segment 'msdyn\_UpdatePrivacyTerms'.

## Cause

This issue occurs when certain required Omnichannel-related plugins are disabled.

## Solution

To resolve this issue, follow these steps:

### Step 1: Access the Customization Settings

1. Open the **Dynamics 365 model-driven app**.

2. Navigate to the following path: **Settings** > **Advanced Settings** > **Customizations** > **Customize the System**.

### Step 2: Locate SDK Message Processing Steps

1. Within the **Customize the System** window, expand the left-hand navigation panel.

2. Select **SDK Message Processing Steps** under the **Components** section.

### Step 3: Activate the Required Plugins

1. In the **SDK Message Processing Steps** list, look in the **Name**column to locate the following plugins:

    - **Microsoft.Dynamics.OmnichannelSharedBase.Plugins.PostOperationUpdatePrivacyTermsPlugin**: msdyn_UpdatePrivacyTerms of any Entity.

    - **Microsoft.Dynamics.OmnichannelBase.Plugins.PostOperationUpdatePrivacyTermsPlugin**: msdyn_UpdatePrivacyTerms of any Entity.

2. Verify the **Status**column for each plugin:

    - If the plugin is disabled, select it by clicking the checkbox next to its name.

    - Click the **Activate** button in the toolbar.

### Step 4: Save and Publish Customizations

1. Once the necessary plugins are activated, click **Save** in the toolbar.

2. Then, click **Publish All Customizations** to apply the changes.
