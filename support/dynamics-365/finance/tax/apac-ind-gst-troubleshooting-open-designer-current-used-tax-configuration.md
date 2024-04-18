---
# required metadata

title: Open the designer for the current tax configuration
description: Introduces how to open the designer for the tax configuration that is currently used.
author: yungu
ms.date: 04/18/2024

# optional metadata

# ms.search.form:
audience: Application user

# ms.devlang

ms.reviewer: kfend, maplnan

# ms.tgt_pltfrm

ms.custom: sap:Tax - India tax\Issues with generic tax engine (GTE)

ms.search.region: India

# ms.search.industry

ms.author: wangchen
ms.search.validFrom: 2021-04-01
ms.dyn365.ops.version: 10.0.1
---

# How to open the designer for the current tax configuration

This article explains how to open the designer for the tax configuration that is currently used. It uses the tax setup in a standard environment as an example.

## Find the version of the currently used tax configuration

1. Go to **Tax** \> **Setup** \> **Tax configuration** \> **Tax setup**.
2. On the **Companies** FastTab, select the related company, and then select **Setup**.
3. Make a note of the configuration version that is shown in the tree. You'll need this information later.

    :::image type="content" source="media/apac-ind-gst-troubleshooting-open-designer-current-used-tax-configuration/open-designer-configuration.png" alt-text="You need to remember the configuration version that is shown in the tree.":::

## Open the designer for the currently used tax configuration

1. Go to **Workspaces** \> **Electronic reporting** \> **Tax configurations**.
2. Expand the **Taxable Document** node, and then expand **Taxable Document (India)** \> **Tax (India GST)**.
3. Select the tax configuration version that you made a note of earlier.
4. Select **Designer**.

## Determine whether customization exists

If you've completed the steps in the previous section but have found no issue, determine whether customization exists. If no customization exists, create a Microsoft service request for further support.
