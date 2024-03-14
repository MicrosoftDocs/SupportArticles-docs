---
title: The destination could not be initialized
description: Provides a solution to an error that occurs when you try to run an integration in Integration Manager for Microsoft Dynamics GP in a Citrix environment as a published application.
ms.reviewer: theley, dlanglie, grwill
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# You receive an error message when you try to run an integration in Integration Manager for Microsoft Dynamics GP in a Citrix environment as a published application

This article provides a solution to an error that occurs when you try to run an integration in Integration Manager for Microsoft Dynamics GP in a Citrix environment as a published application.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968086

## Symptoms

Consider the following scenario. You run an integration in Integration Manager for Microsoft Dynamics GP in a Citrix environment. Integration Manager and Microsoft Dynamics GP are delivered as a published application in this environment. In this scenario, you may receive an error message. In Integration Manager for Microsoft Dynamics GP 10.0, you receive the following error message:

> The destination could not be initialized due to the following problem: You must start Microsoft Dynamics GP in order to run an Integration.

In Integration Manager for Microsoft Dynamics GP 9.0 and in Integration Manager for Microsoft Business Solutions-Great Plains 8.0, you receive the following error message:

> The destination could not be initialized due to the following problem: Microsoft Business Solutions-Great Plains is not running.

## Cause

This problem occurs when Integration Manager or Microsoft Dynamics GP are delivered to the client desktop as a Citrix published application. Citrix published applications use application streaming technology that streams the application to the client device where it's run in an isolated, virtual environment. Integration Manager must be able to control the Microsoft Dynamics GP client application to work correctly. It can't do it in the isolation environment that is used by the application streaming technology of a Citrix published application.

## Resolution

To resolve this problem, users must connect to a traditional Citrix session where both applications can run in the same terminal session, or you must install both applications on the local computer.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.
