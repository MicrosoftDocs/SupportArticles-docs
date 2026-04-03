---
title: Troubleshoot session affinity issues
titleSuffix: Azure Application Gateway
description: Troubleshoot session affinity issues in Azure Application Gateway to keep user requests on the same backend server and improve app reliability. Follow the steps now.
services: application-gateway
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 03/27/2026
ms.custom: sap:Routing,sfi-image-nochange
# Customer intent: As a DevOps engineer, I want to diagnose and resolve session affinity issues with application traffic, so that I can ensure consistent user sessions and optimal application performance.
---

# Troubleshoot Azure Application Gateway session affinity problems

## Summary

Learn how to diagnose and resolve session affinity problems with Azure Application Gateway. By keeping users on the same backend server, you can improve application performance.

> [!NOTE]
> Use the Azure Az PowerShell module to interact with Azure. To get started, see [Install Azure PowerShell](/powershell/azure/install-azure-powershell). To learn how to migrate to the Az PowerShell module, see [Migrate Azure PowerShell from AzureRM to Az](/powershell/azure/migrate-from-azurerm-to-az).

## Overview

The cookie-based session affinity feature is useful to keep a user session on the same server. By using gateway-managed cookies, the Application Gateway directs subsequent traffic from a user session to the same server for processing. This feature is important in cases where session state is saved locally on the server for a user session. Session affinity is also known as sticky sessions.

> [!NOTE]
> Application Gateway v1 uses a cookie named ARRAffinity to direct traffic to the same backend pool member. In Application Gateway v2, this cookie is renamed to ApplicationGatewayAffinity. For the purposes of this document, ApplicationGatewayAffinity is used as an example. ARRAffinity can be substituted where applicable for Application Gateway v1 instances.

## Possible problem causes

Problems maintaining cookie-based session affinity can happen for the following reasons:

- You didn't enable the **Cookie-based Affinity** setting.
- Your application can't handle cookie-based affinity.
- Your application uses cookie-based affinity but requests still bounce between backend servers.

### Check whether the "Cookie-based Affinity" setting is enabled

Session affinity problems can occur if you forget to enable the "Cookie based affinity" setting. To check whether you enabled the "Cookie based affinity" setting on the Backend Settings tab in the Azure portal, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com/).

1. In the **left navigation** pane, select **All resources**. Select the application gateway name in the **All resources** blade. If the subscription that you selected already has several resources in it, enter the application gateway name in the **Filter by name…** box to easily access the application gateway.

1. Select the **Backend settings** tab under **SETTINGS**.

   :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-1.png" alt-text="Screenshot of the Azure portal with Settings and Backend settings selected for an Application Gateway." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-1.png":::

1. Select the backend setting. On **Add Backend setting**, check if **Cookie based affinity** is enabled.

   :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-2.png" alt-text="Screenshot of backend settings showing Cookie based affinity selected in Application Gateway." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-2.png":::



To check if the value of the "**CookieBasedAffinity**" is set to *Enabled* under "**backendHttpSettingsCollection**", use one of the following methods:

- Run [Get-AzApplicationGatewayBackendHttpSetting](/powershell/module/az.network/get-azapplicationgatewaybackendhttpsetting) in PowerShell.
- Look through the JSON file by using the Azure Resource Manager template.

```
"cookieBasedAffinity": "Enabled", 
```

### The application can't handle cookie-based affinity

#### Cause

The application gateway can only perform session-based affinity by using a cookie.

#### Workaround

If the application can't handle cookie-based affinity, you must use an external or internal Azure load balancer or another third-party solution.

### Application uses cookie-based affinity but requests still bounce between backend servers

#### Symptom

You enable the cookie-based affinity setting. When you access the Application Gateway by using a short name URL in Internet Explorer, such as `http://website`, the request still bounces between backend servers.

To identify this problem, follow these instructions:

1. Take a web debugger trace on the **Client** that connects to the application behind the Application Gateway. This example uses Fiddler.
    **Tip** If you don't know how to use Fiddler, check the option **I want to collect network traffic and analyze it using web debugger** at the bottom.

1. Check and analyze the session logs to determine whether the cookies that the client provides include the ApplicationGatewayAffinity details. If you don't find the ApplicationGatewayAffinity details, such as `ApplicationGatewayAffinity=ApplicationGatewayAffinityValue` within the cookie set, the client isn't replying with the ApplicationGatewayAffinity cookie that the Application Gateway provides.
    For example:

    :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-3.png" alt-text="Screenshot of a session log with a single entry highlighted." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-3.png":::

    :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-4.png" alt-text="Screenshot of HTTP request headers with cookie information highlighted." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-4.png":::

The application continues to try to set the cookie on each request until it gets a reply.

#### Cause

This problem occurs because Internet Explorer and other browsers don't store or use the cookie with a short name URL.

#### Resolution

