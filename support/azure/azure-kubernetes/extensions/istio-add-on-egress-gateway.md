---
title: Istio service mesh add-on egress gateway troubleshooting
description: Learn how to do egress gateway troubleshooting on the Istio service mesh add-on for Azure Kubernetes Service (AKS).
ms.date: 04/23/2025
author: nshankar13
ms.author: nshankar
editor: v-jsitser
ms.reviewer: fuyuanbie, kochhars, ddama, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the egress gateway of the Istio add-on so that I can use the Istio service mesh successfully.
---
# Istio service mesh add-on egress gateway troubleshooting

## Overview

The Istio add-on egress gateway is an Envoy-based proxy that can be used to route outbound traffic from applications in the mesh. The Istio egress gateway is a `ClusterIP` type service and thus isn't exposed externally. 

The Istio add-on egress gateway takes a hard dependency on the [Static Egress Gateway feature](/azure/aks/configure-static-egress-gateway). You must enable Static Egress Gateway on your cluster before enabling an Istio add-on egress gateway.

You can create multiple Istio add-on egress gateways across different namespaces with a Deployment/Service `name` of your choice, with a max of `2000` egress gateways per cluster.

## Prerequisites
- Users must have Azure CLI `aks-preview` version `14.0.0b2` or later installed to enable an Istio add-on egress gateway.
- Users must enable [Static Egress Gateway feature](/azure/aks/configure-static-egress-gateway) on their cluster, create an agent pool of mode `gateway`, and configure a `StaticGatewayConfiguration` custom resource before enabling an Istio add-on egress gateway.

## Troubleshooting Checklist

### Networking and Firewall Errors

#### Step 1: Make sure no firewall or outbound traffic rules block egress traffic
If you're using Azure Firewall, Network Security Group (NSG) rules, or other outbound traffic restrictions, ensure that the IP ranges from the `egressIpPrefix` for the Istio add-on egress gateway `StaticGatewayConfigurations` are allowlisted for egress communication. 

#### Step 2: Verify cluster CNI plugin
Because Static Egress Gateway is currently not supported on [Azure CNI Pod Subnet](/azure/aks/concepts-network-azure-cni-pod-subnet) clusters, the Istio add-on egress gateway can't be used on Azure CNI Pod Subnet clusters either. 

### Egress Gateway Provisioning Issues

#### Step 1: Make sure admission controllers aren't blocking Istio egress provisioning

Ensure that self-managed mutating and validating webhooks aren't blocking provisioning of the Istio egress gateway resources. Because the Istio egress gateway can be deployed in user-managed namespaces (BYO-namespace), [AKS admissions enforcer](/azure/aks/faq#can-admission-controller-webhooks-impact-kube-system-and-internal-aks-namespaces-) can't prevent custom admission controllers from affecting Istio egress gateway resources.

#### Step 2: Verify that the Istio add-on egress gateway name is valid

Istio egress gateway names should be a valid DNS name, and must be less than or equal to 63 characters in length, can only consist of lowercase alphanumerical characters, '.' and '-,' and must start and end with a lowercase alphanumerical character. The regex used for Istio egress name validations is: `^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$`.

#### Step 3: Inspect the `StaticGatewayConfiguration` if Pods are stuck in `containerCreating`

