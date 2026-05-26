---
title: Troubleshoot Istio add-on Gateway API ingress in AKS 
description: Troubleshoot Gateway API ingress on the Istio service mesh add-on for AKS. Diagnose and resolve ingress traffic routing issues quickly with this step-by-step guide.
ms.date: 08/26/2025
author: nshankar13
ms.author: nshankar
ms.reviewer: jkatariya
ms.service: azure-kubernetes-service
ms.topic: troubleshooting
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot Gateway-API based ingress gateways of the Istio add-on so that I can use the Istio service mesh successfully.
---

# Istio service mesh add-on Gateway API ingress troubleshooting

## Summary

This article discusses Istio service mesh add-on Gateway API ingress troubleshooting in Azure Kubernetes Service (AKS) so you can resolve ingress traffic routing problems quickly.

Similar to the [classic Istio ingress gateways](./istio-add-on-ingress-gateway.md), Gateway API-based ingress gateways for the Istio add-on are Envoy-based reverse proxies. You must install the [AKS Managed Gateway API CRDs](/azure/aks/managed-gateway-api) on your cluster before you can use the Istio add-on for Gateway API-based ingress.

## Before troubleshooting

Before you proceed, take the following actions:

- Install the [Managed Gateway API CRDs](/azure/aks/managed-gateway-api) on your cluster.
- Make sure that you have the Istio add-on installed and are on `asm` minor revision `asm-1-26` or a later revision. Follow the [installation guide](/azure/aks/istio-deploy-addon) to enable the Istio add-on and the [upgrade documentation](/azure/aks/istio-upgrade) to upgrade your mesh to `asm-1-26` if you're on an earlier revision.

## Troubleshooting scenarios

The following situations are common troubleshooting scenarios for Istio service mesh add-on Gateway API ingress in AKS.

### Application routing Gateway API implementation compatibility and migration

You can't use the [application routing Gateway API Implementation](/azure/aks/app-routing-gateway-api) and the [Istio service mesh add-on](/azure/aks/istio-about) at the same time. You must disable one first and then enable the other in a separate operation. You must also update the `gatewayClassName` for your `Gateways` from `approuting-istio` to `approuting`.

If you previously used application routing Istio Gateway API Implementation, then migrated to the Istio add-on, and now experience issues that cause the Istio add-on control plane to take ownership of existing `Gateway` resources, try restarting the `istiod` deployment. Also, inspect the `istiod` logs for any errors that are related to watching and taking ownership of the `Gateway` resources.

### Networking, firewall, and load balancer errors 

To troubleshoot common networking, firewall, and load balancer errors that you might encounter when you use the application routing Gateway API, follow these steps.

#### Step 1: Make sure that Azure Load Balancer health probes are configured appropriately

The Istio add-on adds [Azure Load Balancer annotations](https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/) to the `Gateway` service to configure health probes. 

See the following examples:

```
service.beta.kubernetes.io/port_<gateway_port>_health-probe_port: "10256"

service.beta.kubernetes.io/port_<gateway_port>_health-probe_protocol: http

service.beta.kubernetes.io/port_<gateway_port>_health-probe_request-path: /healthz
```

These annotations tell Azure Load Balancer the path, protocol, and port for health probing the node or back-end pods before forwarding traffic to the pod. By default, this configuration sets the port to the one that `kube-proxy` listens on to make sure that the `kube-proxy` instance on the node is healthy and can forward traffic to the destination pods. 

> [!NOTE]
> These health probes take effect only if `externalTrafficPolicy` is set to `cluster`. If `externalTrafficPolicy` is set to `local`, Azure Load Balancer uses the `healthCheckNodePort` for health probing the node.

Verify this by running `kubectl get service <gateway-svc-name> -n <gateway-svc-namespace> -o yaml` in the cluster. If the service doesn't have these annotations, or if you overwrite these annotations with your own resource customizations, failing health probes can block traffic from Azure Load Balancer to the Istio Gateway API deployment. 

