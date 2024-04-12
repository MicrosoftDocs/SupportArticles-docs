---
title: Adapter for TIBCO EMS supports only text
description: This article describes how the BizTalk Adapter for TIBCO EMS supports only the text message type.
ms.date: 03/16/2020
ms.custom: sap:Adapters
---
# BizTalk Adapter for TIBCO EMS supports only the text message type

_Original product version:_ &nbsp; BizTalk Server 2013, 2010  
_Original KB number:_ &nbsp; 2925887

TIBCO Enterprise Message Service (EMS) accepts all messages enumerated in the Java Message Service (JMS) specification (text, byte, stream, map, and object). However, the BizTalk Adapter for TIBCO EMS supports only the text message type.

JMS doesn't require type text messages to contain XML-formatted bodies. The adapter doesn't process the body of a message before providing it to the BizTalk Server as received. So, messages submitted to BizTalk Server through the adapter might not always be parsed as XML data.
