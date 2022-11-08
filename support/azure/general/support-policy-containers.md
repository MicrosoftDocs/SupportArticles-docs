---
title: Support policy for containers and related services on Azure
description: Describes the support options and coverage that Microsoft offers for containers and surrounding infrastructure services.
ms.date: 08/14/2020
ms.reviewer: 
ms.service: azure-common-issues-support
ms.author: genli
author: genlin
---
# Support policy for containers and related services on Azure

Azure provides flexible, extensive support options for container deployments. This article outlines the support options and coverage for containers and the surrounding infrastructure services that Microsoft offers.

_Original product version:_ &nbsp; Container Service  
_Original KB number:_ &nbsp; 4035670

## Supported components

### Containers running on physical infrastructure

For containers that are running on physical infrastructure and servers, Microsoft supports instances of Windows Server Containers on Windows Server 2016. For more information, see [Docker Engine on Windows](/virtualization/windowscontainers/manage-docker/configure-docker-daemon).

For ­­­ support of Linux operating systems that are running on physical infrastructure and servers, customers have to contact the distribution provider for support, such as [Canonical](https://www.canonical.com/services), [CoreOS](https://coreos.com/support), or [Red Hat](https://www.redhat.com/en/services/support).

Physical infrastructure support is not provided by Microsoft, except in cases in which the hardware is a Microsoft product under warranty or a support plan, such as for Surface Pro 4.

:::image type="content" source="./media/support-policy-containers/4036515_en_1.png" alt-text="Physical Infrastructure.":::

## Containers on Azure Cloud Services

Azure Container Service has been retired on January 31, 2020. For more information, see [Azure Container Service](https://azure.microsoft.com/updates/azure-container-service-will-retire-on-january-31-2020/).

## Container orchestrators

### Azure Service Fabric

Customers who have deployed Windows Server Containers on Windows Server 2016 can use Azure Service Fabric as a container orchestrator. Azure Service Fabric is fully supported by Microsoft in this scenario, which includes the Azure Cloud Platform, Windows operating system, Container Service, and orchestrator.

### Third-party orchestrators

Container orchestrators are enabled to work with container deployments as mentioned above, such as Windows Server Containers and Azure Kubernetes Service (AKS). Microsoft provides support for the deployment of common orchestrators such as Docker Swarm, Kubernetes, DC or system, and several others on **AKS ONLY**. Microsoft does not currently offer phone or web-based technical support for the configuration or operation of these container orchestrators within AKS or any support for third-party container orchestrators outside of AKS.

We recommend that you use community resources or contact the orchestrator provider for additional technical assistance:

- [Mesosphere](https://support.d2iq.com/)
- [Docker Swarm](https://docs.docker.com/engine/swarm/)
- [DC/OS](https://dcos.io/community/)
- [Kubernetes](https://kubernetes.io/community/)

If you think you have encountered a bug, visit the AKS community issue page on GitHub: [AKS Community on GitHub](https://github.com/Azure/AKS).

## Container workloads

Support for issues within a container is limited to "Hello, world" scenarios that help verify whether the container implementation is operating as expected.

## Azure networking and storage

Microsoft supports Microsoft products when it can be determined that the issue is not caused by the container configuration or container engine.

For third-party (non-Microsoft technology), Microsoft provides commercially reasonable support. Example scope of support available from Microsoft:

- Deployment and configuration issues
- Performance issues related to Azure platform
- Networking

:::image type="content" source="media/support-policy-containers/container-service.png" alt-text="Screenshot of container services.":::

## Azure Web Apps and containers

Customers may also choose to deploy containers to Azure Web Apps on Linux. In this scenario, customers can deploy a web app on Linux and then deploy containers within the app by using the Azure Container Registry, Docker Hub, a default container, or a private registry.

### Component support

Microsoft offers commercially reasonable support for the components that are deployed in this scenario, including the operating system, Docker Engine, and hosted elements in the container (such as Node.js). Customized code is not within the scope of support.

:::image type="content" source="media/support-policy-containers/component-support.png" alt-text="Screenshot of component support.":::

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
