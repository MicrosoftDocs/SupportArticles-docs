---
title: BlueStripe management server firewall rules
description: Describes firewall rules for the BlueStripe management server.
ms.date: 08/13/2020
---
# BlueStripe management server firewall rules

This article describes firewall rules for the BlueStripe management server.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134888

## Management server firewall rules

The following ports need to be open on the management server.

|Direction and port|Description|
|---|---|
|Outgoing: TCP and UDP 7561|Discovery and outgoing connections to collectors|
|Incoming: TCP 7560|Incoming connections from collector initiated connections|
|Incoming: TCP 7565|Incoming connections from Java consoles and DB loader|
|Incoming: TCP 8080 and 8443|Incoming connections to the Jetty WebServer from the Web console|
  
## Collector firewall rules

The following ports need to be open on the collector

|Direction and port|Description|
|---|---|
|Incoming: TCP and UDP 7561|Discovery and incoming connections from the management server|
|Outgoing: TCP 7560|Outgoing connections initiated from the collector|
  
## Java console firewall rules

The following ports need to be open on the Java console.

|Direction and port|Description|
|---|---|
|Outgoing: TCP 7565|Outgoing connections to the management server|
  
## DB loader firewall rules

The following ports need to be open on the DB loader.

|Direction and port|Description|
|---|---|
|Outgoing: TCP 7565|Outgoing connections to the management server|
|Outgoing: TCP 5432|Outgoing connections to `PostgreSQL`|
  