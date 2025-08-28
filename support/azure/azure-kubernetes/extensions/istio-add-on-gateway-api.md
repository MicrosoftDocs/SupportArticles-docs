---
title: Istio service mesh add-on Gateway API ingress troubleshooting
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

This article discusses how to troubleshoot ingress gateways configured with the [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) for the Istio service mesh add-on.

## Overview

Like the [classic Istio ingress gateways](./IngressGateway.md), Gateway API-based ingress gateways for the Istio add-on are Envoy-based reverse proxies. Users must have the [AKS Managed Gateway API CRDs](/azure/aks/managed-gateway-api) installed on their cluster first before using the Istio add-on for Gateway API-based ingress.

## Before troubleshooting

Before proceeding, take the following actions:

- Install the [Managed Gateway API CRDs](/azure/aks/managed-gateway-api) on your cluster.
- Ensure that you have the Istio add-on installed and are on ASM minor revision `asm-1-26` or higher. Follow the [installation guide](/azure/aks/istio-deploy-addon) to enable the Istio add-on and the [upgrade documentation](/azure/aks/istio-upgrade) to upgrade your mesh to `asm-1-26` if you are on a lower minor revision.

## Before troubleshooting

## Networking, firewall, and load balancer errors troubleshooting

### Step 1: Make sure that Azure Load Balancer health probes are configured appropriately

In some cases, traffic from Azure Load Balancer to the Istio Gateway API Deployment could be blocked due to failing health probes. You can address this by [customizing the Kubernetes service](#gateway-resource-customization-issues) for the `Gateway` - either via the `GatewayClass`-level ConfigMap or the per-`Gateway` ConfigMap - by adding [Azure LoadBalancer annotations](https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/) for the health probe path/port/protocol:

    ```yaml
    apiVersion: gateway.networking.k8s.io/v1
    kind: Gateway
    metadata:
      annotations:
        service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: "/healthz/ready"
        service.beta.kubernetes.io/port_80_health-probe_protocol: http
        service.beta.kubernetes.io/port_80_health-probe_port: "15021"
    ```

    You can also see whether health probes are failing by inspecting the `LoadBalancer` in the infrastructure resource group for the cluster on Azure Portal under `Settings/Properties`.

### Step 2: Make sure no firewall or NSG rules block ingress traffic

Verify that the there aren't any [firewall](/azure/firewall/protect-azure-kubernetes-service) or [Network Security Group (NSG) rules](/azure/virtual-network/network-security-groups-overview) that block traffic to the ingress gateway.

Double check if you have set restrictions to only allow traffic to the subnet(s) of your user node pool(s). If the Gateway API pods are scheduled onto [system node pools](/azure/aks/use-system-pools?tabs=azure-cli), then incoming traffic to these pods could be blocked. You can address this by allowing traffic to the subnet(s) of your system node pool(s).

## Gateway configuration troubleshooting

### Step 1: Make sure the gatewayClassName is set to `istio`

Verify that all `Gateways` you created have the `spec.gatewayClassName` set to `istio`. 

### Step 2: Verify cross-namespace references

Depending on the namespace the `Gateway` and respective Routes are deployed in, the `Gateway` `spec.listeners.allowedRoutes` should be set accordingly to allow Routes only from the same namespace or across different namespaces. Likewise, the `spec.parentRefs` for Routes should a reference the correct `Gateway` and provide the appropriate namespace for cross-namespace `Gateway` references. See the Gateway API docs on [cross-namespace routing](https://gateway-api.sigs.k8s.io/guides/multiple-ns/) for more information.

### Step 3: Inspect the `Gateway` for programming errors

If the `Gateway` has a programmed status of `failed` or `unknown`, you should inspect the `Gateway` object for more details. You can do this by running `kubectl get gateway <gateway-name> -n <gateway-namespace> -o yaml` and `kubectl describe gateway <gateway-name> -n <gateway-namespace> `.

### Step 4: Inspect `istiod` and `Gateway` logs for errors

The `istiod` logs may also have additional details on `Gateway` programming-related errors. If the `Gateway` is programmed successfully and the Pod/Deployment are created, but is running into other issues, then you should try inspecting the `Gateway` Pod logs for any potential errors.

## Minor revision upgrades and revision label troubleshooting

During an [Istio add-on minor revision upgrade](/azure/aks/istio-upgrade) when two control planes are deployed on the cluster simultaneously, the higher revision will by default take ownership of the `Gateway` resources if the `Gateways` are not labeled with a specific ASM revision as such:

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

During the minor revision upgrade, you should verify that the Pods/Deployments for the `Gateway` are automatically updated with the new proxy minor image version corresponding to the higher control plane minor revision. If not, you should try restarting the Deployment. 

If your `Gateways` are labeled explicitly with an ASM revision, you should relabel them accordingly before completing or rolling back the upgrade operation.

## Gateway resource customization troubleshooting

The Istio add-on supports [customization of the resources](/azure/aks/istio-gateway-api#resource-customizations) created for the `Gateways`, namely the:
* Deployment
* Service
* Horizontal Pod Autoscaler (HPA)
* PodDisruptionBudget (PDB)

The following are some troubleshooting steps for issues relating to configuration of the `Gateway` resources.

### Step 1: Ensure customization fields are allowlisted

Ensure that the customizations for both `GatewayClass`-level ConfigMaps and `Gateway`-level ConfigMaps only include fields in the [allowlist](/azure/aks/istio-gateway-api#resource-customization-allowlist) for the specific resource.

### Step 2: Ensure GatewayClass-level ConfigMap is configured correctly

The `GatewayClass`-level ConfigMap `istio-gateway-class-defaults` is automatically deployed in the `aks-istio-system` namespace by the Istio add-on when the Managed Gateway API installation is enabled on the cluster. If you are editing this ConfigMap, ensure that you keep the `gateway.istio.io/defaults-for-class` label set to `istio`. You can only have one `GatewayClass`-level ConfigMap deployed at a time.

### Step 3: Verify Gateway-level ConfigMap customizations

If both the `GatewayClass`-level ConfigMap and a `Gateway`-level ConfigMap are deployed, the `Gateway`-level ConfigMap customizations will take precedence. Ensure that the desired resource customizations for the `Gateway` are set in the `Gateway`-level ConfigMap. Also verify that the ensure that the `spec.infrastructure.parametersRef` field references the correct ConfigMap for that `Gateway`.

### Step 4: Inspect Gateway resource propogation errors

If the `Gateway` customizations fail to propagate to their respective resources, verify that the ConfigMap spec is valid in terms of indentation, correct field names, spelling, and so-on. You should also inspect the `istiod` logs to see if there are any issues with template rendering or resource creation for the `Gateways`.
