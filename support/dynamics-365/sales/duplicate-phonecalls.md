---
title: Duplicate Phone Calls
description: Troubleshot the problem where duplicate phone calls are being created.
---

# Duplicate Phone Calls

## Symptom
User makes calls from Sales Accelerator and notices there are multiple phonecalls being created for the same call.

## Root cause and resolution
### Issue: Both Sales Accelerator and TeamsDialer create a phonecall.

#### Root cause
The problem arises from both Sales Accelerator and TeamsDialer create a phonecall.

#### Resolution
To resolve this, user will have to turn off the SalesAccelerator creation, by excluding phonecall (checking this box).
![Global settings sales accelerator](media/duplicate-phonecalls/global-settings-sales-accelerator.png)