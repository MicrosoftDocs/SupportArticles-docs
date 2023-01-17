---
title: FactFinder heap space configuration
description: Describes some basic guidelines to configure FactFinder heap space.
ms.date: 08/13/2020
---
# FactFinder heap space configuration suggestions

While there are no concrete rules about configuring heap sizes, there are some basic guidelines that can help prevent performance issues as systems grow.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134887

Required heap space will depend on the average load per collector, and can vary greatly in different environments.

|Size (collectors per management server)| Management server main heap| Management server exec heap| Console heap |
|---|---|---|---|
|Initial (0-50)|2 GB|1 GB|1 GB|
|Medium (50-200)|2-4 GB|1-2 GB|2-4 GB|
|Large (200+)|4-8 GB|2-4 GB|4-8 GB|
  
## Main heap space

By default, this heap is 1 GB. In most cases, doubling this value to 2 GB is recommended. Deployments with lots of collectors (hundreds per management server), or systems that have extraordinarily high amounts of transactions may need more heap space to run optimally.

Config file: `/server/config/FactFinderMS.vmoptions`

Setting: `-Xmx2048m`

To increase heap space to 4 GB, you would change the above value to `-Xmx4096m`, save the change, and restart the management server service for the change to take effect.

## Exec heap space

The exec heap space is separate from the main heap, and is used for several processor intensive operations such as viewing historical queries. When a historical query is started, FactFinder spawns a separate Java virtual machine (JVM) to do the work so that the management server performance isn't impacted. We recommend setting this value to half the size of the main heap to begin.

Config file: `/server/config/FactFinderMS.properties` on the management server

Setting: `bluestripe.factfinder.ms.exec.heapSize`

After changing the value, save the change and restart the management server service for the change to take effect.

## Console heap space (Local and WebStart)

There are two types of console that you can use to access a FactFinder management server. The locally installed console, and the Java WebStart console.

Local console heap config file: `/console/config/FactFinderConsole.vmoptions`

Setting: `-Xmx2048m`

WebStart console heap config file: `FactFinderMS.properties`

Setting: `bluestripe.factfinder.consolewebstart.heapSize`

After changing the heap value, save the change and restart the management server service for the change to take effect.
