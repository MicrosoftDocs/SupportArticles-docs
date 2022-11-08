---
title: Override EDI header for outgoing X12 997
description: When you want to override EDI headers for an outgoing X12 997, an error happens.
ms.date: 03/18/2020
ms.custom: sap:Accelerators
---
# Override EDI header values for outgoing X12 997

This article provides information about resolving issues when you override electronic data interchange (EDI) header values for outgoing X12 997.

_Original product version:_ &nbsp; BizTalk Server 2010  
_Original KB number:_ &nbsp; 2753540

## Symptom

When using `OverrideEDIHeader` as documented at [Overriding EDI Headers](/biztalk/core/overriding-edi-headers) in order to override EDI headers for an outgoing X12 997 document, the following error happens:

> There was a failure executing the send pipeline: "Microsoft.BizTalk.Edi.DefaultPipelines.EdiSend, Microsoft.BizTalk.Edi.EdiPipelines, Version=3.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Source: "EDI Assembler" Send Port: "SENDPORTNAME" URI: "SENDPORTURI" Reason: Agreement Resolution based on the context properties for x12 Protocol has failed.  

## Cause

`EDI receive` creates `997s` with the following four context properties already set:

- DestinationPartyReceiverIdentifier
- DestinationPartyReceiverQualifier
- DestinationPartySenderIdentifier
- DestinationPartySenderQualifier

Due to this situation, the logic at [Agreement Resolution and Schema Determination for Outgoing EDI Messages](/biztalk/core/agreement-resolution-and-schema-determination-for-outgoing-edi-messages) still applies.

## Resolution

In order to use the override EDI headers, the custom pipeline component needs to first remove the above four context properties.

Below is the sample `Execute()` code for a pipeline component that sets `ISA05`,`ISA06`, `ISA07`, and `ISA08` on an outgoing 997 message.

```csharp
public IBaseMessage Execute(IPipelineContext pContext, IBaseMessage pInMsg)
{
    string EdiPropertyNS = "http://schemas.microsoft.com/BizTalk/2006/edi-properties";
    string EdiNS = "http://schemas.microsoft.com/Edi/PropertySchema";
    string EDi997NS = "http://schemas.microsoft.com/Edi/X12#X12_997_Root";
    string systemPropertiesNs = "http://schemas.microsoft.com/BizTalk/2003/system-properties";

    if (pInMsg.Context.Read("MessageType", systemPropertiesNs).ToString() == EDi997NS)
    {
        pInMsg.Context.Write("DestinationPartyReceiverIdentifier", EdiNS, null);
        pInMsg.Context.Write("DestinationPartyReceiverQualifier", EdiNS, null);  
        pInMsg.Context.Write("DestinationPartySenderIdentifier", EdiNS, null);  
        pInMsg.Context.Write("DestinationPartySenderQualifier", EdiNS, null);  
        pInMsg.Context.Promote("OverrideEDIHeader", EdiPropertyNS, (object)"True");
        pInMsg.Context.Promote("ISA05", EdiPropertyNS, (object)"00;
        pInMsg.Context.Promote("ISA06", EdiPropertyNS, (object)"1111111111");
        pInMsg.Context.Promote("ISA07", EdiPropertyNS, (object)"ZZ");
        pInMsg.Context.Promote("ISA08", EdiPropertyNS, (object)"AAAAAAAAAAAAAAA");
    }
    return pInMsg;
}
```
