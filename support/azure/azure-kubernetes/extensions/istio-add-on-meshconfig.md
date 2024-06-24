---
title: Istio service mesh add-on MeshConfig troubleshooting
description: Learn how to do MeshConfig troubleshooting on the Istio service mesh add-on for Azure Kubernetes Service (AKS).
ms.date: 06/19/2024
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

This article discusses how to troubleshoot issues that occur when you [use MeshConfig to configure the Istio service mesh add-on](/azure/aks/istio-meshconfig) for Microsoft Azure Kubernetes Service (AKS).

## Shared ConfigMap configuration

The Istio add-on [MeshConfig](https://istio.io/latest/docs/reference/config/istio.mesh.v1alpha1/#MeshConfig) enables you to configure certain mesh-wide settings. To do this, you create a local ConfigMap in the `aks-istio-system` namespace. Then, the Istio control plane merges this ConfigMap with the default ConfigMap. (If a conflict exists between settings, the default settings take precedence.) This approach is called a shared ConfigMap configuration.

Create a ConfigMap that's named `istio-shared-configmap-<asm-revision>` in the `aks-istio-system` namespace. For instance, if you use revision `asm-1-18`, you should name the ConfigMap, `istio-shared-configmap-asm-1-18`. Then, you provide the mesh configuration within the `mesh` field of the `data` section, as shown in the following ConfigMap YAML file:

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

Before you start a canary upgrade, follow the [mesh configuration and upgrade guidance](/azure/aks/istio-meshconfig#mesh-configuration-and-upgrades) to create a second shared ConfigMap for the new control plane revision in the `aks-istio-system` namespace.

If a new ConfigMap wasn't created before you start the upgrade, any features that are configured by the shared ConfigMap won't be accessible. To fix this problem, create the missing ConfigMap for the corresponding revision, and copy over relevant fields from the previous shared ConfigMap.

For more information, see [Upgrade Istio-based service mesh add-on for Azure Kubernetes Service](/azure/aks/istio-upgrade) and [Istio service mesh add-on minor revision upgrade troubleshooting](./istio-add-on-minor-revision-upgrade.md).

## Allowed, supported, and disallowed values

The Istio add-on designates MeshConfig fields as allowed and `supported`, allowed but `unsupported`, and `disallowed`. To learn about allowed and supported MeshConfig fields for the add-on, and see an overview of the different support tiers, see [Configure Istio-based service mesh add-on for Azure Kubernetes Service](/azure/aks/istio-meshconfig). If fields that are mentioned in the [upstream Istio documentation](https://istio.io/latest/docs/reference/config/istio.mesh.v1alpha1/) don't appear in the allowlist for the add-on, these fields are disallowed.

## Troubleshooting checklist

### Step 1: Make sure that you're editing the correct ConfigMap

- Make sure that you're configuring the shared ConfigMap (for example, `istio-shared-configmap-asm-1-17`) and not editing the default ConfigMap (for example, `istio-asm-1-17`).
- Make sure that the shared ConfigMap points to the correct revision in its title.

### Step 2: Remove tab indents from the MeshConfig definition within the shared ConfigMap

In the MeshConfig definition within the shared ConfigMap (under `data.mesh`), make sure that you use spaces instead of tabs. Remove any tab characters that you find.

### Step 3: Make sure that MeshConfig fields are valid

If fields are unrecognized or aren't included in the [MeshConfig allowlist](/azure/aks/istio-meshconfig#allowed-supported-and-blocked-values), updates to the MeshConfig are rejected. Check whether the desired MeshConfig fields are allowed, and make sure that the fields are spelled correctly.

### Step 4: Avoid CoreDNS overload

Issues that relate to CoreDNS overload might require you to change certain Istio DNS settings, such as the `dnsRefreshRate` field in the Istio MeshConfig definition.

### Step 5: Fix memory consumption issues

If you experience high memory consumption in Envoy, double-check your Envoy settings for [statistics data collection](https://istio.io/latest/docs/ops/configuration/telemetry/envoy-stats/). If you're [customizing Istio metrics](https://istio.io/latest/docs/tasks/observability/metrics/customize-metrics/) through the [MeshConfig](./istio-add-on-meshconfig.md), remember that certain metrics can have [high cardinality](https://istio.io/latest/about/faq/metrics-and-logs/#metric-expiry) and, therefore, cause a higher memory footprint.

We recommend that you use the `discoverySelectors` field in the MeshConfig definition to reduce memory consumption for Istiod and Envoy. For more information, see [General Istio service mesh add-on troubleshooting](./istio-add-on-general-troubleshooting.md).

### Step 6: Free CPU cores

If all CPU cores are in use, the `concurrency` field in the MeshConfig definition might be misconfigured. If this field is set to zero, Envoy uses all the CPU cores. In this situation, remove `concurrency` from the MeshConfig definition. If the `concurrency` field isn't configured, then CPU requests and limits determine the number of CPU cores that are used instead.

### Step 7: Fix pod and sidecar race conditions

If your application pod starts before the Envoy sidecar starts, the application might become unresponsive or it might restart. For instructions about how to avoid this problem, see [Pod or containers start with network issues if istio-proxy is not ready](https://istio.io/latest/docs/ops/common-problems/injection/#pod-or-containers-start-with-network-issues-if-istio-proxy-is-not-ready). Specifically, you can set the `holdApplicationUntilProxyStarts` MeshConfig field under `defaultConfig` to `true` to help prevent these race conditions.

## References

- [Configure Istio-based service mesh add-on for Azure Kubernetes Service](/azure/aks/istio-meshconfig)

- [General Istio service mesh add-on troubleshooting](istio-add-on-general-troubleshooting.md)

- [Istio service mesh add-on ingress gateway troubleshooting](istio-add-on-ingress-gateway.md)

- [Istio service mesh add-on minor revision upgrade troubleshooting](istio-add-on-minor-revision-upgrade.md)

- [Istio service mesh add-on plug-in CA certificate troubleshooting](istio-add-on-plug-in-ca-certificate.md)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
