---
title: Posting message to MSMQ from SQL Server
description: This article describes how to post message to MSMQ from SQL Server.
ms.date: 09/24/2020
ms.prod-support-area-path: 
---
# Posting message to MSMQ from SQL Server

This article shows how to post message to MSMQ from SQL Server.

_Original product version:_ &nbsp; Microsoft Message Queuing  
_Original KB number:_ &nbsp; 555070

## Summary

The ability to interact with Microsoft Message Queuing from within a SQL Server stored procedure can open up a large number of possible solutions for common business problems. This tip describes a technique that can be used to post an arbitrary message to any reachable message queue.

There is a COM interface that can be used by Visual Basic 6 (and other) applications to interact with the message queue. However, the needed method (the Send method of the MSMQMessage class) cannot be used from within SQL Server. The reason for this limitation is that the method used to post a message to a message queue accepts a Variant as a parameter. While SQL Server allows COM objects to be instantiated, it doesn't allow a variant data type to be passed.

The solution is to put a type-specific wrapper around the Send method. In that manner, SQL Server cannot only create the COM object, by also pass a string (or other intrinsic SQL data type) to the object, which in turns posts the message to the message queue. The following steps accomplish this goal.

## Create the type-specific wrapper around the Send method  

1. Run Visual Studio .NET. Create a new Class Library project.
2. Change the name of the class in the `Class1.cs` file to `SqlMsmq`.
3. Add a public method called *SendMessage* to `Class1.cs`.

    ```csharp
    publicvoid SendMessage(string queuePath, string messageLabel, string messageBody)
    {
        if (MessageQueue.Exists(queuePath))
        {
            MessageQueue mq = new MessageQueue(queuePath);
            Message mm = new Message();
            mm.Label = messageLabel;
            mm.Body = messageBody;
            mq.Send(mm);
            mq.Close();
        }
    }
    ```

4. Because the assembly must be placed into the Global Assembly Cache, it must be strongly named.
5. On the **Build** menu, click **Build Solution**.

## Put the compiled assembly into the Global Assembly Cache 

1. Run the Visual Studio .NET Command Prompt
2. Navigate to the directory in which the SqlMsmq assembly was created.
3. Execute the command: `gacutil /i sqlmsmq.dll`

## Register the assembly  

To make the class implemented in the assembly available to through a COM interface, information about the class needs to be placed into the registry. While there are a number of ways to do this, the easiest uses the Assembly Registration Tool (regasm.exe).

Still in the Visual Studio .NET Command Prompt, execute the command: `regasm sqlmsmq.dll`.

## Create the Stored Procedure  

The stored procedure that uses the `SqlMsmq` class utilizes the sp_OACreate and `sp_OAMethod` stored procedures to instantiate the object and invoke the `SendMessage` method respectively. The T-SQL code below creates such a stored procedure.

```sql
CREATE PROCEDURE prcSendMSMQMessage
 @msmqPath varchar(255),
 @messageLabel varchar(255),
 @messageBody varchar(1000)

AS

DECLARE @msmqQueue INT
DECLARE @result INT

-- Create the SQLMSMQ Object.
EXECUTE @result = sp_OACreate 'SqlMsmq', @msmqQueue OUT, 1
IF @result <> 0 GOTO ErrorHandler

-- Send the message using the Send method
EXECUTE @result = sp_OAMethod @msmqQueue, 'SendMessage', NULL, @msmqPath, @messageLabel, @messageBody
IF @result <> 0 GOTO ErrorHandler

GOTO DestroyObjects

ErrorHandler:

DECLARE @source varchar(53)
DECLARE @description VARCHAR(200)
EXECUTE sp_OAGetErrorInfo @msmqQueue, @source OUT, @description OUT, NULL, NULL
RAISERROR(@description, 16, 1)

GOTO DestroyObjects

DestroyObjects:
-- Destroy the SQLMSMQ object.
EXECUTE @result = sp_OADestroy @msmqQueue

RETURN

The following T-SQL code provides an example of how to invoke this stored procedure:

EXEC prcSendMSMQMessage 'queue_path', 'message_label', 'message_body'
```

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]