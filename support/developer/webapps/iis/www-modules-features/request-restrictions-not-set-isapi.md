---
title: Request Restrictions can't be set for ISAPI
description: This article provides resolutions for the problem where the Request Restrictions functionality not working for Wildcard ISAPI extension.
ms.date: 04/17/2020
ms.custom: sap:WWW Modules and Features\Handler mappings and ISAPI extensions
ms.reviewer: pphadke, wadeh, bariscag
---
# Request Restrictions can't be set for a wildcard ISAPI in IIS

This article helps you resolve the problem where the **Request Restrictions** feature of handler mappings is not available for a Wildcard Internet Server Application Programming Interface (ISAPI) extension on Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2725025

## Symptoms

The **Request Restrictions** functionality of handler mappings cannot be set for a Wildcard ISAPI extension on the current version of IIS. If the **Request Restrictions** are set by editing the IIS configuration and adding the sections `requireAccess` and `resourceType` for the wildcard ISAPI extension handler, you may experience unexpected behavior browsing pages that are not handled by the Wildcard ISAPI extension, such as `StaticFile` handler requests.

The option to add **Request Restrictions** for a Wildcard ISAPI are not available through the IIS Manager.

## Cause

This behavior is by design on the current version of IIS. You cannot add **Request Restrictions** for a Wildcard ISAPI extension on IIS either through the IIS manager or by changing configuration. Adding **Request Restrictions** for a Wildcard ISAPI extension by editing the configuration is not supported on IIS.

## Resolution

You will need to manually perform the checks inside your wildcard ISAPI extension. This is because the feature to add request restrictions for a Wildcard ISAPI is not available on IIS.

For example, if you intend to run your ISAPI extension on IIS and if you would like to deny users who did not have permissions to view a particular file on IIS, you will need to perform those same checks manually in your wildcard ISAPI extension and deny users.
