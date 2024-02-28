---
title: Allow internet traffic to Cloud Services (extended support) by using an application gateway
description: Configure traffic from the internet to Azure Cloud Services (extended support) by using a public application gateway together with an internal load balancer.
ms.date: 02/19/2024
ms.topic: how-to
author: JerryZhangMS
ms.author: zhangjerry
editor: v-jsitser
ms.reviewer: maheshallu, piw, v-leedennis
ms.service: cloud-services-extended-support
---
# Allow internet traffic to Cloud Services (extended support) by using an application gateway

This article discusses how you can make internet access to Microsoft Azure Cloud Services (extended support) safer by adding an [Azure Application Gateway](/azure/application-gateway/overview) within a virtual network that already uses an internal load balancer. Adding Application Gateway to this scenario provides the following benefits:

- From the public internet, traffic can reach Cloud Services (extended support) only through Application Gateway.

- In the virtual network, this design doesn't block internet traffic.

- You can provide safer access to internet traffic by adding extra features, such as [Azure Web Application Firewall](/azure/web-application-firewall/overview) (WAF).

Generally speaking, Application Gateway is an International Organization for Standardization (ISO) Open Systems Interconnection (OSI) Reference model layer 7 service. You can use Application Gateway for load balancing, WAF, and other purposes.

## Prerequisites

- A running instance of Cloud Services (extended support).

- A virtual network.

- An internal load balancer that's set up to communicate with Cloud Services (extended support) within the virtual network. For information about how to set up the internal load balancer to work with Cloud Services (extended support), see [Grant a virtual network sole access to Azure Cloud Services (extended support)](./grant-virtual-network-sole-access.md).

## Internal load balancer configuration

The following Azure portal images show an example load balancer environment that uses a front-end IP address of `10.0.3.200` that the Internet Assigned Numbers Authority (IANA) reserves as an IP address for private internets. This configuration indicates that the load balancer is for internal use.

- **Load balancer front-end IP configuration**

  :::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/load-balancer-frontend-ip-configuration.png" alt-text="Azure portal screenshot of the 'Frontend IP configuration' page of an internal load balancer for Azure Cloud Services (extended support)." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/load-balancer-frontend-ip-configuration.png":::

- **Load balancer back-end pools**

  :::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/load-balancer-backend-pools.png" alt-text="Azure portal screenshot of the 'Backend pools' page of an internal load balancer for Azure Cloud Services (extended support)." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/load-balancer-backend-pools.png":::

- **Load balancer health probes**

  :::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/load-balancer-health-probes.png" alt-text="Azure portal screenshot of the 'Health probes' page of an internal load balancer for Azure Cloud Services (extended support)." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/load-balancer-health-probes.png":::

- **Load balancing rules**

  :::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/load-balancing-rules.png" alt-text="Azure portal screenshot of the 'Load balancing rules' page of an internal load balancer for Azure Cloud Services (extended support)." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/load-balancing-rules.png":::

## Network traffic architecture

In the [Grant a virtual network sole access to Azure Cloud Services (extended support)](./grant-virtual-network-sole-access.md) article, you learn how to configure and limit access to Cloud Services (extended support) so that it communicates with only specific virtual networks by using an internal load balancer. However, you can use an application gateway to make communication with Cloud Services (extended support) safer without having to fully block traffic from the public internet. The following diagram shows the network architecture after you add an application gateway.

:::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/cses-internal-load-balancer-traffic-design.png" alt-text="Diagram of internet traffic design through Azure Application Gateway and public and internal load balancers to Cloud Services (extended support)." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/cses-internal-load-balancer-traffic-design.png":::

In this diagram, the components that are shown within the dashed box are inside the virtual network. The public internet is outside the box. Because Cloud Services (extended support) communicates with only the internal load balancer, the traffic that passes through the public load balancer is blocked. In this scenario, to be able to visit a site that's hosted in Cloud Services (extended support), you have to use another service as a jump box to forward the traffic to Cloud Services (extended support). That service is the application gateway.

The traffic flow is as follows:

> **Public internet** > **Public IP address of the application gateway** > **Application gateway** > **Private IP address of Cloud Services (extended support)** > **Internal load balancer** > **Cloud Services (extended support) instance**

## Application gateway configuration guidelines

> [!NOTE]
> To make the process easier to follow, this section illustrates only the basic function of traffic forwarding. If other features are necessary, please refer to other articles on the Microsoft website. (For example, to use Application Gateway together with HTTPS traffic, see [Configure an Application Gateway with TLS termination](/azure/application-gateway/create-ssl-portal). Or, to apply a WAF configuration to Application Gateway, see [What is Azure Web Application Firewall on Azure Application Gateway?](/azure/web-application-firewall/ag/ag-overview))

