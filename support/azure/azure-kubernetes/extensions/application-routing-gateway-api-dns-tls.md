---
title: Troubleshoot Azure DNS and TLS integration for the application routing Gateway API implementation
description: Learn how to troubleshoot Azure DNS and TLS integration issues for AKS Gateway API, and fix missing certificates or DNS records.
ms.date: 06/15/2026
author: jaiveerk
ms.author: jkatariya
ms.reviewer: nshankar
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the Azure DNS and Azure Key Vault TLS integration for the application routing Gateway API implementation so that my Gateway listeners terminate TLS correctly and my hostnames are published to Azure DNS.
---

# Troubleshoot Azure DNS and TLS integration for the application routing Gateway API implementation in AKS

## Summary

This article helps you troubleshoot the Azure DNS and Azure Key Vault Transport Layer Security (TLS) integration for the [application routing Gateway API implementation](/azure/aks/app-routing-gateway-api-dns-tls) in Azure Kubernetes Service (AKS). For control-plane, networking, and upgrade problems that aren't specific to the Azure DNS or Key Vault integration, see [Troubleshoot the application routing Gateway API implementation](application-routing-gateway-api.md).

The application routing add-on automates two integrations on top of the [application routing Gateway API implementation](/azure/aks/app-routing-gateway-api):

- **TLS:** When a `Gateway` listener carries the `kubernetes.azure.com/tls-cert-keyvault-uri` and `kubernetes.azure.com/tls-cert-service-account` TLS options, the add-on provisions a `SecretProviderClass` resource, syncs the certificate from Key Vault as a `kubernetes.io/tls` Kubernetes Secret, and updates the listener `tls.certificateRefs` field.
- **Domain Name System (DNS):** The `ClusterExternalDNS` and `ExternalDNS` custom resources let you stand up a managed `external-dns` instance that publishes A records to Azure DNS based on hostnames in `Gateway`, `HTTPRoute`, and `GRPCRoute` resources.

> [!NOTE]
> `TLSRoute` resources aren't currently supported as a source of DNS records.

Most failures appear as warning events on the `Gateway` resource or the `ClusterExternalDNS` or `ExternalDNS` resource. Run `kubectl describe` on the affected resource first. The operator issues descriptive events for almost every misconfiguration that's documented here.

## Verify that the cluster prerequisites are in place

Before you troubleshoot a specific symptom, verify that all prerequisites for the integration are enabled on the cluster. A missing prerequisite is the most common cause if the integration doesn't provision TLS certs or manage DNS records. See the following table for the prerequisites and how to verify them.

| Prerequisite | How to verify |
|---|---|
| Application routing add-on (`--enable-app-routing`) | `az aks show -g $RG -n $CLUSTER --query ingressProfile.webAppRouting.enabled` returns `true`. |
| Application routing Azure Gateway API implementation (`--enable-app-routing-istio`) | `kubectl get gatewayclass approuting-istio` shows `ACCEPTED=True`. |
| Managed Gateway API installation | `kubectl get crd gateways.gateway.networking.k8s.io` returns a Custom Resource Definition (CRD). |
| OpenID Connect (OIDC) issuer and Microsoft Entra Workload ID | `az aks show ... --query "{oidc:oidcIssuerProfile.enabled, wi:securityProfile.workloadIdentity.enabled}"` returns `true` for both. |
| Key Vault provider for Secrets Store Container Storage Interface (CSI) Driver add-on (TLS only) | `kubectl get pods -n kube-system -l app=secrets-store-csi-driver` shows running pods. |

Both `--enable-app-routing` and `--enable-app-routing-istio` are required. If you enable only one of these prerequisites, the integration becomes unavailable. The legacy `--attach-kv` and `--attach-zones` flags on `az aks approuting update` configure the legacy NGINX-based experience. They have no effect on the Gateway API integration that's documented here.

## TLS troubleshooting

### The Kubernetes Secret for the listener certificate doesn't appear

When TLS reconciliation succeeds, you should see a `SecretProviderClass` and a `kubernetes.io/tls` Secret that's named `kv-gw-cert-<gateway-name>-<listener-name>` in the `Gateway` namespace.

Run the following command in a command line interface (CLI) tool of your choice:

```bash
kubectl get secretproviderclass,secret -n <gateway-namespace>
```

If neither object exists, run `kubectl describe gateway <gateway-name> -n <gateway-namespace>`, and look for warning events from the application routing operator. Use the following table to map an event message to its cause.

