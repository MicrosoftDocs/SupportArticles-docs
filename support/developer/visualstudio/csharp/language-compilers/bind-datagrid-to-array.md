---
title: Bind a DataGrid control to an array of objects
description: Describes how to bind a DataGrid control to an array of objects or of structures in Visual C#. Also gives a code sample to explain the related information.
ms.date: 04/20/2020
ms.custom: sap:Language or Compilers\C#
ms.topic: how-to
---
# Use Visual C# to bind a DataGrid control to an array of objects or of structures

This article provides information about how to bind an array of objects to a DataGrid control.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 315786

## Summary

The example in this article consists of a Windows form with a DataGrid control to display object property values and four command buttons to browse the rows of the DataGrid control.

## Requirements

This article assumes that you're familiar with the following topics:

- Visual C# programming concepts
- Visual C# .NET

## Design the class

A class that is to be bound to a control must have property accessors. Any property that is to be bound must have the property `Set` method and the property `Get` method. The sample class that is used in this article has three members. Only one member is described in this article. A parameterized constructor has also been provided. However, it isn't a requirement.

```csharp
public class guitar
{
    private string make;
    private string model;
    private short year;

    public guitar()
    {
    }

    public guitar(string make, string model, short year)
    {
        Make=make;
        Model=model;
        Year=year;
    }

    public string Make
    {
        get
        {
            return make;
        }
        set
        {
            make = value;
        }
    }
}
```

## Add class instances to an array

To create instances and add them to the array, follow these steps:

1. Declare an array.
2. Create instances of the class, and then add the instances to the array.

    ```csharp
    private guitar[] arr=new guitar[3];
    arr[0] = new guitar("Gibson", "Les Paul", 1958);
    arr[1] = new guitar("Fender", "Jazz Bass", 1964);
    arr[2] = new guitar("Guild", "Bluesbird", 1971);
    ```

## Bind the array to the DataGrid control

After the array has been populated, set the DataSource property of the DataGrid control to the array. The columns in the DataGrid control are populated based on the properties for which in-scope property accessors exist.

```csharp
dataGrid1.DataSource=arr;
```

## Provide a means to browse the array

You can use `CurrencyManager` to browse through the array. To do it, associate `CurrencyManager` with the `BindingContext` of the control, in this case, the array.

```csharp
private CurrencyManager currencyManager=null;
currencyManager = (CurrencyManager)dataGrid1.BindingContext[arr];
```

The `CurrencyManager` class has a `Position` property that you can manipulate to iterate over the members of the array. By adding to, or subtracting from, the current value of `Position`, you can browse the rows of the `DataGrid` control.

```csharp
//Move forward one element.
currencyManager.Position++;
//Move back one element.
currencyManager.Position--;
//Move to the beginning.
currencyManager.Position = 0;
//Move to the end.
currencyManager.Position = arr.Length - 1;
```

## Step-by-step example

1. In Visual C# .NET, create a new Windows Application project. Form1 is created by default.
2. Add a class to the project.
3. Replace the code in *Class1.cs* with the following code.

    ```csharp
    public class guitar
    {
        private string make;
        private string model;
        private short year;

        public guitar()
        {
        }

        public guitar(string Make, string Model, short Year)
        {
            make=Make;
            model=Model;
            year=Year;
        }

        public string Make
        {
            get
            {
                return make;
            }
            set
            {
                make = value;
            }
        }

        public string Model
        {
            get
            {
                return model;
            }
            set
            {
                model = value;
            }
        }

        public short Year
        {
            get
            {
                return year;
            }
            set
            {
                year = value;
            }
        }
    }
    ```

4. Close the *Class1.cs* code window, and then switch to the **Form Designer**.
5. Add a DataGrid control to Form1. Size the DataGrid control to accommodate four columns and three rows.
6. Add four Button controls to Form1, and then arrange the buttons horizontally.
7. Change the **Text** property of Button1 to **Next**.
8. Change the **Text** property of Button2 to **Previous**.
9. Change the **Text** property of Button3 to **First**.
10. Change the **Text** property of Button4 to **Last**.
11. Add the following code to the `Form1` class.

    ```csharp
    private guitar[] arr=new guitar[3];
    private CurrencyManager currencyManager=null;
    ```

12. Switch to the **Form Designer**, right-click the form, and then click **Properties**.
13. Click the **Events** icon, and then double-click the load event to add the `Form1_Load` event to your code.
14. Add the following code to the `Form1_Load` event.

    ```csharp
    arr[0] = new guitar("Gibson", "Les Paul", 1958);
    arr[1] = new guitar("Fender", "Jazz Bass", 1964);
    arr[2] = new guitar("Guild", "Bluesbird", 1971);
    currencyManager = (CurrencyManager)dataGrid1.BindingContext[arr];
    dataGrid1.DataSource=arr;
    ```

15. Switch to view the **Form Designer**.
16. Double-click **Next**, and then add the following code to the `button1_Click` event.

    ```csharp
    currencyManager.Position++;
    ```

17. Double-click **Previous**, and then add the following code to the `button2_Click` event.

    ```csharp
    currencyManager.Position--;
    ```

18. Double-click **First**, and then add the following code to the `button3_Click` event.

    ```csharp
    currencyManager.Position = 0;
    ```

19. Double-click **Last**, and then add the following code to the `button4_Click` event.

    ```csharp
    currencyManager.Position = arr.Length - 1;
    ```

20. Build and run the project.
21. Click the command buttons to move among the rows of the DataGrid control.

    > [!NOTE]
    > You can edit the values of the objects if desired.  

## Use a structure instead of a class

The rules for binding a structure are the same as the rules for binding an object. Property that is member accessors is required. A structure that is created for this purpose resembles a class.

To bind to an array of structures, follow these steps.

1. Change the definition of the *Class1.cs* class module in the example from

    ```csharp
    public class guitar
    ```

    to the following example:

    ```csharp
    public struct guitar
    ```

2. Comment out the default constructor, as follows.

    ```csharp
    //public guitar()
    //{
    //}
    ```

3. Build and run the example program again and verify that it functions with an array of structures.

## References

For more information, see the **Consumers of Data on Windows Forms** topic in the Visual Studio .NET Online Help.
