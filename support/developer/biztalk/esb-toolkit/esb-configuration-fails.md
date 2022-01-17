---
title: ESB configuration fails
description: BizTalk ESB configuration fails because of problems in ESB.config.
ms.date: 03/16/2020
ms.prod-support-area-path: ESB Toolkit
ms.reviewer: shaheera
---
# ESB configuration fails with unrecognized element typeConfig

This article describes the issue where the Enterprise Service Bus (ESB) 2.2 configuration fails.

_Original product version:_ &nbsp; BizTalk Server 2013  
_Original KB number:_ &nbsp; 2887942

## Symptoms

The following error is thrown during ESB 2.2 configuration:

> Exception calling "PushAllConfiguration" with "6" argument(s): 'Unrecognized element 'typeConfig'. (C:\Program Files (x86)\Microsoft BizTalk ESB Toolkit\esb.config line 151)'

## Cause

The error (Unrecognized element 'typeConfig') occurs because the `typeConfig` element in *ESB.config* is no longer valid since ESB Toolkit 2.2 uses Unity 2.0.

For more information about Unity 2.0, visit [The Unity Configuration Schema](/previous-versions/msp-n-p/ff660914(v=pandp.20)).

## Resolution

Modify the *esb.config* file as outlined in [ESB Toolkit BRE Itinerary Resolver Fails with Exception](https://support.microsoft.com/help/2887594).
