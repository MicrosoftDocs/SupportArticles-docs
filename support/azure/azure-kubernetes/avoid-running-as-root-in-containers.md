---
title: Avoid running as root in containers on Azure Kubernetes Service
description: This article discusses how to run as a nonroot user in containers by using the securityContext field.
ms.date: 03/27/2024
ms.reviewer: chiragpa, andbar, haitch, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Security best practice: don't run as root in containers

To improve security, we recommend that you don't run as a root user inside containers that are hosted on Azure Kubernetes Service. To run the container as a nonroot user, specify the following `securityContext`settings in the YAML file when you deploy a pod or other Azure Kubernetes resources.

**SecurityContext**

- Resource: Pod / Deployment / DaemonSet / StatefulSet / ReplicaSet / ReplicationController / Job / CronJob
- Arguments:
    - **runAsNonRoot (Optional)**: If it's true, the container operates without root privileges. Default is false.
    - **runAsUser (Optional)**: If user number is anything other than **0** (root), the container runs by using that user ID (not the root user). 

By default, the `securityContext` field is `empty ({})`. To implement these fields in the YAML file, see [Configure a security context for a pod or container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/). After you add these configurations, redeploy the pods to enforce the updates. If the `securityContext` field is omitted, the pod runs as root.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
