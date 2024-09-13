---
title: Connection Creation failing with "This computer has not-joined Microsoft Entra or the domain." or "MachineNotJoined"
description: Run with connection using sign-in authentication requires to have a machine Microsoft Entra joined
author: QuentinSele
ms.author: QuentinSele
ms.topic: troubleshooting 
ms.date: 09/13/2024
---

<!---For SEO metadata, refer to the SEO cheat sheet provided at https://review.learn.microsoft.com/help/contribute/contribute-how-to-write-seo-basics?branch=main. It has complete information on metadata that impacts SEO, specifically the page title and meta description.--->

<!--- We write general troubleshooting articles when a specific error message isn't known. The customer has come across an issue that they need to resolve, but it's not clear what's causing the issue.--->

<!--- Recommended: Remove all the comments in this template before you sign-off or merge to main branch.--->

# Connection Creation failing with "This computer is not joined Microsoft Entra or the domain." or "MachineNotJoined"

<!---Required: Include the word "troubleshoot" --->

## Symptoms

- Error Message: `Failed to create OAuth connection: ClientError: Test connection failed. Details: Connection failed: [Machine <machineid>] This computer has not joined Microsoft Entra or the domain.`
- Error Code `MachineNotJoined` and error message `The machine is neither Microsoft Entra nor domain joined`.

## Cause

Your machine isn't properly joined to either Microsoft Entra or a Domain which is a prerequisite to be able to use the "Connect with Sign-in" feature.
<!---Optional: An issue might be able to be temporarily resolved with a quick fix. If known, list any workarounds that can be implemented quickly to resolve the issue. Link to information about  longer-term solutions in the Solution section.--->

## Resolution

### Option 1: Join your device to Microsoft Entra ID

Microsoft Entra join can be accomplished using self-service options like the Out of Box Experience (OOBE), bulk enrollment, or Windows Autopilot. You can read more about [Microsoft Entra joined devices](https://learn.microsoft.com/entra/identity/devices/concept-directory-join)

### Option 2: Use another connection option

If you can't join your device to Microsoft Entra ID, you can update your connections and select the option to connect with username and password.
You can read more about [connection with username and password](https://learn.microsoft.com/power-automate/desktop-flows/desktop-flow-connections#connect-with-username-and-password)
