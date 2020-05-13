---
title: HTTP Error 403 and 404
description: Describes HTTP Error 403 and 404 errors when accessing WebView or WebPort, provides resolutions.
ms.date: 04/17/2020
ms.prod-support-area-path:
---
# HTTP Error 403 - Forbidden or HTTP Error 404 - File Not Found

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
3. Click the **Documents** tab.
4. Select each document and click the **Remove** button.
5. Click the **Add** button.
6. Type *Default.asp* and click **OK**.
7. Click **OK** again to return to the main IIS Console screen.
8. You should now have access to the WebPort site.

Verify that the *default.asp* document exists in the WebPort directory on the server. If that file is missing, contact your FRx support provider to receive a new copy.

- If the WebPort installation doesn't have the latest FRx service pack applied, apply the service pack. Be sure to stop the web service and the FRxPDFSvr process before applying the service pack.

- If WebPort is installed on a Windows Server, verify that ASP pages are enabled on the server. Unless it's selected manually during the installation of Windows Server, Active Server Pages functionality won't be available on the server.

Verify that the application mappings for the .asp and .asa extensions are mapped to *asp.dll*.

1. Open the IIS console (Internet Services Manager).
2. Right-click on the WebPort virtual directory and select **Properties**.
3. Click the **Virtual Directory** tab.
4. Click the **Configuration** button in the **Application Settings** section.
5. On the **Mappings** tab of the **Application Configuration** window, verify that the .asa and .asp extensions are mapped to *asp.dll*. If they are not, correct the mapping.
6. Click **OK**.
