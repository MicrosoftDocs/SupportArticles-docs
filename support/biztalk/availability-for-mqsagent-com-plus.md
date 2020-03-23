---
title: High availability for MQSAgent COM+
description: Explains that you must install the MQSAgent COM+ application or the MQSAgent2 COM+ application on each cluster node to provide high availability in a clustered environment.
ms.date: 03/17/2020
ms.prod-support-area-path: 
ms.reviewer:  shaheera
---
# How to provide high availability for the MQSAgent COM+ application or for the MQSAgent2 COM+ application in a clustered environment

This article describes that you must install the MQSAgent COM+ application or the MQSAgent2 COM+ application on each cluster node to provide high availability in a clustered environment.

_Original product version:_ &nbsp; BizTalk Server 2006 and later versions  
_Original KB number:_ &nbsp; 936125

## Summary

Consider the following scenario:

- In Microsoft BizTalk Server, you use the BizTalk Adapter for MQSeries adapter to connect to a clustered IBM WebSphere MQ Server-based server.
- The clustered IBM WebSphere MQ Server-based server hosts the MQSAgent Microsoft COM+ application or the MQSAgent2 COM+ application.

In this scenario, you should not provide high availability by clustering the MQSAgent COM+ application or the MQSAgent2 COM+ application.

> [!NOTE]
> In BizTalk Server 2006 and later versions, the MQSAgent COM+ application is named the MQSAgent2 COM+ application.

## How to provide high availability

To provide high availability for the MQSAgent COM+ application or for the MQSAgent2 COM+ application in a clustered environment, you must install the COM+ application locally on each cluster node. Do not cluster this component. If the COM+ application stops for any reason, the next call to the COM+ application from BizTalk Server automatically restarts the COM+ application. This behavior makes sure that you provide high availability without clustering this component.

## Third-party contact disclaimer

Microsoft provides third-party contact information to help you find additional information about this topic. This contact information may change without notice. Microsoft does not guarantee the accuracy of third-party contact information.
