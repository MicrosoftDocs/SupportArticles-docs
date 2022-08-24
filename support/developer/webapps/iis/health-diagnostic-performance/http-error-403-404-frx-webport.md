---
title: HTTP Error 403 and 404
description: This article provides resolutions for the HTTP Error 403 and 404 errors that occur when accessing WebView or WebPort.
ms.date: 04/17/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.technology: iis-health-diagnostic-performance
---
# HTTP Error 403 - Forbidden or HTTP Error 404 - File Not Found

This article helps you resolve the errors (HTTP Error 403 and 404) that occur when you access WebView or WebPort.

_Original product version:_ &nbsp; Microsoft FRx WebPort  
_Original KB number:_ &nbsp; 965174

## Symptoms

The following errors occur when accessing the FRx WebView or WebPort.

> You are not authorized to view this page (HTTP Error 403 - Forbidden)

Or

> The page cannot be found (HTTP Error 404 - File not found)

These errors occur when accessing the WebView or WebPort.

## Cause

The default document (*default.asp*) in the WebPort virtual directory within Internet Information Services (IIS) is set incorrectly or is missing from the WebPort directory.

## Resolution

On the Web Server, verify the default document setting.

1. Open the IIS (Internet Information Services) Manager.
2. Right-click on the WebPort virtual directory and select **Properties**.
3. Select the **Documents** tab.
4. Select each document and select the **Remove** button.
5. Select the **Add** button.
6. Type *Default.asp* and select **OK**.
7. Select **OK** again to return to the main IIS Console screen.
8. You should now have access to the WebPort site.

Verify that the *default.asp* document exists in the WebPort directory on the server. If that file is missing, contact your FRx support provider to receive a new copy.

- If the WebPort installation doesn't have the latest FRx service pack applied, apply the service pack. Be sure to stop the web service and the FRxPDFSvr process before applying the service pack.

- If WebPort is installed on a Windows Server, verify that ASP pages are enabled on the server. Unless it's selected manually during the installation of Windows Server, Active Server Pages functionality won't be available on the server.

Verify that the application mappings for the .asp and .asa extensions are mapped to *asp.dll*.

1. Open the IIS console (Internet Services Manager).
2. Right-click on the WebPort virtual directory and select **Properties**.
3. Select the **Virtual Directory** tab.
4. Select the **Configuration** button in the **Application Settings** section.
5. On the **Mappings** tab of the **Application Configuration** window, verify that the .asa and .asp extensions are mapped to *asp.dll*. If they are not, correct the mapping.
6. Select **OK**.
