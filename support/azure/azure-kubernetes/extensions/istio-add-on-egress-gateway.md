---
title: Istio Service Mesh Add-on Egress Gateway Troubleshooting
description: Learn how to do egress gateway troubleshooting on the Istio service mesh add-on for Azure Kubernetes Service (AKS).
ms.date: 05/29/2025
ms.reviewer: nshankar, kochhars, v-weizhu
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the egress gateway of the Istio add-on so that I can use the Istio service mesh successfully.
---
# Istio service mesh add-on egress gateway troubleshooting

This article discusses how to troubleshoot egress gateway issues on the Istio service mesh add-on for Azure Kubernetes Service (AKS).

## Overview

The Istio add-on egress gateway is an Envoy-based proxy that can be used to route outbound traffic from applications in the mesh. The Istio egress gateway is a `ClusterIP` type service. Therefore, it isn't exposed externally.

The Istio add-on egress gateway takes a hard dependency on the [Static Egress Gateway feature](/azure/aks/configure-static-egress-gateway). You must enable the Static Egress Gateway feature on your cluster before you enable an Istio add-on egress gateway.

You can create multiple Istio add-on egress gateways across different namespaces by using a `Deployment` or `Service` `name` of your choice, with a max of `500` egress gateways per cluster.

## Before troubleshooting

Before you proceed, take the following actions:

- Install Azure CLI `aks-preview` version `14.0.0b2` or a later version to enable an Istio add-on egress gateway.
- Enable the [Static Egress Gateway feature](/azure/aks/configure-static-egress-gateway) on your cluster, create an agent pool of mode `gateway`, and configure a `StaticGatewayConfiguration` custom resource.

## Networking and firewall errors troubleshooting

### Step 1: Make sure no firewall or outbound traffic rules block egress traffic

If you use Azure Firewall, Network Security Group (NSG) rules, or other outbound traffic restrictions, make sure that the IP ranges from the `egressIpPrefix` for the Istio add-on egress gateway `StaticGatewayConfigurations` are added to an allowlist for egress communication.

### Step 2: Verify cluster Container Networking Interface (CNI) plugin

Because Static Egress Gateway is currently not supported on [Azure CNI Pod Subnet](/azure/aks/concepts-network-azure-cni-pod-subnet) clusters, the Istio add-on egress gateway can't be used on Azure CNI Pod Subnet clusters either.

## Egress gateway provisioning issues troubleshooting

### Step 1: Verify that the Istio egress gateway deployment and service are provisioned

Each Istio egress gateway should have a respective deployment and service provisioned. Verify that the Istio egress gateway deployment and service are provisioned by running the following commands:

```bash
kubectl get deployment $ISTIO_EGRESS_DEPLOYMENT_NAME -n $ISTIO_EGRESS_NAMESPACE
```

```bash
kubectl get service $ISTIO_EGRESS_NAME -n $ISTIO_EGRESS_NAMESPACE
```

The name of the deployment is in this format: `<istio-egress-gateway-name>-<asm-revision>`. For example, if the name of the egress gateway is `aks-istio-egressgateway`, and the Istio add-on revision is `asm-1-24`, the name of the deployment is `aks-istio-egressgateway-asm-1-24`.

You should see a service type of `ClusterIP` for the Istio egress gateway, and a service VIP should be assigned. The name of the service is the same as the name of the Istio egress gateway, without any `revision` appended. For example, `aks-istio-egressgateway`.

### Step 2: Make sure admission controllers don't block Istio egress provisioning

Make sure that self-managed mutating and validating webhooks don't block provisioning of the Istio egress gateway resources. Because the Istio egress gateway can be deployed in user-managed namespaces, [AKS admissions enforcer](/azure/aks/faq#can-admission-controller-webhooks-affect-kube-system-and-internal-aks-namespaces-) can't prevent custom admission controllers from affecting Istio egress gateway resources.

### Step 3: Verify that the Istio add-on egress gateway name is valid

Istio egress gateway names must:

- Be 63 characters or fewer long.
- Contain only lowercase alphanumeric characters, periods (.), and hyphens (-).
- Start and end in a lowercase alphanumerical character.
- Be valid Domain Name System (DNS) names.

The regex for Istio egress name validations is `^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$`.

### Step 4: Inspect Static Egress Gateway components if Istio egress deployments aren't ready

