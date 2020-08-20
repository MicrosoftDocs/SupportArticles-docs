---
title: Error when RAM exceeds allocated memory
description: This article provides help to resolve a problem that occurs when the amount of RAM that is being used to store messages in Message Queuing 2.0 exceeds the allocated memory.
ms.date: 07/24/2020
ms.prod-support-area-path: 
ms.reviewer: nicoleh
---
# Error when RAM that is used to store messages in Message Queuing 2.0 exceeds the allocated memory

This article provides help to resolve a problem that occurs when the amount of RAM that is being used to store messages in Microsoft Message Queuing 2.0 (MSMQ 2.0) exceeds the allocated memory.

_Original product version:_ &nbsp; Microsoft Message Queuing  
_Original KB number:_ &nbsp; 899613

## Symptoms

When you send a message to a queue, MSMQ does not accept the message that you are sending. Instead, MSMQ generates an **insufficient resources** error message. You receive this error message in the application that is using MSMQ 2.0 to send messages.

When this problem occurs, the following information may appear in the stack trace of a .NET Framework service or application:

> Exception Type: System.Messaging.MessageQueueException  
> MessageQueueErrorCode: InsufficientResources  
> Message: Insufficient resources to perform operation.  
> ErrorCode: -2147467259  
> TargetSite: Void SendInternal(System.Object, System.Messaging.MessageQueueTransaction, System.Messaging.MessageQueueTransactionType)  
> HelpLink: NULL  
> Source: System.Messaging

Additionally, the above message is logged in the Application log. In a COM+ Queued Component (QC) application, the above message may be logged in the Application log. This issue occurs when the following conditions are true:

- You try to send a message in MSMQ.
- The allocated memory that is currently being used to run the service and to store messages has reached 2 gigabytes (GB). By default, Windows 2000 allocates 2 GB of addressable memory to a process.

  After the MSMQ service loads, the default amount of allocated memory that is available to MSMQ 2.0 to store messages is between 1.6 GB and 1.8 GB.

  > [!NOTE]
  > If you use the 3GB switch, the allocated memory will be between 2 GB and 2.5 GB.

  Message storage files are memory-mapped files. Therefore, you can see whether the limit has been exceeded by checking the size of the MSMQ Storage folder. This folder is typically located in the `%WinDir%\System32\MSMQ` Storage folder. However, the storage folder can be configured for another location. To see whether the storage folder has been configured for another location, look in the **Message Files Folder** field on **Storage** tab in the MSMQ tool in Control Panel.

## Cause

This problem occurs for one or more of the following reasons:

- The application that reads and processes the messages that arrive in the queues is experiencing difficulties. However, messages continue to arrive in the queues at a faster rate than the rate at which the application can read and process the messages.

- Journaling is enabled in the queues. However, the data that causes messages to accumulate has not been deleted.

- Deadlettering is enabled in the queues. Additionally, the amount of allocated memory that is available to store deadlettered messages has been reached or exceeded.

- Messages have accumulated in the outgoing queue because the destination queue is unavailable.

## Resolution

The method that you use to resolve this problem depends on the current status of the MSMQ service. Before you can resolve this problem, you must stop the services or applications that are writing to the queues.

### If MSMQ is running

Determine which queues have accumulated messages. To do this, use one of the following methods:

- Manually examine the queues by using the MSMQ interface. The MSMQ interface is located in the Computer Management console.

- In Performance Monitor, set all the counters on the MSMQ QUEUE performance object. Then, select **Report** view. In **Report** view, you can see the number of messages in each queue.

After you have determined which queues have accumulated messages, you must determine why the messages have accumulated. There are several possible reasons why messages might accumulate in the queues. These reasons include the following:

- The messages that are in the outgoing message queue cannot reach their destinations. If the messages cannot reach their destinations, make sure that the destination computer is available to receive messages. If these messages are outdated or have no value, clear the queue.

- The application that should be receiving messages has stopped or has entered an error condition. If one of these conditions is true, resolve the problem in that application.

- The messages in the dead letter queues or in the journal queues have been retained. These messages have not been removed or processed. If these messages have been retained, determine the purpose for retaining these messages. The option to journal messages is frequently used for testing.

When testing is completed, this option may be unintentionally left enabled. If the messages are deadlettered, the messages have not been processed or delivered within a specified time. If deadlettering or journaling is turned on, a process should be reading these messages out of the queue. When you have identified the queues where messages have accumulated, you can delete the accumulated messages.

### If MSMQ is not running and you cannot manually start it

> [!NOTE]
>
> - Before you make any changes to the files in the MSMQ Storage folder, we recommend that you back up the current MSMQ environment by using MQbkup.exe. This step is very important if you need help from Product Support Services.
>
> - Because MSMQ has entered an unstable state, you may not be able to recover all the messages. If you experience difficulties restoring messages by using the following steps, and the data is very important, contact Product Support Services for help.

To back up the MSMQ configuration by using MQbkup.exe, follow these steps.