Add [Azure Load Balancer annotations](https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/) for the health probe path, port, or protocol directly to the `Gateway` object, or by [customizing](#gateway-resource-customization-problems) the `GatewayClass`-level ConfigMap or the per-`Gateway` ConfigMap.

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

You can also see whether health probes are failing by inspecting the `LoadBalancer` in the infrastructure resource group for the cluster in the [Azure portal](https://portal.azure.com) in the **Settings** > **Properties** section.

#### Step 2: Make sure no firewall or NSG rules block ingress traffic

Verify that no [firewall](/azure/firewall/protect-azure-kubernetes-service) or [Network Security Group (NSG) rules](/azure/virtual-network/network-security-groups-overview) rules block traffic to the ingress gateway.

Double check whether you set restrictions to allow traffic to only the subnets of your user node pools. If the Gateway API pods are scheduled onto [system node pools](/azure/aks/use-system-pools?tabs=azure-cli), incoming traffic to these pods could be blocked. You can address this issue by allowing traffic to the subnets of your system node pools.

### Gateway configuration problems

Follow these steps to troubleshoot Gateway configuration problems.

#### Step 1: Make sure the gatewayClassName is set to `istio`

Verify that all `Gateways` that you created have `spec.gatewayClassName` set to `istio`. If you're using the [application routing Gateway API implementation](/azure/aks/app-routing-gateway-api), set `spec.gatewayClassName` to `approuting-istio`.

#### Step 2: Verify cross-namespace references

Depending on the namespace that you deploy the `Gateway` and respective routes in, set the `Gateway` `spec.listeners.allowedRoutes` value to allow routes from only the same namespace or across different namespaces. Likewise, set the `spec.parentRefs` value for routes to reference the correct `Gateway` and provide the appropriate namespace for cross-namespace `Gateway` references. For more information, see the Gateway API documentation for [cross-namespace routing](https://gateway-api.sigs.k8s.io/guides/multiple-ns/).

Similarly, use [ReferenceGrants](https://gateway-api.sigs.k8s.io/guides/getting-started/introduction/) to enable cross namespace from routes to backends in other namespaces.

#### Step 3: Ensure no conflicts with AKS-managed `istio-gateway-class-defaults` ConfigMap

Make sure that AKS provisions and reconciles the `istio-gateway-class-defaults` ConfigMap when you enable the Managed Gateway API CRDs and the Istio add-on together. If you previously created the `istio-gateway-class-defaults` ConfigMap in the `aks-istio-system` namespace, delete the self-managed ConfigMap instance before you enable the Managed Gateway API CRDs to avoid conflicts with reconciliation of the AKS-managed ConfigMap.

#### Step 4: Verify routing rules don't conflict

Although you can attach multiple routes to a single `Gateway` resource, only one route rule can match each request. Overlapping rules often cause conflicts and merging issues.

#### Step 5: Inspect the `Gateway` and routes for programming errors

If the `Gateway` has a programmed status of `failed` or `unknown`, inspect the `Gateway` object for more details. Run `kubectl get gateway <gateway-name> -n <gateway-namespace> -o yaml` and `kubectl describe gateway <gateway-name> -n <gateway-namespace>`. Check the Gateway objects' `STATUS` for programming issues or other errors.

Make sure that you inspect the status of routes (such as `HTTPRoutes` and `GRPCRoutes`) by running `kubectl describe httproute <route-name> -n <route-namespace> -o yaml`. 

#### Step 6: Inspect `istiod` and `Gateway` logs for errors

The `istiod` logs might have additional details about `Gateway` programming-related errors. If the gateway is programmed successfully, and the pod deployments are created but other issues occur, inspect the `Gateway` pod logs for any potential errors. The `Gateway` pod deployment name follows this format: `<gateway-name>-istio`.

#### Step 7: Inspect `Gateway` proxy pods

Verify that `Gateway` proxy pods aren't failing or `OOMKilled` because of memory issues. You can configure the deployment resource requests and limits and the Horizontal Pod Autoscaler (HPA) for the `Gateway` by using [ConfigMap customizations](#gateway-resource-customization-problems).

#### Step 8: Verify that `Gateway` resource names are valid

By default, the Istio control plane appends the `GatewayClass` name `istio` (or `approuting-istio` for the [application routing Gateway API Implementation](/azure/aks/app-routing-gateway-api)) to the name of the resources that it provisions for the `Gateway`. The resource names must be less than `63` characters and must also be a valid DNS name. If the names are invalid, `istiod` doesn't provision the `Gateway` resources, but it does output an `error` log.

You can annotate your `Gateway` resource with `gateway.istio.io/name-override` to override the name of the provisioned resources.

#### Step 9: Verify `GatewayClass` is created

Verify that the `GatewayClass` `istio` is created. To verify, run `istiod`: `kubectl get gatewayclass`. If the `GatewayClass` isn't yet created, make sure that you enabled the Managed Gateway API CRD installation on the cluster. If the Managed Gateway API CRDs are installed but the `GatewayClass` still isn't created, inspect the `istiod` logs for any errors. 

> [!NOTE]
> If you're using the [application routing Gateway API Implementation](/azure/aks/app-routing-gateway-api), the created `GatewayClass` should be `approuting-istio`.

To avoid conflicts, also make sure that you don't have the `GatewayClass` `istio` installed on your cluster before you enable the Istio add-on with the Managed Gateway API. Also make sure that you don't have another Istio-based controller that reconciles the `GatewayClass` `istio` (like Open-Source Istio) installed simultaneously with the Istio add-on. 

### Minor revision upgrades and revision label problems

By default, during an [Istio add-on minor revision upgrade](/azure/aks/istio-upgrade), if you deploy two control planes on the cluster at the same time, the higher revision takes ownership of the `Gateway` resources if you don't label the gateways with a specific `asm` revision as shown in the following example:

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

During the minor revision upgrade, verify that the pods and deployments for the gateway are automatically updated to have the new proxy minor image version that corresponds to the later control plane minor revision. If the versions aren't updated, try to restart the `istiod` deployment. 

If you explicitly label your gateways to have an `asm` revision, relabel them accordingly before you finish or roll back the upgrade operation.

### Gateway resource customization problems

The Istio add-on supports [customization of the resources](/azure/aks/istio-gateway-api#resource-customizations) that it creates for the gateways. The supported resource types are as follows:

- Deployment
- Service
- Horizontal Pod Autoscaler (HPA)
- PodDisruptionBudget (PDB)

Follow these troubleshooting steps for issues that relate to configuring the `Gateway` resources.

#### Step 1: Make sure that customization fields are on the allowlist

Make sure that the customizations for both `GatewayClass`-level ConfigMaps and `Gateway`-level ConfigMaps include only fields that are on the [allowlist](/azure/aks/istio-gateway-api#resource-customization-allowlist) for the specific resource.

#### Step 2: Make sure that GatewayClass-level ConfigMap is configured correctly

The Istio add-on automatically deploys the `GatewayClass`-level ConfigMap `istio-gateway-class-defaults` in the `aks-istio-system` namespace when you enable the Managed Gateway API installation on the cluster. 

> [!NOTE]
> It can take up to five minutes for the `istio-gateway-class-defaults` ConfigMap to be deployed after you install the Managed Gateway API CRDs. 

If you're editing this ConfigMap, make sure that you keep the `gateway.istio.io/defaults-for-class` label set to `istio`. You can have only one `GatewayClass`-level ConfigMap deployed at a time.

#### Step 3: Verify gateway-level ConfigMap customizations

If both the `GatewayClass`-level ConfigMap and a `Gateway`-level ConfigMap are deployed, the `Gateway`-level ConfigMap customizations take precedence. Make sure that the desired resource customizations for the gateway are set in the `Gateway`-level ConfigMap. Verify that the `spec.infrastructure.parametersRef` field references the correct ConfigMap for that gateway.

#### Step 4: Inspect gateway resource propagation errors

If the `Gateway` customizations don't propagate to their respective resources, verify that the ConfigMap spec is valid in terms of indentation, correct field names, spelling, and so on. You should also inspect the `istiod` logs to see whether any issues affect template rendering or resource creation for the gateways.
