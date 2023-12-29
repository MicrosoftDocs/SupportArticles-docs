---
title: Troubleshoot the Open Service Mesh (OSM) add-on for AKS
description: Understand how to troubleshoot the Open Service Mesh (OSM) add-on for Azure Kubernetes Service (AKS).
ms.topic: troubleshooting-general
ms.date: 12/28/2023
author: phillipgibson
ms.author: pgibson
editor: v-jsitser
ms.reviewer: cssakscic, v-ntjandra, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-extensions-add-ons
---

# Troubleshoot the Open Service Mesh (OSM) add-on for Azure Kubernetes Service (AKS)

When you deploy the Open Service Mesh (OSM) add-on for Microsoft Azure Kubernetes Service (AKS), you might experience problems that affect the service mesh configuration. The article explores common troubleshooting errors and how to resolve them.

> [!NOTE]
> Following the retirement of [Open Service Mesh (OSM)](https://docs.openservicemesh.io/) by the Cloud Native Computing Foundation (CNCF), we recommend that you migrate your OSM configurations to an equivalent Istio configuration. For information about how to migrate from OSM to Istio, see [Migration guidance for Open Service Mesh (OSM) configurations to Istio](/azure/aks/open-service-mesh-istio-migration-guidance).

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- [Open Service Mesh](https://openservicemesh.io/).

## Troubleshooting checklist

### Troubleshooting step 1: Check OSM controller deployment, pod, and service

Check the health of the OSM controller deployment, pod, and service by running the `kubectl get deployment,pod,service` command:

```azurecli-interactive
kubectl get deployment,pod,service --namespace kube-system --selector app=osm-controller
```

A healthy OSM controller produces output that resembles the following text:

```output
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/osm-controller   2/2     2            2           3m4s

NAME                                  READY   STATUS    RESTARTS   AGE
pod/osm-controller-65bd8c445c-zszp4   1/1     Running   0          2m
pod/osm-controller-65bd8c445c-xqhmk   1/1     Running   0          16s

NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                       AGE
service/osm-controller   ClusterIP   10.96.185.178   <none>        15128/TCP,9092/TCP,9091/TCP   3m4s
service/osm-validator    ClusterIP   10.96.11.78     <none>        9093/TCP                      3m4s
```

> [!NOTE]
> For the `osm-controller` services, the `CLUSTER-IP` column value is different. However, the service `NAME` and `PORT(S)` column values must be the same as the example output.

### Troubleshooting step 2: Check OSM injector deployment, pod, and service

Check the health of the OSM injector deployment, pod, and service by running the `kubectl get deployment,pod,service` command:

```azurecli-interactive
kubectl get deployment,pod,service --namespace kube-system --selector app=osm-injector
```

A healthy OSM injector produces output that resembles the following text:

```output
NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/osm-injector   2/2     2            2           4m37s

NAME                                READY   STATUS    RESTARTS   AGE
pod/osm-injector-5c49bd8d7c-b6cx6   1/1     Running   0          4m21s
pod/osm-injector-5c49bd8d7c-dx587   1/1     Running   0          4m37s

NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/osm-injector   ClusterIP   10.96.236.108   <none>        9090/TCP   4m37s
```

### Troubleshooting step 3: Check OSM bootstrap deployment, pod, and service

Check the health of the OSM bootstrap deployment, pod, and service by running the `kubectl get deployment,pod,service` command:

```azurecli-interactive
kubectl get deployment,pod,service --namespace kube-system --selector app=osm-bootstrap
```

A healthy OSM bootstrap produces output that resembles the following text:

```output
NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/osm-bootstrap   1/1     1            1           5m25s

NAME                                 READY   STATUS    RESTARTS   AGE
pod/osm-bootstrap-594ffc6cb7-jc7bs   1/1     Running   0          5m25s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
service/osm-bootstrap   ClusterIP   10.96.250.208   <none>        9443/TCP,9095/TCP   5m25s
```

### Troubleshooting step 4: Check validating and mutating webhooks

1. Check the health of the OSM validating webhook by running the `kubectl get ValidatingWebhookConfiguration` command:

    ```azurecli-interactive
    kubectl get ValidatingWebhookConfiguration --selector app=osm-controller
    ```

    A healthy OSM validating webhook produces output that resembles the following text:

    ```output
    NAME                         WEBHOOKS   AGE
    aks-osm-validator-mesh-osm   1          81m
    ```

2. Check the health of the OSM mutating webhook by running the `kubectl get MutatingWebhookConfiguration` command:

    ```azurecli-interactive
    kubectl get MutatingWebhookConfiguration --selector app=osm-injector
    ```

    A healthy OSM mutating webhook produces output that resembles the following text:

    ```output
    NAME                  WEBHOOKS   AGE
    aks-osm-webhook-osm   1          102m
    ```

### Troubleshooting step 5: Check for the service and CA bundle of the validating webhook

Check for the service and certificate authority (CA) bundle of the OSM validating webhook by running the `kubectl get ValidatingWebhookConfiguration` command together with `aks-osm-validator-mesh-osm` and `jq '.webhooks[0].clientConfig.service'`:

```azurecli-interactive
kubectl get ValidatingWebhookConfiguration aks-osm-validator-mesh-osm --output json | jq '.webhooks[0].clientConfig.service'
```

A well-configured validating webhook configuration resembles the following JSON output:

```json
{
  "name": "osm-config-validator",
  "namespace": "kube-system",
  "path": "/validate-webhook",
  "port": 9093
}
```

### Troubleshooting step 6: Check for the service and CA bundle of the mutating webhook

Check for the service and CA bundle of the OSM mutating webhook by running the `kubectl get ValidatingWebhookConfiguration` command together with `aks-osm-validator-mesh-osm` and `jq '.webhooks[0].clientConfig.service'`:

```azurecli-interactive
kubectl get MutatingWebhookConfiguration aks-osm-webhook-osm --output json | jq '.webhooks[0].clientConfig.service'
```

A well-configured mutating webhook configuration resembles the following JSON output:

```json
{
  "name": "osm-injector",
  "namespace": "kube-system",
  "path": "/mutate-pod-creation",
  "port": 9090
}
```

### Troubleshooting step 7: Check the osm-mesh-config resource

1. Make sure that the OSM MeshConfig resource exists by running the `kubectl get meshconfig` command:

    ```azurecli-interactive
    kubectl get meshconfig osm-mesh-config --namespace kube-system
    ```

2. Check the contents of the OSM MeshConfig resource by running the `kubectl get meshconfig` command together with `--output yaml`:

    ```azurecli-interactive
    kubectl get meshconfig osm-mesh-config --namespace kube-system --output yaml
    ```

    ```yaml
    apiVersion: config.openservicemesh.io/v1alpha1
    kind: MeshConfig
    metadata:
      creationTimestamp: "0000-00-00A00:00:00A"
      generation: 1
      name: osm-mesh-config
      namespace: kube-system
      resourceVersion: "2494"
      uid: 6c4d67f3-c241-4aeb-bf4f-b029b08faa31
    spec:
      certificate:
        serviceCertValidityDuration: 24h
      featureFlags:
        enableEgressPolicy: true
        enableMulticlusterMode: false
        enableWASMStats: true
      observability:
        enableDebugServer: true
        osmLogLevel: info
        tracing:
          address: jaeger.kube-system.svc.cluster.local
          enable: false
          endpoint: /api/v2/spans
          port: 9411
      sidecar:
        configResyncInterval: 0s
        enablePrivilegedInitContainer: false
        envoyImage: mcr.microsoft.com/oss/envoyproxy/envoy:v1.18.3
        initContainerImage: mcr.microsoft.com/oss/openservicemesh/init:v0.9.1
        logLevel: error
        maxDataPlaneConnections: 0
        resources: {}
      traffic:
        enableEgress: true
        enablePermissiveTrafficPolicyMode: true
        inboundExternalAuthorization:
          enable: false
          failureModeAllow: false
          statPrefix: inboundExtAuthz
          timeout: 1s
        useHTTPSIngress: false
    ```

#### osm-mesh-config resource values

| Key | Type | Default value | Kubectl Patch command examples |
|-----|------|---------------|--------------------------------|
| spec.traffic.enableEgress | bool | `true` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"traffic":{"enableEgress":true}}}'  --type=merge` |
| spec.traffic.enablePermissiveTrafficPolicyMode | bool | `true` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"traffic":{"enablePermissiveTrafficPolicyMode":true}}}'  --type=merge` |
| spec.traffic.useHTTPSIngress | bool | `false` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"traffic":{"useHTTPSIngress":true}}}'  --type=merge` |
| spec.traffic.outboundPortExclusionList | array | `[]` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"traffic":{"outboundPortExclusionList":[6379,8080]}}}'  --type=merge` |
| spec.traffic.outboundIPRangeExclusionList | array | `[]` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"traffic":{"outboundIPRangeExclusionList":["10.0.0.0/32","1.1.1.1/24"]}}}'  --type=merge` |
| spec.traffic.inboundPortExclusionList | array | `[]` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"traffic":{"inboundPortExclusionList":[6379,8080]}}}'  --type=merge` |
| spec.certificate.serviceCertValidityDuration | string | `"24h"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"certificate":{"serviceCertValidityDuration":"24h"}}}'  --type=merge` |
| spec.observability.enableDebugServer | bool | `true` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"observability":{"enableDebugServer":true}}}'  --type=merge` |
| spec.observability.tracing.enable | bool | `false` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"observability":{"tracing":{"enable":true}}}}'  --type=merge` |
| spec.observability.tracing.address | string | `"jaeger.kube-system.svc.cluster.local"`| `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"observability":{"tracing":{"address": "jaeger.kube-system.svc.cluster.local"}}}}'  --type=merge` |
| spec.observability.tracing.endpoint | string | `"/api/v2/spans"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"observability":{"tracing":{"endpoint":"/api/v2/spans"}}}}'  --type=merge` |
| spec.observability.tracing.port | int | `9411`| `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"observability":{"tracing":{"port":9411}}}}'  --type=merge` |
| spec.observability.tracing.osmLogLevel | string | `"info"`| `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"observability":{"tracing":{"osmLogLevel": "info"}}}}'  --type=merge` |
| spec.sidecar.enablePrivilegedInitContainer | bool | `false` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"sidecar":{"enablePrivilegedInitContainer":true}}}'  --type=merge` |
| spec.sidecar.logLevel | string | `"error"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"sidecar":{"logLevel":"error"}}}'  --type=merge` |
| spec.sidecar.maxDataPlaneConnections | int | `0` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"sidecar":{"maxDataPlaneConnections":"error"}}}'  --type=merge` |
| spec.sidecar.envoyImage | string | `"mcr.microsoft.com/oss/envoyproxy/envoy:v1.19.1"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"sidecar":{"envoyImage":"mcr.microsoft.com/oss/envoyproxy/envoy:v1.19.1"}}}'  --type=merge` |
| spec.sidecar.initContainerImage | string | `"mcr.microsoft.com/oss/openservicemesh/init:v0.11.1"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"sidecar":{"initContainerImage":"mcr.microsoft.com/oss/openservicemesh/init:v0.11.1"}}}' --type=merge` |
| spec.sidecar.configResyncInterval | string | `"0s"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"sidecar":{"configResyncInterval":"30s"}}}'  --type=merge` |
| spec.featureFlags.enableWASMStats | bool | `"true"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"featureFlags":{"enableWASMStats":"true"}}}'  --type=merge` |
| spec.featureFlags.enableEgressPolicy | bool | `"true"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"featureFlags":{"enableEgressPolicy":"true"}}}'  --type=merge` |
| spec.featureFlags.enableMulticlusterMode | bool | `"false"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"featureFlags":{"enableMulticlusterMode":"false"}}}'  --type=merge` |
| spec.featureFlags.enableSnapshotCacheMode | bool | `"false"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"featureFlags":{"enableSnapshotCacheMode":"false"}}}'  --type=merge` |
| spec.featureFlags.enableAsyncProxyServiceMapping | bool | `"false"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"featureFlags":{"enableAsyncProxyServiceMapping":"false"}}}'  --type=merge` |
| spec.featureFlags.enableIngressBackendPolicy | bool | `"true"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"featureFlags":{"enableIngressBackendPolicy":"true"}}}'  --type=merge` |
| spec.featureFlags.enableEnvoyActiveHealthChecks | bool | `"false"` | `kubectl patch meshconfig osm-mesh-config --namespace kube-system --patch '{"spec":{"featureFlags":{"enableEnvoyActiveHealthChecks":"false"}}}'  --type=merge` |

