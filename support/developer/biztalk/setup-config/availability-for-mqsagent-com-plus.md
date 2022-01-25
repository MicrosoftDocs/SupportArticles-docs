---
title: High availability for MQSAgent COM+
description: This article explains that you must install the MQSAgent or MQSAgent2 COM+ application on each cluster node to provide high availability in a clustered environment.
ms.date: 03/17/2020
ms.custom: sap:BizTalk Server Setup and Configuration
ms.reviewer: shaheera
---
# Provide high availability for the MQSAgent or MQSAgent2 COM+ application in a clustered environment

This article describes why you must install the MQSAgent or MQSAgent2 COM+ application on each cluster node to provide high availability in a clustered environment.

_Original product version:_ &nbsp; BizTalk Server 2006 and later versions  
_Original KB number:_ &nbsp; 936125

## Summary

Consider the following scenario:

- In Microsoft BizTalk Server, you use the BizTalk Adapter for MQSeries adapter to connect to a clustered IBM WebSphere MQ Server-based server.
- The clustered IBM WebSphere MQ Server-based server hosts the MQSAgent or MQSAgent2 COM+ application.

In this scenario, you should not provide high availability by clustering the MQSAgent or MQSAgent2 COM+ application.

> [!NOTE]
> In BizTalk Server 2006 and later versions, the MQSAgent COM+ application is named MQSAgent2.

## How to provide high availability

To provide high availability for the MQSAgent or MQSAgent2 COM+ application in a clustered environment, you must install the COM+ application locally on each cluster node. Don't cluster this component. If the COM+ application stops for any reason, the next call to the application from BizTalk Server automatically restarts the application. This behavior makes sure that you provide high availability without clustering this component.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