See [Step 2](#step-2-make-sure-that-an-egressipprefix-has-been-provisioned-for-the-staticgatewayconfiguration) in the "Static Egress Gateway errors" section on how to debug the `StaticGatewayConfiguration` if the Istio egress gateway pods are stuck in `containerCreating`. 

### Static Egress Gateway Errors

#### Step 1: Inspect the Istio egress gateway `StaticGatewayConfiguration`

Ensure that the `StaticGatewayConfiguration` for the Istio add-on egress gateway has a valid configuration and hasn't been deleted. Verify that the Istio add-on egress gateway pod spec has the `kubernetes.azure.com/static-gateway-configuration` annotation set to the name of the `StaticGatewayConfiguration` for that Istio add-on egress gateway.

#### Step 2: Make sure that an `egressIpPrefix` has been provisioned for the `StaticGatewayConfiguration`

If the egress gateway pods are stuck in `ContainerCreating`, the `kube-egress-gateway-cni-manager` could be preventing the `istio-proxy` container from being created because `StaticGatewayConfiguration` for that Istio add-on egress gateway doesn't have an `egressIpPrefix` assigned to it yet. You can check the `status` of the `StaticGatewayConfiguration` for that Istio egress gateway to verify whether it has been assigned an `egressIpPrefix`, and also by running `kubectl describe` against the `StaticGatewayConfiguration` to view if there are any errors with the `egressIpPrefix` provisioning. You can also check the logs of the `kube-egress-gateway-cni-manager` pod running on the node of the failing Istio egress pod. Note that it can take up to ~5 minutes for a Static Egress Gateway `StaticGatewayConfiguration` to be assigned an `egressIpPrefix`.

```bash
kubectl get staticgatewayconfiguration $ISTIO_SGC_NAME -n $ISTIO_EGRESS_NAMESPACE -o jsonpath='{.status.egressIpPrefix}'
kubectl describe staticgatewayconfiguration $ISTIO_SGC_NAME -n $ISTIO_EGRESS_NAMESPACE
```

#### Step 3: Make sure that the Istio egress gateway `StaticGatewayConfiguration` references a valid `gateway` agent pool

Verify that the `spec.gatewayNodepoolName` for the `StaticGatewayConfiguration` for each Istio egress gateway references a valid agent pool of mode `Gateway` on the cluster. You shouldn't delete a gateway agent pool if any Istio add-on egress gateway `StaticGatewayConfiguration` is referencing it in `spec.gatewayNodepoolName`.

#### Step 4: Try sending an external request from the Istio egress gateway

To validate that requests from the egress gateway are being routed correctly via the Static Egress Gateway nodepool, you can use a Kubernetes ephemeral container with `kubectl debug` to send an external request from the egress pod and verify the source IP of the request. Make sure that you temporarily set `outboundTrafficPolicy.mode` to `ALLOW_ANY` so that the egress gateway can access `ifconfig.me`.

```bash
kubectl debug -it --image curlimages/curl $EGRESS_POD_NAME -n $EGRESS_NAMESPACE -- curl ifconfig.me
```

The source IP address returned should match the `egressIpPrefix` of the `StaticGatewayConfiguration` associated with that Istio egress gateway. If the request fails or the source IP address returned doesn't match the `egressIpPrefix`, then you should try [restarting the Istio egress gateway deployment](#step-5-try-restarting-the-istio-egress-gateway-deployment) or debugging potential issues with [Static Egress Gateway](#step-6-debug-the-static-egress-gateway).

#### Step 5: Try restarting the Istio egress gateway deployment

Updates to certain `StaticGatewayConfiguration` fields, such as `defaultRoute` and `excludeCidrs` require the Istio add-on egress gateway pods to be restarted for the changes to the `StaticGatewayConfiguration` take effect. You can bounce the pod by triggering a restart of the egress gateway deployment:

```bash
kubectl rollout restart deployment $ISTIO_EGRESS_DEPLOYMENT_NAME -n $ISTIO_EGRESS_NAMESPACE
```

#### Step 6: Debug the Static Egress Gateway

If errors with egress routing through the Istio add-on egress gateway persist, even after verifying that [Istio egress routing is configured correctly](#istio-egress-configuration-and-custom-resources), then it's possible that there is an underlying networking or infrastructure issue with the Static Egress Gateway. See the [Static Egress Gateway documentation](/azure/aks/configure-static-egress-gateway) for more information.

### Istio Egress Configuration and Custom Resources

More information about Istio egress configuration can be found on the open source [Istio docs site](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/). Note that Gateway API is currently not supported for the Istio add-on egress gateway - you must use Istio custom resources to configure outbound communication via the egress gateway to receive support from Azure for issues relating to the Istio egress gateway.

#### Step 1: Enable Envoy access logging

You can enable Envoy access logging via the [Istio MeshConfig](/azure/aks/istio-meshconfig) or [Telemetry API](/azure/aks/istio-telemetry) to inspect traffic flowing through the egress gateway.

#### Step 2: Validate the Istio `Gateway` configuration

Ensure that the `selector` in the `Gateway` custom resource is properly set. For instance, if your `Gateway` object for the Istio egress gateway uses the `istio:` selector, then it must match the value of the `istio` label in the Kubernetes service spec for that egress gateway. 

For instance - for an egress gateway with the following Kubernetes service spec: 

```bash
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

The `Gateway` should be configured as follows:

```bash
apiVersion: networking.istio.io/v1
kind: Gateway
metadata:
  name: istio-egressgateway
spec:
  selector:
    istio: asm-egress-test
```

#### Step 3: Ensure that a `ServiceEntry` has been created and has DNS resolution enabled

Ensure that you have created a `ServiceEntry` custom resource for the specific external service that that the egress gateway is routing traffic to. Creating a `ServiceEntry` may be necessary even if the `outboundTrafficPolicy.mode` is set to `ALLOW_ANY`, since the `Gateway`, `VirtualService`, and `DestinationRule` custom resources may reference an external host via a `ServiceEntry` name. Additionally, when configuring a `ServiceEntry` to be used by an Istio egress gateway, you must set the `spec.resolution` to `DNS`. 

#### Step 4: Verify the Kubernetes secret namespace for mTLS origination at the Istio egress gateway

If you're trying to configure the egress gateway to perform mutual TLS origination, ensure that the Kubernetes secret object is in the same namespace that the Istio egress gateway is deployed in. 

#### Step 5: Ensure that applications are sending plaintext HTTP requests for Egress Gateway TLS origination and Authorization Policies

To originate TLS and to apply Authorization Policies at the egress gateway, workloads in the mesh must send HTTP requests. The sidecar proxies can then use mTLS when forwarding requests to the egress gateway, and the egress gateway will terminate the mTLS connection and originate a simple TLS / HTTPS connection to the destination host.