### Troubleshooting step 8: Check namespaces

> [!NOTE]
> The `kube-system` namespace never participates in a service mesh. It's never labeled or annotated in the following key-value combinations.

The `osm namespace add` command enables you to join namespaces to a given service mesh. In order for a K8s namespace to become part of the mesh, it must have the following annotation and label:

1. View the annotations by running the `kubectl get namespace` command together with `jq '.metadata.annotations'`:

    ```azurecli-interactive
    kubectl get namespace bookbuyer --output json | jq '.metadata.annotations'
    ```

    You must see the following annotation in the JSON output:

    ```json
    {
      "openservicemesh.io/sidecar-injection": "enabled"
    }
    ```

2. View the labels by running the `kubectl get namespaces` command together with `jq '.metadata.labels'`:

    ```azurecli-interactive
    kubectl get namespace bookbuyer --output json | jq '.metadata.labels'
    ```

    You must see the following label in the JSON output:

    ```json
    {
      "openservicemesh.io/monitored-by": "osm"
    }
    ```

If a namespace doesn't have the `"openservicemesh.io/sidecar-injection": "enabled"` annotation or the `"openservicemesh.io/monitored-by": "osm"` label, the OSM injector doesn't add Envoy sidecars.

> [!NOTE]
> After `osm namespace add` is called, only new pods are injected with an Envoy sidecar. You must restart existing pods by running `kubectl rollout restart deployment ...`.