| Event reason and message | Cause |
|---|---|
| `InvalidInput`: *"KeyVault Cert URI provided, but the required ServiceAccount option was not."* | The listener sets `kubernetes.azure.com/tls-cert-keyvault-uri` but doesn't set `kubernetes.azure.com/tls-cert-service-account`. Set both options, or remove both. |
| `InvalidInput`: *"ServiceAccount for WorkloadIdentity provided, but KeyVault Cert URI was not."* | The listener sets the service account option but doesn't set the certificate URI. Set both options, or remove both. |
| `InvalidInput`: *"invalid secret uri: ..."* | The certificate URI doesn't follow the pattern, `https://<vault>.vault.azure.net/certificates/<cert-name>`. Use the unversioned URI that's returned by `az keyvault certificate show --vault-name <vault> --name <cert> --query id -o tsv \| sed 's\|/[^/]*$\|\|'` for automatic rotation. |
| `InvalidInput`: *"service account `<sa>` does not exist in namespace `<ns>`"* | The service account that's named in the listener TLS options doesn't exist in the `Gateway`'s namespace. Service accounts must live in the same namespace as the `Gateway` that references them. They aren't shared cluster-wide. |
| `InvalidInput`: *"service account `<sa>` was specified but does not include necessary annotation for Workload Identity"* | The service account is missing the `azure.workload.identity/client-id` annotation. The application routing operator reads the client ID from this annotation to populate the `SecretProviderClass`. Therefore, the annotation is required even though Microsoft Entra Workload ID treats it as optional in general. Add the annotation by using the client ID of the user-assigned managed identity that's federated to this service account. While you're editing the service account, also verify that the `azure.workload.identity/use: "true"` label is set. The operator doesn't validate this label at admission, but the Microsoft Entra Workload ID webhook needs it at runtime to inject the projected token into the placeholder pod. |

If `kubectl describe` shows no warning events at all, verify that the `Gateway` resource uses `gatewayClassName: approuting-istio`. The application routing operator reconciles TLS only for `Gateway` resources that target the `approuting-istio` GatewayClass. Make sure that app routing is enabled together with the CSI driver add-on and Microsoft Entra Workload ID.

### The Secret exists but the listener stays unprogrammed and traffic fails with TLS errors

If the `SecretProviderClass` exists but the `kubernetes.io/tls` Secret is missing or empty, the Key Vault provider for Secrets Store CSI Driver can't create the certificate. The application routing add-on runs a small placeholder pod in the `Gateway`'s namespace whose only job is to mount the `SecretProviderClass` and trigger the CSI driver to populate the Secret. If the placeholder pod can't authenticate to Key Vault, the Secret is never written.

Check the placeholder pod. Run the following command in a command line interface (CLI) tool of your choice:

```bash
kubectl get pods -n <gateway-namespace> -l app=kv-gw-cert-<gateway-name>-<listener-name>
kubectl describe pod -n <gateway-namespace> -l app=kv-gw-cert-<gateway-name>-<listener-name>
```

The most common errors are:

- **`AADSTS700211: No matching federated identity record found`.** The Kubernetes service account is missing the `azure.workload.identity/use: "true"` label. This label is required by [Microsoft Entra Workload ID](/azure/aks/workload-identity-overview). Without it, the Microsoft Entra Workload ID webhook doesn't inject the projected OIDC token into the placeholder pod, and Microsoft Entra rejects the resulting token.
- **`AADSTS70021: No matching federated identity record found for presented assertion subject`.** A federated identity credential (FIC) for the `(namespace, ServiceAccount)` pair doesn't exist on the user-assigned managed identity. FICs are subject-specific. Every `(namespace, ServiceAccount)` pair that has to authenticate to Azure requires its own FIC with a subject value of `system:serviceaccount:<namespace>:<sa-name>`.
- **`AuthorizationFailed` on `Microsoft.KeyVault/vaults/secrets/getSecret`.** The user-assigned managed identity is missing the `Key Vault Secrets User` role on the target Key Vault. Grant the role on the vault scope, and wait a minute for the assignment to propagate.
- **`Forbidden`: vault uses access policies.** The Key Vault is configured by using the legacy access policy permission model. Re-create the vault to have `--enable-rbac-authorization true` permissions, or grant access through an access policy on the user-assigned managed identity instead.

If the placeholder pod looks healthy, and the events on it don't point to any of the errors earlier, check the Key Vault provider for the Secrets Store CSI Driver itself. The provider and driver pods run in `kube-system` and expose their own mount-time error logs.

