---
title: HCW errors in Organization Configuration transfer
description: Describes HCW8109, HCW8110, and HCW8111 errors and the troubleshooting of these errors.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Cross organization
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: kchandra, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Hybrid Configuration Wizard errors when running the Organization Configuration transfer feature

_Original KB number:_ &nbsp;4337538

## Summary

This article describes Hybrid Configuration Wizard (HCW) error codes HCW8109, HCW8110, and HCW8111 that you may receive when running the Organization Configuration transfer.

## HCW8109

This error is encountered if any unknown error occurs in the Organization Configuration transfer feature. This error occurs if any exception isn't caught by the HCW8110 and HCW8111 errors.

To fix this error, contact Microsoft Custom Support, who will investigate.

## HCW8110

This is an exception that catches errors that are encountered when you run the Organization Configuration transfer feature. This error occurs if objects can't be copied over from on-premises to cloud.

To fix this error, check the logs to view the detailed reason for the error.

## HCW8111

This error occurs when the retention ID of a policy on-premises is the same as the one in cloud. This error will stop the policy being copied from on-premises to cloud.

To fix this error, update the `RetentionId` property for the policy either on-premises or in the cloud, and then rerun the Organization Configuration transfer feature to copy the policy object from on-premises to cloud.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
