---
title: Troubleshoot Proxy Server Rejects Requests from ARR to Backend Servers
description: Learn how to resolve issues where a proxy server rejects requests directed through it from your ARR to backend servers.
ms.date: 09/30/2025
ms.custom: sap:Application Request and Routing (ARR)\Proxy
ms.reviewer: paulboc, v-shaywood

#customer intent: As a developer, I want resolve issues with a proxy server rejecting requests from ARR to my backend servers. This issue is preventing me from using a proxy server between my ARR server and backend.
---

# Proxy server rejects requests from ARR to backend servers

This article provides troubleshooting guidance for an issue that can occur where a proxy server rejects requests directed through it from your ARR server to backend servers. In this scenario, the proxy server rejects the requests from ARR as incorrectly formatted.

## Symptoms

When your ARR server directs a request to your backend through a proxy server, the proxy server rejects the request with an error message that the request is incorrectly formatted. When the proxy server rejects a request from your ARR server, the ARR server returns an `HTTP 400 Bad Request` status code and the error message "Some aspect of the requested URL is incorrect." to the client that initiated the request.

## Cause

A proxy server might reject a request directed from your ARR server if the request uses a relative URL, for example:

```http
/mywebapp/mypage.aspx
```

Per [section 5.3.2 of RFC 7230](https://datatracker.ietf.org/doc/html/rfc7230#section-5.3.2), proxy servers require requests that use absolute ULRs, for example:

```http
http://www.contoso.com/mywebapp/mypage.aspx
```

> [!NOTE]
> Some proxy servers are less strict with their implementation of the RFC specification and do allow requests with relative URLs. This behavior is nonstandard and inconsistent across proxy server implementations.

## Solution

Use the following steps to properly configure your ARR server to direct backend requests through a proxy server:

1. Open the **Internet Information Services (IIS) Manager**.
1. Select your IIS server node from the **Connections** side pane, then select the **Configuration Editor** in the main pane.
   :::image type="content" source="./media/proxy-server-rejects-backend-requests/open-configuration-editor.png" alt-text="Screenshot of the IIS Manager with a server node selected in the Connections pane.":::
1. Inside the Configuration Editor, select the **webFarms** node from the **Section** dropdown to display all configured ARR server farms.
   :::image type="content" source="./media/proxy-server-rejects-backend-requests/configuration-editor-section-dropdown.png" alt-text="Screenshot of the IIS Manager with the Configuration Editor pane open. The Section dropdown in the Configuration Editor is expanded and the webFarms section is selected.":::
1. Select the ellipsis button (...) next to the **(Collection)** field to open the **Collection Editor** window.
   :::image type="content" source="./media/proxy-server-rejects-backend-requests/webfarm-collection-editor-button.png" alt-text="Screenshot of the IIS Manager with the Configuration Editor pane open. The ellipsis button to the right of the (Collection) field is highlighted.":::
1. Select the farm you want to configure in the **Items** pane, its details are displayed in the **Properties** pane.
   :::image type="content" source="./media/proxy-server-rejects-backend-requests/collection-editor-select-farm.png" alt-text="Screenshot of the IIS Manager's Collection Editor window. The first webFarm in the Items pane of the Collection Editor is highlighted":::
1. In the **Properties** pane, navigate to the **applicationRequestRouting** > **protocol** > **proxy** node.
   :::image type="content" source="./media/proxy-server-rejects-backend-requests/collection-editor-proxy-property.png" alt-text="Screenshot of the IIS Manager's Collection Editor window. The proxy node in the Properties pane is highlighted.":::
1. In the **proxy** node input the host and port of the proxy server that ARR should direct backend requests through.
   :::image type="content" source="./media/proxy-server-rejects-backend-requests/collection-editor-proxy-added.png" alt-text="Screenshot of the IIS Manager's Collection Editor window. The proxy node in the Properties pane is set to localhost:8888":::
1. Close the **Collection Editor** window.
1. Select **Apply** in the **Actions** pane of the IIS Manager window to finalize the configuration change.
   :::image type="content" source="./media/proxy-server-rejects-backend-requests/apply-collection-changes.png" alt-text="Screenshot of the IIS Manager's Actions pane. The Apply button is highlighted":::

This configuration update makes your ARR server compliant with the RFC specification for proxy servers.

## Related content

- [Creating a Forward Proxy Using Application Request Routing](/iis/extensions/configuring-application-request-routing-arr/creating-a-forward-proxy-using-application-request-routing)
- [Reverse Proxy with URL Rewrite v2 and Application Request Routing](/iis/extensions/url-rewrite-module/reverse-proxy-with-url-rewrite-v2-and-application-request-routing)
