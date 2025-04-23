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

The Istio add-on egress gateway also takes a hard dependency on the [Static Egress Gateway feature](https://learn.microsoft.com/en-us/azure/aks/configure-static-egress-gateway). You must enable Static Egress Gateway on your cluster, create an agent pool of mode: `gateway`, and configure a `StaticGatewayConfiguration` custom resource before enabling an Istio add-on egress gateway.

You can create multiple Istio add-on egress gateways across different namespaces with a Deployment/Service `name` of your choice, with a max of `2000` egress gateways per cluster. Names must be unique per namespace. Names should be a valid DNS name, and must be less than or equal to 63 characters in length, can only consist of lowercase alphanumerical characters, '.' and '-,' and must start and end with a lowercase alphanumerical character. The regex used for Istio egress name validations is: `^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$`.

## Troubleshooting Checklist

### Networking and Firewall Errors
- If you're using Azure Firewall, Network Security Group (NSG) rules, or other outbound traffic restrictions, ensure that the IP ranges from the `egressIpPrefix` for the Istio add-on egress gateway `StaticGatewayConfigurations` are allowlisted for egress communication. 
- Because Static Egress Gateway is currently not supported on Azure CNI Pod Subnet clusters, the Istio add-on egress gateway can't be used on Azure CNI Pod Subnet clusters either. 

### Egress Gateway Provisioning Issues

- If the egress gateway pods are stuck in `ContainerCreating`, the `kube-egress-gateway-cni-manager` could be preventing the `istio-proxy` container from being created because `StaticGatewayConfiguration` for that Istio add-on egress gateway doesn't have an `egressIpPrefix` assigned to it yet. You can check the `status` of the `StaticGatewayConfiguration` for that Istio egress gateway to verify whether it has been assigned an `egressIpPrefix`, and also by running `kubectl describe` against the `StaticGatewayConfiguration` to view if there are any errors with the `egressIpPrefix` provisioning. You can also check the logs of the `kube-egress-gateway-cni-manager` pod running on the node of the failing Istio egress pod. Note that it can take up to ~5 minutes for a Static Egress Gateway `StaticGatewayConfiguration` to be assigned an `egressIpPrefix`.
- Ensure that self-managed mutating and validating webhooks aren't blocking provisioning of the Istio egress gateway resources. Because the Istio egress gateway can be deployed in user-managed namespaces (BYO-namespace), [AKS admissions enforcer](https://learn.microsoft.com/en-us/azure/aks/faq#can-admission-controller-webhooks-impact-kube-system-and-internal-aks-namespaces-) can't prevent custom admission controllers from affecting the Istio egress gateway deployment/namespace.
- Ensure that the egress gateway name adheres to the aforementioned regex pattern and is a valid DNS name.

### Static Egress Gateway Errors

- Because the Istio add-on egress gateway routes traffic through the Static Egress Gateway, it's possible that underlying networking and provisioning issues could be due to an error with Static Egress Gateway - for instance, Istio egress `ContainerCreating` issues due to a missing `egressIpPrefix` as mentioned above. See the [Static Egress Gateway docs](https://learn.microsoft.com/en-us/azure/aks/configure-static-egress-gateway) for more information on how to create and configure the Static Egress Gateway. 
- Verify that the `spec.gatewayNodepoolName` for the `StaticGatewayConfiguration` for each Istio egress gateway references a valid agent pool of mode: `Gateway` on the cluster. You shouldn't delete a gateway agent pool if any Istio add-on egress gateway `StaticGatewayConfiguration` is referencing it in `spec.gatewayNodepoolName`.
- Ensure that the `StaticGatewayConfiguration` for the Istio add-on egress gateway has a valid configuration and hasn't been deleted.
- Verify that the Istio add-on egress gateway pod spec has the `kubernetes.azure.com/static-gateway-configuration` annotation set to the name of the `StaticGatewayConfiguration` for that Istio add-on egress gateway. 
- To validate that requests from the egress gateway are being routed correctly via the Static Egress Gateway nodepool, you can use a Kubernetes ephemeral container with `kubectl debug` to send an external request from the egress pod and verify the source IP of the request. Make sure that you temporarily set `outboundTrafficPolicy.mode` to `ALLOW_ANY` so that the egress gateway can access `ifconfig.me`.

    ```bash
    kubectl debug -it --image curlimages/curl $EGRESS_POD_NAME -n $EGRESS_NAMESPACE -- curl ifconfig.me
    ```

    The source IP address returned should match the `egressIpPrefix` of the `StaticGatewayConfiguration` associated with that Istio egress gateway.

- Updates to certain `StaticGatewayConfiguration` fields, such as `defaultRoute` and `excludeCidrs` require the Istio add-on egress gateway pods to be restarted for the changes to the `StaticGatewayConfiguration` take effect. You can bounce the pod by triggering a restart of the egress gateway deployment:

    ```bash
    kubectl rollout restart deployment $EGRESS_DEPLOYMENT_NAME -n $EGRESS_NAMESPACE
    ```

### Istio Egress Configuration and Custom Resources

More information about Istio egress configuration can be found on the open source [Istio docs site](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/).

- Ensure that the `selector` in the `Gateway` custom resource is properly set. For instance, if your `Gateway` object for the Istio egress gateway uses the `istio:` selector, then it must match the value of the `istio` label in the Kubernetes service spec for that egress gateway. 

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

    The `Gateway` should be set up as follows:

    ```bash
    apiVersion: networking.istio.io/v1
    kind: Gateway
    metadata:
    name: istio-egressgateway
    spec:
      selector:
        istio: asm-egress-test
    ```

- If you're trying to configure the egress gateway to perform mutual TLS origination, ensure that the Kubernetes secret object is in the same namespace that the Istio egress gateway is deployed in. 

- You can enable Envoy access logging via the [Istio MeshConfig](https://learn.microsoft.com/en-us/azure/aks/istio-meshconfig) or [Telemetry API](https://learn.microsoft.com/en-us/azure/aks/istio-telemetry) to inspect traffic flowing through the egress gateway.

- Ensure that you have created a `ServiceEntry` custom resource for the specific external service that that the egress gateway is routing traffic to. Creating a `ServiceEntry` may be necessary even if the `outboundTrafficPolicy.mode` is set to `ALLOW_ANY`, since the `Gateway`, `VirtualService`, and `DestinationRule` custom resources may reference an external host via a `ServiceEntry` name. 

- When configuring a `ServiceEntry` to be used by an Istio egress gateway, the `spec.resolution` must be set to `DNS`. 

- Gateway API is currently not supported for the Istio add-on egress gateway.

- To originate TLS and to apply Authorization Policies at the egress gateway, workloads in the mesh must send HTTP requests. The sidecar proxies can then use mTLS when forwarding requests to the egress gateway, and the egress gateway will terminate the mTLS connection and originate a simple TLS / HTTPS connection to the destination host.
