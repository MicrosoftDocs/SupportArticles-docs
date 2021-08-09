---
title: Can't call HL7 pipelines from Orchestration
description: Calling BizTalk Server HL7 Pipelines directly from Orchestration isn't supported as per RFC 1481591. 
ms.date: 03/16/2020
ms.prod-support-area-path: Accelerators
---
# BizTalk Server HL7 pipelines can't be called from orchestration

This article provides information about the issue where calling BizTalk Server HL7 pipelines directly from Orchestration fails.

_Original product version:_ &nbsp; BizTalk Server 2013, 2010  
_Original KB number:_ &nbsp; 2892768

## Summary

In BizTalk Server, you can normally execute pipelines from an expression shape in an orchestration. However, this won't work with the BizTalk Accelerator for HL7 pipelines. The `BTAHL72XReceive`, `BTAHL72XSend`, `BTAHL72XMLReceive`, and `BTAHL72XMLSend` pipelines must be executed within a port. If you attempt to execute any of these pipelines from an Expression shape in an orchestration, unexpected behavior can result.

## Workaround

The general workaround when not being able to call a pipeline from an orchestration is to send out the message via a send port and then receive it back into BizTalk via a receive location. The HL7 pipeline can be executed in the send port or receive location and the resulting message can be routed back to the same orchestration instance via a correlating receive.

Another option is to use a custom loopback adapter. It's a solicit-response send port that returns the same value it receives. The HL7 pipeline can be used with this two-way send port.
