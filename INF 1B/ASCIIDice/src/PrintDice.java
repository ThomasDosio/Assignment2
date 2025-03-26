import java.util.Scanner;


public class PrintDice {

    public static void printInt(int number)
    {
        System.out.println("-----");

        switch (number)
        {
            case 1:
                System.out.println("|   |");
                System.out.println("| 0 |");
                System.out.println("|   |");
                break;

            case 2:
                System.out.println("|0  |");
                System.out.println("|   |");
                System.out.println("|  0|");
                break;

            case 3:
                System.out.println("|0  |");
                System.out.println("| 0 |");
                System.out.println("|  0|");
                break;

            case 4:
                System.out.println("|0 0|");
                System.out.println("|   |");
                System.out.println("|0 0|");
                break;

            case 5:
                System.out.println("|0 0|");
                System.out.println("| 0 |");
                System.out.println("|0 0|");
                break;

            case 6:
                System.out.println("|0 0|");
                System.out.println("|0 0|");
                System.out.println("|0 0|");
                break;
        }
        System.out.println("-----");
    }

/**
 * Opens scanner and takes input. If it's a valid input it pretty prints the face of the die by calling printInt
@param args This method uses a scanner not arguments
 */
    public static void main(String[] args)
    {
        boolean exit = false;
        System.out.println("Type in the number whose face you want printed");
        System.out.println("Please give an integer between 1 and 6.");
        System.out.println("Type 'Exit' to exit the program");

        while (exit == false)
        {


            Scanner input = new Scanner(System.in);

            if (input.hasNextInt()) {
                int numberOnFace = input.nextInt();

                if (numberOnFace >0 && numberOnFace <= 6)
                {
                    printInt(numberOnFace);
                } else
                {
                    System.out.println("Please give an integer between 1 and 6");
                }
            }

            if (input.nextLine().equals("Exit")) break;

            else
            {
                System.out.println("Please give an integer between 1 and 6");
            }

        }
    }
}

/* TODO 1 Open the TODO tab to help you see what needs doing.
            You can rename these comments to remove them from the list.
            This is better than deleting them because you can see what did need
            doing. Alternatively add "DONE" to the comment.
*/
// TODO 2 Read the proposed design in readme.md
/* TODO 3 Sketch out the design on paper so you have a clear idea of the
            program flow before your start coding
 */
// TODO 4 Code, test, and refine a design
// TODO 5 Add comments and JavaDoc comments
// TODO 6 Fill in walkthrough.md
// TODO 7 If you have time, code, test, and refine a different design for comparison
// TODO 8 Complete the reflections.md file