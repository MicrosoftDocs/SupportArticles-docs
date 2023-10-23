---
author: davepinch
description: Learn how to resolve a problem when the installation of the Dynamics 365 Remote Assist model-driven app fails
ms.author: davepinch
ms.date: 09/26/2023
ms.topic: troubleshooting-general
title: Troubleshoot errors with the installation of the Dynamics 365 Remote Assist model-driven app
ms.reviewer: v-wendysmith
ms.custom: bap-template
---

# Troubleshoot errors with the installation of the Dynamics 365 Remote Assist model-driven app

There are several reasons why the installation of the Dynamics 365 Remote Assist model-driven app might fail.

## Prerequisites

- Admin access to the [Microsoft Power Platform admin center](https://admin.powerplatform.microsoft.com/)
- Admin access to the [Microsoft 365 admin center](https://admin.microsoft.com/AdminPortal)
- Admin access to the environment Dynamics 365 Remote Assist is installed in

## Symptom 1: The Remote Assist model-driven app installation fails because of missing dependencies

### Cause

You try to install the Dynamics 365 Remote Assist model-driven app in an environment that isn't enabled for Dynamics 365 apps.

### Resolution

Install the app in an environment where other Dynamics 365 apps, such as Dynamics 365 Field Service or Dynamics 365 Sales, are installed. Or [create a new environment](/dynamics365/mixed-reality/remote-assist/install-the-dynamics-365-remote-assist-model-driven-app) that's enabled for Dynamics 365 apps.

## Symptom 2: Can't enable Dynamics 365 apps when creating an environment

### Cause

An active Dynamics 365 Remote Assist subscription is missing.

### Resolution

1. View your subscriptions in the [Microsoft 365 admin center](https://admin.microsoft.com/).

1. If you don't see a trial subscription for Dynamics 365 Remote Assist, create a [**subscription-based trial environment**](/power-platform/admin/trial-environments#create-a-trial-subscription-based-environment-in-the-power-platform-admin-center) and enable the Dynamics 365 apps option.

## Symptom 3: Not enough capacity to create environments

### Cause

At least 1 GB of available database capacity isn't available.

### Resolution

Environment creation requires at least 1 GB of available database capacity. Paid subscriptions of Dynamics 365 Remote Assist provide a default tenant entitlement of 10 GB of database capacity (if Dynamics 365 Remote Assist was your first Dynamics 365 subscription). Review [New Dataverse storage capacity](/power-platform/admin/capacity-storage) for possible resolution.

## Symptom 4: The Dynamics 365 Remote Assist app isn't showing up in the Power Platform admin center

### Cause

An active Dynamics 365 Remote Assist subscription or license is missing.

### Resolution

1. Check to ensure that you have an active Dynamics 365 Remote Assist subscription.

2. Try assigning a Dynamics 365 Remote Assist license to your account from the [Microsoft 365 admin center](https://admin.microsoft.com) to force a license sync to occur. Wait five minutes, and then see whether the app appears in the [Power Platform admin center](https://admin.powerplatform.com).

3. If the issue isn't resolved, file a support request by going to the [Power Platform admin center](https://admin.powerplatform.com) > **Help + support** > **New support request**.
