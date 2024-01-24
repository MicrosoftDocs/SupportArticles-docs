---
title: Create GUIDs by using Active Server Pages
description: This article provides introduction about how to create GUIDs in IIS by using Active Server Pages (ASP) pages.
ms.date: 04/15/2020
ms.custom: sap:Active Server Pages
ms.technology: active-server-pages
ms.reviewer: robmcm, jameshow
---
# Create GUIDs by using Active Server Pages in IIS

This article provides information about how to create several example pages by using various forms of GUIDs for Active Server Pages (ASP) pages to use. These values can be used to create unique data entries in a database, or anywhere else where a unique data field is required.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 320375

> [!NOTE]
> Because these examples don't use session variables, these examples also work on Web servers that have session state disabled.

## Create a simple time-based GUID

This example creates a simple 14-character time-based GUID by using the current year, month, day, hour, minute, and seconds. This permits you to sort data based on the GUID.

1. Select **Start**, point to **Programs**, select **Accessories**, and then select **Notepad** to open Notepad.
2. Type or paste the following ASP code in Notepad:

    ```vbs
    <%@LANGUAGE="VBSCRIPT"%>
    <HTML>
        <BODY>
            <%
                Response.Write "GUID = " & CreateGUID()

                Function CreateGUID()
                    Dim tmpTemp
                    tmpTemp = Right(String(4,48) & Year(Now()),4)
                    tmpTemp = tmpTemp & Right(String(4,48) & Month(Now()),2)
                    tmpTemp = tmpTemp & Right(String(4,48) & Day(Now()),2)
                    tmpTemp = tmpTemp & Right(String(4,48) & Hour(Now()),2)
                    tmpTemp = tmpTemp & Right(String(4,48) & Minute(Now()),2)
                    tmpTemp = tmpTemp & Right(String(4,48) & Second(Now()),2)
                    CreateGUID = tmpTemp
                End Function
            %>
        </BODY>
    </HTML>
    ```

3. Save the page:

    1. On the **File** menu, select **Save**.
    2. Locate the root folder for your Web site, which is typically the `C:\InetPub\Wwwroot` folder for the default Web site.
    3. Name the file *GuidTest0.asp*.
    4. Select **Save**.
    5. On the **File** menu, select **Exit**.

4. Locate the page with Internet Explorer. You see a GUID. As you refresh the page, you see the GUID increment.

## Create a simple time-offset GUID

This example creates a 20-character time-based GUID by using the offset in seconds from 12:00 midnight on January 1, 2000. This permits you to sort data based on the GUID, and can be updated to use any other date as the base.

1. Select **Start**, point to **Programs**, select **Accessories**, and then select **Notepad** to open Notepad.
2. Type or paste the following ASP code in Notepad:

    ```vbs
    <%@LANGUAGE="VBSCRIPT"%>
    <HTML>
        <BODY>
            <%
                Response.Write "GUID = " & CreateGUID()

                Function CreateGUID()
                    Dim tmpTemp1,tmpTemp2
                    tmpTemp1 = Right(String(15,48) & CStr(CLng(DateDiff("s","1/1/2000",Date()))), 15)
                    tmpTemp2 = Right(String(5,48) & CStr(CLng(DateDiff("s","12:00:00 AM",Time()))), 5)
                    CreateGUID = tmpTemp1 & tmpTemp2
                End Function
            %>
        </BODY>
    </HTML>
    ```

3. Save the page:

    1. On the **File** menu, select **Save**.
    2. Locate the root folder for your Web site, which is typically the `C:\InetPub\Wwwroot` folder for the default Web site.
    3. Name the file *GuidTest1.asp*.
    4. Select **Save**.
    5. On the **File** menu, select **Exit**.

4. Locate the page with Internet Explorer. You see a GUID. As you refresh the page, you see the GUID increment.

