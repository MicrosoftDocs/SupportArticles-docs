---
title: Can't Install Customer Service Apps In Existing Environment
description: Solves an issue where users can't install Dynamics 365 Customer Service applications in an existing Power Platform environment.
ms.reviewer: ghoshsoham
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/17/2025
ms.custom: sap:Core Service Scheduling, DFM
---
# Can't install Dynamics 365 Customer Service applications in an existing Power Platform environment

This article provides guidance for users encountering issues while trying to install Dynamics 365 Customer Service applications, such as the Customer Service workspace and Customer Service admin center model-driven apps, in an existing Power Platform environment.

## Symptoms

Users can't install Dynamics 365 Customer Service applications in an existing Power Platform environment, such as the [Customer Service workspace](/dynamics365/customer-service/implement/csw-overview?tabs=customerserviceadmincenter) and the [Copilot Service admin center (previously known as Customer Service admin center)](/dynamics365/customer-service/implement/cs-admin-center) model-driven applications.

This issue occurs due to one or more of the following reasons:

## Cause 1: The environment is Dataverse-only

- The environment is created as a Dataverse-only environment without enabling Dynamics 365 apps.
- Dynamics 365 applications, such as Customer Service workspace, require the environment to be created with the **Enable Dynamics 365 apps** option selected during the environment setup.
- The **Enable Dynamics 365 apps** option allows the environment to host first-party applications such as Dynamics 365 Sales, Dynamics 365 Customer Service, and Dynamics 365 Marketing.

### Resolution

1. Navigate to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
2. Select the environment where you are trying to install the applications.
3. Go to **Settings** > **Overview**, verify whether the environment is listed as **Dataverse-only** or if Dynamics 365 apps are enabled.

## Cause 2: Missing or incorrect licensing

Users trying to install or access Dynamics 365 applications must have the [appropriate license](/dynamics-365/products/customer-service/pricing) assigned.

### Resolution

1. Go to the [Microsoft 365 admin center](https://admin.microsoft.com/).
2. Select **Users** > **Active users**.
3. Locate and select the user who needs access to the Customer Service applications.
4. Select **Licenses and apps**, and ensure the user has one of the following licenses assigned:

    - Customer Service Professional
    - Customer Service Enterprise
    - Customer Service Premium

5. Save the changes.

## More information

If the current environment isn't configured to support Dynamics 365 applications, follow these steps to create a new environment:

1. Navigate to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
2. Select **+ New environment**.
3. Provide a name and select a region for the new environment.
4. Under **Type**, select **Production** or **Sandbox** as required.
5. Enable Dataverse by selecting the appropriate box.
6. Enable Dynamics 365 apps by selecting the **Enable Dynamics 365 apps** checkbox.
7. Select **Save** and wait for the provisioning process to complete.

Once the environment is successfully set up, the [Customer Service Hub](/dynamics365/customer-service/implement/customer-service-hub-user-guide-basics) and Copilot Service admin center applications will be available in the app list for users with the appropriate licenses.

For more detailed guidance on creating and managing environments, see [Create and manage environments in the Power Platform admin center](/power-platform/admin/create-environment).
