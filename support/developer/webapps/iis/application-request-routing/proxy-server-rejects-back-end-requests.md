---
title: Troubleshoot Proxy Server Rejects Requests from ARR to Back-End Servers
description: Learn how to resolve issues that cause a proxy server to reject requests directed through it from your ARR to back-end servers.
ms.date: 09/30/2025
ms.custom: sap:Application Request and Routing (ARR)\Proxy
ms.reviewer: paulboc, v-shaywood

#customer intent: As a developer, I want to resolve issues that cause a proxy server to reject requests from an ARR server to my back-end servers. This issue is preventing me from routing requests to back-end servers on different networks than my ARR server.
---

# Proxy server rejects requests from ARR to back-end servers

This article provides troubleshooting guidance for a scenario in which a proxy server is placed between an Application Request Routing (ARR) server and its back-end servers. The ARR server acts as a load balancer. The back-end servers comprise the ARR server farm that the ARR module is routing requests to. In this scenario, the proxy server might reject the requests from ARR as incorrectly formatted.

## Symptoms

When your ARR server routes a request to a back-end server that's on a different network, the request might have to transit through a proxy server to reach the other network. When the proxy server processes the request to be routed to the back-end servers in the ARR farm, the following events occur:

- The proxy server rejects the request and returns an `HTTP 400 Bad Request` status code together with an error message that states that the requested URL is invalid.
- When the ARR server receives the `HTTP 400 Bad Request` status code from the proxy server, it returns the same `HTTP 400 Bad Request` status code. It also returns the following error message to the client that initiated the request:

  > Some aspect of the requested URL is incorrect.

## Cause

> [!IMPORTANT]
> Some proxy servers are less strict about their implementation of the RFC specification. You might not experience rejected requests from these servers, even if you don't add the proxy server to your ARR configuration. However, this behavior is nonstandard and subject to change across proxy server implementations.

When your ARR server routes a request to a back-end server on the same network, the ARR server can reach the back-end server directly, as shown in the following screenshot.

:::image type="content" source="./media/proxy-server-rejects-back-end-requests/normal-network-layout.png" alt-text="Network diagram of the typical ARR and back-end server configuration when on the same network":::

However, if your back-end server is on a different network than your ARR server, your ARR server might have to route requests to the back-end server through a proxy server, as shown in the following screenshot.

:::image type="content" source="./media/proxy-server-rejects-back-end-requests/proxy-network-layout.png" alt-text="Network diagram of the ARR and back-end server configuration when on a different network, using a proxy server to transit request between networks":::

When your ARR server routes a request through a proxy server, the proxy server can reject the request if it uses a relative URL. For example:

```http
/mywebapp/mypage.aspx
```

According to [section 5.3.2 of RFC 7230](https://datatracker.ietf.org/doc/html/rfc7230#section-5.3.2), proxy servers require requests that use absolute ULRs. For example:

```http
http://www.contoso.com/mywebapp/mypage.aspx
```

Some proxy servers allow requests that use relative URLs, but this behavior is an inconsistent across different proxy servers. In all cases, we recommend that you configure your ARR server to properly route requests through the proxy server according to the steps in [Solution](#solution).

## Solution

To configure your ARR server to correctly direct back-end requests through a proxy server, follow these steps:

1. Start Internet Information Services (IIS) Manager.
1. Select your IIS server node from the **Connections** side pane, then select **Configuration Editor** in the main pane.

   :::image type="content" source="./media/proxy-server-rejects-back-end-requests/open-configuration-editor.png" alt-text="IIS Manager showing a server node as selected in the Connections pane.":::
1. Inside Configuration Editor, select the **webFarms** node from the **Section** list to display all configured ARR server farms.

   :::image type="content" source="./media/proxy-server-rejects-back-end-requests/configuration-editor-section-dropdown.png" alt-text="IIS Manager showing the Configuration Editor pane open. The Section list in the Configuration Editor is expanded and the webFarms section is selected.":::
1. Open the **Collection Editor** window by selecting the ellipsis button (...) to the right of the **(Collection)** field.

   :::image type="content" source="./media/proxy-server-rejects-back-end-requests/web-farm-collection-editor-button.png" alt-text="IIS Manager showing the Configuration Editor pane open. The ellipsis button to the right of the (Collection) field is highlighted.":::
1. In the **Collection Editor** window, select the farm that you want to configure from the **Items** pane. Details of the selected farm are displayed in the **Properties** pane.

   :::image type="content" source="./media/proxy-server-rejects-back-end-requests/collection-editor-select-farm.png" alt-text="The IIS Manager Collection Editor window showing the first webFarm as highlighted in the Items pane of the Collection Editor.":::
1. In the **Properties** pane, navigate to the **applicationRequestRouting** > **protocol** > **proxy** node.

   :::image type="content" source="./media/proxy-server-rejects-back-end-requests/collection-editor-proxy-property.png" alt-text="The IIS Manager Collection Editor window showing the proxy node as highlighted in the Properties pane.":::
1. In the **proxy** node, enter the host and port of the proxy server that ARR should direct back-end requests through.

   :::image type="content" source="./media/proxy-server-rejects-back-end-requests/collection-editor-proxy-added.png" alt-text="The IIS Manager Collection Editor window showing that the proxy node in the Properties pane is set to localhost:8888.":::
1. Close the **Collection Editor** window.
1. In the **Actions** pane of the IIS Manager window, select **Apply** to finalize the configuration change.

   :::image type="content" source="./media/proxy-server-rejects-back-end-requests/apply-collection-changes.png" alt-text="The IIS Manager Actions pane showing the Apply button as highlighted":::

This configuration update makes your ARR server compliant with the RFC specification for proxy servers.

## Related content

- [Creating a Forward Proxy Using Application Request Routing](/iis/extensions/configuring-application-request-routing-arr/creating-a-forward-proxy-using-application-request-routing)
- [Reverse Proxy with URL Rewrite v2 and Application Request Routing](/iis/extensions/url-rewrite-module/reverse-proxy-with-url-rewrite-v2-and-application-request-routing)
