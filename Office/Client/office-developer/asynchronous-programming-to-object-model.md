---
title: Limitation of Asynchronous Programming to Object Model
description: Excel Automation calls may encouter errors or corrupt state if made from in-process asynchronous callbacks. Direct asynchronous programming of the Object Model is unsupported.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel 2013
- Excel 2010
---

# Limitation of Asynchronous Programming to the Excel Object Model

## Summary

In-process asynchronous programming to the Excel Object Model (OM) can lead to errors and incorrect application state.  Direct asynchronous programming of the OM is unsupported.

The Excel Object Model does not automatically protect against concurrency or reentrancy issue when called from asynchronous events in a macro or add-in solution, so the caller must serialize and handle such conditions before calling the OM from asynchronous callbacks (such as a timer events) or a background thread. For optimal safety, it is recommended that such tasks wait for the main thread to be idle before attempting to interrupt the user activity with a new automation task. There are various ways to do this depending on the macro/add-in type, and programming language employed in the solution.

## More Information

Microsoft Excel supports a Programming Object Model (OM) for developers to use to automate and control Excel behavior. The OM was originally designed for Visual Basic for Applications (VBA) macros, but is also used by most add-in types, such as Component Object Model (COM) Add-Ins, managed (.NET) Add-Ins, Visual Studio Tools for Office (VSTO) document and application level customizations, and other in-process extensions and controls. 

In the original design, the OM is built on the assumption that the OM will be invoked based on user action, such as when a user runs a macro, clicks a UI element associated with a macro/add-in, or is invoked by Excel directly for a user-defined worksheet function, etc., or used during whole application automation from an external controller.  Attempts to automate Excel while a user is interacting with it can cause complications, and result in errors or state problems that can undermine the program. Because of the variety of actions and functions that Excel may process when a user is interacting with it, many of which may lead to a call to a macro/add-in, or a calculation event that can call such add-ins, Excel does not prevent OM calls while user actions (or calculations) are being performed.  Doing so would negatively impact the ability of the product to use macros/add-ins in the most flexible way.  While Excel will do its best to protect against concurrent activity between a user and an OM caller, it cannot guard against such instances that a macro/add-in itself introduces.

There are times when a program wants to obtain information from outside sources that runs asynchronous to Excel, and will attempt to use the OM to update something in Excel or obtain data from Excel to decide what to do with the asynchronous event.   If a program attempts to use the OM from a non-user interface invoked action that Excel does not process -- such a timer callback, or a direct event on a background thread, or in response to a sent or posted message from an external source unknown to Excel -- the OM may not be in a proper state to handle calls at that time. The OM will not prevent the call, and some calls may appear to work, but this action is risky.  It can cause concurrency errors or introduce reentrancy on the main thread, which may lead to errors, state problems, book corruption, and/or application exceptions (crashes) to the program. 

The macro/add-in designer should take care to either avoid using such programming techniques (timers, et.al.), or they need to take care to properly handle such code to ensure they themselves prevent concurrency and reentrancy problems prior to their use of the Excel OM. Using asynchronous programming to the OM without protecting against these issue is unsupported, and any corruption or crash caused by such actions are not considered "bugs" in Excel. Rather they are considered design flaws in the macro/add-in itself, since it introduces the concurrency and reentrancy under the situation, and as such is responsible for guarding against it in their code.

A warning about this situation was originally documented in the Excel 97 Software Development Kit (SDK) for both VBA OM and the XLL C-API.  The limitation has applied to every version of Excel since the introduction of the programming interface.  As the product has grown and added more features and capabilities over time, the likelihood of for concurrent or reentrant actions has grown under the same relative workload for a given timeslice.  This may make it appear to be a new issue, when in fact it is not. Code that "used to work" was never valid if it encounters this situation; rather it just failed "less" in the past, so it did not gain much attention before. Nonetheless, we are issuing this warning again to remind developers of their responsibility to handle asynchronous programming carefully on their side.  Do not assume the Excel OM will handle it for you.

Developers that have a need to collect and use asynchronous information, and cannot afford to use other means, may be able to still use them provided they safeguard their code to handle the concurrency and reentrancy issues prior to using the OM.  There are several approaches to do this, and which approach you take will depend on your macro/add-in design, programming language used, and general architecture. For the more common tasks, such as timer callbacks, we recommend using the Application.OnTime function rather than a UserForm/WinForm/API timer. OnTime is guaranteed to be called from main thread idle when the OM is ready to accept new commands which will not conflict with tasks being run by a user. For populating data into cells based on external asynchronous events, consider using the Real-Time Data (RTD) API instead of using the OM.  RTD is likewise guaranteed to update correctly without these issues interfering with user interactivity.   Managed code using background threads should delegate back to the main thread before engaging in the OM.  Consider using the WinForms MethodInvoker object to run a delegate function on the UI thread before using the OM. While this will not prevent all conditions that can lead to errors, it will cover the worst cases. To get full protection, we would suggest a native code component to queued event callbacks and then raise your delegate callback function during idle times.  C/C++ programs can register for idle task processing to handle a private queue for task actions they want to perform when no user activity is present.

Keep in mind this warning applies to situations where a macro/add-in code is responding to asynchronous events that it introduces when it is not in a modal state (like with its own dialog up). So timers or other events that occur while the macro/add-in code has control over the main thread are not at issue here.  Only those cases where they attempt to get such callbacks after control has returned to Excel.  It also does not apply to asynchronous events that Excel itself will handle, such as Windows system events, OLE Link updates, DDE link updates, or RTD.
