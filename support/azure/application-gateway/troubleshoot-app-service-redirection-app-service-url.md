---
title: Troubleshoot Azure App Service redirects
titleSuffix: Azure Application Gateway
description: Troubleshoot Azure App Service redirects in Azure Application Gateway to preserve URLs, cookies, and session affinity. Follow these steps to resolve common issues.
services: application-gateway
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 09/02/2026
ms.custom: sap:Configuration and Setup
# Customer intent: "As a network engineer, I want to troubleshoot redirection problems between Azure Application Gateway and App Service, so that I can ensure proper URL handling and session affinity in my web applications."
---

# Troubleshoot Azure App Service redirection problems in Application Gateway

## Summary

Learn how to diagnose and resolve Azure App Service redirection problems when App Service is used as a backend target with Azure Application Gateway.

## Overview

In this article, you learn how to troubleshoot the following problems, as described in more detail in Architecture Center: [Preserve the original HTTP host name between a reverse proxy and its backend web application](/azure/architecture/best-practices/host-name-preservation#potential-issues).

This list of problems isn't exhaustive, but it covers the most common issues that can occur when Application Gateway is used as a reverse proxy for App Service:

- [Incorrect absolute URLs](/azure/architecture/best-practices/host-name-preservation#incorrect-absolute-urls)
- [Incorrect redirect URLs](/azure/architecture/best-practices/host-name-preservation#incorrect-redirect-urls)  
  - The app service URL is exposed in the browser when there's a redirection. For example, an OpenID Connect (OIDC) authentication flow is broken because of a redirect with the wrong hostname. This problem includes the use of [App Service Authentication and Authorization](/azure/app-service/overview-authentication-authorization).
- [Broken cookies](/azure/architecture/best-practices/host-name-preservation#broken-cookies)
  - Cookies aren't propagated between the browser and the App Service. For example, the app service ARRAffinity cookie domain is set to the app service host name and is tied to `example.azurewebsites.net` instead of the original host. As a result, session affinity is broken.

The root cause for these problems is a setup that overrides the hostname as used by Application Gateway towards App Service into a different hostname as is seen by the browser. Often the hostname is overridden to the default App Service `azurewebsites.net` domain.

:::image type="content" source="media/troubleshoot-app-service-redirection-app-service-url/root-cause-application-gateway-to-azure-app-service-default-domain.png" alt-text="Screenshot of Application Gateway overriding the host name to the azurewebsites.net App Service domain." lightbox="media/troubleshoot-app-service-redirection-app-service-url/root-cause-application-gateway-to-azure-app-service-default-domain.png":::

## Sample configuration

If your configuration matches one of following two situations, your setup aligns with the instructions in this article.

- **Pick Hostname from Backend Address** is enabled in **HTTP Settings**.
- **Override with specific domain name** is set to a value different from what the browser request has.

### Cause

App Service is a multitenant service, so it uses the host header in the request to route the request to the correct endpoint. The default domain name of App Services, `*.azurewebsites.net` (like `contoso.azurewebsites.net`), is different from the application gateway's domain name (like `contoso.com`). The backend App Service is missing the required context to generate redirect URLs or cookies that align with the domain as seen by the browser.

### Solution

Configure Application Gateway and App Service to not override the hostname. Follow the instructions for **"Custom Domain (recommended)"** in [Configure App Service with Application Gateway](/azure/application-gateway/configure-web-app).

Only consider applying the following workaround (a rewrite of the location header as described in the next section) after assessing the implications as described in [Preserve the original HTTP host name between a reverse proxy and its backend web application](/azure/architecture/best-practices/host-name-preservation). These implications include the potential for domain-bound cookies and for absolute URLs outside of the location header to remain broken.

### Workaround - Rewrite the location header

> [!WARNING]
> This configuration comes with limitations. Review the implications of using different host names between the client and Application Gateway and between Application Gateway and App Service in the backend. For more information, review [Preserve the original HTTP host name between a reverse proxy and its backend web application](/azure/architecture/best-practices/host-name-preservation).

Set the host name in the location header to the application gateway's domain name. To do this, create a [rewrite rule](/azure/application-gateway/rewrite-http-headers-url) with a condition that evaluates if the location header in the response contains `azurewebsites.net`. It must also perform an action to rewrite the location header to have the application gateway's host name. For more information, see [how to rewrite the location header](/azure/application-gateway/rewrite-http-headers-url#modify-a-redirection-url).

> [!NOTE]
> HTTP header rewrite support is only available for the [Standard_v2 and WAF_v2 SKU](/azure/application-gateway/application-gateway-autoscaling-zone-redundant) of Application Gateway. We recommend [migrating to v2](/azure/application-gateway/migrate-v1-v2) for header rewrite and other [advanced capabilities](/azure/application-gateway/overview-v2#feature-comparison-between-v1-sku-and-v2-sku) that are available with v2 SKU.