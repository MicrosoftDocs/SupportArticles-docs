---
title: Add an HTTP response header to a web site
description: Explains how to add a custom HTTP response header to a Web site that's hosted by Internet Information Services (IIS).
ms.date: 03/27/2020
ms.custom: sap:Development
ms.topic: how-to
ms.subservice: development
---
# Add a custom HTTP response header to a web site that is hosted by IIS

This article discusses how to add a custom HTTP response header to a web site that's hosted by IIS. This header may apply to a site, or an application.

_Original product version:_ &nbsp; Internet Information Services 7.0  
_Original KB number:_ &nbsp; 954002

## Add custom HTTP response header in IIS 7.0

To add a custom HTTP response header at the web site level in IIS 7.0 on a Windows Server 2008 computer, follow these steps:

1. Select **Start**, select **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. In the connections pane, expand the node for the server, and then expand **Sites**.
3. Select the web site where you want to add the custom HTTP response header.
4. In the web site pane, double-click **HTTP Response Headers** in the **IIS** section.
5. In the actions pane, select **Add**.
6. In the **Name** box, type the custom HTTP header name.
7. In the **Value** box, type the custom HTTP header value.
8. Select **OK**.

## More information

You can also add custom HTTP response headers at the server level. However, we recommend you use custom headers only on a specific site or application. We don't recommend you use custom headers globally.