For deeper CSI driver troubleshooting (mount errors, missing driver registration, private-endpoint connectivity to Key Vault, and similar issues), see [Troubleshoot Azure Key Vault Secrets Provider add-on in AKS](troubleshoot-key-vault-csi-secrets-store-csi-driver.md).

### The certificate that the gateway presents is stale after rotation

The `kubernetes.azure.com/tls-cert-keyvault-uri` option accepts both versioned and unversioned Key Vault certificate Uniform Resource Identifiers (URIs). If you set a versioned URI (one that ends in `/certificates/<name>/<version>`), the application routing operator pins the `SecretProviderClass` to that specific version, and rotations in Key Vault aren't picked up.

To enable automatic rotation, set the option to the unversioned URI. Run the following command in a command line interface (CLI) tool of your choice:

```bash
az keyvault certificate show \
  --vault-name $KV_NAME \
  --name $CERT_NAME \
  --query id -o tsv | sed 's|/[^/]*$||'
```

The result has the form, `https://<vault>.vault.azure.net/certificates/<cert>`, without a trailing version segment. Use this value in the listener TLS options.

### The browser shows a certificate error for the apex hostname only

If you create a self-signed wildcard certificate by using `CN=*.<zone>`, the certificate includes `*.<zone>` but not the apex `<zone>`. Browsers reject `https://<zone>` even though `https://www.<zone>` succeeds.

Re-create the certificate by using the apex hostname that's listed in `subjectAlternativeNames.dnsNames`. Run the following command in a command line interface (CLI) tool of your choice:

```json
"subjectAlternativeNames": { "dnsNames": ["*.<zone>", "<zone>"] }
```

Then, update the certificate version in Key Vault. If you're using an unversioned URI on the listener (recommended), the new version is picked up automatically.

## Azure DNS troubleshooting

### The `ClusterExternalDNS` or `ExternalDNS` resource is rejected at admission

The `ExternalDNS` and `ClusterExternalDNS` custom resources enforce several validation rules at admission time. The Kubernetes API server rejects a resource that violates any of these rules, and returns a message that names the failing rule. See the following table for some common rejections.

| Validation message | Cause |
|---|---|
| *"all items must have the same subscription ID"* | The Azure DNS zone resource IDs in `dnsZoneResourceIDs` span more than one Azure subscription. Split them across multiple custom resources, one per subscription. |
| *"all items must have the same resource group"* | The zone resource IDs span more than one resource group. Split them across multiple custom resources, one per resource group. |
| *"all items must be of the same resource type"* | The list mixes public DNS zones (`Microsoft.Network/dnszones`) and private DNS zones (`Microsoft.Network/privateDnsZones`). Use one custom resource per zone type. |
| `spec.dnsZoneResourceIDs in body should have at most 7 items` | A single custom resource can target seven zones at most. Split your zones across multiple custom resources. |
| *"all items must be either 'gateway' or 'ingress'"* | `resourceTypes` accepts only the `gateway` and `ingress` values. It's invalid here to specify `httproute`, `grpcroute`, or `tlsroute` because `HTTPRoute` and `GRPCRoute` records are managed automatically when their parent `Gateway` is in scope. |
| `spec.filters.gatewayLabels in body should match '^[^=]+=[^=]+$'` | The `gatewayLabels` and `routeAndIngressLabels` filters accept exactly one `key=value` pair. Comma-separated lists, set-based selectors (`In`, `NotIn`), and inequality (`!=`) aren't supported. To match multiple disjoint sets of resources, deploy multiple custom resources. |
| *"serviceAccount is required when type is workloadIdentity"* | `identity.type` defaults to `workloadIdentity` and requires `identity.serviceAccount` to be set. |
| *"clientID is required when type is managedIdentity"* | `identity.type: managedIdentity` requires `identity.clientID` to be set to the client ID of the user-assigned managed identity. |

### The custom resource is admitted but no DNS records appear

If the resource is admitted, but Azure DNS doesn't show new A records after a couple of minutes, run `kubectl describe externaldns <name>` (or `kubectl describe clusterexternaldns <name>`). The application routing operator issues a `FailedUpdateOrCreateExternalDNSResources` warning event for identity and configuration problems.

#### Step 1: Verify that the service account is in the right namespace

The service account that's named in `identity.serviceAccount` must exist in the namespace where the managed `external-dns` instance runs:

- For `ExternalDNS` (namespace-scoped): The namespace of the custom resource itself.
- For `ClusterExternalDNS`: The namespace that's named in `spec.resourceNamespace`.

