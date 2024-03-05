---
title: Changes to Deployment Type are deployed unexpectedly
description: Describes a behavior that Deployment Type changes are deployed unexpectedly and can't be rolled back.
ms.date: 12/05/2023
ms.reviewer: kaushika, ErinWi, prakask, keiththo
---
# Changes to the Deployment Type are deployed unexpectedly and cannot be rolled back

This article describes a behavior that Deployment Type changes are deployed unexpectedly and can't be rolled back in Microsoft System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2683900

## Symptoms

Consider the following scenario in System Center 2012 Configuration Manager:

- User A is an administrator who is granted the Application Editor role.
- User B is an administrator who is granted the Application Deployment role.
- User A creates an application and adds requirements, dependencies, and so on. Because User A is an Application Editor, the user cannot deploy the application.
- User B, as an administrator in the Application Deployment role, finds the application that User A created. User B deploys the application for immediate installation to a collection of devices or of users.
- User A makes changes to the Deployment Type for the application.

In this scenario, clients that don't already have the original Deployment Type installed will have the new Deployment Type installed according to the configured schedule. However, you may expect that the new Deployment Type would not be automatically deployed without additional steps being followed by User B, the administrator in the Application Deployment role. Additionally, User B cannot roll back the changes to the Deployment Type for the application.

The new Deployment Type doesn't automatically deploy to clients for which the original Deployment Type was installed successfully. This is confirmed by the Detection Method logic for the Deployment Type. If the Detection Method logic for the Deployment Type does not find that the application is installed, a reinstallation by using the latest revision of the Deployment Type will be tried on the client. The Detection Method logic is reevaluated per the compliance evaluation schedule that is configured in the compliance settings of the client settings that apply to the client device. This occurs regardless of whether the Deployment Type has changed.

## Status

This behavior is by design. Changes to applications and Deployment Types that are already deployed to clients should be carefully coordinated in this scenario.
