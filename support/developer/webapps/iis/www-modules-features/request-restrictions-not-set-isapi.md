---
title: Request Restrictions can't be set for ISAPI
description: This article provides resolutions for the problem where the Request Restrictions functionality not working for Wildcard ISAPI extension.
ms.date: 12/18/2024
ms.custom: sap:WWW Modules and Features\Handler mappings and ISAPI extensions
ms.reviewer: pphadke, wadeh, bariscag, zixie
---
# Request Restrictions can't be set for a wildcard ISAPI in IIS

This article helps you resolve the problem where the **Request Restrictions** feature of handler mappings isn't available for a Wildcard Internet Server Application Programming Interface (ISAPI) extension on Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2725025

## Symptoms

The **Request Restrictions** functionality of handler mappings can't be set for a Wildcard ISAPI extension on the current version of IIS. If the **Request Restrictions** feature is set by editing the IIS configuration and adding the sections `requireAccess` and `resourceType` for the wildcard ISAPI extension handler, you might experience unexpected behavior when browsing pages that aren't handled by the Wildcard ISAPI extension, such as `StaticFile` handler requests.

The option to add **Request Restrictions** for a Wildcard ISAPI isn't available through the IIS Manager.

## Cause

This behavior is by design on the current version of IIS. You can't add **Request Restrictions** for a Wildcard ISAPI extension on IIS either through the IIS manager or by changing configuration. Adding **Request Restrictions** for a Wildcard ISAPI extension by editing the configuration isn't supported on IIS.

## Resolution

You need to manually perform the checks inside your wildcard ISAPI extension because the feature to add request restrictions for a Wildcard ISAPI isn't available on IIS.

For example, if you intend to run your ISAPI extension on IIS, and if you want to deny users who don't have permissions to view a particular file on IIS, you need to perform those same checks manually in your wildcard ISAPI extension and deny users.
