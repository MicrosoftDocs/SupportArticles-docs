---
title: Use comparison interfaces in Visual C#
description: This article describes how to use the `IComparable` and `IComparer` interfaces in Visual C#.
ms.date: 04/14/2020
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use the `IComparable` and `IComparer` interfaces in Visual CSharp

This article describes the use of `IComparer` and `IComparable` interfaces in Visual C#.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 320727

## Summary

The `IComparable` and `IComparer` interfaces are discussed in the same article for two reasons. These interfaces are frequently used together. Although the interfaces are similar and have similar names, they serve different purposes.

If you have an array of types (such as string or integer) that already support `IComparer`, you can sort that array without providing any explicit reference to `IComparer`. In that case, the elements of the array are cast to the default implementation of `IComparer` (`Comparer.Default`) for you. However, if you want to provide sorting or comparison capability for your custom objects, you must implement either or both of these interfaces.

This article references the Microsoft .NET Framework Class Library namespace `System.Collections`.

## `IComparable`

The role of `IComparable` is to provide a method of comparing two objects of a particular type. It's necessary if you want to provide any ordering capability for your object. Think of `IComparable` as providing a default sort order for your objects. For example, if you have an array of objects of your type, and you call the `Sort` method on that array, `IComparable` provides the comparison of objects during the sort. When you implement the `IComparable` interface, you must implement the `CompareTo` method, as follows:

```csharp
// Implement IComparable CompareTo method - provide default sort order.
int IComparable.CompareTo(object obj)
{
   Car c=(Car)obj;
   return String.Compare(this.make,c.make);
}
```

The comparison in the method is different depending on the data type of the value that is being compared. `String.Compare` is used in this example because the property that is chosen for the comparison is a string.

## `IComparer`

The role of `IComparer` is to provide more comparison mechanisms. For example, you might want to provide ordering of your class on several fields or properties, ascending and descending order on the same field, or both.

Using `IComparer` is a two-step process. First, declare a class that implements `IComparer`, and then implement the `Compare` method:

```csharp
private class SortYearAscendingHelper : IComparer
{
   int IComparer.Compare(object a, object b)
   {
      Car c1=(Car)a;
      Car c2=(Car)b;
      if (c1.year > c2.year)
         return 1;
      if (c1.year < c2.year)
         return -1;
      else
         return 0;
   }
}
```

> [!NOTE]
> The `IComparer.Compare` method requires a tertiary comparison. **1**, **0**, or **-1** is returned depending on whether one value is greater than, equal to, or less than the other. The sort order (ascending or descending) can be changed by switching the logical operators in this method.

The second step is to declare a method that returns an instance of your `IComparer` object:

```csharp
public static IComparer SortYearAscending()
{
   return (IComparer) new SortYearAscendingHelper();
}
```

In this example, the object is used as the second argument when you call the overloaded `Array.Sort` method that accepts `IComparer`. The use of `IComparer` isn't limited to arrays. It's accepted as an argument in many different collection and control classes.

## Step-by-step example

The following example demonstrates the use of these interfaces. To demonstrate `IComparer` and `IComparable`, a class named `Car` is created. The `Car` object has the make and year properties. An ascending sort for the make field is enabled through the `IComparable` interface, and a descending sort on the make field is enabled through the `IComparer` interface. Both ascending and descending sorts are provided for the year property by using `IComparer`.

1. In Visual C#, create a new Console Application project. Name the application *ConsoleEnum*.

