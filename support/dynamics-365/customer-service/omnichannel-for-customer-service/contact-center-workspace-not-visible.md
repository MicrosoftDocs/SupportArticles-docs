---
title: Contact Center Workspace not Visible
description: Solves an issue where users are unable to see or access the Dynamics 365 Contact Center workspace.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/27/2025
ms.reviewer: bavasude, srubinstein
ms.custom: sap:Licensing, provisioning, and installation, DFM
---
# Contact center workspace not visible

Users may encounter an issue where they are unable to see or access the Dynamics 365 Contact Center workspace, even though they have been assigned the appropriate licenses and roles. This article provides an explanation of the issue and steps to resolve it.

## Symptoms

- Users with Dynamics 365 Contact Center licenses are unable to locate or access the Dynamics 365 Contact Center workspace within the system.
- The workspace does not appear in the Dynamics 365 environment, despite license and role assignment.

## Cause

The Dynamics 365 Contact Center workspace and the Customer Service workspace cannot be used simultaneously within the same Dynamics 365 organization. This limitation prevents the Contact Center workspace from being displayed if the Customer Service workspace is already in use.

## Resolution

To enable the Dynamics 365 Contact Center workspace, follow these steps:

1. Create a new environment:

    - Navigate to the [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/).
    - Select **Environments** from the left-hand menu.
    - Click **+ New** to create a new environment.

2. Deploy the Contact Center app:

    - During the provisioning of the new environment, ensure that you select the **Contact Center** app for deployment.
    - Complete the setup process as prompted.

3. Switch to the new environment:

    - Users who need access to the Dynamics 365 Contact Center workspace should switch to the newly created environment.
    - Ensure that appropriate licenses and roles are assigned within this new environment.

> [!NOTE]
> Existing organizations using the Customer Service workspace cannot simultaneously display the Contact Center workspace. A separate environment is required to use the Contact Center workspace.

## More Information

- [Overview of Contact Center workspace](/dynamics365/contact-center/use/ccw-overview)
- [Overview of the Customer Service workspace application for Dynamics 365 Customer Service](/dynamics365/customer-service/implement/csw-overview?tabs=customerserviceadmincenter)