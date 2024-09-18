---
title: Connection Creation failing with "This computer has not-joined Microsoft Entra or the domain." or "MachineNotJoined"
description: Run with connection using sign-in authentication requires to have a machine Microsoft Entra joined
author: QuentinSele
ms.author: QuentinSele
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 09/18/2024
---
# Connection Creation failing with "This computer is not joined Microsoft Entra or the domain." or "MachineNotJoined"

## Symptoms

- Error Message: `Failed to create OAuth connection: ClientError: Test connection failed. Details: Connection failed: [Machine <machineid>] This computer has not joined Microsoft Entra or the domain.`
- Error Code `MachineNotJoined` and error message `The machine is neither Microsoft Entra nor domain joined`.

## Cause

Your machine isn't properly joined to either Microsoft Entra or a Domain which is a prerequisite to be able to use the "Connect with Sign-in" feature.

## Resolution

### Option 1: Join your device to Microsoft Entra ID

Microsoft Entra join can be accomplished using self-service options like the Out of Box Experience (OOBE), bulk enrollment, or Windows Autopilot. You can read more about [Microsoft Entra joined devices](https://learn.microsoft.com/entra/identity/devices/concept-directory-join)

### Option 2: Use another connection option

If you can't join your device to Microsoft Entra ID, you can update your connections and select the option to connect with username and password.
You can read more about [connection with username and password](https://learn.microsoft.com/power-automate/desktop-flows/desktop-flow-connections#connect-with-username-and-password)
