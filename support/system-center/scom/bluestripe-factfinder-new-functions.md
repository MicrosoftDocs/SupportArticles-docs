---
title: New functions in BlueStripe FactFinder 8.1
description: Describes the Web console and FactFinder Rest API in BlueStripe FactFinder 8.1.
ms.date: 08/13/2020
---
# What's new in BlueStripe FactFinder 8.1

This article describes the Web console and FactFinder Rest API in BlueStripe FactFinder 8.1.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134893

## Web console

BlueStripe FactFinder 8.1 includes a Web console interface to the management server. The Web console includes application and server lists and maps, Application dashboards, and a subset of the administrator functions. Point your browser to `https://<ManagementServer>:8443/console` to access the Web console.

The original Health Monitoring dashboard is now included as part of the new Web console or it can be accessed directly via `https://<ManagementServer>:8443/execdashboard`.

## FactFinder Rest API

The Rest API provides access to live FactFinder performance, dependency, and application data. This API can be used for analytics and reporting on server dependencies, application discovery, capacity planning, performance benchmarking, configuration analysis, and many other use cases. You can access the Rest API documentation from the **About** box in the Web console, or `https://<ManagementServer>:8443/apidoc`.

There are a number of new options to support the Web console in the **FactFinderMS.properties** file. If you upgrade the management server, these options will not get added to your current config, but can be copied over from the **FactFinderMS.properties.new** file. These options are the default values used when they're not specified in the property file.

- Default ports for the embedded web server

    `bluestripe.factfinder.webserver.port=8080`  
    `bluestripe.factfinder.webserver.secureport=8443`

- Timeout for connections to the web server (milliseconds)

    `bluestripe.web.idleTimeout = 60000`

- Authentication for the Web console and API

    `bluestripe.web.api.auth.user.enabled = true`

- Disables HTTPS if it's set to true

    `bluestripe.web.api.http.enabled = false`

- HTTP Access Control (CORS): Comma-separated list of hosts to allows cross domain access

    `bluestripe.web.api.cors.origins =`
