---
title: ExpiredDesktopFlowConnection
description: Resolves errors that occur when you run a desktop flow or test a connection that hasn't been used since the target machine or group rotated its key.
ms.reviewer: padib，aartigoyle, johndund, quseleba
ms.date: 12/10/2024
ms.custom: sap:Desktop flows\Unattended flow runtime errors
---
# "ExpiredDesktopFlowConnection" errors when using or testing a desktop flow connection

This article provides a resolution for `ExpiredDesktopFlowConnection` errors that might occur when you run a desktop flow or test a connection, and your connection has not been used while its target machine or group rotated its certificate.

## Symptoms

- Attempting to use your connection or running a desktop flow that uses it fails with the following error:

```json
  {
      "error":{
          "code": "ExpiredDesktopFlowConnection",
          "message": "Looks up a localized string similar to The connection is no longer valid and needs to be updated. [...]"
      }
  }
```

## Cause

The contents of the connection are encrypted using its target group / machine certificate. During the period when the certificate is rotated, if a connection isn't used, it will expire as the certificate required to decrypt it has been deprecated by the rotation.

A connection in this state is not recoverable and must be manually edited to work again.

## Resolution

- Go to the Power Automate portal.
- Navigate to **Data** > **Connections**.
- Find the expired connection, select it, select **Edit** and reenter the necessary information.