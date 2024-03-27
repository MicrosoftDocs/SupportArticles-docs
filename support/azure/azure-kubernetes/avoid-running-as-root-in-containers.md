---
title: Avoid running as root in Containers hosted on Azure Kubernetes Service
description: This article provides information about how to run as nonroot user in containers by using the securityContext field.
ms.date: 03/27/2024
ms.reviewer: chiragpa, andbar, haitch, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Security best practices: avoid running as root in Containers

It isn't recommended to run as root user inside containers due security considerations. To run the container with nonroot user, specify the `securityContext`settings in the YAML file.

**SecurityContext**

- Resource: Pod / Deployment / DaemonSet / StatefulSet / ReplicaSet / ReplicationController / Job / CronJob
- Arguments:
    - runAsNonRoot (Optional): If it's true, the container operates without root privileges. Default is false.
    - runAsUser (Optional): If user number is anything other than 0,  the container runs with that user ID, which is not root user. 

By default, the `securityContext field` is `empty ({})`. To implement these fields in the YAML file, see [Configure a security context for a pod or container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/). After adding these configurations, redeploy the pods to enforce the updates. If the field is omitted, the pod will run as root.

Additionally, the `runAsGroup` field specifies the primary group ID of 3000 for all processes within any containers of the Pod. If the field is omitted, the primary group ID of the containers will default to run as root (0).


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
