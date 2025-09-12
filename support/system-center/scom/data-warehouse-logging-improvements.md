---
title: Data warehouse logging improvements
description: Introduces data warehouse logging improvements in System Center 2012 R2 Operations Manager Update Rollup 5.
ms.date: 04/15/2024
---
# Data warehouse logging improvements that help troubleshoot SQL Server time-out issues

This article contains information about the logging improvements that have been made in System Center 2012 R2 Operations Manager data warehouse where SQL Server time-out exceptions are concerned. The information can be used to troubleshoot SQL Server time-out scenarios.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 3029227

## Symptoms

The following Health Service Module errors are logged in the Operations Manager log:

> Log Name - Operations Manager  
> Source - Health Service Modules  
> EventID - 31551  
> Level - Error  
> User - N/A  
> Task Category - Data Warehouse  
> Keywords - Classic  
> Details -

|Before Update Rollup 5|After Update Rollup 5|
|---|---|
|Failed to store data in the Data Warehouse. The operation will be retried.<br/><br/>Exception "SqlException": Time-out expired. The time-out period elapsed before completion of the operation, or the server is not responding.<br/><br/>One or more of the following workflows were affected by this:<br/><br/>Workflow name: _Workflow_name_ <br/>Instance name: _Instance_name_ <br/>Instance ID: _Instance_ID_ <br/>Management group: _Management_group_name_ <br/><br/>|Failed to store data in the Data Warehouse. The operation will be retried.<br/><br/>Exception 'SqlTimeoutException': Timeout expired. The timeout period elapsed prior to completion of the operation, or the server is not responding.<br/><br/>Possible error messages:<br/><br/> Message 1 <br/> Timeout occurred while trying to bulk copy data to _Table_name_ table.<br/><br/> Message 2 <br/> Timed-out stored procedure: _Stored_procedure_name_ <br/> <br/>Current time-out value: _Current_time-out_value_in_seconds_ <br/><br/>This time-out can be increased by adding a registry key (type: dword 32 bit, value: revised time-out in seconds) named: <br/><br/>_Registry_name_ at HKLM\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Data Warehouse<br/><br/>One or more of the following workflows were affected by this:<br/><br/>Workflow name: *Workflow_name* <br/>Instance name: *Instance_name* <br/>Instance ID: *Instance_ID* <br/>Management group: *Management_group_name*|
  
> Log Name - Operations Manager  
> Source - Health Service Modules  
> EventID - 31552  
> Level- Error  
> User - N/A  
> Task Category - Data Warehouse  
> Keywords - Classic  
> Details -

|Before Update Rollup 5|After Update Rollup 5|
|---|---|
|Failed to store data in the Data Warehouse.<br/>Exception "SqlException": Time-out expired. The time-out period elapsed before completion of the operation, or the server is not responding.<br/><br/>One or more of the following workflows were affected by this:<br/><br/>Workflow name: _Workflow_name_ <br/>Instance name: _Instance_name_ <br/>Instance ID: _Instance_ID_ <br/>Management group: _Management_group_name_|Failed to store data in the Data Warehouse. Exception 'SqlTimeoutException': Timeout expired. The timeout period elapsed prior to completion of the operation, or the server is not responding.<br/><br/>Possible error messages:<br/><br/> Message 1 <br/> Timeout occurred while trying to bulk copy data to _Table_name_  table.<br/><br/> Message 2 <br/> Timed-out stored procedure: _Stored_procedure_name_ <br/> <br/>Current time-out value: _Current_time-out_value_in_seconds_ <br/><br/>This time-out can be increased by adding a registry key (type: dword 32 bit, value: revised time-out in seconds) named: <br/><br/>_Registry_name_ at HKLM\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Data Warehouse<br/><br/>One or more of the following workflows were affected by this:<br/><br/>Workflow name: *Workflow_name* <br/>Instance name: *Instance_name* <br/>Instance ID: *Instance_ID* <br/>Management group: *Management_group_name*|
  
## Resolution

SQL Server time-outs may occur for various reasons. In some cases, increasing the value of the time-out interval may be helpful in reducing or eliminating time-out events. To increase the value of the time-out interval, follow these steps:

1. Check the Operations Manager log for events 31551 and 31552, as mentioned in the [Symptoms](#symptoms) section.

2. In the description, check for the _registry_name_. This should be one of the following:

   - **Command Timeout Seconds** - Time-out value that's used by the data warehouse maintenance commands.
   - **Bulk Insert Command Timeout Seconds** - Time-out value that's used when copying bulk data to the data warehouse.

3. Click **Start** > **Run**.
4. In the **Open** box, type `regedit`, and then press ENTER.

5. Navigate to the following location in the registry:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0`

   Add the **Data Warehouse** subkey if it doesn't already exist.

6. Add a new **DWORD (32-bit)** value and name it **Command Timeout Seconds** or **Bulk Insert Command Timeout Seconds**, depending on your circumstances.

7. Set this value to the time-out interval that you want, in seconds. For example, the value should be set to 40 for a 40-second time-out interval.

> [!NOTE]
> We recommend that you incrementally increase the value of the time-out, because a very high value could lead to other issues. If setting a substantial value for the time-out interval doesn't resolve the problem, the root cause may differ from the scenarios that are described here.