If Static Egress Gateway components such as the `kube-egress-gateway-cni-manager` stop responding, or other issues affect the static egress IP allocation, Istio egress gateway provisioning might fail. In this case, [troubleshoot Static Egress Gateway errors or misconfiguration](#static-egress-gateway-errors-or-misconfiguration-troubleshooting).

## Static Egress Gateway errors or misconfiguration troubleshooting

### Step 1: Inspect the Istio egress gateway StaticGatewayConfiguration

Make sure that the `StaticGatewayConfiguration` resource for the Istio add-on egress gateway has a valid configuration and isn't deleted:

1. Check the `gatewayConfigurationName` for that egress gateway to find the name of the `StaticGatewayConfiguration` for an Istio add-on egress gateway:

    ```bash
    az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME -o json | jq '.serviceMeshProfile.istio.components.egressGateways' | grep $ISTIO_EGRESS_NAME -B1
    ```

2. Verify that the Istio add-on egress gateway pod `spec` has the `kubernetes.azure.com/static-gateway-configuration` annotation set to the `gatewayConfigurationName` for that Istio add-on egress gateway:

    ```bash
    kubectl get pod $ISTIO_EGRESS_POD_NAME -n $ISTIO_EGRESS_NAMESPACE -o jsonpath={.metadata.annotations."kubernetes\.azure\.com\/static-gateway-configuration"}
    ```

### Step 2: Make sure that an egressIpPrefix is provisioned for the StaticGatewayConfiguration

If the Istio egress gateway pods are stuck in `ContainerCreating`, the `kube-egress-gateway-cni-manager` pod might prevent the `istio-proxy` container from being created because the `StaticGatewayConfiguration` resource doesn't have an `egressIpPrefix` assigned to it yet. To verify whether an `egressIpPrefix` is assigned to the resource, check the `status` value of `StaticGatewayConfiguration` for that Istio egress gateway. To determine whether any errors affect the `egressIpPrefix` provisioning, run the `kubectl describe` command against `StaticGatewayConfiguration`.

> [!NOTE]
> The process to assign an `egressIpPrefix` to a Static Egress Gateway `StaticGatewayConfiguration` can take up to five minutes.

```bash
kubectl get staticgatewayconfiguration $ISTIO_SGC_NAME -n $ISTIO_EGRESS_NAMESPACE -o jsonpath='{.status.egressIpPrefix}'
kubectl describe staticgatewayconfiguration $ISTIO_SGC_NAME -n $ISTIO_EGRESS_NAMESPACE
```

You can also check the logs of the `kube-egress-gateway-cni-manager` pod that runs on the node of the failing Istio egress pod. If any issues affect `egressIpPrefix` provisioning, or if an IP prefix still isn't assigned after approximately five minutes, you might have to further [debug the Static Egress Gateway](#step-8-debug-the-static-egress-gateway).

### Step 3: Make sure that the StaticGatewayConfiguration references a valid gateway agent pool

Verify that the `spec.gatewayNodepoolName` for the `StaticGatewayConfiguration` for each Istio egress gateway references a valid agent pool of the mode type `Gateway` on the cluster. If any Istio add-on egress gateway `StaticGatewayConfiguration` references an agent pool through the `spec.gatewayNodepoolName`, you shouldn't delete a `Gateway` agent pool.

### Step 4: Try to send an external request from the Istio egress gateway

Verify that requests from the Istio egress gateway are routed correctly through the Static Egress Gateway node pool. To take this action, use the `kubectl debug` command to create a Kubernetes ephemeral container and verify the source IP of requests from the Istio egress pod. Make sure that you temporarily set `outboundTrafficPolicy.mode` to `ALLOW_ANY` so that the egress gateway can access `ifconfig.me`. As a security best practice, we recommend that you revert `outboundTrafficPolicy.mode` to `REGISTRY_ONLY` after you finish debugging.

```bash
kubectl debug -it --image curlimages/curl $ISTIO_EGRESS_POD_NAME -n $ISTIO_EGRESS_NAMESPACE -- curl ifconfig.me
```

The source IP address that's returned should match the `egressIpPrefix` value of the `StaticGatewayConfiguration` that's associated with that Istio egress gateway. If the request fails or the source IP address returned doesn't match the `egressIpPrefix`, try [to restart the Istio egress gateway deployment](#step-6-try-to-restart-the-istio-egress-gateway-deployment) or debugging potential issues by using [Static Egress Gateway](#step-8-debug-the-static-egress-gateway).

### Step 5: Try to send a request from an uninjected pod to the external service

Another way to identify whether the issue is caused by the Istio add-on egress gateway or the Static Egress Gateway is to send a request directly from an uninjected pod (outside of the Istio mesh). You can use the [curl sample application](https://raw.githubusercontent.com/istio/istio/release-1.25/samples/curl/curl.yaml). Under `spec.template.metadata.annotations`, set the `kubernetes.azure.com/static-gateway-configuration` annotation to the same `gatewayConfigurationName` for the Istio add-on egress gateway.

If the requests from the uninjected pod fail, try to debug potential issues that affect the [Static Egress Gateway](#step-8-debug-the-static-egress-gateway). If the requests from the uninjected pod succeed, verify your [Istio egress gateway configurations](#istio-egress-configuration-and-custom-resources-troubleshooting).

### Step 6: Try to restart the Istio egress gateway deployment

For changes to take effect to certain `StaticGatewayConfiguration` fields such as `defaultRoute` and `excludeCidrs`, you must restart the Istio add-on egress gateway pods.

You can bounce the pod by triggering a restart of the egress gateway deployment:

```bash
kubectl rollout restart deployment $ISTIO_EGRESS_DEPLOYMENT_NAME -n $ISTIO_EGRESS_NAMESPACE
```

### Step 7: Try to create a new StaticGatewayConfiguration for the Istio add-on egress gateway

If the `StaticGatewayConfiguration` for the Istio add-on egress gateway has an error, try to create a new `StaticGatewayConfiguration` custom resource in the same namespace. Then, run the following `az aks mesh enable-egress-gateway` command to update the `gatewayConfigurationName`. We recommend that you wait until the newly created `StaticGatewayConfiguration` is assigned an `egressIpPrefix`:

```bash
az aks mesh enable-egress-gateway --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --istio-egressgateway-name $ISTIO_EGRESS_NAME --istio-egressgateway-namespace $ISTIO_EGRESS_NAMESPACE --gateway-configuration-name $NEW_ISTIO_SGC_NAME
```

After you update the egress gateway to use the new `StaticGatewayConfiguration`, you should be able to delete the previous `StaticGatewayConfiguration` if no other Istio add-on egress gateway uses it.

### Step 8: Debug the Static Egress Gateway

If errors that affect egress routing through the Istio add-on egress gateway persist even after you verify that [Istio egress routing is configured correctly](#istio-egress-configuration-and-custom-resources-troubleshooting), an underlying networking or infrastructure issue that affects the Static Egress Gateway might exist. For more information, see the [Configure Static Egress Gateway in Azure Kubernetes Service (AKS)](/azure/aks/configure-static-egress-gateway).

## Istio egress configuration and custom resources troubleshooting

For more information about Istio egress configuration, see [Egress Gateways](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/).

> [!NOTE]
> Gateway API is currently unsupported for the Istio add-on egress gateway. You must configure the gateway by using Istio custom resources to receive support from Azure for issues that are related to the Istio egress gateway.

### Step 1: Enable Envoy access logging

You can enable Envoy access logging through the [Istio MeshConfig](/azure/aks/istio-meshconfig) or [Telemetry API](/azure/aks/istio-telemetry) to inspect traffic that flows through the egress gateway.

### Step 2: Inspect Istio egress gateway and istiod logs

To inspect the logs in the `istio-proxy` container for the Istio add-on egress gateway, run the following command:

```bash
kubectl logs $ISTIO_EGRESS_POD_NAME -n $ISTIO_EGRESS_NAMESPACE
```

An `info Envoy proxy is ready` message that appears in the logs indicates that the Istio egress gateway pod can communicate with `istiod` and is ready to serve traffic.

We also recommend that you inspect the `istiod` control plane logs for any Envoy `xDS` errors that are related to updating the configuration of the Istio egress gateway.

### Step 3: Validate the Istio Gateway configuration

Make sure that the `selector` in the `Gateway` custom resource is correctly set. For example, if your `Gateway` object for the Istio egress gateway uses the `istio:` selector, it must match the value of the `istio` label in the Kubernetes service `spec` for that egress gateway.

For example, for an egress gateway that has the following Kubernetes service `spec`:

```yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    meta.helm.sh/release-name: asm-egx-asm-egress-test
    meta.helm.sh/release-namespace: istio-egress-ns
  creationTimestamp: "2025-04-19T21:50:08Z"
  labels:
    app: asm-egress-test
    azureservicemesh/istio.component: egress-gateway
    istio: asm-egress-test
```

The `Gateway` custom resource should be configured as follows:

```yaml
apiVersion: networking.istio.io/v1
kind: Gateway
metadata:
  name: istio-egressgateway
spec:
  selector:
    istio: asm-egress-test
```

### Step 4: make sure that a ServiceEntry custom resource is created and has a DNS resolution enabled

Make sure that you create a `ServiceEntry` custom resource for the specific external service that the egress gateway forwards requests to. Even if the `outboundTrafficPolicy.mode` is set to `ALLOW_ANY`, create a `ServiceEntry` custom resource might be necessary. This condition exists because the `Gateway`, `VirtualService`, and `DestinationRule` custom resources might reference an external host through a `ServiceEntry` name. Additionally, when you configure a `ServiceEntry` custom resource for an Istio egress gateway, you must set the `spec.resolution` to `DNS`.

By default, `ServiceEntries` are exported to all namespaces. To limit the scope of a `ServiceEntry` to a specific namespace, use the `exportTo` field in the [spec](https://istio.io/latest/docs/reference/config/networking/service-entry/#ServiceEntry-export_to).

### Step 5: Verify the Kubernetes secret namespace for egress gateway mTLS origination

If you try to configure the Istio egress gateway to perform mutual TLS (mTLS) origination, make sure that the Kubernetes secret object is located in the same namespace in which the egress gateway is deployed.

### Step 6: Make sure that applications send plaintext HTTP requests for egress gateway TLS origination and authorization policies

To originate TLS and apply authorization policies at the egress gateway, workloads in the mesh must send HTTP requests. The sidecar proxies can then use mTLS when they forward requests to the egress gateway. The egress gateway terminates the mTLS connection, and it originate a TLS/HTTPS connection to the destination host.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