The following sections outline various aspects of the application gateway configuration.

### Front-end public IP address

The following Azure portal screenshot is from the application gateway's **Overview** page. In the **Frontend public IP address** field, the value is `172.191.12.201`.

:::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/application-gateway-frontend-public-ip-address.png" alt-text="Azure portal screenshot of the front-end public IP address of an application gateway." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/application-gateway-frontend-public-ip-address.png":::

### Back-end pools

On the **Edit backend pool** page of the application gateway, make sure that the **Backend targets** table contains an item that has the following field values:

| Field | Value |
|--|--|
| **Target type** | **IP address or FQDN** |
| **Target** | The IP address that you specified on the **Frontend IP configuration** page of the internal load balancer |

In the following Azure portal screenshot, the back-end target is the `10.0.3.200` IP address. This matches what's specified in the front-end IP configuration screenshot for the internal load balancer.

:::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/application-gateway-backend-pool.png" alt-text="Azure portal screenshot of the 'Edit backend pool' page of an application gateway." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/application-gateway-backend-pool.png":::

### Back-end setting

Aside from the back-end pool, you have to configure another back-end setting to control how to forward the traffic. In the following Azure portal screenshot, a simple HTTP traffic configuration that uses port 80 is specified in the **Add Backend setting** page of the application gateway. If the Cloud Services (extended support) is listening on another port, such as port 700, the application gateway should be configured to a **Backend port** setting of 700.

:::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/application-gateway-add-backend-setting.png" alt-text="Azure portal screenshot of the 'Add Backend setting' page of an application gateway." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/application-gateway-add-backend-setting.png":::

### Listeners

On the specific listener page of the application gateway, you specify which application gateway port the public internet uses to send traffic to Cloud Services (extended support). In the following Azure portal screenshot, port 8080 is specified in the **Port** field. When a user in the public internet tries to communicate with Cloud Services (extended support), they must send the traffic to the application gateway by using port 8080. You can still specify port 80, but 8080 is shown here to illustrate that the application gateway listening port can be different from the Cloud Services (extended support) listening port.

:::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/application-gateway-listener.png" alt-text="Azure portal screenshot of the Listeners page of an application gateway." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/application-gateway-listener.png":::

### Rules

The final step is to create an application gateway rule that combines the configurations that you specified for back-end pools, back-end settings, and listeners. On the **Listener** tab of your rule, select the name of the listener that you defined previously (in this example, *cses-httplistener*).

:::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/application-gateway-routing-rule-listener.png" alt-text="Azure portal screenshot of the Listener tab in the routing rule of an application gateway." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/application-gateway-routing-rule-listener.png":::

On the **Backend targets** tab of your rule, select a **Target type** of **Backend pool**, and then select the names that you defined previously for the **Backend target** and **Backend settings** lists (*cses-backendpool* and *appgwtest-cses*, respectively).

:::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/application-gateway-routing-rule-backend-targets.png" alt-text="Azure portal screenshot of the 'Backend targets' tab in the routing rule of an application gateway." border="false" lightbox="./media/allow-internet-traffic-cses-application-gateway/application-gateway-routing-rule-backend-targets.png":::

## Expected result

Open a web browser to test whether the application gateway works correctly. In the address bar, enter the front-end IP address, a colon, and the listener port that you defined in the application gateway (*172.191.12.201:8080*), and then select <kbd>Enter</kbd>. The browser should successfully display the home page of the application that you're hosting in Cloud Services (extended support).

:::image type="content" source="./media/allow-internet-traffic-cses-application-gateway/web-site-hosted-cses-internal-load-balancer.png" alt-text="Browser screenshot showing the Application Gateway IP address and port number of the internal load balancer for Azure Cloud Services (extended support)." lightbox="./media/allow-internet-traffic-cses-application-gateway/web-site-hosted-cses-internal-load-balancer.png":::

## Autoscaling and load balancing in Cloud Services (extended support)

In this article, you simultaneously implement two different load balancing services in Azure: a load balancer and an application gateway. This duplication might cause a small decrease in the performance of network-level traffic. However, the dual load balancing services are helpful if you use autoscaling in Cloud Services (extended support).

If you use only an application gateway in the network traffic architecture, the application gateway has to add the private IP addresses of each Cloud Services (extended support) instance to the back-end pool. If the Cloud Services (extended support) instance is scaled out (increasing the number of instances), the new instances use new private IP addresses. You would then have to manually add those new instances to the back-end pool of the application gateway. If you also use a load balancer, you can eliminate that inconvenience.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
