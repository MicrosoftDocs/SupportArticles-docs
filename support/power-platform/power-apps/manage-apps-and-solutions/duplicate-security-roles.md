---
title: Duplicate security roles after solution import
description: Describes an issue where duplicate security roles appear after solution import.
ms.reviewer: matp
ms.topic: troubleshooting
ms.date: 06/18/2021
author: nhelgren
ms.author: risquass
---
# Duplicate security roles after solution import

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

Notice that when you try to create a security role in the Power Platform admin center when there’s already a security role with the same name in the environment, you receive a message that a role with the specified name already exists and the role isn’t created. However, it is possible through solution import to import a security role into an environment that already has a different security role with the same name.

## Cause

This behavior is by design.

## Workaround

Make sure a different security role, but with the same name, doesn't already exist in the target environment.