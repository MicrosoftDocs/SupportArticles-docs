---
title: Change dates by using functions and operators
description: Describes the functions and the operators that are available in Microsoft Access. You can use the functions and the operators to manipulate the Date/Time data type by using example queries.
author: helenclu
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 05/26/2025
---

# How to make a change to dates by using functions and operators in Access

This article applies to either a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file, and to a Microsoft Access project (.adp) file.

Moderate: Requires basic macro, coding, and interoperability skills. 

## Summary

This article describes the functions and the operators that are available in Microsoft Office Access 2007, in Microsoft Office Access 2003, and in Microsoft Access 2002. You can use the functions and the operators to make a change to the Date/Time data type by using example queries. The example queries that you can use to make a change to the date values use the tables in the Northwind.mdb sample database.

> [!NOTE]
> The Northwind sample database for Access 2007 does not use the same fields as the earlier versions of the Northwind sample database. There are no HireDate and BirthDate fields in the Employees table that is included with the Northwind sample database for Access 2007. The EmployeeID field has been renamed ID and the FirstName field has been renamed First Name.

## More Information

Access provides operators and functions to validate or to make a change to the fields with the Date/Time data type. The following example queries use the date manipulations, the calculation functions, and the comparison operators that are available in Access.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

### Date() function, Now() function, and Format() function

**SELECT Date(), Now();**

The Date() function returns the current date in the short-date format. The Now() function returns the current date with the time.

**SELECT Format(Now(), "dd mmmm yyyy");**

You can use the Format() function with date values to specify the date format that you want to use for the date. This example query returns the current date in the long date format (01 December 2003).   

### Day() function, WeekDay() function, Month() function, and Year() function

```adoc
SELECT HireDate, Day(HireDate) AS Day,
Weekday(HireDate) AS WeekDay,
Month(HireDate) AS Month, Year(HireDate) AS Year 
FROM Employees;
```

From the Employees table, this query returns the date of hire, the day of hire, the day of the week of hire, the month of hire, and the year of hire for each employee. Notice that the WeekDay() function returns a numeric value that indicates the day of the week.   

### DatePart() function

```adoc
SELECT *  FROM Employees
WHERE DatePart("yyyy", BirthDate) < 1960;
```

From the Employees table, this query returns all the employees who were born before the year 1960. The DatePart() function can be used to extract the part of the specified date, such as the day, the month, or the year.   

### DateDiff() function

```adoc
SELECT EmployeeID, FirstName, BirthDate,
DateDiff("yyyy", BirthDate, Date()) AS Age
FROM Employees;
```

From the Employees table, this query returns the employee ID, the first name, the date of birth, and the age of each employee. The DateDiff() function returns the difference or the time lag between the two specified date values (in terms of the day, the month, the year, or the time units, such as hours, minutes, and seconds).   

### DateAdd() function

```adoc
SELECT EmployeeID, FirstName, HireDate,
DateAdd("yyyy", 10, HireDate)
FROM Employees;
```

From the Employees table, this query returns the employee ID, the first name, the hire date, and the date that the employee finishes 10 years of service with the company. The DateAdd() function increments a date by a specified number of time units, such as a day, a month, or a year and then returns the resultant value.

You can add a numeric value to a date value directly. Do this to increment the date value by a day, as in the following example:

**SELECT Date() + 1 ;**

This query increments the current date by one day and then returns the resultant date value.   

### DateValue() function

**SELECT DateValue("20 Nov 2003") AS ValidDate;**

The DateValue() function verifies whether the input string is a valid date. If the input string is recognized as a valid date, the date is returned in short-date format. If the input string is not recognized as a valid date, the statement "Data type mismatch in criteria expression" is returned. The DateValue() function recognizes a variety of date formats, such as mm dd yyyy, dd mm yyyy, dd mmm yyyy, and dd mmm yyyy hh:mm:ss long date format.   

### DateSerial() function

**SELECT DateSerial( 2003,  03, 1-1);**


The DateSerial() function returns the date value for the specified input parameters of year, month, and day. The input parameters can be expressions that involve arithmetical operations. The DateSerial() function evaluates the expressions in the input parameters before it returns the resultant date value.

This example query returns the last day in the month of February for the year 2003. The last input parameter for the day with the value of 1 is decremented by 1. The result is that the month parameter is evaluated to 2.   

### Use comparison operators with date values

You can use the following comparison operators to compare date values in expressions and in queries: 

- < (less than)   
- \> (greater than)   
- <= (less than or equal to)   
- \>= (greater than or equal to)   
- <> (not equal)   

```adoc
SELECT * FROM Employees
WHERE HireDate >= DateValue(" 10/01/1993")
AND HireDate <= DateValue("12/31/1993");
```

This query uses the >= comparison operator and the <= comparison operator to verify whether the hire date of the employee falls in the range of the two specified dates. This query fetches the records of all employees who were hired in the last quarter of the calendar year 1993.

```adoc
SELECT * FROM Employees
WHERE HireDate <> Date();
```

This query uses the inequality comparison operator to fetch the records of all employees who have a hire date that is not equal to the current date.   

### WeekdayName() function

**SELECT WeekdayName(1, False, 1) AS FirstWeekDayName;**

The WeekdayName() function returns a string that indicates the day of the week, as specified in the first parameter. The day of the week string that is returned depends on the third parameter. This parameter sets the first day of the week. The second parameter is set to False to specify that the weekday name must not be abbreviated.

This example query returns the value Sunday as the first day of the week.   

### MonthName() function

**SELECT MonthName(1);**

The MonthName() function returns a string that indicates the month name for the specified month number from 1 through 12. The input parameter can also be an expression, as in the following query:

**SELECT MonthName( DatePart("m", Date()) );**

This query returns the name of the current month.   

## References

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:
- [290178 ](https://support.microsoft.com/help/290178) How to create a query that has parameters to evaluate complex criteria in Microsoft Access
- [290190 ](https://support.microsoft.com/help/290190) How to create two functions to calculate age in months and in years in Microsoft Access