To fix this problem, access the Application Gateway by using a fully qualified domain name (FQDN). For example, use [http://website.com](https://website.com/) or [http://appgw.website.com](http://website.com/).

## Additional logs to troubleshoot

You can collect and analyze extra logs to troubleshoot problems related to cookie-based session affinity.

- [Analyze Application Gateway logs](#analyze-application-gateway-logs)
- [Use a web debugger to capture and analyze the HTTP or HTTPS traffic](#use-a-web-debugger-to-capture-and-analyze-the-http-or-https-traffic)

### Analyze Application Gateway logs

To collect Application Gateway logs, follow these instructions:

Enable logging by using the Azure portal.

1. In the [Azure portal](https://portal.azure.com/), find your resource and then select **Diagnostic setting**.

   For Application Gateway, three logs are available: Access log, Performance log, and Firewall log.

1. Select **Add diagnostic setting** to start collecting data.

   :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-5.png" alt-text="Screenshot of an application gateway with Diagnostic settings selected." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-5.png":::

1. The **Diagnostic setting** page provides the settings for the diagnostic logs. In this example, Log Analytics stores the logs. You can also use Azure Event Hubs and a storage account to save the diagnostic logs.

   :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-6.png" alt-text="Screenshot of the Diagnostic settings pane with Log Analytics configuration selected." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-6.png":::

1. Confirm the settings and then select **Save**.

### Use a web debugger to capture and analyze the HTTP or HTTPS traffic

Web debugging tools like Fiddler can help you debug web applications by capturing network traffic between the Internet and test computers. These tools enable you to inspect incoming and outgoing data as the browser receives or sends it. In this example, Fiddler has the HTTP replay option that can help you troubleshoot client-side problems with web applications, especially authentication problems.

Use the web debugger of your choice. In this sample, use Fiddler to capture and analyze HTTP or HTTPS traffic. Follow the instructions:

1. Download [Fiddler](https://www.telerik.com/download/fiddler).

    > [!NOTE]
    > Choose Fiddler4 if the capturing computer has .NET 4 installed. Otherwise, choose Fiddler2.

1. Right-click the setup executable, and run as administrator to install.

    :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-12.png" alt-text="Screenshot of the Fiddler setup program with Run as administrator selected." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-12.png":::

1. When you open Fiddler, it automatically starts capturing traffic (notice the **Capturing** at lower-left-hand corner). Press F12 to start or stop traffic capture.

    :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-13.png" alt-text="Screenshot of Fiddler Web Debugger with the Capturing indicator highlighted." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-13.png":::

1. Most likely, you're interested in decrypted HTTPS traffic. Enable HTTPS decryption by selecting **Tools** > **Fiddler Options**, and checking the box **Decrypt HTTPS traffic**.

    :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-14.png" alt-text="Screenshot of Fiddler Options with HTTPS selected and Decrypt HTTPS traffic enabled." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-14.png":::

1. To remove previous unrelated sessions before reproducing the problem, select **X** > **Remove All**. 

    :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-15.png" alt-text="Screenshot of the X menu in Fiddler with Remove all selected." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-15.png":::

1. When you reproduce the problem, save the file for review by selecting **File** > **Save** > **All Sessions**. 

    :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-16.png" alt-text="Screenshot of the File menu in Fiddler with Save All Sessions selected." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-16.png":::

1. Check and analyze the session logs to determine what the problem is.

    For example:

- **Example A:** You find a session log that the request is sent from the client, and it goes to the public IP address of the Application Gateway. Select this log to view the details. On the right side, the data in the bottom box is what the Application Gateway returns to the client. Select the **RAW** tab and determine whether the client is receiving a "**Set-Cookie: ApplicationGatewayAffinity=** *ApplicationGatewayAffinityValue*." If there's no cookie, session affinity isn't set, or the Application Gateway isn't applying cookie back to the client.

   > [!NOTE]
   > This ApplicationGatewayAffinity value is the cookie-id, that the Application Gateway sets for the client to be sent to a particular backend server.

   :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-17.png" alt-text="Screenshot of log entry details with the Set-Cookie value highlighted." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-17.png":::

- **Example B:** The next session log followed by the previous one is the client responding back to the Application Gateway, which sets the ApplicationGatewayAffinity. If the ApplicationGatewayAffinity cookie-id matches, the packet goes to the same backend server that was used previously. Check the next several lines of HTTP communication to see whether the client's ApplicationGatewayAffinity cookie is changing.

   :::image type="content" source="./media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-18.png" alt-text="Screenshot of log entry details with a cookie value highlighted." lightbox="media/how-to-troubleshoot-application-gateway-session-affinity-issues/troubleshoot-session-affinity-issues-18.png":::

> [!NOTE]
> For the same communication session, the cookie shouldn't change. Check the top box on the right side, select **Cookies** tab to see whether the client is using the cookie and sending it back to the Application Gateway. If not, the client browser isn't keeping and using the cookie for conversations. Sometimes, the client might lie.
