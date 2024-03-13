---
title: Fatal error during installation error when installing Integration Manager
description: This article gives steps on how to resolve the Integration Manger for Microsoft Dynamics GP error messages.
ms.reviewer: theley, dlanglie
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Fatal error during installation" error when installing Integration Manager for Microsoft Dynamics GP 10.0

This article provides a resolution for the issue that an error may occur when you install Integration Manager for Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 970850

## Symptoms

When you install Integration Manager for Microsoft Dynamics GP 10.0, you receive the following error message.

> Fatal error during installation

or

> Property 'SQL_Server_Name' not found.

## Cause

The cause of this error message is a bad instance of Microsoft Dynamics GP. Integration Manager is looking for the Dynamics GP instance during the installation and if the registry is incorrect and Integration Manager cannot find the Dynamics GP instance these errors can be returned.

## Resolution

To resolve the issue, a repair must be done on the Microsoft Dynamics GP 10.0 install. If the Dynamics GP repair does not work, complete a support request with the system team as the Dynamics GP install must be corrected before Integration Manager will be able to be installed.

As soon as the Dynamics GP install is corrected, try the Integration Manager install again.