> [!NOTE]
> This example permits uniqueness only when the function is not called two times in the same second. Any two calls to the function at the same second cause a collision. This may not cause a problem depending on how your code is using the function, but you can use the [Create a more unique time-offset GUID](#create-a-more-unique-time-offset-guid) example to allow unique values that occur in the same second.

## Create a more unique time-offset GUID

This example, like the [Create a simple time-offset GUID](#create-a-simple-time-offset-guid) example, creates a time-based GUID, but it is 25 characters long. This example creates a 20-character value from the offset in seconds from 12:00 midnight on January 1, 2000, and appends an additional five random numbers to the end of that. This permits you to sort data based on the GUID, but permits much greater uniqueness. This can be updated to use any other date as the base.

1. Select **Start**, point to **Programs**, select **Accessories**, and then select **Notepad** to open Notepad.
2. Type or paste the following ASP code in Notepad:

    ```vbs
    <%@LANGUAGE="VBSCRIPT"%>
    <HTML>
        <BODY>
            <%
                Response.Write "GUID = " & CreateGUID()

                Function CreateGUID()
                    Randomize Timer
                    Dim tmpTemp1,tmpTemp2,tmpTemp3
                    tmpTemp1 = Right(String(15,48) & CStr(CLng(DateDiff("s","1/1/2000",Date()))), 15)
                    tmpTemp2 = Right(String(5,48) & CStr(CLng(DateDiff("s","12:00:00 AM",Time()))), 5)
                    tmpTemp3 = Right(String(5,48) & CStr(Int(Rnd(1) * 100000)),5)
                    CreateGUID = tmpTemp1 & tmpTemp2 & tmpTemp3
                End Function
            %>
        </BODY>
    </HTML>
    ```

3. Save the page:

    1. On the **File** menu, select **Save**.
    2. Locate the root folder for your Web site, which is typically the `C:\InetPub\Wwwroot` folder for the default Web site.
    3. Name the file *GuidTest2.asp*.
    4. Select **Save**.
    5. On the **File** menu, select **Exit**.

4. Locate the page with Internet Explorer. You see a GUID. As you refresh the page, you see the first 20 characters of the GUID increment, and the last five characters are random.

> [!NOTE]
> This example and the [Create a simple time-offset GUID](#create-a-simple-time-offset-guid) example are created for time-based serialization of calls to the `CreateGUID` function. If sorting data based on time is not a requirement, you can use the [Create a simple random GUID](#create-a-simple-random-guid) example to create a random GUID.

## Create a simple random GUID

1. Select **Start**, point to **Programs**, select **Accessories**, and then select **Notepad** to open Notepad.
2. Type or paste the following ASP code in Notepad:

    ```vbs
    <%@LANGUAGE="VBSCRIPT"%>
    <HTML>
        <BODY>
            <%
                Response.Write "GUID = " & CreateGUID()

                Function CreateGUID()
                    Randomize Timer
                    Dim tmpCounter,tmpGUID
                    Const strValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                    For tmpCounter = 1 To 20
                    tmpGUID = tmpGUID & Mid(strValid, Int(Rnd(1) * Len(strValid)) + 1, 1)
                    Next
                    CreateGUID = tmpGUID
                End Function
            %>
        </BODY>
    </HTML>
    ```

3. Save the page:

    1. On the **File** menu, select **Save**.
    2. Locate the root folder for your Web site, which is typically the *C:\InetPub\Wwwroot* folder for the default Web site.
    3. Name the file *GuidTest3.asp*.
    4. Select **Save**.
    5. On the **File** menu, select **Exit**.
  
4. Locate the page with Internet Explorer. You see a 20-character random GUID. As you refresh the page, you see the value change randomly.

> [!NOTE]
> This example creates a fixed-length random GUID. To create a variable-length GUID, use the [Create a variable-length random GUID](#create-a-variable-length-random-guid) example.

## Create a variable-length random GUID

1. Select **Start**, point to **Programs**, select **Accessories**, and then select **Notepad** to open Notepad.
2. Type or paste the following ASP code in Notepad:

    ```vbs
    <%@LANGUAGE="VBSCRIPT"%>
    <HTML>
        <BODY>
            <%
                Response.Write "<P>GUID = " & CreateGUID(10)
                Response.Write "<P>GUID = " & CreateGUID(25)
                Response.Write "<P>GUID = " & CreateGUID(50)

                Function CreateGUID(tmpLength)
                    Randomize Timer
                    Dim tmpCounter,tmpGUID
                    Const strValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                    For tmpCounter = 1 To tmpLength
                    tmpGUID = tmpGUID & Mid(strValid, Int(Rnd(1) * Len(strValid)) + 1, 1)
                    Next
                    CreateGUID = tmpGUID
                End Function
            %>
    </BODY>
    </HTML>
    ```

3. Save the page:

    1. On the **File** menu, select **Save**.
    2. Locate the root folder for your Web site, which is typically the *C:\InetPub\Wwwroot* folder for the default Web site.
    3. Name the file *GuidTest4.asp*.
    4. Select **Save**.
    5. On the **File** menu, select **Exit**.

4. Locate the page with Internet Explorer. You see a 10-character, 25-character, and 50-character random GUID. As you refresh the page, you see the values change randomly.

> [!NOTE]
> This example and the [Create a simple random GUID](#create-a-simple-random-guid) example both create strings of concatenated random characters. The [Create a windows-style random GUID](#create-a-windows-style-random-guid) example expands on this functionality to create a GUID that is formatted like a Windows GUID.

## Create a windows-style random GUID

Windows primarily uses GUIDs when it registers Class IDs for components and other objects, but GUIDs can be used for anything. Windows GUIDs are long strings of formatted hexadecimal characters, meaning that they use the numbers 0 through 9 and the letters A through F. (Microsoft Access also has a built-in Replication ID in the same format.) This example shows how to use code that is similar to the [Create a variable-length random GUID](#create-a-variable-length-random-guid) example code to create a GUID like a Windows GUID.

1. Select **Start**, point to **Programs**, select **Accessories**, and then select **Notepad** to open Notepad.
2. Type or paste the following ASP code in Notepad:

    ```vbs
    <%@LANGUAGE="VBSCRIPT"%>
    <HTML>
        <BODY>
            <%
                Response.Write "<P>GUID = " & CreateWindowsGUID()

                Function CreateWindowsGUID()
                    CreateWindowsGUID = CreateGUID(8) & "-" & _
                    CreateGUID(4) & "-" & _
                    CreateGUID(4) & "-" & _
                    CreateGUID(4) & "-" & _
                    CreateGUID(12)
                End Function

                Function CreateGUID(tmpLength)
                    Randomize Timer
                    Dim tmpCounter,tmpGUID
                    Const strValid = "0123456789ABCDEF"
                    For tmpCounter = 1 To tmpLength
                    tmpGUID = tmpGUID & Mid(strValid, Int(Rnd(1) * Len(strValid)) + 1, 1)
                    Next
                    CreateGUID = tmpGUID
                End Function
            %>
        </BODY>
    </HTML>
    ```

3. Save the page:

    1. On the **File** menu, select **Save**.
    2. Locate the root folder for your Web site, which is typically the `C:\InetPub\Wwwroot` folder for the default Web site.
    3. Name the file *GuidTest5.asp*.
    4. Select **Save**.
    5. On the **File** menu, select **Exit**.

4. Locate the page with Internet Explorer. You see a random GUID that is formatted like a Windows GUID. As you refresh the page, you see the value change randomly.

## Create a stronger windows-style random GUID

Because Windows GUIDs use hexadecimal numbers for each character, 16 values are possible per character in the GUID. If you expand the values to include the whole alphabet, 36 values are possible per character in the GUID. This example uses the function from the [Create a variable-length random GUID](#create-a-variable-length-random-guid) example to create a GUID in the same format as a Windows GUID.

1. Select **Start**, point to **Programs**, select **Accessories**, and then select **Notepad** to open Notepad.
2. Type or paste the following ASP code in Notepad:

    ```vbs
    <%@LANGUAGE="VBSCRIPT"%>
    <HTML>
        <BODY>
            <%
                Response.Write "<P>GUID = " & CreateWindowsGUID()

                Function CreateWindowsGUID()
                    CreateWindowsGUID = CreateGUID(8) & "-" & _
                    CreateGUID(4) & "-" & _
                    CreateGUID(4) & "-" & _
                    CreateGUID(4) & "-" & _
                    CreateGUID(12)
                End Function

                Function CreateGUID(tmpLength)
                    Randomize Timer
                    Dim tmpCounter,tmpGUID
                    Const strValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                    For tmpCounter = 1 To tmpLength
                    tmpGUID = tmpGUID & Mid(strValid, Int(Rnd(1) * Len(strValid)) + 1, 1)
                    Next
                    CreateGUID = tmpGUID
                End Function
            %>
        </BODY>
    </HTML>
    ```

3. Save the page:

    1. On the **File** menu, select **Save**.
    2. Locate the root folder for your Web site, which is typically the `C:\InetPub\Wwwroot` folder for the default Web site.
    3. Name the file *GuidTest6.asp*.
    4. Select **Save**.
    5. On the **File** menu, select **Exit**.

4. Locate the page with Internet Explorer. You see a random GUID that is formatted like a Windows GUID. As you refresh the page, you see the value change randomly.
