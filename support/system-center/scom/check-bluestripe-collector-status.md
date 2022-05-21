---
title: Check the BlueStripe Collector status
description: Describes how to check the status of the BlueStripe Collector on Solaris.
ms.date: 08/13/2020
---
# How to check the status of the BlueStripe Collector on Solaris

This article describes how to check the status of the BlueStripe Collector on Solaris by using commands.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134880

If the BlueStripe Collector service unexpectedly stops, it will automatically attempt to restart itself. If too many restarts occur in a short period, the operating system may prevent the service from restarting.

## Check the status of the collector on Solaris 10

```console
svcs -l bluestripe-collectorsvc
```

Here is a sample output:

> fmri svc:/system/bluestripe-collector:default  
> name BlueStripe Collector  
> enabled true  
> state online  
> next_state none  
> state_time August 1, 2014 12:26:17 PM EDT  
> logfile /var/svc/log/system-bluestripe-collector:default.log  
> restarter svc:/system/svc/restarter:default  
> contract_id 162143  
> dependency require_all/none file://localhost/etc/bluestripe-collector/BlueStripeCollector.properties (online)  
> dependency require_all/none svc:/system/filesystem/local (online)  
> dependency require_all/none svc:/network/service (online)  
> dependency require_all/none svc:/milestone/name-services (online)

If state is **online**, the collector is up and running.

If state is **disabled**, enable the collector by using the following command:

```console
svcadm enable bluestripe-collector
```

If state is **maintenance**, follow these steps:

1. Clear maintenance mode.

    ```console
    svcadm clear bluestripe-collector
    ```

2. Start the collector.

    ```console
    svcadm start bluestripe-collector
    ```

## Start and stop the collector on Solaris 10

Stop the collector by using the following command:

```console
svcadm disable bluestripe-collector
```

Start the collector by using the following command:

```console
svcadm start bluestripe-collector
```

## Check the status of the collector on Solaris 8 and 9

```console
/etc/init.d/bluestripe-collector status
```

## Restart the collector on Solaris 8 and 9

```console
/etc/init.d/bluestripe-collector restart
```

or

```console
/etc/init.d/bluestripe-collector stop
/etc/init.d/bluestripe-collector start
```
