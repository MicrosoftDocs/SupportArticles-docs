---
title: Duplicate security roles after importing a solution 
description: Provides a workaround for an issue where duplicate security roles occur after you import a solution.
ms.reviewer: matp
ms.date: 07/26/2023
author: nhelgren
ms.author: risquass
---
# Duplicate security roles occur after you import a solution

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

There's a security role in the Power Platform admin center. When you try to create another security role with the same name in the environment, you receive a message stating that a role with the specified name already exists, and your security role isn't created. However, you can import a security role into the environment that already has a different security role with the same name by importing a solution.

## Cause

This behavior is by design.

## Workaround

To work around this issue, make sure that no security role with the same name exists in the target environment.
