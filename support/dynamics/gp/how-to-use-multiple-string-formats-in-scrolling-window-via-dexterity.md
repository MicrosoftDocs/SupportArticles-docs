---
title: How to use multiple string formats in scrolling window via Dexterity
description: Describes how to use multiple string formats in a scrolling window by using Dexterity in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to use multiple string formats in a scrolling window by using Dexterity in Microsoft Dynamics GP

This article describes how to use multiple string formats in a scrolling window by using Dexterity in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 949623

## Introduction

When you use Dexterity in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains, you can assign more than one FormatString property to a string format. Then, you can use an integer field that is linked to the string field by using the Link Format Selector tool while you work on a window layout. When you change the value of the integer field, you can select the different FormatString properties.

This feature does not work when the string field and the linked integer field are in a scrolling window. This is a known issue.

## More information

As a workaround, you can produce a very similar result so that the string field is formatted correctly in the scrolling window. To do this, follow these steps and use the example code:

1. Create a new local string field of a keyable length that is large enough to fit the longest format.
2. Put this local string field in the scrolling window, and then hide the original string field.
3. Create a series of messages that have an ID that is larger than 22,000 and that contains the formats in the same order as they are listed in the format string list. If you begin at message 22,201, the base number will be 22,200.
4. Create a Format_String function that resembles the following.

    ```console
    function returns string OUT_String;
    in string IN_String;
    in string IN_Format;
    
    local integer i, j;
    local string l_string;
    
    clear l_string, j;
    for i = 1 to length(IN_Format) do
    if substring(IN_Format,i,1) = CH_X then
    increment j;
    l_string = l_string + substring(IN_String,j,1);
    else
    l_string = l_string + substring(IN_Format,i,1);
    end if;
    end for;
    OUT_String = l_string;
    ```

5. In the Scrolling Window Fill script, set the local string field by using the Format_String function.

    ```console
    '(L) Dummy String' of window Scrolling_Window = 
    Format_String('String' from table Table, getmsg(Base + 'Format' from table Table);
    ```

    > [!NOTE]
    > You must use the fields from the table buffer because the window fields are populated after the fill script is completed. This will format the local string field as if the multiple formats were working.

    If the local string field must be editable, you can use the field PRE script and the POST script to strip out the format, and then add it back later. This would make the local string field behave in a similar manner to how date fields work.
