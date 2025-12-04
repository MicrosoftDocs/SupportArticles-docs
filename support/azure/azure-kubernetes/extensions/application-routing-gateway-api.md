---
title: Application Routing Gateway API ingress Troubleshooting
description: Learn how to do Application Routing Gateway API ingress troubleshooting for Azure Kubernetes Service (AKS).
ms.date: 11/26/2025
author: nshankar13
ms.author: nshankar
ms.reviewer: jkatariya
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot Gateway-API based ingress gateways of Application Routing add-on so that I can use the Istio service mesh successfully.
---

# Application routing Gateway API ingress troubleshooting

## Overview

The [application routing add-on](/azure/aks/app-routing-gateway-api) supports using the [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) to manage ingress traffic to AKS cluster workloads. If you are using [managed NGINX](/azure/aks/app-routing-nginx-configuration) with the legacy Ingress API, we strongly recommend migrating to using the Kubernetes Gateway API Implementation. 

The application routing Gateway API Implementation deploys an Istio control plane to reconcile Kubernetes Gateway API resources. However, the application routing Gateway API Implementation is distinct from the [Istio add-on](./istio-add-on-general-troubleshooting.md), which is a full, end-to-end service mesh solution for AKS users to manage east-west and egress traffic in addition to ingress traffic - the application routing add-on's Istio control plane _only_ reconciles Gateway API resources. Moreover, the application routing Gateway API Istio control plane is not revisioned and is upgraded in-place, whereas the Istio add-on uses [canary upgrades](/azure/aks/istio-gateway-api) for minor revision upgrades.

## Troubleshooting Steps

### Istio Add-On Compatibility and Migration

Use of the [application routing Gateway API Implementation](/azure/aks/app-routing-gateway-api) and the [Istio service mesh add-on](/azure/aks/istio-about) simultaneously is unsupported. You must disable one first and enable the other in a separate operation.

If you were previously using the Istio add-on and migrated to the application routing Gateway API Implementation, make sure that all Istio Custom Resource Definitions (CRDs) and other resources have been cleaned up from the prior installation. If you previously labeled your Istio `Gateway` resources with the revision label `istio.io/rev=<asm-revision`, remember to remove this label after enabling the application routing add-on, which does not have a revisioned Istio control plane. You may also need to manually restart pods that were previously part of the mesh for Envoy sidecars to be un-injected from applications.

If there are issues with the new application routing Istio control plane taking ownership of existing `Gateway` resources, try restarting the `istiod` deployment. Also inspect the `istiod` logs for any errors related to watching and/or taking ownership of the `Gateway` resources.

### Networking, firewall, and load balancer errors troubleshooting

#### Step 1: Make sure that Azure Load Balancer health probes are configured appropriately

The application routing add-on adds [Azure Load Balancer annotations](https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/) to the `Gateway` service to configure health probes, namely:

```
service.beta.kubernetes.io/port_<gateway_port>_health-probe_port: "10256"

service.beta.kubernetes.io/port_<gateway_port>_health-probe_protocol: http

service.beta.kubernetes.io/port_<gateway_port>_health-probe_request-path: /healthz
```

These annotations tell Azure Load Balancer the path, protocol, and port for health probing the node or backend pods before forwarding traffic to the pod. By default, this is set to the port that `kube-proxy` is listening on to ensure that the `kube-proxy` instance on the node is healthy and can forward traffic to the destination pods. Note that these health probes only take effect when the `externalTrafficPolicy` is set to `cluster` - when the `externalTrafficPolicy` is set to `local`, Azure Load Balancer will use the `healthCheckNodePort` for health probing the node.

