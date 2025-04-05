---
title: Contact Center Workspace not Visible
description: Solves an issue where users are unable to see or access the Dynamics 365 Contact Center workspace.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/31/2025
ms.reviewer: bavasude, srubinstein
ms.custom: sap:Licensing, provisioning, and installation, DFM
---
# Dynamics 365 Contact Center workspace isn't visible

Users may encounter an issue where they're unable to see or access the Dynamics 365 Contact Center workspace, even though they have been assigned the appropriate licenses and roles. This article provides an explanation of the issue and steps to resolve it.

## Symptoms

Users with Dynamics 365 Contact Center licenses are unable to locate or access the Dynamics 365 Contact Center workspace within the system. And the workspace doesn't appear in the Dynamics 365 environment, despite license and role assignment.

## Cause

The Dynamics 365 Contact Center workspace and the Customer Service workspace can't be used simultaneously within the same Dynamics 365 organization. This limitation prevents the Contact Center workspace from being displayed if the Customer Service workspace is already in use.

## Resolution

> [!NOTE]
> Existing organizations using the Customer Service workspace can't simultaneously display the Contact Center workspace. A separate environment is required to use the Contact Center workspace.

To enable the Dynamics 365 Contact Center workspace, follow these steps:

1. Create a new environment:

    - Navigate to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
    - Select **Environments** on the left navigation pane.
    - Select **+ New** to create a new environment.

2. Deploy the Contact Center app:

    - During the provisioning of the new environment, ensure that you select the **Contact Center** app for deployment.
    - Complete the setup process as prompted.

3. Switch to the new environment:

    - Users who need access to the Dynamics 365 Contact Center workspace should switch to the newly created environment.
    - Ensure that appropriate licenses and roles are assigned within this new environment.

## More information

- [Overview of Contact Center workspace](/dynamics365/contact-center/use/ccw-overview)
- [Overview of the Customer Service workspace application for Dynamics 365 Customer Service](/dynamics365/customer-service/implement/csw-overview?tabs=customerserviceadmincenter)
