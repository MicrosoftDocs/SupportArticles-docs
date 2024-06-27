---
title: Istio service mesh add-on ingress gateway troubleshooting
description: Learn how to do ingress gateway troubleshooting on the Istio service mesh add-on for Azure Kubernetes Service (AKS).
ms.date: 06/27/2024
author: nshankar13
ms.author: nshankar
editor: v-jsitser
ms.reviewer: fuyuanbie, shasb, kochhars, ddama, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-extensions-add-ons
ms.topic: troubleshooting-general
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the ingress gateway of the Istio add-on so that I can use the Istio service mesh successfully.
---
# Istio service mesh add-on ingress gateway troubleshooting

This article discusses how to troubleshoot [ingress gateway](/azure/aks/istio-deploy-ingress) issues on the Istio service mesh add-on in the Microsoft Azure Kubernetes Service (AKS). The Istio ingress gateway is an [Envoy](https://www.envoyproxy.io)-based reverse proxy that you can use to route incoming traffic to workloads in the mesh.

For the Istio-based service mesh add-on, we offer the following ingress gateway options:

- An internal ingress gateway that uses a private IP address.

- An external ingress gateway that uses a publicly accessible IP address.

> [!NOTE]
> Microsoft doesn't support customizing the IP address for either the internal or external ingress gateways. Any IP customization changes to the Istio service mesh add-on will be reverted.

The add-on deploys Istio ingress gateway pods and deployments per revision. If you're doing a [canary upgrade](./istio-add-on-minor-revision-upgrade.md) and have two control plane revisions installed in your cluster, then you might have to troubleshoot multiple ingress gateway pods across both revisions.

## Troubleshooting checklist

### Step 1: Make sure no firewall or NSG rules block the ingress gateway

Verify that you don't have firewall or [Network Security Group (NSG) rules](/azure/virtual-network/network-security-groups-overview) that block traffic to the ingress gateway. You have to explicitly add a Destination Network Address Translation (DNAT) rule to [allow inbound traffic](/azure/aks/limit-egress-traffic#allow-inbound-traffic-through-azure-firewall) through Azure Firewall to the ingress gateway.

### Step 2: Configure gateways, virtual services, and destination rules correctly

When you configure gateways, virtual services, and destination rules for traffic routing through the ingress gateway, follow these steps:

1. Make sure that the ingress gateway selector in the gateway resource is set to one of the following text values if you're using an external or internal gateway, respectively:

   - `istio: aks-istio-ingressgateway-external`
   - `istio: aks-istio-ingressgateway-internal`

1. Make sure that the ports are set correctly in gateways and virtual services. For the gateway, the port should be set to `80` for `http` or `443` for `https`. For the virtual service, the port should be set to the port that the corresponding service for the application is listening on.

1. Verify that the service is exposed within the `hosts` specification for both the gateway and the virtual service. If you experience issues that are related to the `Host` header in the requests, try adding to the allowlist all hosts that contain an asterisk wildcard ("*"), such as in this [example gateway configuration](https://raw.githubusercontent.com/istio/istio/release-1.19/samples/bookinfo/networking/bookinfo-gateway.yaml). However, we recommend that you don't amend the allowlist as a production practice. Also, the `hosts` specification should be [configured explicitly](https://istio.io/latest/docs/ops/best-practices/security/#avoid-overly-broad-hosts-configurations).

### Step 3: Fix the health of the ingress gateway pod

If the ingress gateway pod crashes or doesn't appear in the ready state, verify that the Istio daemon (`istiod`) control plane pod is in the ready state. The ingress gateway depends on having the `istiod` release be ready.

If the `istiod` pod doesn't appear in the ready state, make sure that the Istio custom resource definitions (CRDs) and the `base` Helm chart is installed correctly. To do this, run the following command:

```bash
helm ls --all --all-namespaces
```

You might see a broader error in which the add-on installation isn't configured specifically to the ingress gateway.

If the `istiod` pod is healthy, but the ingress gateway pods aren't responding, inspect the following ingress gateway resources in the `aks-istio-ingress` namespace to collect more information:

- Helm release
- Deployment
- Service

Additionally, you can find more information about gateway and sidecar debugging in [General Istio service mesh add-on troubleshooting](./istio-add-on-general-troubleshooting.md).

### Step 4: Configure resource utilization

In an event of high resource utilization where the default min/max replica configurations for istiod and the gateways are not sufficient, [Horizontal pod autoscaling](/azure/aks/istio-scale) configurations can be modified. 

### Step 5: Troubleshoot [Secure ingress gateway](/azure/aks/istio-secure-gateway)

When external ingress gateway is configured to expose a secure HTTPS service using either simple or mutual TLS, follow these troubleshooting steps:

1. Inspect the values of the INGRESS_HOST_EXTERNAL and SECURE_INGRESS_PORT_EXTERNAL environment variables. Make sure they have valid values, according to the output of the following commands:

```bash
kubectl -n aks-istio-ingress get service aks-istio-ingressgateway-external
```

1. Checking logs for gateway controller for error messages

```bash
kubectl logs -n aks-istio-ingress <gateway-service-pod>
```

1. Verify that the secrets are successfully created in the `aks-istio-ingress` namespace:

```bash
kubectl -n aks-istio-ingress get secrets
```
For the example in the secure ingress gateway article, `productpage-credential` secret should be listed.
After you enable the Azure Key Vault secrets provider add-on, you have to grant access for the user-assigned managed identity of the add-on to the Azure Key Vault. Setting up access to Azure Key Vault incorrectly will cause the `productpage-credential` secret to not get created.

After you create `SecretProviderClass` resource, ensure the sample pod, `secrets-store-sync-productpage` that references this resourse is successfully deployed to ensure secrets sync from Azure Key Vault to the cluster.

## References

- [Istio add-on ingress enablement and configuration](/azure/aks/istio-deploy-ingress)

- [Ingress control](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/)

- [Traffic management concepts for gateways](https://istio.io/latest/docs/concepts/traffic-management/#gateways)

- [Istio gateway configuration](https://istio.io/latest/docs/reference/config/networking/gateway/)

- [Istio virtual service configuration](https://istio.io/latest/docs/reference/config/networking/virtual-service/)

- [Traffic management: Ingress gateway tasks (TLS termination, secure gateways, and so on)](https://istio.io/latest/docs/tasks/traffic-management/ingress/)

- [Istio security best-practices for gateways](https://istio.io/latest/docs/ops/best-practices/security/#gateways)

- [Traffic management and gateway pitfalls](https://istio.io/latest/docs/ops/common-problems/network-issues/#route-rules-have-no-effect-on-ingress-gateway-requests)

- [Istio and Kubernetes ingress](https://istio.io/latest/docs/tasks/traffic-management/ingress/kubernetes-ingress/)

- [Kubernetes Gateway API and Istio Ingress](https://istio.io/latest/docs/tasks/traffic-management/ingress/gateway-api/)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
