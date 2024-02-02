---
title: Resynchronize Audit Trail codes
description: Describes how to resynchronize Audit Trail codes in a Multilingual installation for Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# How to resynchronize Audit Trail codes in a Multilingual installation for Microsoft Dynamics GP

This article describes how to resynchronize Audit Trail codes in a Multilingual installation for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4230461

## Symptom

I upgraded one of my companies with the secondary code folder, so now my Audit Trail codes aren't in sync between the company SY01000 table and the Dynamics..Messages table. How do I resynchronize the Audit trail codes for this company?

Error messages include:

> "The audit trail code cannot be assigned. Information is incomplete or missing"

> A get/change operation on table 'SY_Transaction_Source_MSTR' could not find a record.
Violation of PRIMARY KEY constraint 'PKSY40100', Cannot insert duplicate key in object 'dbo.SY40100'.

## Resolution

***Always make a backup of the company and Dynamics databases before making any changes. All changes should be tested when no users are in the system***  

Use these steps to resynchronize the Audit Trail Codes with the Primary code folder:

1. Clear the MESSAGES table in the DYNAMICS database:

    ```sql
    DELETE  DYNAMICS .. MESSAGES
    ```

1. In the Dex.ini file in the Dynamics GP code folder for the secondary language code folder (that is, for ALL language code folders being used in the Multilingual environment), edit/add this switch:

    `Synchronize=TRUE`

1. Launch into GP Utilities as **sa** first with the **Primary language code folder**. An easy way to ensure you're launching into GP Utilities with a specific code folder is to drag and drop the DYNUTILS.SET file over the DynUtils.exe file within that specific code folder.

1. While in GP Utilities (accessed via the **primary code folder**), select the **Launch Microsoft Dynamics GP** button to launch into the company. Which will synchronize the audit trail codes with the primary code folder?

1. Next, launch into GP Utilities via **secondary language folder**. (Be sure that SYNCHRONIZE = TRUE in the Dex.ini file) Again, a simple way to do it is to drag and drop the DYNUTILS.SET file over the DynUtils.exe file within that specific code folder:

1. While in GP Utilities (accessed via the **secondary code folder**), select the **Launch Microsoft Dynamics GP** button to launch into the company database(s). It will synch the audit trail codes in the MESSAGES table to those created when the company was installed with the primary code folder.

    An effective way to verify the audit trails are synchronized between the primary and secondary code folders is to run the following SQL statement against the DYNAMICS database:

    ```sql
    SELECT * FROM  DYNAMICS .. MESSAGES WHERE  SQL_MSG LIKE '%GLT%'
    ```

    EXAMPLE:

    Dynamics ..Messages table shows:

    |Language ID|MSGNUM|SQL_MSG|DEX_ROW_ID|
    |---|---|---|---|
    |0|183|GLTHS|183|
    |0|184|GLTRX|184|
    |1|183|GLTHS|14905|
    |1|184|GLTRX|14906|

    *For Payables Management, you would get either PMTRN or PMTRX.

    In the example above:

    - Language ID 0 = United States Install
    - Language ID 1 = United Kingdom Install

    Overall, the SQL_MSG's should match across Language ID's when the Multilingual environment has been set up correctly.

1. Repeat steps 5 and 6 for all secondary code folders.

## Resources

- [Multilingual installs in Microsoft Dynamics PG - what you need to know!!](https://community.dynamics.com/blogs/post/?postid=a3fe78ae-d265-4672-8282-a10600329784)

- [KB 887108 - Answers to frequently asked questions about international installations of Microsoft Dynamics GP](https://support.microsoft.com/help/887108) (see Q7 & Q8)
