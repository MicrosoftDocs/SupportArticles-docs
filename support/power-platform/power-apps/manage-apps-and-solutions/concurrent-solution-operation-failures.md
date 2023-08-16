---
title: Concurrent solution operation failures 
description: Solution operations like import, delete, publish customization, create solution component and background ribbon calculation, these can result in failure because of Concurrent operations. Only one operation can be done at a time, customer needs retry later if they still see failure.
ms.reviewer: jdaly
ms.date: 08/16/2023
author: swatim
ms.author: swatim
---
# Concurrent solution operation failures

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to do one of these Solution operation (Solution Import, Delete, Publish Customization, Create Solution component, Background ribbon Calculation), it can result in "Please try again later" error.

## Error example
“Microsoft.Crm.ObjectModel.CustomizationLockException: Cannot start the requested operation [PublishAll] because there is another [Import] running at this moment. Use Solution History for more details. -- The solution installation or removal failed due to the installation or removal of another solution at the same time. Please try again later.” 

## Cause

In the platform, we only allow one solution operation at a time. Concurrent request for different solution operations results in this error until the first operation is completed. 

## Workaround

* In an environment, avoid conflicts by avoiding multiple operations at a time. Waiting is the only resolution. 

* Avoid maintenance time and use different service hours. The scenario may include the background updates going on during the maintenance hours and if you are trying to upgrade during the maintenance time and seeing the issue, please try to wait till it completes. 

* You can also watch solution history page to check for completion any other operations on the environment. 
