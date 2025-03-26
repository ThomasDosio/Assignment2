// Credit to https://beginnersbook.com/2019/02/java-program-to-break-integer-into-digits/

import java.util.Scanner;

public class Digitiser
{
    public static void main(String[] args)
    {
        int num, temp, digit, count = 0;

        //getting the number from user
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter any number:");
        num = scanner.nextInt();
        scanner.close();

        if (num < 0) {
            num = Math.abs(num);
        }

        if (num == 0) {
            System.out.println("Digit at place 1 is: 0");
        }

        //making a copy of the input number
        temp = num;

        //counting digits in the input number
        while(num > 0)
        {
            num = num / 10;
            count++;
        }
        while(temp > 0)
        {
            digit = temp % 10;
            System.out.println("Digit at place "+count+" is: "+digit);
            temp = temp / 10;
            count--;
        }
    }
}