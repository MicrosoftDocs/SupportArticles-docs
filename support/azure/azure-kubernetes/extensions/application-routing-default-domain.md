---
title: Troubleshoot the application routing default domain feature in AKS
description: Learn how to troubleshoot the application routing default domain feature in AKS. Fix a certificate that isn't ready or a domain that doesn't resolve.
ms.date: 10/14/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: nshankar, kingoliver
ms.service: azure-kubernetes-service
ms.topic: troubleshooting
ms.custom: sap:Extensions, Policies and Add-Ons
ai-usage: ai-assisted
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the application routing default domain feature so that my managed aksapp.io domain serves a valid TLS certificate and resolves in DNS.
---

# Troubleshoot the application routing default domain feature in Azure Kubernetes Service

## Summary

This article helps you troubleshoot the application routing default domain feature in Azure Kubernetes Service (AKS) so that you can fix a Transport Layer Security (TLS) certificate that isn't ready or a domain that doesn't resolve. 

When you enable the feature, AKS provisions a managed `*.<id>.<region>.aksapp.io` domain for your cluster. AKS also issues a trusted, publicly signed TLS certificate for that domain and publishes the Domain Name System (DNS) records for it.

The feature has two parts that can fail independently:

- **TLS certificate** - AKS issues the certificate and reconciles it into a Kubernetes secret through a `DefaultDomainCertificate` custom resource.
- **DNS** - A managed `external-dns` instance, which is defined by a `default-domain-dns` `ClusterExternalDNS` custom resource, publishes the address (A) records for the domain to the managed zone.

## Prerequisites

You need `kubectl` access to the cluster.

> [!NOTE]
> The certificate and DNS paths are independent. The certificate can be ready while DNS still fails, and DNS can resolve while the certificate isn't ready. Be sure to check both.

## Verify that the default domain feature is enabled

Before you troubleshoot a specific symptom, confirm that the default domain feature is enabled on the cluster. If you don't enable the feature, the cluster doesn't create a certificate or DNS resources.

Use Azure CLI to run the following command.

```azurecli
az aks show --resource-group <resource-group> --name <cluster-name> --query ingressProfile.webAppRouting.defaultDomain.enabled
```

If the command returns `true`, the feature is enabled. If it returns `false` or `null`, enable it. Run the following command.

```azurecli
az aks approuting update --resource-group <resource-group> --name <cluster-name> --enable-default-domain
```

## Step 1: Check the DefaultDomainCertificate custom resource for certificate issues

The `DefaultDomainCertificate` custom resource holds the status of the managed certificate. Its `Available` condition tells you whether the certificate is ready and applied to a secret.

Run the following command to list the custom resource and its status.

```bash
kubectl get defaultdomaincertificate -A
```

Then, describe the resource to read its `Available` condition and events. Run the following command.

```bash
kubectl describe defaultdomaincertificate <name> -n <namespace>
```

Look at the `Available` condition in the `Status` section.

The following list explains the possible values of the `Available` condition and their meanings:

- If the `Status` value of the `Available` condition is `True`, and the `Reason` value is `CertificateSecretApplied`, the certificate is ready and applied to the target secret. The certificate path is healthy. Continue to [Step 2: Check the default domain external-dns for DNS resolution issues](#step-2-check-the-default-domain-external-dns-for-dns-resolution-issues) to troubleshoot DNS.
- If the `Status` value of the `Available` condition is `False`, use the following table to map the `Reason` value to its cause and resolution.

The following table maps the `Reason` values to their causes and resolutions.

| Reason | Cause | Resolution |
|---|---|---|
| `CertificateNotReady` | The certificate isn't issued yet. AKS is still provisioning it. | Wait a few minutes. Provisioning takes single-digit minutes in normal conditions. If the resource stays in this state for more than 30 minutes, [open a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot). |
| `ConflictingSecretExists` | The target secret already exists but isn't managed by the default domain feature. The feature doesn't overwrite a secret that it doesn't own. | Delete or rename the conflicting secret in the same namespace, or point the `DefaultDomainCertificate` `spec.target.secret` field to a different secret name. |
| `ApplyingCertificateSecretFailed` | The operator couldn't write the certificate secret. A cluster policy or an admission webhook usually blocks the write. | Run `kubectl describe defaultdomaincertificate <name> -n <namespace>`, and read the warning event. Check your admission webhooks and policies for a rule that blocks secret creation in the namespace. |

After the certificate is `Available`, the target secret holds the certificate. Confirm that the secret exists. Run the following command.

```bash
kubectl get secret <target-secret> -n <namespace>
```

The `<target-secret>` value is the name in the `spec.target.secret` field of the `DefaultDomainCertificate` resource.

## Step 2: Check the default domain external-dns for DNS resolution issues

The default domain DNS records are published by a managed `external-dns` instance. AKS defines it with a `ClusterExternalDNS` custom resource that's named `default-domain-dns` in the `app-routing-system` namespace. If this instance is unhealthy, the domain doesn't resolve, and new records aren't published.

### Check the ClusterExternalDNS resource status

Run the following command to inspect the resource and its events.

```bash
kubectl describe clusterexternaldns default-domain-dns -n app-routing-system
```

Review the events at the end of the output. A `FailedUpdateOrCreateExternalDNSResources` warning event points to an identity or configuration problem. If the events are clean, continue to check the pod stability and logs.

### Check the external-dns pod stability

The managed `external-dns` instance runs as a deployment in the `app-routing-system` namespace. Confirm that its pods are running and aren't restarting.

Run the following command.

```bash
kubectl get pods -n app-routing-system -l app.kubernetes.io/name=default-domain-dns-external-dns
```

The following scenarios indicate the stability of the `external-dns` pods:

- If a pod shows a `Running` status with no restarts, the instance is stable. Continue to [Check the external-dns pod logs](#check-the-external-dns-pod-logs).
- If a pod shows a `CrashLoopBackOff` status, or a high restart count, describe it to see why. Run the following command.

  ```bash
  kubectl describe pod -n app-routing-system -l app.kubernetes.io/name=default-domain-dns-external-dns
  ```

  A pod that's `Pending` usually can't be scheduled. Check the node capacity of the cluster. A pod that restarts often usually fails to authenticate. Check the logs in the next section.

### Check the external-dns pod logs

The pod logs show whether `external-dns` publishes records or fails to authenticate to Azure DNS.

Run the following command.

```bash
kubectl logs -n app-routing-system deploy/default-domain-dns-external-dns
```

Use the following table to map a log pattern to its cause.

| Log pattern | Cause | Resolution |
|---|---|---|
| Lines that contain `Desired change: CREATE` or `UPDATE`, followed by success | The instance publishes records normally. If the domain still doesn't resolve, wait for public DNS propagation. See the following note. |
| `AADSTS` authentication errors | The managed identity that you federated to the `default-domain-sa` service account can't get a token. This condition is a platform configuration problem. | [Open a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot). |
| `AuthorizationFailed` on a DNS zone | The managed identity is missing the required role on the managed DNS zone. This condition is a platform configuration problem. | [Open a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot). |
| No record lines at all, but the pod is healthy | The instance runs but sees no hostnames to publish. Your `Ingress` resources don't set a `host` value, or they don't use the application routing ingress class. | Add a `host` value to your `Ingress` or `Gateway` resource. |

> [!NOTE]
> After `external-dns` publishes a record, public DNS propagation adds a short delay. Testing with `curl` or `nslookup` can fail for the first few minutes even when the record is correct.

## References

- [Configure ingress with the application routing add-on](/azure/aks/app-routing)
- [Troubleshoot the Application Routing Gateway API Implementation](application-routing-gateway-api.md)
- [Troubleshoot Azure DNS and TLS integration for the application routing Gateway API implementation](application-routing-gateway-api-dns-tls.md)