### Troubleshooting step 9: Verify OSM custom resource definitions

1. Check whether the cluster has the required custom resource definitions (CRDs) by running the `kubectl get crds` command:

    ```azurecli-interactive
    kubectl get crds
    ```

    You must have the following CRDs on the cluster:

    - egresses.policy.openservicemesh.io
    - httproutegroups.specs.smi-spec.io
    - ingressbackends.policy.openservicemesh.io
    - meshconfigs.config.openservicemesh.io
    - multiclusterservices.config.openservicemesh.io
    - tcproutes.specs.smi-spec.io
    - trafficsplits.split.smi-spec.io
    - traffictargets.access.smi-spec.io

2. Get the installed versions of the Service Mesh Interface (SMI) CRDs by running the `osm mesh list` command:

    ```azurecli-interactive
    osm mesh list
    ```

    The output should resemble the following text:

    ```output
    MESH NAME   MESH NAMESPACE   VERSION   ADDED NAMESPACES
    osm         kube-system      v0.11.1

    MESH NAME   MESH NAMESPACE   SMI SUPPORTED
    osm         kube-system      HTTPRouteGroup:v1alpha4,TCPRoute:v1alpha4,TrafficSplit:v1alpha2,TrafficTarget:v1alpha3
    ```

    OSM Controller v0.11.1 requires the following versions.

    | SMI CRD | Version |
    |--|--|
    | httproutegroups.specs.smi-spec.io | [v1alpha4](https://github.com/servicemeshinterface/smi-spec/blob/v0.6.0/apis/traffic-specs/v1alpha4/traffic-specs.md#httproutegroup) |
    | tcproutes.specs.smi-spec.io | [v1alpha4](https://github.com/servicemeshinterface/smi-spec/blob/v0.6.0/apis/traffic-specs/v1alpha4/traffic-specs.md#tcproute) |
    | trafficsplits.split.smi-spec.io | [v1alpha2](https://github.com/servicemeshinterface/smi-spec/blob/v0.6.0/apis/traffic-split/v1alpha2/traffic-split.md) |
    | traffictargets.access.smi-spec.io | [v1alpha3](https://github.com/servicemeshinterface/smi-spec/blob/v0.6.0/apis/traffic-access/v1alpha3/traffic-access.md) |
    | udproutes.specs.smi-spec.io | Not supported |
    | \*.metrics.smi-spec.io | [v1alpha1](https://github.com/servicemeshinterface/smi-spec/blob/v0.6.0/apis/traffic-metrics/v1alpha1/traffic-metrics.md) |

### Troubleshooting step 10: Learn how to manage certificates

For more information about how OSM distributes and manages certificates to Envoy proxies that run on application pods, see the [OSM certificates guide](https://docs.openservicemesh.io/docs/guides/certificates/).

### Troubleshooting step 11: Upgrade the Envoy version

When you create a new pod in a namespace that the add-on monitors, OSM injects an [Envoy proxy sidecar](https://docs.openservicemesh.io/docs/guides/app_onboarding/sidecar_injection/) into that pod. For more information about how to update the Envoy version, see the [OSM upgrade guide](https://docs.openservicemesh.io/docs/getting_started/).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
