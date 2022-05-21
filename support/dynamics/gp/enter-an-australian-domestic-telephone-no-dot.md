---
title: Enter an Australian domestic telephone No.
description: Introduces the Australian telephone number format and describes how to enter an Australian domestic telephone number or an international telephone number in Dynamics GP 9.0.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/31/2021
---
# How to enter an Australian domestic telephone number or an international telephone number in Microsoft Dynamics GP 9.0

This article introduces the Australian telephone number format and describes how to enter an Australian domestic telephone number or an international telephone number in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 920834

## Introduction

> [!NOTE]
> Singapore and Australia both use the same domestic telephone number scheme. The method for entering an Australian telephone number also applies to entering a Singapore telephone number.

## More information

In 1995, the Australian Telecommunications Authority (AUSTEL) started phasing in 10-digit telephone numbers. The new format was intended to help cover the shortfall that was caused by an increased demand for other telephone numbers in major cities.

Previously, Australia used a two-digit area code together with a seven-digit telephone number. For example, a typical Australian telephone number was (02) 123-4567. To increase the supply of telephone numbers, a digit was added to the front of the number following the area code. This change created a 10-digit telephone number. For example, a typical Australian telephone number is now (02) 9123-4567.

The telephone number format for a U.S. installation of Microsoft Great Plains is (**XXX**) **XXX** - **XXXX** Ext. **XXXX**. This format has a keyable length of 14 digits.

The telephone number format for an Australian installation of Microsoft Great Plains was changed to (**XXX**) **XXXX** - **XXXX** Ext. **XXX**. This format has a keyable length of 14 digits.
> [!NOTE]
> In these formats, each **X** represents a single digit.

This change eliminates the need for two separate formats. The new scheme can be used to handle both domestic and international telephone numbers by using the following variations of the new 10-digit format:  
Domestic numbers: (**XX**) **XXXX** - **XXXX**  

International numbers: (**XXX**) **XXX** - **XXXX**  

To use the new format, replace a space for the appropriate digit, as indicated in the following examples.

> [!NOTE]
>
> - In the following examples, the underscore (_) represents a space.
> - You type only the digits. The parentheses and the hyphen are included to simulate the display and also to indicate the placement of the space.

To enter an Australian domestic telephone number, type the 2-digit area code, type a space, and then type the eight-digit telephone number. For example, to enter a typical Australian domestic telephone number, type the following number:  
(02_) 9123-4567

To enter an international telephone number, type the three-digit area code, type a space, and then type the seven-digit telephone number. For example, to enter a typical Australian international telephone number, type the following number:  
(123) _456-7890

The telephone numbers may be used in any of the following windows:

- Site Maintenance
- Debtor Maintenance
- Debtor Address Maintenance
- Creditor Maintenance
- Creditor Address Maintenance
- Company Setup
