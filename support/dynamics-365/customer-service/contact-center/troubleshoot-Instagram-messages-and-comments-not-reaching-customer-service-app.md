---
author: srreddy
ms.author: srreddy
ms.service: dynamics-365-customer-service
ms.topic: troubleshooting-general
ms.date: 03/20/2025
title: Troubleshoot Instagram messages and comments not reaching customer service app
description: Troubleshoot Instagram messages and comments not reaching customer service app
---
# Troubleshoot Instagram messages and comments not reaching customer service app

This article addresses the issue where Instagram messages and comments, as well as Facebook comments, are not being received in the Dynamics 365 Customer Service application, despite the Facebook account being added and permissions enabled in the Meta developer app.

## Prerequisites

Ensure the following before proceeding:

- You have added your Facebook account and enabled permissions in the Meta developer app.
- You are familiar with Dynamics 365 Customer Service application features.

## Potential quick workarounds

### Workaround: Check current supported social channels

Instagram is not supported as a social channel for chat in Dynamics 365 Customer Service applications by default. Verify the supported channels for integration.

1. Navigate to the Dynamics 365 Customer Service documentation to confirm supported social channels.
2. If Instagram is not listed, consider alternative options such as custom channel creation.

## Troubleshooting checklist

### Verify prerequisites

1. Confirm that the Facebook account has been added correctly to the Customer Service application.
2. Ensure permissions in the Meta developer app are properly configured.

### Check for official Instagram integration

1. Visit the Dynamics 365 Customer Service ideas portal to check for updates on Instagram integration: [Idea Portal](https://experience.dynamics.com/ideas/idea/?ideaid=9d2da859-15b3-eb11-89ee-0003ff45921e).
2. Review the status of the open idea for introducing Instagram as a supported channel.

## Cause: Instagram not supported by default

Instagram is not currently supported as a social channel for chat in Dynamics 365 Customer Service applications. This limitation is due to the lack of an out-of-the-box (OOB) integration for Instagram messaging and comments.

### Solution: Explore alternative options

1. Follow updates on the open idea for Instagram integration to see if future improvements are made.
    - Access the idea portal: [Idea Portal](https://experience.dynamics.com/ideas/idea/?ideaid=9d2da859-15b3-eb11-89ee-0003ff45921e).
2. Create a custom channel to integrate Instagram messaging with Dynamics 365 Customer Service applications. Detailed steps can be found here: [Configure custom messaging channels | Microsoft Learn](/dynamics365/customer-service/administer/configure-custom-channel).

## Advanced troubleshooting and data collection

If you encounter issues while setting up a custom channel or need further assistance:

1. Gather error logs or screenshots related to the issue.
2. Contact Microsoft Support, providing details about the problem and actions taken. Include the collected data for faster resolution.

By following the steps above, you can determine the cause of the issue and explore available solutions to integrate Instagram messaging with Dynamics 365 Customer Service applications.