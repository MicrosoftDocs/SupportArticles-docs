---
title: Segment terminator for X12 interchange
description: The properties included in the ISA Segment define how BizTalk Server generates the ISA segment for an X12-encoded interchange. Valid values for Segment terminator are explained.
ms.date: 03/19/2020
ms.prod-support-area-path: Accelerators
---
# BizTalk 2010 configuring segment terminator for an X12-encoded interchange

This article provides valid values for segment terminator and suffix.

_Original product version:_ &nbsp; BizTalk Server 2010  
_Original KB number:_ &nbsp; 2723596

## Summary

The properties included in the ISA Segment define how BizTalk Server generates the ISA segment for an X12-encoded interchange. Segment terminator indicates the end of an EDI segment. In an X12 interchange, the segment terminator is defined as the character in the last character position of the ISA segment.

The help file installed with BizTalk Server 2010 includes incorrect information for segment terminator and suffix.

The default value is **~** if the type is `Char`, and **7e** if the type is `Hex`. This data element cannot be left empty. If you do, you will receive an error **Specify a valid value for the separator**. The segment terminator is set along with a suffix setting.

## Segment terminator

The **Segment terminator** and **Suffix** sections will be updated as follows:

Select the type of the Segment terminator (either `Char` or `Hex`), and then enter a single character for the separator. This character indicates the end of an EDI segment. In an X12 interchange, the segment terminator is defined as the character in the last character position of the ISA segment.

The default value is **~** if the type is `Char`, and **7e** if the type is `Hex`.

You can't leave this data element empty.

This element is limited to the values in the ASCII character set. This property is not validated against the X12 character set defined in the General page.

## Suffix

Select the **Suffix** to be used with the Segment identifier, either **None**, **CR** (carriage return - Hex D), **LF** (line feed - Hex A), or **CR LF** (carriage return/line feed 0D 0A).

If you designate a **Suffix**, the Segment terminator data element can't be empty.

The following are ways to configure all combinations in the user interface:

1. **Segment Terminator** set (for example **~**, **A** or **D**) plus **Suffix** - **None**/**CR**/**LF**/**CRLF**.
2. **Segment Terminator** not set blank, **Suffix** set to **None** - When you apply the setting, the error is **Specify a valid value for the separator**.
3. **Segment Terminator** is blank, **Suffix** set to **CR** - To configure this, set **Segment Terminator** to **D (hex)** and set **Suffix** to **None**.
4. **Segment Terminator** is blank, **Suffix** set to **LF** - To configure this, set **Segment Terminator** to **A (hex)** and set **Suffix** to **None**.
5. **Segment Terminator** is blank, **Suffix** set to **CR LF** - To configure this, set **Segment Terminator** to **D (hex)** and set **Suffix** to **LF** in User Interface. Essentially, **CR** and **LF** are split into **Segment Terminator** and **Suffix**.

The default remains the same for **Segment terminator** = **~** and **Suffix** = **None**.

> [!NOTE]
> **Character set and separator** user interface displays **Char** by default. To see the `Hex` value, select **Hex** from the dropdown and the previously entered `Hex` value will be displayed.
