---
title: Troubleshoot issue with deploying a custom solution containing Agentscript solution in Omnichannel for Customer Service
description: Provides a resolution for a known issue related to deploying an Agentscript custom solution in Omnichannel for Customer Service..
author: lalexms
ms.author: laalexan
ms.date: 01/17/2023
---

# Troubleshoot issue deploying custom Agentscript solution in Omnichannel for Customer Service

This article helps you troubleshoot and resolve an issue with the Agentscript solution when deploying a custom solution in Omnichannel for Customer Service.

## Issue

When you try to deploy a custom solution, it fails on account of a dependency on the Agentscript solution, which is part of Omnichannel for Customer Service.

## Cause

The Agentscript solution has been deprecated and was not present in the target environment. It has been replaced by the msdyn_Agentscripts solution.

## Resolution

We recommend that you remove all references of the Agentscript solution from the custom solution, and then reimport the solution.
