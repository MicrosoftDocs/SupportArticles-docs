---
title: Troubleshoot issue with deploying a custom solution containing Agentscript solution in Omnichannel for Customer Service
description: Provides a resolution for issues with deploying a custom solution containing Agentscript solution in Omnichannel for Customer Service.
author: lalexms
ms.author: laalexan
ms.topic: troubleshooting
ms.date: 01/19/2023
---

# Troubleshoot issue with deploying a custom solution containing Agentscript solution in Omnichannel for Customer Service

This article helps you troubleshoot an issue with deploying a custom solution containing Agentscript solution in Omnichannel for Customer Service.

## Symptom

When you try to deploy a custom solution, it fails on account of a dependency on the Agentscript solution, which is part of Omnichannel for Customer Service.

### Cause

The Agentscript solution has been deprecated and was not present in the target environment. It has been replaced by the msdyn_Agentscripts solution.

### Resolution

 Remove all references of the Agentscript solution from the custom solution, and then reimport the solution.
