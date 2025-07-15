---
title: Troubleshooting Guide: Deployment Safeguards in Azure Kubernetes (AKS)
description: Provides a solution to issues related to deployment safeguards in Azure Kubernetes Service (AKS).
ms.date: 07/15/2025
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshooting guide: Deployment Safeguards in Azure Kubernetes Service (AKS)

Deployment Safeguards in Azure Kubernetes Service (AKS) help enforce Kubernetes best practices by using Azure Policy and Gatekeeper. While they offer valuable protection, a misconfiguration or misunderstanding of their behavior can cause blocked or mutated workloads. This guide helps you troubleshoot common issues when you use Deployment Safeguards in **Warn** or **Enforce** mode.

## Frequently asked questions

### Why aren't Deployment Safeguards taking effect?

**Symptoms:**

- You deploy noncompliant resources, but you see no warnings or signs of enforcement.

- The Azure Policy dashboard shows a **Not started** value or an empty compliance status.

**Recommended actions:**

- Verify that the Azure Policy add-on is enabled on the cluster:

``` bash
    az aks show \--resource-group \<rg-name\> \--name \<cluster-name\>
    \--query addonProfiles.azurepolicy
```

- Check whether the namespace is excluded:

``` bash
    az aks safeguards show \--resource-group \<rg-name\> \--name
    \<cluster-name\>
```

### How can I disable Deployment Safeguards?

To disable deployment safeguards entirely, run the following command:

```bash
    az aks safeguards delete \--resource-group \<rg-name\> \--name
    \<cluster-name\>
```

### Why can I turn on Deployment Safeguards without Azure Policy permissions?

Deployment Safeguards uses Azure Policy as an implementation detail. To turn on Deployment Safeguards on an AKS cluster, you do not have to have the
correct permissions to assign or delete Azure Policies.

## 4. Why does my deployment resource get admitted even though it doesn\'t follow best practices?

Deployment safeguards enforce best practice standards through Azure Policy controls. It has policies that validate against Kubernetes resources. To evaluate and enforce cluster components, Azure Policy extends [Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/). Gatekeeper enforcement also currently operates in a [fail-open model](https://open-policy-agent.github.io/gatekeeper/website/docs/failing-closed/#considerations). Because there are no guarantee that Gatekeeper will respond to our networking call, we make sure that, in this case, the validation is skipped so that the denial doesn't block your deployments.

## Additional tips

- All safeguard policies are bundled. They cannot be individually toggled.

- Use the [AKS GitHub repo](https://github.com/Azure/AKS/issues) to request new safeguard features.

## Contact us for help

If you have questions or need help, [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot), or ask [Azure community support](https://learn.microsoft.com/answers/products/azure?product=all). You can also submit product feedback to [Azure feedback community](https://feedback.azure.com/d365community).
