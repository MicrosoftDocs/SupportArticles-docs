---
title: Istio service mesh add-on MeshConfig troubleshooting
description: Learn how to do MeshConfig troubleshooting on the Istio service mesh add-on for Azure Kubernetes Service (AKS).
ms.date: 04/26/2024
author: nshankar13
ms.author: nshankar
editor: v-jsitser
ms.reviewer: fuyuanbie, shasb, kochhars, ddama, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-extensions-add-ons
ms.topic: troubleshooting-general
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the global mesh configuration (MeshConfig) of the Istio add-on so that I can use the Istio service mesh successfully.
---
# Istio service mesh add-on MeshConfig troubleshooting

This article discusses how to troubleshoot issues that occur when you use MeshConfig to configure the Istio service mesh add-on for Microsoft Azure Kubernetes Service (AKS).

## Shared ConfigMap configuration

The Istio add-on [MeshConfig](https://istio.io/latest/docs/reference/config/istio.mesh.v1alpha1/#MeshConfig) enables you to configure certain mesh-wide settings. To do this, you create a local ConfigMap in the `aks-istio-system` namespace, and then the Istio control plane merges this ConfigMap with the default ConfigMap. (If there's a conflict, the default settings take precedence.) This approach is called a shared ConfigMap configuration.

Create a ConfigMap that's named `istio-shared-configmap-<asm-revision>` in the `aks-istio-system` namespace. For instance, if you use revision `asm-1-18`, you should name the ConfigMap `istio-shared-configmap-asm-1-18`. Then, you provide the mesh configuration within the `mesh` field of the `data` section, as shown in the following ConfigMap YAML file:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: istio-shared-configmap-asm-1-18
  namespace: aks-istio-system
data:
  mesh: |-
    accessLogFile: /dev/stdout
    defaultConfig:
      holdApplicationUntilProxyStarts: true
```

The values within the `defaultConfig` field are the mesh-wide settings for the Envoy sidecar.

### Canary upgrades

For canary upgrades, you have to create a second, separate ConfigMap for the new control plane revision in the `aks-istio-system` namespace before you begin the upgrade. For instance, if you upgrade from `asm-1-18` to `asm-1-19`, you have to create a new ConfigMap that's named `istio-shared-configmap-asm-19` in the `aks-istio-system` namespace. You also have to copy changes over from the `asm-1-18` shared ConfigMap to the `asm-1-19` shared ConfigMap.

After the upgrade is completed, you will delete the older ConfigMap after the older control plane is uninstalled. If you're doing a rollback, you will delete the newer ConfigMap after the newer control plane is uninstalled.

For more information, see [Upgrade Istio-based service mesh add-on for Azure Kubernetes Service](/azure/aks/istio-upgrade) and [Istio service mesh add-on minor revision upgrade troubleshooting](./istio-add-on-minor-revision-upgrade.md).

## Allowed, supported, and disallowed values

The Istio add-on designates MeshConfig fields as allowed and `supported`, allowed but `unsupported`, and `disallowed`. See [Configure Istio-based service mesh add-on for Azure Kubernetes Service](/azure/aks/istio-meshconfig) for all allowed and supported MeshConfig fields for the add-on, and an overview of the different support tiers. If fields that are mentioned in the [upstream Istio documentation](https://istio.io/latest/docs/reference/config/istio.mesh.v1alpha1/) don't appear in the allowlist for the add-on, these fields are disallowed.

## Troubleshooting checklist

### Step 1: Avoid editing the default ConfigMap

Make sure that you're configuring the shared ConfigMap and not editing the default ConfigMap (such as `istio-asm-1-17`).

### Step 2: Remove tabs from the MeshConfig definition within the shared ConfigMap

In the MeshConfig definition within the shared ConfigMap (under `data.mesh`), make sure that you use actual spaces instead of tabs. Remove any tab characters that you find.

### Step 3: Fix misspelled MeshConfig fields

Check the spelling of all MeshConfig fields, and make any necessary corrections. If fields are unrecognized or aren't part of the allowlist, updates to the MeshConfig are rejected.

### Step 4: Avoid CoreDNS overload

Issues that relate to CoreDNS overload might require you to change certain Istio DNS settings, such as the `dnsRefreshRate` field in the Istio MeshConfig definition.

### Step 5: Fix memory consumption issues

If you experience high memory consumption in Envoy, double-check your Envoy settings for [statistics data collection](https://istio.io/latest/docs/ops/configuration/telemetry/envoy-stats/). If you're [customizing Istio metrics](https://istio.io/latest/docs/tasks/observability/metrics/customize-metrics/) through the [MeshConfig](./istio-add-on-meshconfig.md), remember that certain metrics can have [high cardinality](https://istio.io/latest/about/faq/metrics-and-logs/#metric-expiry) and, therefore, cause a higher memory footprint.

We recommend that you use the `discoverySelectors` field in the MeshConfig definition to reduce memory consumption for Istiod and Envoy. For more information, see [General Istio service mesh add-on troubleshooting](./istio-add-on-general-troubleshooting.md).

### Step 6: Free CPU cores

If all CPU cores are in use, the `concurrency` field in the MeshConfig definition might be misconfigured. If this field is set to zero, Envoy uses all the CPU cores. In this situation, remove `concurrency` from the MeshConfig definition. If the `concurrency` field isn't configured, then CPU requests and limits determine the number of CPU cores that are used instead.

### Step 7: Fix pod and sidecar race conditions

If your application pod starts before the Envoy sidecar starts, the application might become unresponsive, or it might restart. For instructions about how to avoid this problem, see [Pod or containers start with network issues if istio-proxy is not ready](https://istio.io/latest/docs/ops/common-problems/injection/#pod-or-containers-start-with-network-issues-if-istio-proxy-is-not-ready). Specifically, you can set the `holdApplicationUntilProxyStarts` MeshConfig field under `defaultConfig` to `true` to help prevent these race conditions.

## References

- [Configure Istio-based service mesh add-on for Azure Kubernetes Service](/azure/aks/istio-meshconfig)

- [General Istio service mesh add-on troubleshooting](istio-add-on-general-troubleshooting.md)

- [Istio service mesh add-on ingress gateway troubleshooting](istio-add-on-ingress-gateway.md)

- [Istio service mesh add-on minor revision upgrade troubleshooting](istio-add-on-minor-revision-upgrade.md)

- [Istio service mesh add-on plug-in CA certificate troubleshooting](istio-add-on-plug-in-ca-certificate.md)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
