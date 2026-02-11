---
# required metadata
title: Unable to remove account structure from ledger
description: Troubleshooting steps for removing account structures that are in use
author: ethanrimes
ms.date: 02/10/2026
---

# Unable to remove account structure from ledger

This article helps troubleshoot problems removing an account structure from your general ledger.

## Symptoms

You are unable to remove an account structure from the ledger.

## Resolution

The account structure is likely used in multiple locations throughout the system. Instead of deleting the account structure, modify it by replacing its content with dummy values, then activate the structure. This approach avoids breaking references across the system.
