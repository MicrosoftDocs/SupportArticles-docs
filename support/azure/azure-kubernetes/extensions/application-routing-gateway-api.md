---
title: Troubleshoot application routing Gateway API ingress problems
description: Troubleshoot application routing Gateway API ingress problems in AKS. Diagnose networking, upgrade, and Istio control plane problems and fix them fast.
ms.date: 05/22/2026
author: nshankar13
ms.author: nshankar
ms.reviewer: jkatariya
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot Gateway-API based ingress gateways of Application Routing add-on so that I can use the Istio service mesh successfully.
---

# Troubleshoot application routing Gateway API ingress problems in AKS

## Summary

This article provides guidance to troubleshoot common problems that affect the application routing Gateway API ingress in Azure Kubernetes Service (AKS).

The [application routing add-on](/azure/aks/app-routing-gateway-api) supports using the [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) to manage ingress traffic to AKS cluster workloads. If you use [managed NGINX](/azure/aks/app-routing-nginx-configuration) with the legacy ingress API, migrate to the Kubernetes Gateway API implementation. 

The application routing Gateway API implementation deploys an Istio control plane to manage Kubernetes Gateway API resources. However, the application routing Gateway API implementation is distinct from the [Istio add-on](istio-add-on-general-troubleshooting.md). 

The add-on is a full, end-to-end service mesh solution for AKS users to manage east-west and egress traffic in addition to ingress traffic. The application routing add-on's Istio control plane *only* manages infrastructure for `Gateways` with `gatewayClassName` of `approuting-istio`, whereas the Istio add-on manages infrastructure for `Gateways` with `gatewayClassName` of `istio` and also supports other service mesh features. 

The application routing Gateway API Istio control plane isn't revisioned, but is upgraded in-place. By contrast, the Istio add-on uses [canary upgrades](/azure/aks/istio-gateway-api) for minor revision upgrades.

## Troubleshooting scenarios

The following situations are common troubleshooting scenarios for the application routing Gateway API.

### Istio add-on compatibility and migration

You can't use the [application routing Gateway API Implementation](/azure/aks/app-routing-gateway-api) and the [Istio service mesh add-on](/azure/aks/istio-about) at the same time. You must disable one first and then enable the other in a separate operation.

If you previously used the Istio add-on, and then migrated to the application routing Gateway API Implementation, make sure that you clean up all Istio Custom Resource Definitions (CRDs) and other resources from the previous installation. You must also update the `gatewayClassName` for your `Gateways` from `istio` to `approuting-istio`. If you previously labeled your Istio `Gateway` resources by using the revision label `istio.io/rev=<asm-revision`, remove this label after you enable the application routing add-on. This step is necessary because the add-on doesn't have a revisioned Istio control plane. You might also have to manually restart pods that were previously part of the mesh in order for Envoy sidecars to be un-injected from applications.

If any problems occur because the new application that routes Istio control plane takes ownership of existing `Gateway` resources, try to restart the `istiod` deployment. Also, inspect the `istiod` logs for any errors that are related to watching and taking ownership of the `Gateway` resources.

### Networking, firewall, and load balancer errors 

To troubleshoot common networking, firewall, and load balancer errors that you might encounter when you use the application routing Gateway API, follow these steps.

#### Step 1: Make sure Azure Load Balancer health probes are configured appropriately

The application routing add-on adds [Azure Load Balancer annotations](https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/) to the `Gateway` service to configure health probes. 

See the following examples:

```
service.beta.kubernetes.io/port_<gateway_port>_health-probe_port: "10256"

service.beta.kubernetes.io/port_<gateway_port>_health-probe_protocol: http

service.beta.kubernetes.io/port_<gateway_port>_health-probe_request-path: /healthz
```

These annotations tell Azure Load Balancer the path, protocol, and port for health probing the node or back-end pods before it forwards traffic to the pod. By default, this configuration sets the port to the one that `kube-proxy` listens on to make sure that the `kube-proxy` instance on the node is healthy and can forward traffic to the destination pods. 

> [!NOTE]
> These health probes take effect only if `externalTrafficPolicy` is set to `cluster`. If `externalTrafficPolicy` is set to `local`, Azure Load Balancer uses the `healthCheckNodePort` for health probing the node.

Verify that the service has these annotations. Run `kubectl get service <gateway-svc-name> -n <gateway-svc-namespace> -o yaml` in the cluster. If the service doesn't have these annotations, or if you overwrite these annotations by using your own resource customizations, failing health probes can block traffic from Azure Load Balancer to the Gateway API deployment. 

