---
title: The SLA state moves from active to draft state after importing the solution which contains an SLA presents in the org.
description: Provides a resolution for the issue where solution upgrade contains an SLA which present on the org, that SLA will go into draft state after importing the solution.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 07/12/2023
---
# Solution upgrade contains SLA presents in the org moves to draft state 

This article provides a resolution for the issue where a solution upgrade contains an SLA that is present in the org, the SLA will go into draft state after importing the solution.

## Symptoms

SLA state moves from active to draft state after importing the solution which contains SLA presents in the org.

## Cause

The reason for moving the state to draft is for applying any metadata changes from source SLA to target SLA while importing solution.

## Resolution

To solve this issue, take the following step:

This is a by-design behavior, if upgrade solution contains an SLA that is present on the org, that SLA state will move to draft state after importing the solution. So, the user has to activate that SLA again manually after importing the solution.