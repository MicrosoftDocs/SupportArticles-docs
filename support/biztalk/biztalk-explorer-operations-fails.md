---
title: BizTalk Explorer operations fail
description: Describes a workaround for System.Data.SqlClient.SQLException error message while performing BizTalk Explorer operations.  
ms.date: 03/16/2020
ms.prod-support-area-path:
---
# BizTalk Explorer operations fail with a System.Data.SqlClient.SQLException error

This article provides information about resolving the issue that BizTalk Explorer operations fail when using the BizTalk Explorer Object Model to manipulate service instances and messages.

_Original product version:_ &nbsp; BizTalk Server 2013, 2010  
_Original KB number:_ &nbsp; 3054335

## Symptoms

The BizTalk Explorer Object Model allows users to manipulate service instances and messages like shown in the example below:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.BizTalk.Operations;
namespace TestSus
{
    class Program
    {
        static void Main(string[] args)
        {
            var instanceID = new System.Guid("a5cb07b5-65cf-457b-8041-eee7463af564");
            var messageID = new System.Guid("00dca8b0-48af-40b7-a5f9-b91da7d66617");
            var biztalkOperations = new Microsoft.BizTalk.Operations.BizTalkOperations();
            var biztalkMessage = biztalkOperations.GetMessage(messageID, instanceID);
            biztalkOperations.TerminateInstance(instanceID);
        }
    }
}
```

You receive the following exception message:

> Exception:  
> An unhandled exception of type 'System.Data.SqlClient.SqlException' occurred in Microsoft.BizTalk.Operations.dll: Conversion failed when converting from a character string to unique identifier.

## Workaround

To work around this problem, create two separate `BizTalkOperations` objects. Use one `BizTalkOperations` object to call `GetMessage()` and the other to call `TerminateInstance()`. Generally, you should create two `BizTalkOperations` objects: use one for read operations and the other for write operations.
