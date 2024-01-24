---
title: WCF REST services generate metadata in WSDL
description: This article describes the problem where the REST Service generates WSDL for the associated contracts when you use a REST Service in WCF, and provides a resolution.
ms.date: 03/20/2020
ms.reviewer: hongmeig, vinelap, pradnyad, tvish
---
# WCF REST services generate metadata in the WSDL

This article helps you resolve the problem where other non-RESTful services may be affected because Windows Communication Foundation (WCF) doesn't support metadata for RESTful services.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2019903

## Symptoms

When you use a REST service in WCF, the REST service generates Web Service Description Language (WSDL) for the associated contracts. However, WCF doesn't support metadata for RESTful services. This may cause problems with other non-RESTful services that are hosted in the same service. For example, some properties and methods may be duplicated.

## Cause

Even though WCF doesn't support metadata for REST services, WCF still exposes the WSDL. However, this may cause problems if there are conflicts or duplicates in the metadata that describes the other endpoints in the service.

## Resolution

To work around this issue, use one of the following methods:

- Host the REST services and the other services as separate services.
- Manually edit the WSDL to remove the REST service data. Then, set the `ServiceMetadataBehavior.ExternalMetadataLocation` property to redirect clients to a separate URL that points to that WSDL.
