---
title: Credit card number field that was removed from SmartList and from Advanced Lookups
description: This article describes that the credit card number field was removed from SmartList and from Advanced Lookups because of customer requests.
ms.reviewer: 
ms.date: 03/31/2021
---
# Information about the credit card number field that was removed from SmartList and from Advanced Lookups in Microsoft Dynamics GP

This article describes that the credit card number field was removed from SmartList and from Advanced Lookups because of customer requests.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 926647

## Introduction

This article contains information about the credit card number field that was removed from SmartList and from Advanced Lookups starting with Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0 Service Pack 4a.

## More information

The credit card number field was removed from SmartList and from Advanced Lookups because of customer requests.

To display credit card numbers, use one of the following methods:

- Enter the credit card number in an alternative field from the Customer Maintenance window, and then add that field to the SmartList list or to the Advanced Lookups dialog box. For example, if you do not use the **Comment 1** field in the Customer Maintenance window, you can enter the customer's credit card number in this field. You can then add the **Comment 1** column to your SmartList list. However, you cannot rename the field.

- Use Report Writer to modify an existing report or to create a custom report. The table and field information will vary according to the module in which the transaction was entered.

For more information about how to modify or customize a report, contact Microsoft Dynamics GP technical support.

> [!NOTE]
> Microsoft Dynamics GP does not encrypt credit card information. If you have to encrypt the credit card information, you must use a third-party solution.
