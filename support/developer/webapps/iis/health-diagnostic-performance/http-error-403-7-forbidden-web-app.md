---
title: HTTP error 403.7 when you run applications
description: This article discusses where an HTTP Error 403.7 - Forbidden error occurs when you run a Web application that is hosted on a server that is running IIS 7.0, and provides resolutions.
ms.date: 03/27/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.technology: health-diagnostic-performance
---
# HTTP error 403.7 when you run a web application that's hosted on a server that is running IIS 7.0

This article helps you resolve the problem where **HTTP Error 403.7** may be thrown when you run a web application that is hosted on a server that is running Microsoft Internet Information Services (IIS) 7.0.

_Original product version:_ &nbsp; Internet Information Services 7.0  
_Original KB number:_ &nbsp; 942067

## Symptoms

When you try to run a Web application that is hosted on a server that is running IIS 7.0, you may receive the following error message:

> Server Error in Application "**ApplicationName**"  
> HTTP Error 403.7 - Forbidden  
> HRESULT: 0x80070005  
> Description of HRESULT The page you are attempting to access requires your browser to have a Secure Sockets Layer (SSL) client certificate that the Web server recognizes.

## Cause

This problem occurs because the **Require SSL** option is selected. This option appears on the **SSL Settings** page of IIS Manager. When this option is selected, all requests that client computers make to the Web application must use a Secure Sockets Layer (SSL) connection.

Additionally, the **Require** option of the **Client certificates** feature is selected. This option also appears on the **SSL Settings** page of IIS Manager. When this option is selected, all client computers that send requests to the server that is running IIS must have valid client certificates.

To resolve this problem, use one of the following methods.

## Resolution 1: Configure a client certificate on a client computer

The client certificate is issued by a certification authority that is trusted by the server that is running IIS.

## Resolution 2: Change Require option to Accept

If you don't require that users have client certificates to run the Web application, use the **Accept** option instead of the **Require** option of the **Client certificates** feature. You can change this setting on the **SSL Settings** page for the Web application in IIS Manager. To do this, follow these steps:

1. On the computer that is running IIS 7.0, select **Start**, type *inetmgr* in the **Start Search** box, right-click **Inetmgr** in the **Programs** list, and then select **Run as administrator**.

    If you're prompted for an administrator password or for a confirmation, type your password, or select **Continue**.
2. In IIS Manager, locate the Web application for which you want to change the SSL setting.
3. In **Features View**, double-click **SSL Settings**.
4. On the **SSL Settings** page, select the **Accept** option under **Client certificates**.
5. In the **Actions** pane, select **Apply**.
