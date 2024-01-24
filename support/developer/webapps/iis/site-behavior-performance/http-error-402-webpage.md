---
title: HTTP Error 404.2 when you visit a web page
description: This article describes a problem where you might receive an error message when you try to visit a web page that is hosted on IIS 7.0.
ms.date: 03/31/2020
ms.custom: sap:Site behavior and performance
ms.reviewer: cochen
ms.technology: site-behavior-performance
---
# HTTP Error 404.2 when you visit a web page that is hosted on a computer that is running IIS 7.0

This article helps you resolve the problem where an unexpected error may be thrown when you visit a web page that is hosted on a computer that is running Internet Information Services (IIS) 7.0.

_Original product version:_ &nbsp; Internet Information Services 7.0  
_Original KB number:_ &nbsp; 942040

## Symptoms

When you try to visit a Web page that is hosted on a computer that is running IIS 7.0, you may receive the following error message:

> Server Error in Application "**application name**"  
> HTTP Error 404.2 - Not Found
> HRESULT: 0x800704ec  
> Description of HRESULT: The page you are requesting cannot be served because of the ISAPI and CGI Restriction list settings on the Web server.

## Cause

This issue occurs because the requested Internet Server API (ISAPI) resource or the requested Common Gateway Interface (CGI) resource is restricted on the computer that is running IIS 7.0.

## Resolution

To resolve this issue, configure the restriction on the **ISAPI and CGI Restrictions** page to allow the requested ISAPI resource or the requested CGI resource. Follow these steps to resolve this issue:

1. Select **Start**, type **Inetmgr** in the **Start Search** box, and then select **Inetmgr** in the **Programs** list.

    If you're prompted for an administrator password or for confirmation, type the password, or select **Continue**.
2. Locate the level that you want to configure.
3. In **Features** view, double-click **ISAPI and CGI Restrictions**.
4. Right-click the restriction that restricts the requested ISAPI resource or the requested CGI resource, and then select **Allow**.
