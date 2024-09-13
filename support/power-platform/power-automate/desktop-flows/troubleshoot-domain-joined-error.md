---
title: Connection Creation failing with "MissingOnPremSidForMachineDomainJoined"
description: Thsi article describes how to troubleshoot a failure related to connect with sign option.
author: QuentinSele
ms.author: 
ms.topic: troubleshooting 
ms.date: 09/13/2024
---

<!---For SEO metadata, refer to the SEO cheat sheet provided at https://review.learn.microsoft.com/help/contribute/contribute-how-to-write-seo-basics?branch=main. It has complete information on metadata that impacts SEO, specifically the page title and meta description.--->

<!--- We write general troubleshooting articles when a specific error message isn't known. The customer has come across an issue that they need to resolve, but it's not clear what's causing the issue.--->

<!--- Recommended: Remove all the comments in this template before you sign-off or merge to main branch.--->

# Connection Creation failing with "MissingOnPremSidForMachineDomainJoined"

<!---Required: Include the word "troubleshoot" --->

## Symptoms

When creating a Desktop Flow connection using the "Connect with Sign-In" option, the connection creation fails with 
1. error code `MissingOnPremSidForMachineDomainJoined` 

2. error message : `Could not map connection MSEntraID to AD user on the target machine domain-joined. Please check with your Domain Controller admin that onpremisesSecurityIdentifier is synced with MSEntra.`

## Cause

You are using a Domain Joined machine and the Synchronisation between the Domain Controller and MS Entra is not properly done. When using a Domain Joined machine, this synchronisation is a requirement to be able to use Sign-in Connections for Desktop Flows.
<!---Optional: An issue might be able to be temporarily resolved with a quick fix. If known, list any workarounds that can be implemented quickly to resolve the issue. Link to information about  longer-term solutions in the Solution section.--->

## Resolution

### Option 1: Contat your administrator

Check with your administrator if the Domain Controller properly synchronises the Domain Identities with MS Entra.

### Option 2: Use another connection option

If you cannot join your device to MS Entra ID, you can update your connection(s) and select the option to connect with username and password.
You can read more about [connection with username and password](https://learn.microsoft.com/power-automate/desktop-flows/desktop-flow-connections#connect-with-username-and-password)
