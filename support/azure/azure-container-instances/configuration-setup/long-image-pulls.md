---
title: Image pull takes a long time to complete
description: Learn about troubleshooting steps that you can take if an image pull takes a long time to run on Azure Container Instances.
ms.date: 04/14/2025
ms.service: azure-container-instances
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: edneto, v-leedennis, kennethgp
ms.custom: sap:Configuration and Setup
#Customer intent: As a user of Azure Container Instances, I want to learn why an image pull takes a long time to complete so that I can create and use container groups successfully.
---
# Image pull takes a long time to complete

This article discusses possible causes for an image pull taking long time to complete on Microsoft Azure Container Instances.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

- Container groups are stuck in a **Creating** status for a significant amount of time.
- The image size is large.

## Cause

In Container Instances, images aren't cached forever. If the image isn't cached, the image is pulled from the registry. A registry pull can take a long time if the image is large. This is expected behavior for large, uncached images.

If you need faster pull times, you might want to check whether one of the [listed cached images](/rest/api/container-instances/location/list-cached-images) would work successfully for your use case.

## Solution

To view the timeline of the container events, run the following [az container show](/cli/azure/container#az-container-show) command:

```azurecli
az container show --resource-group <resource-group-name> --name <container-group-name>
```

The time span between the `Pulling` and `Pulled` events allows you to determine whether the image pull time is expected or abnormal. The following is a sample command output:

```json
{
  "containers": [
    {
      "command": null,
      "environmentVariables": [],
      "image": "pbdockerregistry-on.azurecr.io/<image-name>:<tag>",
      "instanceView": {
        "currentState": {
          "detailStatus": "",
          "exitCode": null,
          "finishTime": null,
          "startTime": "2019-01-22T16:49:11+00:00",
          "state": "Running"
        },
        "events": [
          {
            "count": 1,
            "firstTimestamp": "2019-01-22T16:30:51+00:00",
            "lastTimestamp": "2019-01-22T16:30:51+00:00",
            "message": "pulling image \"pbdockerregistry-on.azurecr.io/<image-name>:<tag>\"",
            "name": "Pulling",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2019-01-22T16:48:43+00:00",
            "lastTimestamp": "2019-01-22T16:48:43+00:00",
            "message": "Successfully pulled image \"pbdockerregistry-on.azurecr.io/<image-name>:<tag>\"",
            "name": "Pulled",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2019-01-22T16:48:43+00:00",
            "lastTimestamp": "2019-01-22T16:48:43+00:00",
            "message": "Created container with docker id <id>",
            "name": "Created",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2019-01-22T16:49:11+00:00",
            "lastTimestamp": "2019-01-22T16:49:11+00:00",
            "message": "Started container with docker id <id>",
            "name": "Started",
            "type": "Normal"
          }
        ],
        "previousState": null,
        "restartCount": 0
      },
      "livenessProbe": null,
      "name": "<container-name>",
      "ports": [
        {
          "port": 443,
          "protocol": "TCP"
        }
      ],
      "readinessProbe": null,
      "resources": {
        "limits": null,
        "requests": {
          "cpu": 4.0,
          "memoryInGb": 4.0
        }
      },
      "volumeMounts": null
    }
  ],
  "diagnostics": null,
  "id": "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.ContainerInstance/containerGroups/<container-name>",
  "identity": null,
  "imageRegistryCredentials": [
    {
      "password": null,
      "server": "<user-name>.azurecr.io",
      "username": "<user-name>"
    }
  ],
  "instanceView": {
    "events": [],
    "state": "Running"
  },
  "ipAddress": {
    "dnsNameLabel": "<container-name>",
    "fqdn": "<container-name>.<region>.azurecontainer.io",
    "ip": "<IP>",
    "ports": [
      {
        "port": 443,
        "protocol": "TCP"
      }
    ],
    "type": "Public"
  },
  "location": "<region>",
  "name": "<container-name>",
  "networkProfile": null,
  "osType": "Windows",
  "provisioningState": "Succeeded",
  "resourceGroup": "<resource-group-name>",
  "restartPolicy": "Always",
  "tags": {},
  "type": "Microsoft.ContainerInstance/containerGroups",
  "volumes": null
}
```

## Resources

- [Azure Container Apps image pull with managed identity](/azure/container-apps/managed-identity-image-pull)
