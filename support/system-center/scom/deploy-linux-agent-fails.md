---
title: Can't deploy the Linux agent to a Red Hat server
description: Fixes an issue in which you can't deploy the System Center Operations Manager Linux agent to a Red Hat server.
ms.date: 07/13/2020
ms.custom: linux-related-content
ms.reviewer: monsee
---
# The certificate Common Name (CN) does not match when deploying the Operations Manager Linux agent

This article fixes an issue in which you can't deploy the System Center Operations Manager Linux agent to a Red Hat server and receive **The certificate Common Name (CN) does not match** error.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2651766

## Symptoms

Attempting to deploy the System Center Operations Manager Linux agent to a Red Hat server fails. In this scenario, you receive the error below while discovering and deploying the agent:

> The certificate Common Name (CN) does not match. Please resolve the issue, and then run
>
> The server certificate on the destination computer (\<Redhat machine name>) has the following errors:  
> The SSL certificate is signed by an unknown certificate authority.  
> The SSL certificate contains a common name (CN) that does not match the hostname.  
> For additional help on this error please go to ...

## Cause

This can occur for either of the following reasons:

- Certificates may not be valid as the reporting server may have been changed.
- The certificate contains an incorrect host name.

## Resolution

To resolve this issue, complete the following steps:

1. Remove the existing contents of the agent directory on the server and reinstall the agent RPM.
1. Generate the certificate, making sure to use the correct host name:

   `/opt/Microsoft/scx/bin/tools/scssslconfig -f -h <hostname>`

1. Check the status of the certificate:

   ```console
   openssl x509 -noout -in /etc/opt/microsoft/scx/ssl/scx.pem -subject -issuer -dates
   ```

1. Discover the agent from the console and sign the invalid certificate without SSH.