2. Rename *Program.cs* as *Host.cs*, and then replace the code with the following code.

   ```csharp
   using System;

   namespace ConsoleEnum
   {
       class host
       {
          [STAThread]
          static void Main(string[] args)
          {
             // Create an array of Car objects.
             Car[] arrayOfCars= new Car[6]
             {
                new Car("Ford",1992),
                new Car("Fiat",1988),
                new Car("Buick",1932),
                new Car("Ford",1932),
                new Car("Dodge",1999),
                new Car("Honda",1977)
             };

             // Write out a header for the output.
             Console.WriteLine("Array - Unsorted\n");

             foreach(Car c in arrayOfCars)
                Console.WriteLine(c.Make + "\t\t" + c.Year);

             // Demo IComparable by sorting array with "default" sort order.
             Array.Sort(arrayOfCars);
             Console.WriteLine("\nArray - Sorted by Make (Ascending - IComparable)\n");

             foreach(Car c in arrayOfCars)
                Console.WriteLine(c.Make + "\t\t" + c.Year);

             // Demo ascending sort of numeric value with IComparer.
             Array.Sort(arrayOfCars,Car.SortYearAscending());
             Console.WriteLine("\nArray - Sorted by Year (Ascending - IComparer)\n");

             foreach(Car c in arrayOfCars)
                Console.WriteLine(c.Make + "\t\t" + c.Year);

             // Demo descending sort of string value with IComparer.
             Array.Sort(arrayOfCars,Car.SortMakeDescending());
             Console.WriteLine("\nArray - Sorted by Make (Descending - IComparer)\n");

             foreach(Car c in arrayOfCars)
                Console.WriteLine(c.Make + "\t\t" + c.Year);

             // Demo descending sort of numeric value using IComparer.
             Array.Sort(arrayOfCars,Car.SortYearDescending());
             Console.WriteLine("\nArray - Sorted by Year (Descending - IComparer)\n");

             foreach(Car c in arrayOfCars)
                Console.WriteLine(c.Make + "\t\t" + c.Year);

             Console.ReadLine();
          }
      }
   }
   ```

3. Add a class to the project. Name the class *Car*.

4. Replace the code in *Car.cs* with the following code:

    ```csharp
    using System;
    using System.Collections;
    namespace ConsoleEnum
    {
       public class Car : IComparable
       {
          // Beginning of nested classes.
          // Nested class to do ascending sort on year property.
          private class SortYearAscendingHelper: IComparer
          {
             int IComparer.Compare(object a, object b)
             {
                Car c1=(Car)a;
                Car c2=(Car)b;

                if (c1.year > c2.year)
                   return 1;

                if (c1.year < c2.year)
                   return -1;

                else
                   return 0;
             }
          }

          // Nested class to do descending sort on year property.
          private class SortYearDescendingHelper: IComparer
          {
             int IComparer.Compare(object a, object b)
             {
                Car c1=(Car)a;
                Car c2=(Car)b;

                if (c1.year < c2.year)
                   return 1;

                if (c1.year > c2.year)
                   return -1;

                else
                   return 0;
             }
          }

          // Nested class to do descending sort on make property.
          private class SortMakeDescendingHelper: IComparer
          {
             int IComparer.Compare(object a, object b)
             {
                Car c1=(Car)a;
                Car c2=(Car)b;
                 return String.Compare(c2.make,c1.make);
             }
          }
          // End of nested classes.
          private int year;
          private string make;

          public Car(string Make,int Year)
          {
             make=Make;
             year=Year;
          }

          public int Year
          {
             get  {return year;}
             set {year=value;}
          }

          public string Make
          {
             get {return make;}
             set {make=value;}
          }
          // Implement IComparable CompareTo to provide default sort order.
          int IComparable.CompareTo(object obj)
          {
             Car c=(Car)obj;
             return String.Compare(this.make,c.make);
          }
          // Method to return IComparer object for sort helper.
          public static IComparer SortYearAscending()
          {
             return (IComparer) new SortYearAscendingHelper();
          }
          // Method to return IComparer object for sort helper.
          public static IComparer SortYearDescending()
          {
             return (IComparer) new SortYearDescendingHelper();
          }
          // Method to return IComparer object for sort helper.
          public static IComparer SortMakeDescending()
          {
            return (IComparer) new SortMakeDescendingHelper();
          }

       }
    }
    ```

5. Run the project. The following output appears in the **Console** window:

    ```output
    Array - Unsorted

    Ford 1992
    Fiat 1988
    Buick 1932
    Ford 1932
    Dodge 1999
    Honda 1977

    Array - Sorted by Make (Ascending - IComparable)

    Buick 1932
    Dodge 1999
    Fiat 1988
    Ford 1932
    Ford 1992
    Honda 1977

    Array - Sorted by Year (Ascending - IComparer)

    Ford 1932
    Buick 1932
    Honda 1977
    Fiat 1988
    Ford 1992
    Dodge 1999

    Array - Sorted by Make (Descending - IComparer)

    Honda 1977
    Ford 1932
    Ford 1992
    Fiat 1988
    Dodge 1999
    Buick 1932

    Array - Sorted by Year (Descending - IComparer)

    Dodge 1999
    Ford 1992
    Fiat 1988
    Honda 1977
    Buick 1932
    Ford 1932
    ```
