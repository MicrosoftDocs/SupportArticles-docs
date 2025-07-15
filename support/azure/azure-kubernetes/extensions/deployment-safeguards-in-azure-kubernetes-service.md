---
title: Troubleshooting Guide:Deployment Safeguards in Azure Kubernetes (AKS)
description: Provides a solution to issues related to deployment safeguards in Azure Kubernetes Service (AKS).
ms.date: 07/15/2025
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshooting Guide: Deployment Safeguards in Azure Kubernetes Service (AKS)

## Overview

Deployment Safeguards in Azure Kubernetes Service (AKS) help enforce Kubernetes best practices using Azure Policy and Gatekeeper. While they offer valuable protection,
misconfiguration or misunderstanding of their behavior can lead to
blocked or mutated workloads. This guide helps troubleshoot common
issues when using Deployment Safeguards in **Warn** or **Enforce** mode.

### 1. Safeguards Not Taking Effect

**Symptoms:**

- You deployed noncompliant resources but saw no warnings or
  enforcement.

- The Azure Policy dashboard shows **Not started** or empty compliance
  status.

**Recommended Actions:**

- Verify Azure Policy add-on is enabled on the cluster:

``` bash
    az aks show \--resource-group \<rg-name\> \--name \<cluster-name\>
    \--query addonProfiles.azurepolicy
```

- Check if the namespace is excluded:

``` bash
    az aks safeguards show \--resource-group \<rg-name\> \--name
    \<cluster-name\>
```

### 2. Disable Deployment Safeguards

To disable deployment safeguards entirely, you may use the following command:

```bash
    az aks safeguards delete \--resource-group \<rg-name\> \--name
    \<cluster-name\>
```

### 3. Why was I able to turn on Deployment Safeguards without Azure Policy permissions?

Deployment Safeguards uses Azure Policy as an implementation detail. To
turn on Deployment Safeguards on an AKS cluster, you do not need the
correct permissions to assign or delete Azure Policies.

### 4. Why did my deployment resource get admitted even though it wasn\'t following best practices?

Deployment safeguards enforce best practice standards through Azure
Policy controls and has policies that validate against Kubernetes
resources. To evaluate and enforce cluster components, Azure Policy
extends [Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/).
Gatekeeper enforcement also currently operates in
a [fail-open model](https://open-policy-agent.github.io/gatekeeper/website/docs/failing-closed/#considerations).
As there\'s no guarantee that Gatekeeper will respond to our networking
call, we make sure that in that case, the validation is skipped so that
the deny doesn\'t block your deployments.

## Additional Tips

- All safeguard policies are bundled - they cannot be individually
  toggled.

- Use the [AKS GitHub repo](https://github.com/Azure/AKS/issues) to request new safeguard features.

## Contact us for help

If you have questions or need help, [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot),
or ask [Azure community support](https://learn.microsoft.com/answers/products/azure?product=all). You can also submit product feedback to [Azure feedback community](https://feedback.azure.com/d365community).
