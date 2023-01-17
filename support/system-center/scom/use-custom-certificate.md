---
title: Use a custom certificate
description: Describes how to use a custom certificate on a BlueStripe management server.
ms.date: 08/13/2020
---
# How to use a custom certificate on a BlueStripe management server

By default, the FactFinder management server and collectors use a default BlueStripe self-signed certificate and private key to encrypt communication. Starting with V8.1.0, these can be replaced with custom self-signed or certificate authority (CA) signed certificates.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134886

## Summary

The management server has a single private key for use in identifying itself. The management server's private key is used for making secure connections to the Web console and API clients and collectors. This private key is stored in the config directory under the installation directory. By default, the BlueStripe self-signed certificate and private key is installed.

Each collector must have a public certificate for each management server it's authorized to access. These public certificates are stored in the config directory under the installation directory. Removing a management server's certificate from a collector blocks next access. If a management server's certificate is signed by a CA, the CA's public certificate must also be included in the config directory on the collector. Starting with V8.1.0, you must opt-in to use the BlueStripe self-signed certificate.

Each web browser must accept the certificate into its trust store for Web console connections. Using the BlueStripe self-signed certificate will cause self-signed Secure Sockets Layer (SSL) certificate warnings, and will need to be added as a security exception to trust the site. You can disable HTTPS for the Web console, by adding or changing this option in the **FactFinderMS.properties** file and restarting the management server: `bluestripe.web.api.http.enabled = true`.

## Recommended upgrade process to use a custom certificate

The recommended process rolls out a new certificate to minimize loss of connectivity.

1. Upgrade the management server that will continue to use the default BlueStripe self-signed certificate and private key.

2. Upgrade the collectors by passing in the location of the new management server public certificate(s) and (optionally) the CA public certificate, but don't select the option to remove the BlueStripe self-signed certificate. If doing silent installs, you must pass a new installation flag `/DefaultCert` or `--defaultcert` to opt-in.

3. Install the management server's new certificate and private key and restart. This will force new connections to use the new certificate.

4. Optionally delete the BlueStripe self-signed certificate at the collectors.

For more information, see the Administrator's Guide

- Installing Custom Certificates under the management server
- Collector Install and Silent Install

## Management server configuration options

- Whether to use SSL when connecting with collectors

    ```console
    bluestripe.factfinder.ms.server.useSSL = true
    ```

- KeyStore configuration

  - Sets the filename of the keystore to use for secure connections.
  - If a custom file is used, you must generate a data file with `FactFinderKeyStoreTool`. Run `FactFinderKeyStoreTool -?` for usage.  

  ```console
  bluestripe.ms.keystore=factfinder.p12
  ```