A common mistake that's made regarding `ClusterExternalDNS` is to omit `spec.resourceNamespace`. The field defaults to `app-routing-system`, so the service account is then expected in `app-routing-system` instead of in the namespace where you created your service account. Set `resourceNamespace` explicitly to the namespace that contains your service account.

#### Step 2: Verify that the service account is configured for Microsoft Entra Workload ID

Run `kubectl get serviceaccount <sa-name> -n <resource-namespace> -o yaml`, and verify both of the following conditions:

- The label `azure.workload.identity/use: "true"` is set. This label is required by [Microsoft Entra Workload ID](/azure/aks/workload-identity-overview). Without it, the Microsoft Entra Workload ID webhook doesn't inject the projected token, and the managed `external-dns` pod fails to authenticate.
- The annotation `azure.workload.identity/client-id: <client-id>` is set to the client ID of the user-assigned managed identity. The annotation is optional in upstream Microsoft Entra Workload ID. However, the application routing operator reads the client ID from this annotation. Therefore, it's required for the integration to work.

#### Step 3: Check the managed `external-dns` pod logs

The application routing operator deploys an `external-dns` deployment that's named after `spec.resourceName`. Run the following command in a command line interface (CLI) tool of your choice:

```bash
kubectl logs -n <resource-namespace> deploy/<resource-name>-external-dns
```

Some common error patterns include:

- `AADSTS700211`: A FIC is missing for the `(namespace, ServiceAccount)` pair on the user-assigned managed identity.
- `AuthorizationFailed` on the DNS zone|: The user-assigned managed identity is missing the `DNS Zone Contributor` role (for public zones) or `Private DNS Zone Contributor` role (for private zones) on the zone scope.
- *"All replicas are unhealthy"* without Azure errors: The managed `external-dns` pod is `CrashLoopBackOff`. Rerun [Step 2](#step-2-verify-that-the-service-account-is-configured-for-microsoft-entra-workload-id). The most common cause is that the Microsoft Entra Workload ID webhook didn't inject the token volume because the required `azure.workload.identity/use: "true"` label is missing from the service account.

### Records appear for the wrong set of resources

If the managed `external-dns` instance publishes records for resources you didn't expect, or skips resources you did expect, check the scoping rules:

- **`ClusterExternalDNS`** watches `Gateway`, `HTTPRoute`, and `GRPCRoute` resources across all namespaces in the cluster.
- **`ExternalDNS`** (namespace-scoped) watches resources in only its own namespace. A `Gateway` in another namespace is invisible to it, regardless of label filters.
- The `filters.gatewayLabels` selector restricts which `Gateway` resources are observed within scope. The `filters.routeAndIngressLabels` selector restricts which `HTTPRoute`,`GRPCRoute`, and `Ingress` resources are observed.

An Azure Gateway that satisfies the namespace scope but doesn't carry the labels in `filters.gatewayLabels` is silently excluded because no warning event exists.

### Records remain in Azure DNS after I delete the custom resource

DNS records that the managed `external-dns` instance publishes aren't deleted when you delete the `ClusterExternalDNS` or `ExternalDNS` custom resource. To remove orphaned records, delete them directly from the Azure DNS zone after you delete the custom resource.

Run the following command in Azure CLI:

```azurecli
az network dns record-set a delete \
  --resource-group <zone-rg> \
  --zone-name <zone-name> \
  --name <record-name> \
  --yes
```

### `TLSRoute` hostnames don't get records

The managed `external-dns` instance sources records from only `Gateway`, `HTTPRoute`, and `GRPCRoute` resources. `TLSRoute` isn't currently supported.

## References

- [Configure Azure DNS and TLS with the application routing Gateway API implementation](/azure/aks/app-routing-gateway-api-dns-tls)
- [Configure ingress with the Kubernetes Gateway API by using the application routing add-on](/azure/aks/app-routing-gateway-api)
- [Troubleshoot the application routing Gateway API implementation](application-routing-gateway-api.md)
- [Troubleshoot the AKS Managed Gateway API installation](managed-gateway-api.md)
- [Microsoft Entra Workload Identity for AKS](/azure/aks/workload-identity-overview)
- [Azure Key Vault provider for Secrets Store CSI Driver](/azure/aks/csi-secrets-store-driver)
- [Troubleshoot Azure Key Vault Secrets Provider add-on in AKS](troubleshoot-key-vault-csi-secrets-store-csi-driver.md)
