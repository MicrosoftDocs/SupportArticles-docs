---
title: Errors display when you integrate accounts
description: Provides a solution to errors that occur when you run an account integration by using Integration Manager together with Microsoft Dynamics GP.
ms.reviewer: kvogel
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error messages display when you integrate accounts by using Integration Manager and Microsoft Dynamics GP

This article provides a solution to errors that occur when you run an account integration by using Integration Manager together with Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 914168

## Symptoms

When you run an account integration by using Integration Manager together with Microsoft Dynamics GP, you receive one or both of the following error messages:

Error message 1  
> Doc 1 Error: "Account Number **XXXXXX** contains undefined segment information"

Error message 2  
> Error: "This record has been created since you attempted to create it. The Changes won't be saved"

## Cause

This error occurs because of a new feature in Microsoft Dynamics GP that prompts you to enter account segment information when you enter a new segment in the **Account Maintenance** dialog box.

## Resolution

To resolve this problem, follow these steps:

1. On the **Cards** menu, point to **Financial**, and then select **Account**.
2. In the **Account Maintenance** dialog box, enter a new account number in the **Account** field.
3. When you're prompted by a message box to enter account segment information, select the **Do not display this message again** check box so that you aren't prompted again for this message. Then select **No**.
4. Enter the rest of the account number. Then select **Clear**.
5. Run the account integration again.

## More information

To make this message appear again, you must run the following SQL statement in Microsoft SQL Query Analyzer against the company database.

```sql
update SY01401 set USRDFSTR='1' where coDefaultType=13 and USERID='sa'
```

To make sure that this message doesn't appear again, you must run the following SQL statement in Query Analyzer against the company database.

```sql
update SY01401 set USRDFSTR='0' where coDefaultType=13 and USERID='sa'
```
