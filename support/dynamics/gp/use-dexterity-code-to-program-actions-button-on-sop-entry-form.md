---
title: Use Dexterity code to program the new Actions button on the SOP_Entry form in Dexterity in Microsoft Dynamics GP
description: This article provides Microsoft Dynamics GP 10.0 Dexterity code examples that you can use to  manage the new Actions button.
ms.topic: how-to
ms.date: 03/20/2024
ms.reviewer: theley
ms.custom: sap:Distribution - Sales Order Processing
---
# How to use Dexterity code to program the new Actions button on the SOP_Entry form in Dexterity in Microsoft Dynamics GP

This article describes how to use Dexterity code to program the **Actions** button on the SOP_Entry form in Dexterity in Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 970111

## Summary

In version Microsoft Dynamics GP 9.0 and in earlier versions of Microsoft Dynamics GP, each action has its own button. In addition to **Save**, the following buttons exist:

- **Delete**  
- **Void**  
- **Post**  
- **Transfer**  
- **Purchase**  
- **Confirm**  
- **Copy**

These buttons are enabled and disabled as appropriate depending on the document type and the various business rules. In Microsoft Dynamics GP 10.0, all actions for buttons other than the **Save** button and the new **Submit for Approval** workflow button are added to the **Actions** button. This **Actions** button can be populated with the valid actions for the current document.

## Use Dexterity code to program the Actions button

To program the **Actions** button, you can use Dexterity code. For example, the Dexterity 10.0 code for the **Startup** procedure and the **Actions** button trigger handling script is as follows:

```vb
{ Startup procedure }
local integer l_result;

l_result = Trigger_RegisterFocus(anonymous('Action Button' of window SOP_Entry of form SOP_Entry),
 TRIGGER_FOCUS_CHANGE, TRIGGER_BEFORE_ORIGINAL, script MBS_SOP_Entry_Action_PRE);
if l_result <> SY_NOERR then
 warning "SOP Entry Action PRE Trigger registration failed.";
end if;

{ MBS_SOP_Entry_Action_PRE Procedure }
case itemdata('Action Button' of window SOP_Entry of form SOP_Entry, 'Action Button' of window SOP_Entry of form SOP_Entry)
 in [ACTION_POST of form SOP_Entry]
 in [ACTION_TRANSFER of form SOP_Entry]
 in [ACTION_PURCHASE of form SOP_Entry]
 in [ACTION_CONFIRMPICK of form SOP_Entry]
 in [ACTION_CONFIRMPACK of form SOP_Entry]
 in [ACTION_CONFIRMSHIP of form SOP_Entry]
 in [ACTION_COPY of form SOP_Entry]
 in [ACTION_DELETE of form SOP_Entry]
 in [ACTION_VOID of form SOP_Entry]
 warning "Void is disabled";
 reject script;
 abort script;
 else
end case;
```

In Dexterity 9.0, the code for the **Startup** procedure and the **Void** button trigger handling script is as follows:

```vb
{ Startup Procedure }
local integer l_result;

l_result = Trigger_RegisterFocus(anonymous('Void Button NONE' of window SOP_Entry of form SOP_Entry),
 TRIGGER_FOCUS_CHANGE, TRIGGER_BEFORE_ORIGINAL, script MBS_SOP_Entry_Void_PRE);
if l_result <> SY_NOERR then
 warning "SOP Entry Void PRE Trigger registration failed.";
end if;

{ MBS_SOP_Entry_Void_PRE procedure }
warning "Void is disabled";
reject script;
abort script;
```
