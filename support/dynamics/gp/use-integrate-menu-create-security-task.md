---
title: How to create a Security Task for Integration Manager for Microsoft Dynamics GP 10.0
description: Describes how to create a Security Task for Integration Manager for Microsoft Dynamics GP 10.0 by using the Integrate menu.
ms.reviewer: theley, kvogel
ms.topic: how-to
ms.date: 03/13/2024
---
# How to create a Security Task for Integration Manager for Microsoft Dynamics GP 10.0

This article describes how to create a Security Task for Integration Manager for Microsoft Dynamics GP 10.0 by using the Integrate menu.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939542

## Introduction

You must create a **Security Task** to grant security to Integration Manager for Microsoft Dynamics GP 10.0 by using the **Integrate** menu.

## Steps to create a Security Task

To create a Security Task within Microsoft Dynamics GP 10.0, follow these steps:

1. On the **Microsoft Dynamics GP** menu, click **Tools** > **Setup** > **System** > **Security Tasks**.
2. In the Security Task Setup window, specify the following settings:
   - **Product**: **Microsoft Dynamics GP**  
   - **Type**: **Microsoft Dynamics GP Import**  
   - **Series**: **Integration Site Enabler**  
   - **Product**: **Microsoft Dynamics GP**  
   - **Type**: **Microsoft Dynamics GP Import**  
   - **Series**: **Integration Site Enabler**  
   - **Category**: Select the appropriate category (for example, select **Other** or **System**)
3. Click to select the **Integration Site Enabler** check box in the **Access List** area.

## References

For more information about how to set up Security in Microsoft Dynamics GP 10.0, see Chapter 6 in the *Microsoft Dynamics GP System Setup Guide*. By default, the SystemSetup.pdf file is located in the following folder:  
*C:\Program Files\Microsoft Dynamics\GP\Documentation*