> [!NOTE]
> Before you run MQbkup.exe, select a folder to which you will back up the MSMQ files. This folder must be located on a disk that has at least 2.5 GB of available space.

1. Open a Command Prompt window.
2. Change the directory to `%WinDir%\System32`.
3. Run the command:

    ```console
    MQbkup.exe -b Drive :\ Folder to Put Backup Files
    ```

4. Note the location of the folder to which you backed up the MSMQ files.

#### Start the server by using the 3-GB switch

> [!NOTE]
> The 3GB switch is only an option for Windows 2000 Advanced Server. For Windows 2000 Server and for Windows 2000 Professional, go to the [To manually recover your messages](#to-manually-recover-your-messages) section.

By default, Windows 2000 allocates 2 GB of addressable memory to each process. This problem occurs because MSMQ uses the whole allocation. This behavior prevents the service from correctly restarting. If you use the 3-GB switch, Windows 2000 Advanced Server allocates 3 GB of addressable memory to each process. This configuration gives MSMQ sufficient addressable memory to load the service and the message storage files after you restart the server. This switch increases MSMQ storage to between 2 GB and 2.5 GB.

> [!WARNING]
> This configuration may affect other resources on the server. We recommend that you remove the 3GB switch after you have completed troubleshooting. This configuration is not intended to permanently resolve the problem. However, you can use this configuration to access MSMQ so that you can perform the steps in the [If MSMQ is running](#if-msmq-is-running) section.

For more information about how to configure Windows to run by using the 3-GB switch, see the *Enabling application memory tuning support in your applications* topic in the Windows 2000 Help file.

#### To manually recover your messages

> [!NOTE]
>
> - Follow these steps only if MSMQ is in a non-running state.
> - Because MSMQ is in an unstable state and will not start, you may not be able to recover all the messages.

> [!WARNING]
> This process may cause an application to receive transactional messages in a different order from the order in which the messages originally arrived.

1. Create a temporary folder to hold your message storage files. Do not put this folder in the MSMQ folder.
1. Select only the files that have the *.mq* file name extension.

    > [!WARNING]
    > Some files that are located in the MSMQ Storage folder are critical for MSMQ to correctly run. Make sure that you select only the files that have the *.mq* file name extension.

1. Move the selected files to the folder that you created in step 1.  
1. Make sure that the MSMQ Data Access Driver is not started. To do this, run the following command at a command prompt:

    ```console
    Net Stop MQAC /y
    ```

1. Start the MSMQ service. To do this, run the following command at the command prompt:

    ```console
    Net Start MSMQ
    ```

   > [!NOTE]
   > If the data in the messages is not important, and you only want to bring MSMQ back online, you can stop here.

1. After you have verified that the service will now start, stop the service. To do this, run the following command at the command prompt:

    ```console
    Net Stop MQAC /y
    ```

   This command stops both the MSMQ service and the Data Access driver.

1. In the folder to which you moved the message storage files in step 5, notice that some file names have a p**Number**.mq format and some file names have an l**Number**.mq format. These files are stored as pairs. Each *p* file has a corresponding *l* file.

    Notice the dates that the files were modified. Select the oldest *p* file and the corresponding *l* file. Move these files to the original MSMQ Storage folder.

1. Run the command in step 5 to start the MSMQ service. If the service starts, follow the steps in the [If MSMQ is running](#if-msmq-is-running) section to determine in which queues the messages are accumulating and how to handle the messages.

1. After you have removed the accumulating messages from the queues, repeat steps 6 through 8 until you have returned all message files to the MSMQ Storage folder and you have removed all accumulating messages from the queues.

   > [!NOTE]
   > Do not move more than 1.6 GB of data back into the MSMQ Storage folder at the same time. If you do this, the service may not start.

### Steps to reproduce the problem

On a computer that is running Windows 2000 Server, send messages to a local queue until the application that you are using to send the messages receives a **0x00e0027** exception error.

MSMQ 2.0 stores messages in memory-mapped files. On a computer that is running Windows 2000 Server, the default amount of allocated memory that is available to MSMQ 2.0 is 2 GB. After the components of MSMQ 2.0 are loaded onto the computer, the amount of allocated memory that is available to MSMQ 2.0 is reduced to between approximately 1.6 GB and 1.8 GB.

If you enable the 3-GB switch in the *Boot.ini* file, the amount of allocated memory that is available to MSMQ 2.0 increases to 3 GB. After the components of MSMQ 2.0 are loaded onto the computer, the amount of allocated memory that is available to MSMQ 2.0 is reduced to 2.7 GB.

However, the additional allocated memory also takes approximately 1 GB of allocated memory from the kernel. This behavior may affect system performance and may affect applications that perform file I/O.

We do not recommend that you use the 3-GB switch only to increase the amount of allocated memory that is available to MSMQ 2.0. Instead, we recommend that you set up a computer quota to prevent the problem that is mentioned in the [Symptoms](#symptoms) section.

For more information, see [How to set up computer quotas and queue quotas in Microsoft Message Queuing](https://support.microsoft.com/help/899612).
