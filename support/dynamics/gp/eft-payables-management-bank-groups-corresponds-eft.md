---
title: EFT for Payables Management bank groups corresponds to EFT format types
description: This article describes the EFT for Payables Management format types in Microsoft Dynamics GP 10.0 and how they correspond to the bank groups in Microsoft Dynamics GP 9.0.
ms.topic: how-to
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# How EFT for Payables Management bank groups in Microsoft Dynamics GP 9.0 correspond to EFT format types in Microsoft Dynamics GP 10.0

This article describes the EFT for Payables Management format types in Microsoft Dynamics GP 10.0 and how they correspond to the bank groups in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 945789

## Introduction

This article describes how Electronic Funds Transfer (EFT) for Payables Management bank groups in Microsoft Dynamics GP 9.0 correspond to EFT format types in Microsoft Dynamics GP 10.0.

## More information

In Microsoft Dynamics GP 9.0, bank groups are specified in the EFT Checkbook Setup window. To open the EFT Checkbook Setup window, point to **Setup** on the **Tools** menu, point to **Purchasing**, point to **EFT Payables Setup**, and then click **EFT Setup**. The following values are displayed in the **Bank Groups** list:

- Bank of Montreal

- CIBC

- National Bank of Canada

- Non-Standard ACH, space before Co ID

- Non-Standard ACH, Zero Trace

- Royal Bank of Canada

- Standard ACH

- Standard ACH, pad blocks

- Toronto Dominion

In Microsoft Dynamics GP 10.0, format types are specified in the EFT File Format Maintenance window. To open the EFT File Format Maintenance window, follow these steps:

1. Point to **Financial** on the **Cards** menu, and then click **Checkbook**.
2. In the **Checkbook Maintenance** window, click **EFT Bank**, click **Payables Options**, and then click the right arrow next to **Single Format**. The following values are displayed in the **Format Type** list:

    - None

    - CA - Bank of Montreal

    - CA - CIBC

    - CA - National Bank of Canada

    - CA - RBC Royal Bank

    - CA - Toronto Dominion

    - US - NACHA-PPD

    - US - NACHA-PPD+

    - US - NACHA-CCD

    - US - NACHA-CCD+

    - IS0 20022-Domestic, Low-Value

    - User-Defined

The following table matches Microsoft Dynamics GP 9.0 bank groups to the corresponding Microsoft Dynamics GP 10.0 format type:

| Microsoft Dynamics GP 9.0 bank group| Microsoft Dynamics GP 10.0 format type |
|---|---|
|</br>Bank of Montreal|CA - Bank of Montreal|
|CIBC|CA - CIBC|
|National Bank of Canada|CA - National Bank of Canada|
|Toronto Dominion|CA - Toronto Dominion|
|Royal Bank of Canada|CA - RBC Royal Bank|
|Standard ACH</br>|US - NACHA - PPD|
|Not available|US - NACHA-PPD+|
|Not available|US - NACHA-CCD|
|Not available|US - NACHA-CCD+|
|Not available|IS0 20022-Domestic, Low-Value|
|Not available|User-Defined|