To fix this problem, add [Azure Load Balancer annotations](https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/) for the health probe path, port, or protocol directly to the `Gateway` object, or [customize](#gateway-traffic-management-and-resource-customization-problems) the `GatewayClass`-level ConfigMap or the per-`Gateway` ConfigMap.

Run the following `Gateway` customization (for example, `Gateway` listening on port `80`):

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
...
...
spec:
  infrastructure:
    annotations:
      service.beta.kubernetes.io/port_80_health-probe_port: "10256"
      service.beta.kubernetes.io/port_80_health-probe_protocol: http
      service.beta.kubernetes.io/port_80_health-probe_request-path: /healthz
```
ConfigMap customization:
```yaml
apiVersion: v1
kind: ConfigMap
data:
  service: |
    metadata:
      annotations:
        service.beta.kubernetes.io/port_80_health-probe_port: "10256"
        service.beta.kubernetes.io/port_80_health-probe_protocol: http
        service.beta.kubernetes.io/port_80_health-probe_request-path: /healthz
```

Another method to check whether health probes are failing is to inspect the `LoadBalancer` in the infrastructure resource group for the cluster in the [Azure portal](https://portal.azure.com) in the **Settings** > **Properties** section.

#### Step 2: Make sure no firewall or NSG rules block ingress traffic

Verify that no [firewall](/azure/firewall/protect-azure-kubernetes-service) or [network security group (NSG) rules](/azure/virtual-network/network-security-groups-overview) block traffic to the ingress gateway.

Determine whether you set restrictions to allow traffic to only the subnets of your user node pools. If the Gateway API pods are scheduled onto [system node pools](/azure/aks/use-system-pools?tabs=azure-cli), incoming traffic to these pods can be blocked. Address this problem by allowing traffic to the subnets of your system node pools.

### Versioning and upgrade problems

Upgrades of the Istio control plane for the application routing Gateway API implementation occur in-place and are triggered in the following two scenarios:

- You upgrade the AKS cluster to a new version that supports a higher maximum Istio version. The upgrade process updates the Istio control plane to the higher minor version.
- A new Istio version is released for AKS and becomes the maximum supported Istio version for the AKS cluster version. The Istio control plane on your cluster automatically upgrades to the new minor version after the release is rolled out to your region. Follow the AKS release notes to track new Istio version releases.

If no supported Istio version exists for the AKS cluster version, the application routing Gateway API implementation installs the maximum *compatible* Istio version for the given AKS Kubernetes version. In this situation, it should align with your [AKS cluster Kubernetes version](/azure/aks/supported-kubernetes-versions). 

Traffic disruptions can occur during the upgrade process. To minimize disruptions during upgrades, the application routing add-on deploys a Horizontal Pod Autoscaler (HPA) that has two minimum replicas and a PodDisruptionBudget (PDB) that has a minimum availability of one for each `Gateway`. 
To find the expected Istio minor version for the cluster's Kubernetes version, see the [Istio release calendar](/azure/aks/app-routing-gateway-api#versioning-and-upgrades). Check the AKS release notes and [AKS release tracker](https://releases.aks.azure.com/webpage/index.html) to see whether the new Istio minor version is released to your region. 

Verify that the `istiod` deployment pilot image tag has the expected minor version for the given cluster version. Run the following command:

```bash
kubectl get deployment istiod -n aks-istio-system -o yaml
```

If the `istiod` deployment isn't up to date, you likely have to manually trigger a reconciliation of the AKS cluster. To trigger reconciliation, run `az aks update`.

If the `istiod` version is up to date, also verify that the `Gateway` deployment proxy images have the new patch versions. `istiod` updates the `Gateway` deployments automatically after `istiod` gets updated. If the `Gateway` deployment images aren't updated to the new minor or patch version, try to restart the `istiod` deployment manually.

### Istio control plane and `Gateway` proxy problems

Because the application routing Gateway API implementation uses an Istio control plane, you can follow the steps in the [Istio add-on troubleshooting guide](istio-add-on-general-troubleshooting.md) to debug `istiod` and `Gateway` proxies. 

> [!NOTE]
> Some of the Istio add-on troubleshooting steps might also pertain to Istio CRDs, revisioned deployments, canary upgrades, and other features that aren't applicable to the application that routes Istio Gateway API implementation.

### Gateway traffic management and resource customization problems

The application routing Gateway API implementation is separate from the Istio add-on and uses a different `gatewayClassName` of `approuting-istio`. However, the process to deploy and troubleshoot `Gateways` between the Istio add-on and the application routing Gateway API implementation is roughly the same. Both application that route Gateway API implementation and the Istio add-on use the same resource customization allowlist to validate `Gateway` ConfigMaps. Follow the steps in the Istio add-on Gateway API troubleshooting guide for [Gateway configuration problems](istio-add-on-gateway-api.md#gateway-configuration-problems)and [Gateway resource customization problems](istio-add-on-gateway-api.md#gateway-resource-customization-problems).

To avoid conflicts, make sure that you don't have the `GatewayClass` `approuting-istio` installed on your cluster (or any controller that reconciles `Gateways` of `GatewayClass` `approuting-istio`) before you enable application routing Istio with the Managed Gateway API.

> [!NOTE]
> AKS provisions and reconciles the `istio-gateway-class-defaults` ConfigMap when you enable the Managed Gateway API CRDs and the application routing Gateway API implementation together. If you previously created the `istio-gateway-class-defaults` ConfigMap in the `aks-istio-system` namespace, delete the self-managed ConfigMap instance before you enable the Managed Gateway API CRDs to avoid conflicts with reconciliation of the AKS-managed ConfigMap.
