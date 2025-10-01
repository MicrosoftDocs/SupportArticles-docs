---
title: Troubleshoot Proxy Server Rejects Requests from ARR to Back-End Servers
description: Learn how to resolve issues that cause a proxy server to reject requests directed through it from your ARR to back-end servers.
ms.date: 09/30/2025
ms.custom: sap:Application Request and Routing (ARR)\Proxy
ms.reviewer: paulboc, v-shaywood

#customer intent: As a developer, I want to resolve issues that cause a proxy server to reject requests from an ARR server to my back-end servers. This issue is preventing me from using a proxy server between servers.
---

# Proxy server rejects requests from ARR to back-end servers

This article provides troubleshooting guidance for a scenario in which a proxy server rejects requests that are directed through it from your Application Request Routing (ARR) server to back-end servers. In this scenario, the proxy server rejects the requests from ARR as incorrectly formatted.

## Symptoms

When your ARR server directs a request to your back-end server through a proxy server, the following events occur:

- The proxy server rejects the request and returns an `HTTP 400 Bad Request` status code with an error message that the requested URL is invalid.
- The ARR server returns an `HTTP 400 Bad Request` status code and the following error message to the client that initiated the request:

  > Some aspect of the requested URL is incorrect.

## Cause

A proxy server might reject a request that's directed from your ARR server if the request uses a relative URL. For example:

```http
/mywebapp/mypage.aspx
```

According to [section 5.3.2 of RFC 7230](https://datatracker.ietf.org/doc/html/rfc7230#section-5.3.2), proxy servers require requests that use absolute ULRs. For example:

```http
http://www.contoso.com/mywebapp/mypage.aspx
```

> [!NOTE]
> Some proxy servers are less strict about their implementation of the RFC specification. These servers do allow requests that use relative URLs. However, this behavior is nonstandard and inconsistent across proxy server implementations.

## Solution

To configure your ARR server correctly to direct back-end requests through a proxy server, follow these steps:

1. Start Internet Information Services (IIS) Manager.
1. Select your IIS server node from the **Connections** side pane, then select the **Configuration Editor** in the main pane.

   :::image type="content" source="./media/proxy-server-rejects-backend-requests/open-configuration-editor.png" alt-text="IIS Manager showing a server node as selected in the Connections pane.":::
1. Inside the Configuration Editor, select the **webFarms** node from the **Section** list to display all configured ARR server farms.

   :::image type="content" source="./media/proxy-server-rejects-backend-requests/configuration-editor-section-dropdown.png" alt-text="IIS Manager showing the Configuration Editor pane open. The Section list in the Configuration Editor is expanded and the webFarms section is selected.":::
1. Open the **Collection Editor** window by selecting the ellipsis button (...) to the right of the **(Collection)** field.

   :::image type="content" source="./media/proxy-server-rejects-backend-requests/webfarm-collection-editor-button.png" alt-text="IIS Manager showing the Configuration Editor pane open. The ellipsis button to the right of the (Collection) field is highlighted.":::
1. In the **Collection Editor** window, select the farm that you want to configure from the **Items** pane. Details of the selected farm are displayed in the **Properties** pane.

   :::image type="content" source="./media/proxy-server-rejects-backend-requests/collection-editor-select-farm.png" alt-text="The IIS Manager Collection Editor window showing the first webFarm  highlighted in the Items pane of the Collection Editor.":::
1. In the **Properties** pane, navigate to the **applicationRequestRouting** > **protocol** > **proxy** node.

   :::image type="content" source="./media/proxy-server-rejects-backend-requests/collection-editor-proxy-property.png" alt-text="The IIS Manager's Collection Editor window showing the proxy node highlighted in the Properties pane.":::
1. In the **proxy** node, enter the host and port of the proxy server that ARR should direct back-end requests through.

   :::image type="content" source="./media/proxy-server-rejects-backend-requests/collection-editor-proxy-added.png" alt-text="The IIS Manager's Collection Editor window showing that the proxy node in the Properties pane is set to localhost:8888.":::
1. Close the **Collection Editor** window.
1. In the **Actions** pane of the IIS Manager window, select **Apply** to finalize the configuration change.

   :::image type="content" source="./media/proxy-server-rejects-backend-requests/apply-collection-changes.png" alt-text="The IIS Manager's Actions pane showing the Apply button highlighted":::

This configuration update makes your ARR server compliant with the RFC specification for proxy servers.

## Related content

- [Creating a Forward Proxy Using Application Request Routing](/iis/extensions/configuring-application-request-routing-arr/creating-a-forward-proxy-using-application-request-routing)
- [Reverse Proxy with URL Rewrite v2 and Application Request Routing](/iis/extensions/url-rewrite-module/reverse-proxy-with-url-rewrite-v2-and-application-request-routing)
