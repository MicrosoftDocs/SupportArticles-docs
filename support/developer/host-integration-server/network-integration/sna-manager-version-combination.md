---
title: SNA Manager version combinations
description: This article introduces the information of SNA Manager version combinations.
ms.date: 05/11/2020
ms.custom: sap:Network Integration (SNA Gateway)
ms.topic: article
---
# SNA Manager version combinations

_Original product version:_ &nbsp; Host Integration Server 2013, 2010  
_Original KB number:_ &nbsp; 2894153

This article lists the following are SNA Manager combinations that work and don't work properly:

- 32-bit version of SNA Manager -> Managing 32-bit Host Integration Server (HIS) Server = works
- 64-bit version of SNA Manager -> Managing 64-bit HIS Server = works
- 32-bit version of SNA Manager -> Managing 64-bit HIS Server = does not work
- 64-bit version of SNA Manager -> Managing 32-bit HIS Server = does not work

For example, using a 32-bit version of SNA Manager against a 64-bit HIS Server. Observations are that configuration changes are made but there was no Status information displayed and the services could not be stopped/started.

In the non-working scenarios, the recommendation is to use one of the following:

- Install an operation system (OS) on the HIS Client system running SNA Manager that matches the architecture (x86 or x64) of the OS on the HIS Servers.
- Remote desktop to the HIS Server and run SNA Manager on the HIS Server system.
