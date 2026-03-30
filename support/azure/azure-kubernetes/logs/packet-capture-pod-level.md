---
title: How to capture a TCP dump from a pod running on an AKS cluster
description: Learn how to capture a TCP dump from a pod on an AKS cluster, download the capture to your local computer, and troubleshoot connectivity issues. Get started now.
ms.date: 02/27/2024
ms.author: jarrettr
author: y2kdread
ms.service: azure-kubernetes-service
ms.custom: sap:Monitoring and Logging
---
# Capture TCP packets from a pod on an AKS cluster

## Summary

This article explains how to capture TCP traffic at a pod in an Azure Kubernetes Service (AKS) cluster and download the capture to your local computer.

## Prerequisites

You must run the Azure CLI version 2.0.59 or a later version.

Run `az --version` to verify the version. To install the latest version of the Azure CLI, see [Install Azure CLI](/cli/azure/install-azure-cli).

## Identify the pod and install TCPdump

1. Identify the name of the pod that you want to capture the TCP packets from. This pod should be the one that has the connectivity problems. To identify the pod, run `kubectl get pods -A` to see the list of pods on your AKS cluster. The following example shows the output:

    ```output
    NAME                               READY     STATUS    RESTARTS   AGE
    azure-vote-back-2549686872-4d2r5   1/1       Running   0          31m
    azure-vote-front-848767080-tf34m   1/1       Running   0          31m
    ```

   If you know the namespace that the pod runs in, you can also run `kubectl get pods -n <namespace>` to get a list of pods that are running in that namespace.

1. Connect to the pod that you identified in the previous step. The following commands use `azure-vote-front-848767080-tf34m` as the pod name. Replace it with the correct pod name. If the pod isn't in the default namespace, add the `--namespace` parameter to the `kubectl exec` command.

   ```azurecli
   kubectl exec azure-vote-front-848767080-tf34m -it -- /bin/bash
   ```

1. After you connect to the pod, run `tcpdump --version` to check whether TCPdump is installed. If you receive a "command not found" message, run the following command to install TCPdump in the pod:

    ```azurecli
    apt-get update && apt-get install tcpdump
    ```

    If your pod uses Alpine Linux, run the following command to install TCPdump:

   ```azurecli
    apk add tcpdump
    ```

## Capture TCP packets and save them to a local directory

1. Run `tcpdump -s 0 -vvv -w /capture.cap` to start capturing TCP packets on your pod.
1. After the packet capture finishes, exit your pod shell session.
1. Run the following command to save the packets to the current directory:

    ```azurecli
    kubectl cp azure-vote-front-848767080-tf34m:/capture.cap capture.cap
    ```

 
