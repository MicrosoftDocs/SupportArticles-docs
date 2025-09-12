---
title: Manufacturing Data Collection Process and Tables
description: Manufacturing Data Collection Process and Tables in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Manufacturing Series
---
# Manufacturing Data Collection Process and Tables in Microsoft Dynamics GP

This article provides information about the manufacturing data collection process and tables in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4054354

The below information can be viewed in this blog article:

[Manufacturing Data Collection Process and Tables](https://community.dynamics.com/blogs/post/?postid=7085e1b9-81cf-40a1-8115-9298f9b87223)

## More information

We get a few questions around Data collection and what tables it stores the data in, especially if there is a hiccup and something is stuck that needs to be looked at. I put together a quick document that talks about the three options for Data Collection and what main tables the data reside.

There are three locations to manually entering Data Collection. These windows are used when you are NOT back flushing Labor on your Routing. (Path: **Transactions** > **Manufacturing** > **WIP** > see below).

1. Time Card Entry
2. Data Collection
3. Auto Data Collection (ADC)

**Time Card Entry and Time Card Batch** windows are used together. Once you have populated the time card information in the Time Card Entry window, you use the Time Card Batch window to post the data. This window is used to enter Direct Labor.

**Data Collection** window can also be used to enter Direct labor, but you can also enter Indirect labor, as well as Machine Costs too.

**Auto Data Collection** is typically used with integrations that push the labor information into the tables and the system then automatically posts the data when there is a "match". But if there is a hiccup you can also manually enter the data using this window to finish the process. There will be a start time record for a specific Employee, MO number, Sequence etc. When the system recognizes the ending time record or _match record_ for the same, MO number/Sequence, the system will automatically post the document to the main SF010014 and SF010115 tables. The starting record will sit in the SF010501 until that match is found. If there is a hiccup and you need to enter the ending record, you can manually enter the "ending" record and the system will then post the document.  

> [!NOTE]
> If the values don't leave the SF010501 table, check the status column (ADCSTATUS_I). Many times, you will see a 3 status.  Some reasons for Status of 3 and for records sitting in the table and not clearing are:

Here's a list of causes of status 3:

The MO is locked.  
The MO does not have a status of Released (3), Partially Received (7) or Complete (6).  
The MO is marked as Done. (All routing sequences are complete, or manually marked)  
The routing sequence is not part of the MO.  
The data collection type is Direct Labor, but the sequence is marked to backflush labor.  
The data collection type is Machine, but the sequence is marked to backflush machine.  
The MO does not exist. (in the MOP Order MSTR table)  
The employee (for a direct labor data collection) does not exist in the employee master table.  
The machine (for a machine data collection) does not exist in the machine master table.

Below is some information on what tables get updated during our data collection processes. Each column represents the type of document you entered from Start to finish (top to bottom). As you will notice, they ALL end up in the same main tables (SF010014 and SF010115).

### Data collection tables

|Time Card|Data Collection|Auto Data Collection (ADC)|
|---|---|---|
|STARTS: </br></br>SF010600 (Summary)</br></br>SF010601 (Detail)</br></br> Posts to the following tables and clears out of the ones above||STARTS: </br></br>SF010500 (Starts here for a second)</br></br>Moves to:</br></br>SF010501 Immediately after saving.</br></br> On record for Start</br>One record for End</br></br> When Match is found, it removes from the SF010501 and ends up below |
|ENDS: </br></br>SF010014 (Totals- Summary)</br></br>SF010115 (Detail)</br></br>|STARTS/ENDS:</br></br> SF010014 (Totals- Summary)</br></br>SF010115 (Detail)</br></br> SF010200 when DC Transaction Posts|ENDS:</br></br> SF010014 (Totals- Summary)</br>SF010115 (Detail)|
  
> [!NOTE]
> All 3 options have the same resting place when completed. SF010014 and SF010115

All three options once processed will sit in DC Transactions window waiting for you to post to Payroll (**Manufacturing** > **Transactions** > **WIP** > **DC Transactions**)

More information on ADC - SDK information (related to all supported versions:

You can import records directly to the SF010500 table if labor is collected by some other process. Here is a chart showing the fields in this table and related field values:

**Data Entry directly to table through automated device.**

**Table Name**: ADC_Input_Records (SF010500)

**Validations**: The validations that must be performed on each field prior to inserting data into the table are listed along with a description of the fields below.

### Table field descriptions

|Field Name| Physical (SQL) Field Name| Values to Enter| System defaults (if empty)|
|---|---|---|---|
|Data Entry Type ADC|DATAENTRYTYPEADC_I|1 for Direct Labor2 for Machine|1 (Direct Labor) |
|Manufacture Order|MANUFACTUREORDER_I|Manufacturing Order Number|None but required|
|rtseqnum|RTSEQNUM_I|Sequence of the MO routing|None but required|
|done_cb|DONECB_I|0 if sequence is not done1 if this sequence is done.|None for a Finish Transaction; 0 for a Start Transaction|
|Number Scrapped|NUMBERSCRAPPED_I|Number scrapped|None|
|Employee ID|EMPLOYID|Employee ID number|None; required for Direct Labor trans|
|Machine ID IC|MACHINEID_I|Machine ID number|None; required for Machine trans|
|Transaction Type|TRXTYPE|0 for Start transaction1 for Finish transaction|0 (Start)|
|ADCDate|ADCDATE_I|Enter transaction date|System date|
|ADCTime|ADCTIME_I|Enter transaction time|System time|
|Setup CB|SETUPCB_I|0 if transaction not labor setup1 if transaction is labor setup|0 (NOT labor setup)|
|Pieces|PIECES_I|Enter pieces completed|None|
|Rejects|REJECTS_I|Enter pieces rejected|None|
|ADC Device ID|ADCDEVICEID_I|Enter ADC Device ID|None|
|Pay Code Rate 1|PAYCODERATE1_I|Enter Pay Code associated with time being recorded|None|
|Labor Code|LABORCODE_I|Enter payroll Labor Code associated with Pay Code|None|
  
### Validation Details

#### Manufacture Order

Manufacturing Order must exist in the system. Check this from table MOP_Order_MSTR (physical name WO010032) using key 1 (Manufacture Order).

Manufacturing Order must have status of Released or Partially Received. Check this from table MOP_Order_MSTR (physical name WO010032). Check field **Manufacture Order Status** of file MOP_Order_MSTR - if its value is not 3 or 7, the MO is not Released or Partially Received.

Manufacturing Order is not done. Check this from table MOP_Routing_Line (physical name WR010130). For the Manufacture Order, go through all the sequences (field **rtseqnum**) and check the field done_cb. If all the sequences for the MO are done, then the MO is done.

#### rtseqnum

The sequence must be part of the Manufacturing Order. Check this from table MOP_Routing_Line (physical name WR010130). The sequence must exist in this table for the Manufacturing Order. Use fields **Manufacture Order** and **rtseqnum** to check this.

The sequence is not set to be backflushed. Check this from table MOP_Routing_Line (physical name WR010130). If the field **Auto Backflush Labor** or the field **Auto Backflush Machine** is false, then the sequence is not set to be backflushed.

### Employee ID

Employee ID must exist in the system. Check this by using the **Employee ID** field of file UPR_MSTR (physical name UPR00100).

### Machine ID

Machine ID must exist in the system. Check this by using the **Machine ID** field of file Machine_MSTR (physical name MM010032).

The above listed validations are the only ones required to be done on the data entered into the table through an automated device. Other fields will be filled by the system-for example, the labor code, pay code, and job number. Also, if the date and time fields are empty, the system will fill these with system date and time.

## Manual Data Entry into the Automated Data Collection Form

The Automated Data Collection window can be accessed manually and populated. This window provides a user interface and captures the same information as may be pushed into the SF010500 table as listed above.
