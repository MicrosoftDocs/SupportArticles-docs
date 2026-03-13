---
title: Istio Service Mesh Add-on Gateway API ingress Troubleshooting
description: Learn how to do Gateway API ingress troubleshooting on the Istio service mesh add-on for Azure Kubernetes Service (AKS).
ms.date: 08/26/2025
author: nshankar13
ms.author: nshankar
ms.reviewer: jkatariya
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot Gateway-API based ingress gateways of the Istio add-on so that I can use the Istio service mesh successfully.
---

# Istio service mesh add-on gateway api ingress troubleshooting

This article discusses how to troubleshoot ingress gateways that are configured by using the [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) for the Istio service mesh add-on.

## Overview

Similar to the [classic Istio ingress gateways](./istio-add-on-ingress-gateway.md), Gateway API-based ingress gateways for the Istio add-on are Envoy-based reverse proxies. Users must have the [AKS Managed Gateway API CRDs](/azure/aks/managed-gateway-api) installed on their cluster before they can use the Istio add-on for Gateway API-based ingress.

## Before troubleshooting

Before you proceed, take the following actions:

- Install the [Managed Gateway API CRDs](/azure/aks/managed-gateway-api) on your cluster.
- Make sure that you have the Istio add-on installed and are on ASM minor revision `asm-1-26` or a later revision. Follow the [installation guide](/azure/aks/istio-deploy-addon) to enable the Istio add-on and the [upgrade documentation](/azure/aks/istio-upgrade) to upgrade your mesh to `asm-1-26` if you're on an earlier revision.

## Networking, firewall, and load balancer errors troubleshooting

### Step 1: Make sure that Azure Load Balancer health probes are configured appropriately

In some cases, traffic from Azure Load Balancer to the Istio Gateway API Deployment is blocked because of failing health probes. You can address this issue by adding [Azure LoadBalancer annotations](https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/) for the health probe path/port/protocol directly to the `Gateway` object, or by [customizing](#gateway-resource-customization-troubleshooting) the `GatewayClass`-level ConfigMap or the per-`Gateway` ConfigMap.

Gateway customization:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
...
...
spec:
  infrastructure:
    annotations:
      service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: "/healthz/ready"
      service.beta.kubernetes.io/port_80_health-probe_protocol: http
      service.beta.kubernetes.io/port_80_health-probe_port: "15021"
```

ConfigMap customization:

```yaml
apiVersion: v1
kind: ConfigMap
data:
  service: |
    metadata:
      annotations:
        service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: "/healthz/ready"
        service.beta.kubernetes.io/port_80_health-probe_protocol: http
        service.beta.kubernetes.io/port_80_health-probe_port: "15021"
```

You can also see whether health probes are failing by inspecting the `LoadBalancer` in the infrastructure resource group for the cluster on Azure Portal under `Settings/Properties`.

### Step 2: Make sure no firewall or NSG rules block ingress traffic

Verify that no [firewall](/azure/firewall/protect-azure-kubernetes-service) or [Network Security Group (NSG) rules](/azure/virtual-network/network-security-groups-overview) rules block traffic to the ingress gateway.

Double check whether you set restrictions to allow traffic to only the subnets of your user node pools. If the Gateway API pods are scheduled onto [system node pools](/azure/aks/use-system-pools?tabs=azure-cli), incoming traffic to these pods could be blocked. You can address this issue by allowing traffic to the subnets of your system node pools.

## Gateway configuration troubleshooting

### Step 1: Make sure the gatewayClassName is set to `istio`

Verify that all `Gateways` you created have the `spec.gatewayClassName` set to `istio`. 

### Step 2: Verify cross-namespace references

Depending on the namespace that the `Gateway` and respective Routes are deployed in, the `Gateway` `spec.listeners.allowedRoutes` value should be set accordingly to allow Routes from only the same namespace or across different namespaces. Likewise, the `spec.parentRefs` value for Routes should reference the correct `Gateway` and provide the appropriate namespace for cross-namespace `Gateway` references. For more information, see the Gateway API docs on [cross-namespace routing](https://gateway-api.sigs.k8s.io/guides/multiple-ns/).

### Step 3: Inspect the `Gateway` for programming errors

If the `Gateway` has a programmed status of `failed` or `unknown`, you should inspect the `Gateway` object for more details. You can take this step by running `kubectl get gateway <gateway-name> -n <gateway-namespace> -o yaml` and `kubectl describe gateway <gateway-name> -n <gateway-namespace> `.

### Step 4: Inspect `istiod` and `Gateway` logs for errors

The `istiod` logs may have additional details about `Gateway` programming-related errors. If the gateway is programmed successfully, and the pod deployments are created, but other issues occur, try inspecting the `Gateway` pod logs for any potential errors. The `Gateway` pod deployment name follows the format, `<gateway-name>-istio`.

## Minor revision upgrades and revision label troubleshooting

By default during an [Istio add-on minor revision upgrade](/azure/aks/istio-upgrade), if two control planes are deployed on the cluster simultaneously, the higher revision takes ownership of the `Gateway` resources if the gateways aren't labeled with a specific ASM revision:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: httpbin-gateway
  labels:
    istio.io/rev: asm-1-26
spec:
  gatewayClassName: istio
```

During the minor revision upgrade, verify that the pods and deployments for the gateway are automatically updated to have the new proxy minor image version that corresponds to the later control plane minor revision. If this condition isn't true, try to restart the Deployment. 

If your gateways are labeled explicitly with an ASM revision, relabel them accordingly before you finish or roll back the upgrade operation.

## Gateway resource customization troubleshooting

The Istio add-on supports [customization of the resources](/azure/aks/istio-gateway-api#resource-customizations) that are created for the gateways, as follows:

- Deployment
- Service
- Horizontal Pod Autoscaler (HPA)
- PodDisruptionBudget (PDB)

Follow these troubleshooting steps for issues that relate to configuring the `Gateway` resources.

### Step 1: Make sure that customization fields are on the allowlist

Make sure that the customizations for both `GatewayClass`-level ConfigMaps and `Gateway`-level ConfigMaps include only fields that are on the [allowlist](/azure/aks/istio-gateway-api#resource-customization-allowlist) for the specific resource.

### Step 2: Make sure that GatewayClass-level ConfigMap is configured correctly

`GatewayClass`-level ConfigMap `istio-gateway-class-defaults` is automatically deployed in the `aks-istio-system` namespace by the Istio add-on when the Managed Gateway API installation is enabled on the cluster. Notice that it could take up to five minutes for the `istio-gateway-class-defaults` ConfigMap to be deployed after you install the Managed Gateway API CRDs. 

If you're editing this ConfigMap, make sure that you keep the `gateway.istio.io/defaults-for-class` label set to `istio`. You can have only one `GatewayClass`-level ConfigMap deployed at a time.

### Step 3: Verify gateway-level ConfigMap customizations

If both the `GatewayClass`-level ConfigMap and a `Gateway`-level ConfigMap are deployed, the `Gateway`-level ConfigMap customizations take precedence. Make sure that the desired resource customizations for the gateway are set in the `Gateway`-level ConfigMap. Also, verify that the `spec.infrastructure.parametersRef` field references the correct ConfigMap for that gateway.

### Step 4: Inspect gateway resource propagation errors

If the `Gateway` customizations don't propagate to their respective resources, verify that the ConfigMap spec is valid in terms of indentation, correct field names, spelling, and so on. You should also inspect the `istiod` logs to see whether any issues affect template rendering or resource creation for the gateways.
