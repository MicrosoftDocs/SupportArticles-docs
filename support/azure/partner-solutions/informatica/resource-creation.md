---
title: Troubleshoot Informatica resource creation in Azure
description: "Learn how to resolve issues when creating Informatica resources in Azure, including permission and user profile requirements."
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution 
ms.date: 08/04/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator or user, I want to resolve issues creating Informatica resources so that I can successfully set up Informatica integration.

---
# Unable to create Informatica resource in Azure

This article helps you resolve common issues encountered when creating Informatica resources in Azure, such as permission errors or missing user profile information.

## Prerequisites

- You must have **Owner** access on the Azure subscription to set up Informatica integration.
- Ensure your user profile in Azure contains all required business information.

## Symptoms

- Error message indicating you are not a subscription owner when creating an Informatica resource.
- Unable to proceed with Informatica resource creation due to missing details in your user profile.

## Cause 1: Not a subscription owner

The Informatica integration must be set up by users who have _Owner_ access on the Azure subscription.

### Solution 1

1. Verify your access level on the Azure subscription.
1. If you do not have **Owner** access, contact your Azure administrator to grant you the required permissions before starting the integration setup.

## Cause 2: Missing details in user profile

User profile needs to be updated with key business information for Informatica resource creation.

### Solution 2

1. In the Azure portal, select **Users** and fill out the required details.

    :::image type="content" source="media/user.png" alt-text="User resource provider in the Azure portal.":::

1. Search for your **UserName** in the users interface.

    :::image type="content" source="media/user-search.png" alt-text="Searching for user in the Azure portal.":::

1. Edit **UserInformation** and ensure all required fields are completed.

    :::image type="content" source="media/user-info.png" alt-text="User information in the Azure portal.":::

