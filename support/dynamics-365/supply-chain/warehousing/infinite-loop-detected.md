# Infinite loop detected when performing warehouse mobile app operation

## Symptoms

When you perform warehouse mobile app operation, you may encounter error messages such as:
"Infinite loop detected during Movement by template.", "Infinite loop detected during Report as Finished and put away", or similar.

## Cause

This error occurs when the call stack depth exceeds a predefined limit to prevent an infinite loop. It typically happens when a large number of work lines are created or processed in a single scan.

## Resolution

To resolve this issue, reduce the number of work lines processed in a single operation, for example [split a work](https://learn.microsoft.com/en-us/dynamics365/supply-chain/warehousing/work-split) into several smaller ones.