---
title: ADT^A03 problem in BizTalk Accelerator for HL7
description: This article describes event ID 4101. This problem happens when you're using sample data to create the ADT^A03.txt file in the BizTalk Server Accelerator for HL7 1.3 tutorial.
ms.date: 03/16/2020
ms.custom: sap:Accelerators
ms.reviewer: mquian
---
# Error message when you use the ADT^A03.txt file in the BizTalk Server Accelerator for HL7 1.3 tutorial

This article helps you resolve the problem where you can't use the ADT^A03.txt file in the Microsoft BizTalk Server Accelerator for HL7 1.3 tutorial.

_Original product version:_ &nbsp; BizTalk Server  
_Original KB number:_ &nbsp; 931817

## Symptoms

Microsoft BizTalk Server Accelerator for HL7 1.3 includes a tutorial that uses an ADT^A03.txt file. The "Preparing to Use the Tutorial" section of the tutorial includes steps to create and use the ADT^A03.txt file. When you follow the steps, you receive this error message:

> Event Type:Error  
> Event Source:BizTalk Accelerator for HL7  
> Event Category:None  
> Event ID:4101  
> Description: Error happened in body during parsing Error # 1 Segment Id: PD1_PatientAdditionalDemographicSegment Sequence Number: 1 Field Number: 4 Error Number: 103 Error Description: Table value not found Encoding System: HL7nnnn

## Cause

This problem happens because the fourth field in the PD1 segment of the sample data that's used to create the ADT^A03.txt file contains spaces. This field doesn't accept values that are formatted incorrectly. So, the message instance is not valid.

## Workaround

To work around this problem, remove the extra spaces. The PD1 segment is the Patient Additional Demographic segment. The fourth field is the `PD1_4 - XCN_9NameTypeCode` field. The `PD1_4 - XCN_9NameTypeCode` field contains the following sample data when you follow the steps to create the ADT^A03.txt file:

> NormalString^Test&Test^Test^Test^Test^Test^AE^simpletext^simpletext&Test&ISO^P   ^NormalString^M10^MC^simpletext&NormalString&HCD^A|

In this sample, there are spaces between `P` and the next caret (^) character. These spaces cause the problem that's described in the [Symptoms](#symptoms) section. After you remove the spaces, the PD1 segment should resemble the following:

> D1|S|F|NormalString^A^+1^-1^ISO^simpletext&Test&HCD^GI^simpletext&NormalString&ISO^I|   NormalString^Test&Test^Test^Test^Test^Test^AE^simpletext^simpletext&Test&ISO^P^NormalString^M10^MC^simpletext&NormalString&HCD^A|N|simpletext|I|I|N|NormalString   ^+1^M11^simpletext&NormalString&L,M,N^RRI^simpletext&NormalString&HCD|NOVALUE^NormalString   ^Test^Test^NormalString^Test|N
