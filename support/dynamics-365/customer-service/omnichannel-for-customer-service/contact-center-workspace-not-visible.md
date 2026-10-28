---
title: Resolve a Missing Contact Center Workspace
description: Contact Center workspace isn't visible despite appropriate licenses and roles. Learn how to resolve this issue in a separate Dynamics 365 environment.
ai-usage: ai-assisted
ms.date: 10/28/2026
ms.reviewer: bavasude, srubinstein, srreddy, souravbihani, aartigoyle
ms.custom: sap:Licensing, provisioning, and installation, DFM
---
# Dynamics 365 Contact Center workspace isn't visible

## Summary

You might be unable to see or access the Dynamics 365 Contact Center workspace even with the appropriate licenses and roles. This article explains the limitation when the Customer Service workspace is already in use and how to use a separate environment.

## Symptoms

Users with Dynamics 365 Contact Center licenses are unable to locate or access the Dynamics 365 Contact Center workspace within the system. The workspace doesn't appear in the Dynamics 365 environment (for example, in the app selector), despite license and role assignment.

## Cause

The Dynamics 365 Contact Center workspace and the Customer Service workspace can't be used simultaneously within the same Dynamics 365 organization. This limitation is by design and prevents the Contact Center workspace from being displayed if the Customer Service workspace is already in use.

## Solution

> [!NOTE]
> Existing organizations using the Customer Service workspace can't simultaneously display the Contact Center workspace. A separate environment is required to use the Contact Center workspace.

To use the Dynamics 365 Contact Center workspace, follow these steps:

1. Create a new environment.

   1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
   1. In the navigation pane, select **Environments**.
   1. Select **+ New** to create a new environment.

1. Deploy the Contact Center app.

   1. During provisioning of the new environment, select the **Contact Center** app for deployment.
   1. Complete the setup process as prompted.

1. Ensure that users who need access to the Dynamics 365 Contact Center workspace switch to the newly created environment and have the appropriate licenses and roles assigned there.

## Related content

- [Overview of Copilot Service workspace](/dynamics365/contact-center/use/ccw-overview)
- [Overview of the Copilot Service workspace application for Dynamics 365 Customer Service](/dynamics365/customer-service/implement/csw-overview?tabs=customerserviceadmincenter)
