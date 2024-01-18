---
title: Image pull takes a long time to run
description: Learn about troubleshooting steps that you can take if an image pull takes a long time to run on Azure Container Instances.
ms.date: 12/28/2023
ms.service: container-instances
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: v-leedennis
ms.topic: troubleshooting-problem-resolution
#Customer intent: As a user of Azure Container Instances, I want to learn why an image pull takes a long time to run so that I can create and use container groups successfully.
---
# Image pull takes a long time to run

This article discusses what you can do if an image pull takes a long time to run on Microsoft Azure Container Instances.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

- Container groups are stuck in a "Created" status for a significant amount of time.

- The image size that's used for the container group is large.

## Cause

In Container Instances, images aren't cached forever. If the image isn't cached, the image is pulled from the registry. A registry pull can take a long time if the image is large. This is expected behavior for large, uncached images.

If you need faster pull times, you might want to check whether one of the [listed cached images](/rest/api/container-instances/location/list-cached-images) would work successfully for your use case.

## Solution

Run the following [az container show](/cli/azure/container#az-container-show) command so that you can view the timeline of the container events:

```azurecli
az container show --resource-group <resource-group-name> --name <container-group-name>
```

In this example, the `Pulling` image event begins at 16:30:51, and the successful `Pulled` event is recorded on the same day at 16:48:43. Therefore, the image pull takes almost 18 minutes to finish. You can use this information to determine whether the image pull time is expected or abnormal.

```json
{
  "containers": [
    {
      "command": null,
      "environmentVariables": [],
      "image": "pbdockerregistry-on.azurecr.io/software:166884UK",
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
            "message": "pulling image \"pbdockerregistry-on.azurecr.io/software:166884UK\"",
            "name": "Pulling",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2019-01-22T16:48:43+00:00",
            "lastTimestamp": "2019-01-22T16:48:43+00:00",
            "message": "Successfully pulled image \"pbdockerregistry-on.azurecr.io/software:166884UK\"",
            "name": "Pulled",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2019-01-22T16:48:43+00:00",
            "lastTimestamp": "2019-01-22T16:48:43+00:00",
            "message": "Created container with docker id 2dfc27ee4e6",
            "name": "Created",
            "type": "Normal"
          },
          {
            "count": 1,
            "firstTimestamp": "2019-01-22T16:49:11+00:00",
            "lastTimestamp": "2019-01-22T16:49:11+00:00",
            "message": "Started container with docker id 2edfc27ee4e6",
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
    "fqdn": "<container-name>.westeurope.azurecontainer.io",
    "ip": "40.119.152.151",
    "ports": [
      {
        "port": 443,
        "protocol": "TCP"
      }
    ],
    "type": "Public"
  },
  "location": "westeurope",
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

## More information

- [Azure Container Apps image pull with managed identity](/azure/container-apps/managed-identity-image-pull)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
