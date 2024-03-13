---
title: Information about the eConnect Fixed Assets adapter
description: This article describes information about the eConnect Fixed Assets adapter in Integration Manager for Microsoft Dynamics GP.
ms.reviewer: 
ms.date: 03/13/2024
---
# Information about the eConnect Fixed Assets adapter in Integration Manager for Microsoft Dynamics GP

This article describes information about the eConnect Fixed Assets adapter in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950850

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

## Introduction

This article describes the changes to the eConnect Fixed Asset adapter in Integration Manager from Microsoft Dynamics GP 9.0 to Microsoft Dynamics GP 10.0.

## More Information

In Integration Manager for Microsoft Dynamics GP 9.0, the **Account Group ID** field is available to be mapped.

In Integration Manager for Microsoft Dynamics GP 10.0, the **Account Group ID** field is unavailable to be mapped.

The following information describes how the Fixed Asset adapter will function based on the field mappings:

- The FA00400 (Asset Account Master) table will be updated according to the following scenarios:

  - If the **Asset Class ID** is set up to have a default **Account Group ID**, the Asset Group ID will update the FA00400 table.
  - If the **Asset Class ID** is set up **without** a default **Account Group ID,** the FA00400 table will be updated with the company account default settings.

- The eConnect adapter is configured to roll down the class ID information to the asset.

- The adapter does not let you change the **Account Group ID** during the integration.

- The adapter ignores the information in the Book Setup window. The adapter uses the Fixed Assets Company Setup window, and adds all the books to the asset.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
