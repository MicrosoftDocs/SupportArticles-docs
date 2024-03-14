---
title: Batch status messages in the Batch Recovery window
description: Discusses the different batch status messages in the Batch Recovery window in Microsoft Dynamics GP.
ms.reviewer: theley,  
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# Batch status messages in the Batch Recovery window in Microsoft Dynamics GP

This article discusses the different batch status messages in the Batch Recovery window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866233

The following information describes the different batch status messages.

## Posting Int

The batch was interrupted during the actual posting process. select the batch, and then select **Continue**.

## Printing Int

The batch was interrupted during the printing phase. select the batch, and then select **Continue**.

## Updating Int

The batch was interrupted during the cleanup phase. select the batch, and then select **Continue**.

## Recurring Err

A posting error was found in a recurring batch. Select the batch. The status will change to Edit Required. Note the batch that you have to edit, and then select **Continue**. The batch status will change to **Available**. The batch can be edited and then reposted by using the usual procedure.

## Single-Use Err

A posting error was found in a single-use batch. Select the batch. The status will change to Edit Required. Note the batch that you have to edit, and then select **Continue**. The batch status will change to **Available**. The batch can be edited and then reposted by using the usual procedure.