You can verify that these annotations have been added to the service by running `kubectl get service <gateway-svc-name> -n <gateway-svc-namespace> -o yaml`. If these annotations are not added to the service for some reason, traffic from Azure Load Balancer to the Gateway API deployment could be blocked because of failing health probes. You can address this issue by adding [Azure LoadBalancer annotations](https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/) for the health probe path/port/protocol directly to the `Gateway` object, or by [customizing](#gateway-traffic-management-and-resource-customization-issues) the `GatewayClass`-level ConfigMap or the per-`Gateway` ConfigMap.

`Gateway` customization (ex - for `Gateway` listening on port `80`):

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

You can also see whether health probes are failing by inspecting the `LoadBalancer` in the infrastructure resource group for the cluster on Azure Portal under `Settings/Properties`.

#### Step 2: Make sure no firewall or NSG rules block ingress traffic

Verify that no [firewall](/azure/firewall/protect-azure-kubernetes-service) or [Network Security Group (NSG) rules](/azure/virtual-network/network-security-groups-overview) rules block traffic to the ingress gateway.

Double check whether you set restrictions to allow traffic to only the subnets of your user node pools. If the Gateway API pods are scheduled onto [system node pools](/azure/aks/use-system-pools?tabs=azure-cli), incoming traffic to these pods could be blocked. You can address this issue by allowing traffic to the subnets of your system node pools.

### Versioning and Upgrade Troubleshooting

Upgrades of Istio control plane for the application routing Gateway API Implementation occur in-place and are triggered in the following two scenarios:
- The AKS cluster is upgraded to a new version which has a higher maximum supported Istio version corresponding to it. The Istio control plane will be upgraded to the higher minor version as part of the AKS cluster upgrade.
- A new Istio version is released for AKS and is now the maximum supported Istio version for the AKS cluster version. The Istio control plane on your cluster will **automatically** be upgraded to the new minor version after the release is rolled out to your region. Follow the AKS release notes to track new Istio version releases.

It's possible that traffic disruptions could occur during the upgrade process. To minimize disruptions during upgrades, the application routing add-on deploys a Horizontal Pod Autoscaler (HPA) with 2 minimum replicas and a PodDisruptionBudget (PDB) with a minimum availability of 1 for each `Gateway`. 

See the [Istio release calendar](/azure/aks/app-routing-gateway-api#versioning-and-upgrades) to find the expected Istio minor version for the cluster's Kubernetes version, and check the AKS release notes and [AKS release tracker](https://releases.aks.azure.com/webpage/index.html) to see whether the new Istio minor version has been released to your region. You should also verify that the `istiod` deployment pilot image tag has the expected minor version for the given cluster version by running:

```bash
kubectl get deployment istiod -n aks-istio-system -o yaml
```

If the `istiod` deployment is still not up-to-date, you may need to manually trigger a reconciliation of the AKS cluster. You can do this by running `az aks update`.

If the `istiod` version is up-to-date, you should also verify that the `Gateway` deployment proxy images also have the new patch versions. `istiod` should update the `Gateway` deployments automatically after `istiod` gets updated. If the `Gateway` deployment images aren't updated to the new minor or patch version, try restarting the `istiod` deployment manually.

## Istio control plane and `Gateway` proxy troubleshooting

Because the App Routing Gateway API Implementation uses an Istio control plane, you can follow the steps in the [Istio add-on troubleshooting guide](./istio-add-on-general-troubleshooting.md) to debug `istiod` and `Gateway` proxies. Note that some of the Istio add-on troubleshooting steps could pertain to Istio CRDs, revisioned deployments, canary upgrades, and other features that are not applicable to the App Routing Istio Gateway API Implementation.

## Gateway Traffic Management and Resource Customization Issues

While the App Routing Gateway API Implementation is separate from the Istio add-on, the process of deploying and troubleshooting `Gateways` between the Istio add-on and the App Routing Gateway API Implementation is roughly the same. Moreover, both App Routing and the Istio add-on use the same resource customization allowlist to validate `Gateway` ConfigMaps. Follow the steps in the Istio add-on Gateway API troubleshooting guide for [Gateway configuration](./istio-add-on-gateway-api.md#gateway-configuration-troubleshooting) and [resource customization](./istio-add-on-gateway-api.md#gateway-resource-customization-troubleshooting) errors.
