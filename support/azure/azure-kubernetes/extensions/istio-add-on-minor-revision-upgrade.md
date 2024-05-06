---
title: Istio service mesh add-on minor revision upgrade troubleshooting
description: Learn how to do minor revision upgrade troubleshooting on the Istio service mesh add-on for Azure Kubernetes Service (AKS).
ms.date: 04/26/2024
author: SanyaKochhar
ms.author: kochhars
editor: v-jsitser
ms.reviewer: fuyuanbie, shasb, nshankar, ddama, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-extensions-add-ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot minor revision upgrades of the Istio add-on so that I can use the Istio service mesh successfully.
---
# Istio service mesh add-on minor revision upgrade troubleshooting

This article discusses troubleshooting scenarios and restrictions in the minor revision upgrade and rollback processes for the Istio service mesh add-on in Microsoft Azure Kubernetes Service (AKS).

> [!NOTE]
> Istio uses the term "revisions" to implement the canary upgrade process and distinguish between versions. Each revision designation (written as *x*-*y*) corresponds to a major.minor version designation (*x*.*y*). You can control your control plane revision, but you can't control the specific patch version within a revision band.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Troubleshooting matrix

The following table lists various problems and the different scenarios and solutions for those problems.

| Scenario | Problem | Solution |
|--|--|--|
| Data plane workloads are dropped from the mesh. | Data plane and control plane revisions didn't correspond before you completed or rolled back an upgrade. | <p>Follow these steps:</p><ol> <li><p>Relabel namespaces that contain workloads by specifying the revision that's expected to exist after the upgrade completion or rollback. To do this, run the [kubectl label](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_label/) command:</p><pre>kubectl label namespace default istio.io/rev=asm-x-y --overwrite</pre></li> <li><p>Restart the corresponding workload deployments to trigger sidecar reinjection of the correct revision. To do this, run the [kubectl rollout restart](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_restart/) command:</p><pre>kubectl rollout restart deployment \<deployment name></pre></li> <li><p>Verify that the sidecar images exist. To do this, run the [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/) command:</p><pre>kubectl get pods --namespace \<namespace> --output yaml \| grep mcr.microsoft.com/oss/istio/proxyv2:</pre></li> </ol> |
| Control plane pods are in the pending state. | The pods lack capacity. | Verify the state of the pods by running the [kubectl describe](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_describe/) command. If capacity is the problem, you can scale up your cluster to add another node. For more information, see [Manually scale the node count in an Azure Kubernetes Service (AKS) cluster](/azure/aks/scale-cluster). |
| The [az aks mesh get-upgrades](/cli/azure/aks/mesh#az-aks-mesh-get-upgrades) command returns no available upgrades. | The newest Istio revision might be incompatible with the current AKS cluster version. | You can use the [az aks mesh get-revisions](/cli/azure/aks/mesh#az-aks-mesh-get-revisions) command to discover whether newer Istio revisions exist. The output includes a list of compatible cluster versions for each Istio revision. Therefore, you can determine whether a cluster upgrade is necessary. |

> [!NOTE]
> To avoid unintended behavior and broken functionality, and also make sure that you're receiving updates for security vulnerabilities, we strongly recommend that you upgrade to a supported and up-to-date [AKS version](/azure/aks/supported-kubernetes-versions) and Istio add-on revision. Remember that the add-on revision should also be within the supported Kubernetes version range for the given AKS cluster. As highlighted in the [Minor revision upgrade](/azure/aks/istio-upgrade#minor-revision-upgrade) section of the Istio upgrade article, you can run the `az aks mesh get-revisions` and `az aks mesh get-upgrades` commands to learn about available add-on revisions, upgrades, and compatibility information.

## Restrictions

- A downgrade to an older revision (outside the canary rollback process) isn't allowed.

- Skipping from one revision to a nonconsecutive revision is allowed only if AKS no longer supports both the current revision and the next upgrade revision. At this point, the only upgrade that's available to you is the lowest supported revision.

- The Istio `sidecar.istio.io/inject` label doesn't enable sidecar injection for the Istio add-on. You must use the `istio.io/rev` label when you label and relabel your namespaces during the canary upgrade.

- Labeling must occur on a namespace level instead of on a per-deployment level. If you want to be able to roll over pods individually, you can choose to restart individual deployments instead of using pod labeling.

- If you're using the Istio add-on Shared MeshConfig, you have to copy or transfer MeshConfig settings to the new ConfigMap before you do a canary upgrade. For more information, see [Mesh configuration and upgrades](/azure/aks/istio-meshconfig#mesh-configuration-and-upgrades).

- The Istio add-on deploys Istio ingress gateway pods and deployments per revision. If you're doing a [canary upgrade](https://istio.io/latest/docs/setup/upgrade/canary/) and have two control plane revisions installed in your cluster, you might have to troubleshoot multiple ingress gateway pods across both revisions.

## References

- [Safely upgrade the Istio control plane with revisions and tags](https://istio.io/v1.16/blog/2021/revision-tags/)

- [General Istio service mesh add-on troubleshooting](istio-add-on-general-troubleshooting.md)

- [Istio service mesh add-on MeshConfig troubleshooting](istio-add-on-meshconfig.md)

- [Istio service mesh add-on ingress gateway troubleshooting](istio-add-on-ingress-gateway.md)

- [Istio service mesh add-on plug-in CA certificate troubleshooting](istio-add-on-plug-in-ca-certificate.md)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
