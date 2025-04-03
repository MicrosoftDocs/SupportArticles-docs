# Infinite loop detected when performing warehouse mobile app operation

## Symptoms

When you perform warehouse mobile app operation, you may encounter the following error message:
"Infinite loop detected during [mobile app operation].".


## Resolution

This error occurs when the call stack depth exceeds a predefined limit to prevent an infinite loop. It typically happens when a large number of work lines are created or processed in a single scan.

To resolve this issue, reduce the number of work lines processed in a single operation, for example split a work into several smaller ones.