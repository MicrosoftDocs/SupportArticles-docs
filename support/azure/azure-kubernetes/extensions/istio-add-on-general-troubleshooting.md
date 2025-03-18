---
title: General Istio service mesh add-on troubleshooting
description: Learn how to do general troubleshooting of the Istio service mesh add-on for Azure Kubernetes Service (AKS).
ms.date: 03/18/2025
author: nshankar13
ms.author: nshankar
editor: v-jsitser
ms.reviewer: fuyuanbie, shasb, kochhars, ddama, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to do general troubleshooting on the Istio add-on so that I can use the Istio service mesh successfully.
---
# General troubleshooting of the Istio service mesh add-on

This article discusses general strategies (that use `kubectl`, `istioctl`, and other tools)  to troubleshoot issues that are related to the Istio service mesh add-on for Microsoft Azure Kubernetes Service (AKS). This article also provides a list of possible error messages, reasons for error occurrences, and recommendations to resolve these errors.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster

   **Note:** To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The Istio [istioctl](https://istio.io/latest/docs/ops/diagnostic-tools/istioctl/) command-line tool

- The Client URL ([cURL](https://curl.se)) tool

## Troubleshooting checklist: Using kubectl

The following troubleshooting steps use various `kubectl` commands to help you debug stuck pods or failures in the Istio daemon (Istiod).

### Step 1: Get Istiod pod logs

Get the Istiod pod logs by running the following [kubectl logs](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_logs/) command:

```bash
kubectl logs --selector app=istiod --namespace aks-istio-system
```

### Step 2: Bounce (delete) a pod

You might have a good reason to restart a pod. Because Istiod is a deployment, it's safe to simply delete the pod by running the [kubectl delete](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_delete/) command:

```bash
kubectl delete pods <istio-pod> --namespace aks-istio-system
```

The Istio pod is managed by a deployment. It's automatically re-created and redeployed after you delete it directly. Therefore, deleting the pod is an alternative method for restarting the pod.

> [!NOTE]
> Alternatively, you can restart the deployment directly by running the following [kubectl rollout restart](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_restart/) command:
>
> ```bash
> kubectl rollout restart deployment <istiod-asm-revision> --namespace aks-istio-system
> ```

### Step 3: Check the status of resources

If Istiod isn't scheduled, or if the pod isn't responding, you might want to check the status of the deployment and the replica sets. To do this, run the [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/) command:

```bash
kubectl get <resource-type> [[--selector app=istiod] | [<resource-name>]]
```

The current resource status appears near the end of the output. The output might also display events that are associated with its controller loop.

### Step 4: Get custom resource definition types

To view the types of custom resource definitions (CRDs) that Istio uses, run the `kubectl get` command:

```bash
kubectl get crd | grep istio
```

To list all the resource names that are based on a particular CRD, run the following `kubectl get` command:

```bash
kubectl get <crd-type> --all-namespaces
```

### Step 5: View the list of Istiod pods

To view the list of Istiod pods, run the following `kubectl get` command:

```bash
kubectl get pod --namespace aks-istio-system --output yaml
```

### Step 6: Get more information about the Envoy configuration

If you have connectivity issues between pods, get more information about the Envoy configuration by running the following [kubectl exec](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_exec/) command against Envoy's admin port:

```bash
kubectl exec --namespace <pod-namespace> \
    "$(kubectl get pods \
        --namespace <pod-namespace> \
        --selector app=sleep \
        --output jsonpath='{.items[0].metadata.name}')" \
    --container sleep \
-- curl -s localhost:15000/clusters
```

### Step 7: Get the sidecar logs for the source and destination sidecars

Retrieve the sidecar logs for the source and destination sidecars by running the following `kubectl logs` command two times (the first time for the source pod, and the second time for the destination pod):

```bash
kubectl logs <pod-name> --namespace <pod-namespace> --container istio-proxy
```

## Troubleshooting checklist: Using istioctl

The following troubleshooting steps describe how to collect information and debug your mesh environment by running various `istioctl` commands.

All `istioctl` commands must be run together with the `--istioNamespace aks-istio-system` flag to point to the AKS add-on installation of Istio.

> [!WARNING]
> Some `istioctl` commands send requests to all sidecars.

> [!NOTE]
> Before you begin, notice that most `istioctl` commands require you to know the control plane revision. You can get this information from the suffix of either the Istiod deployments or the pods, or you can run the following [istioctl tag list](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-tag-list) command:
>
> `istioctl tag list`

### Step 1: Make sure that Istio is installed correctly

To verify that you have a correct Istio add-on installation, run the following [istioctl verify-install](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-verify-install) command:

```bash
istioctl verify-install --istioNamespace aks-istio-system --revision <tag>
```

### Step 2: Analyze namespaces

To analyze all namespaces, or to analyze a specific namespace, run the following [istioctl analyze](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-analyze) command:

```bash
istioctl analyze --istioNamespace aks-istio-system \
    --revision <tag> \
    [--all-namespaces | --namespace <namespace-name>] \
    [--failure-threshold {Info | Warning | Error}]
```

### Step 3: Get the proxy status

To retrieve the proxy status, run the following [istioctl proxy-status](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-status) command:

```bash
istioctl proxy-status pod/<pod-name> \
    --istioNamespace aks-istio-system \
    --revision <tag> \
    --namespace <pod-namespace>
```

### Step 4: Download the proxy configuration

To download the proxy configuration, run the following [istioctl proxy-config all](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-config-all) command:

```bash
istioctl proxy-config all <pod-name> \
    --istioNamespace aks-istio-system \
    --namespace <pod-namespace> \
    --output json
```

> [!NOTE]
> Instead of using the `all` variant of the `istioctl proxy-config` command, you can use one of the following variants:
>
> - [istioctl proxy-config ecds](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-config-ecds) (extension configuration discovery service)
> - [istioctl proxy-config bootstrap](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-config-bootstrap)
> - [istioctl proxy-config cluster](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-config-cluster)
> - [istioctl proxy-config endpoint](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-config-endpoint)
> - [istioctl proxy-config listener](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-config-listener)
> - [istioctl proxy-config log](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-config-log)
> - [istioctl proxy-config route](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-config-route)
> - [istioctl proxy-config secret](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-proxy-config-secret)

### Step 5: Check the injection status

To check the injection status of the resource, run the following [istioctl experimental check-inject]() command:

```bash
istioctl experimental check-inject --istioNamespace aks-istio-system \
    --namespace <pod-namespace> \
    --labels <label-selector> | <pod-name> | deployment/<deployment-name>
```

### Step 6: Get a full bug report

A full bug report contains the most detailed information. However, running this report can be time-consuming on a large cluster because it includes all pods. You can limit the bug report to certain namespaces. You can also limit the report to certain deployments, pods, or label selectors.

To retrieve a bug report, run the following [istioctl bug-report](https://istio.io/latest/docs/reference/commands/istioctl/#istioctl-bug-report) command:

```bash
istioctl bug-report --istioNamespace aks-istio-system \
    [--include <namespace-1>[, <namespace-2>[, ...]]]
```

## Troubleshooting checklist: Miscellaneous issues

### Step 1: Fix resource usage issues

If you encounter high memory consumption in Envoy, double-check your Envoy settings for [statistics data collection](https://istio.io/latest/docs/ops/configuration/telemetry/envoy-stats/). If you're [customizing Istio metrics](https://istio.io/latest/docs/tasks/observability/metrics/customize-metrics/) through [MeshConfig](./istio-add-on-meshconfig.md), remember that certain metrics can have [high cardinality](https://istio.io/latest/about/faq/metrics-and-logs/#metric-expiry) and, therefore, create a higher memory footprint. Other fields in MeshConfig, such as concurrency, affect CPU usage and should be configured carefully.

By default, Istio adds information about all services that are in the cluster to every Envoy configuration. The [sidecar](https://istio.io/latest/docs/reference/config/networking/sidecar/) can limit the scope of this addition to workloads that are within specific namespaces only. For more information, see [Watch out for this Istio proxy sidecar memory pitfall](https://medium.com/geekculture/watch-out-for-this-istio-proxy-sidecar-memory-pitfall-8dbd99ea7e9d).

For example, the following `Sidecar` definition in the `aks-istio-system` namespace restricts the Envoy configuration for all proxies across the mesh to `aks-istio-system` and other workloads within the same namespace as that specific application:

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: Sidecar
metadata:
  name: sidecar-restrict-egress
  namespace: aks-istio-system  # Needs to be deployed in the root namespace.
spec:
  egress:
  - hosts:
    - "./*"
    - "aks-istio-system/*"
```

You can also try to use the Istio [discoverySelectors](https://istio.io/latest/blog/2021/discovery-selectors/) option in [MeshConfig](./istio-add-on-meshconfig.md#step-5-fix-memory-consumption-issues). The `discoverySelectors` option contains an array of Kubernetes selectors, and it can restrict Istiod's awareness to specific namespaces (as opposed to all namespaces in the cluster). For more information, see [Use discovery selectors to configure namespaces for your Istio service mesh](https://istio.io/v1.14/blog/2021/discovery-selectors/).

### Step 2: Fix traffic and security misconfiguration issues

To address common traffic management and security misconfiguration issues that Istio users frequently encounter, see [Traffic management problems](https://istio.io/latest/docs/ops/common-problems/network-issues/) and [Security problems](https://istio.io/latest/docs/ops/common-problems/security-issues/) on the Istio website.

For links to discussion about other issues, such as sidecar injection, observability, and upgrades, see [Common problems](https://istio.io/latest/docs/ops/common-problems/) on the Istio documentation site.

### Step 3: Avoid CoreDNS overload

Issues that relate to CoreDNS overload might require you to change certain Istio DNS settings, such as the `dnsRefreshRate` field in the Istio MeshConfig definition. 

### Step 4: Fix pod and sidecar race conditions

If your application pod starts before the Envoy sidecar starts, the application might become unresponsive, or it might restart. For instructions about how to avoid this problem, see [Pod or containers start with network issues if istio-proxy is not ready](https://istio.io/latest/docs/ops/common-problems/injection/#pod-or-containers-start-with-network-issues-if-istio-proxy-is-not-ready). Specifically, setting the `holdApplicationUntilProxyStarts` MeshConfig field under `defaultConfig` to `true` can help prevent these race conditions.

### Step 5: Configure a Service Entry when using an HTTP proxy for outbound traffic

If your cluster uses an HTTP proxy for outbound internet access, you'll have to configure a Service Entry. For more information, see [HTTP proxy support in Azure Kubernetes Service](/azure/aks/http-proxy#istio-add-on-http-proxy-for-external-services).

### Step 6: Enable Envoy access logging

Enabling Envoy [access logging](https://istio.io/latest/docs/tasks/observability/logs/access-log/) helps identify and pinpoint issues in the gateways and sidecar proxies. For more information about logging and telemetry collection for the Istio add-on, see the documentation on [mesh configuration](/azure/aks/istio-meshconfig), [Telemetry API](/azure/aks/istio-telemetry), and [Istio metrics collection](/azure/aks/istio-metrics-managed-prometheus).

## Error messages

The following table contains a list of possible error messages (for deploying the add-on, enabling ingress gateways, and performing upgrades), the reason why an error occurred, and recommendations for resolving the error.

| Error | Reason | Recommendations |
|--|--|--|
| `Azure service mesh is not supported in this region` | The feature isn't available in the region during preview (it's available in the public cloud but not the sovereign cloud). | Refer to public documentation about the feature on supported regions. |
| `Missing service mesh mode: {}` | You didn't set the mode property in the service mesh profile of the managed cluster request. | In the [ServiceMeshProfile](/azure/templates/microsoft.containerservice/managedclusters?pivots=deployment-language-arm-template#servicemeshprofile-1) field of the `managedCluster` API request, set the `mode` property to `Istio`. |
| `Invalid istio ingress mode: {}` | You set an invalid value for the ingress mode when adding ingress within the service mesh profile. | Set the ingress mode in the API request to either `External` or `Internal`. |
| `Too many ingresses for type: {}. Only {} ingress gateway are allowed` | You tried to create too many ingresses on the cluster. | Create, at most, one external ingress and one internal ingress on the cluster. |
| `Istio profile is missing even though Service Mesh mode is Istio` | You enabled the Istio add-on without providing the Istio profile. | When you enable the Istio add-on, specify component-specific (ingress gateway, plug-in CA) information for the Istio profile and the particular revision. |
| `Istio based Azure service mesh is incompatible with feature %s` | You tried to use another extension, add-on, or feature that's currently incompatible with the Istio add-on (for example, Open Service Mesh). | Before you enable the Istio add-on, disable the other feature first and clean up all corresponding resources. |
| `ServiceMeshProfile is missing required parameters: %s for plugin certificate authority` | You didn't provide all the required parameters for plug-in CA. | Provide all required parameters for the plug-in certificate authority (CA) feature (for more information, see [Set up Istio-based service mesh add-on with plug-in CA certificates](/azure/aks/istio-plugin-ca#set-up-istio-based-service-mesh-addon-with-plug-in-ca-certificates)). |
| `AzureKeyvaultSecretsProvider addon is required for Azure Service Mesh plugin certificate authority feature` | You didn't enable the AKS Secrets-Store CSI Driver add-on before you used the plug-in CA. | [Set up Azure Key Vault](/azure/aks/istio-plugin-ca#set-up-azure-key-vault) before you use the plug-in CA feature. |
| `'KeyVaultId': '%s' is not a valid Azure keyvault resource identifier. Please make sure that the format matches '/subscriptions//resourceGroups//providers/Microsoft.KeyVault/vaults/'` | You used an invalid AKS resource ID. | See the format that's mentioned in the error message to set a valid Azure Key Vault ID for the plug-in CA feature. |
| `Kubernetes version is missing in orchestrator profile` | Your request is missing the Kubernetes version. Therefore, it can't do a version compatibility check. | Make sure that you provide the Kubernetes version in Istio add-on upgrade operations. |
| `Service mesh revision %s is not compatible with cluster version %s. To find information about mesh-cluster compatibility, use 'az aks mesh get-upgrades'` | You tried to enable an Istio add-on revision that's incompatible with the current Kubernetes cluster version. | Use the [az aks mesh get-upgrades](/cli/azure/aks/mesh#az-aks-mesh-get-upgrades) Azure CLI command to learn which Istio add-on revisions are available for the current cluster. |
| `Kubernetes version %s not supported. Please upgrade to a supported cluster version first. To find compatibility information, use 'az aks mesh get-upgrades'` | You're using an unsupported Kubernetes version. | [Upgrade to a supported Kubernetes version](/azure/aks/upgrade-cluster). |
| `ServiceMeshProfile revision field must not be empty` | You tried to upgrade the Istio add-on without specifying a revision. | Specify the revision and all other parameters (for more information, see [Minor revision upgrade](/azure/aks/istio-upgrade#minor-revision-upgrade)). |
| `Request exceeds maximum allowed number of revisions (%d)` | You tried to do an upgrade operation even though there are already `(%d)` revisions installed. | [Complete or roll back the upgrade operation](/azure/aks/istio-upgrade#minor-revision-upgrade) before you upgrade to another revision. |
| `Mesh upgrade is in progress. Please complete or roll back the current upgrade before attempting to retrieve versioning and compatibility information` | You tried to access revisioning and compatibility information before completing or rolling back the current upgrade operation. | [Complete or roll back the current upgrade operation](/azure/aks/istio-upgrade#minor-revision-upgrade) before you retrieve revisioning and compatibility information. |

## References

- For general tips about Istio debugging, see [Istio diagnostic tools](https://istio.io/latest/docs/ops/diagnostic-tools/)

- [Istio service mesh add-on MeshConfig troubleshooting](istio-add-on-meshconfig.md)

- [Istio service mesh add-on ingress gateway troubleshooting](istio-add-on-ingress-gateway.md)

- [Istio service mesh add-on minor revision upgrade troubleshooting](istio-add-on-minor-revision-upgrade.md)

- [Istio service mesh add-on plug-in CA certificate troubleshooting](istio-add-on-plug-in-ca-certificate.md)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
