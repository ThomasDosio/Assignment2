import java.util.ArrayList;

public class StewieSequence
{
    public static double  operation(double x1, double x2,int n)
    {
        return switch (n % 4)
        {
            case 1 -> x1-x2;
            case 2 -> x1/x2;
            case 3 -> x1+x2;
            default -> x1*x2;
        };
    }

    public static void stewieArrayList (double x1, double x2, int n)
    {
        ArrayList<Double> sequence = new ArrayList<>();
        sequence.add(x1);
        sequence.add(x2);
        for (int i=3; i<=n; i++)
        {
            double value = operation(sequence.get(i-3), sequence.get(i-2), i);
            sequence.add(value);
        }
        System.out.print("[");

        for (double x : sequence)
        {
            if (x == x1) System.out.printf("%.3f", x);
            else
            {
                System.out.printf(", %.3f", x);
            }
        }
        System.out.println("]");
    }

    public static void stewieWhile(double x1, double x2, int n)
    {
        double input1 = x1;
        double input2 = x2;
        System.out.printf("[%.3f, %.3f", input1, input2);
        int index = 3;
        while (index <=n)
        {
            double newinput = operation(input1, input2, index);
            input1 = input2;
            input2 = newinput;

            System.out.printf(", %.3f", newinput);

            index++;
        }
        System.out.print("]");
    }

    public static void main(String[] args)
    {
        stewieArrayList(1,3,8);
        stewieWhile(1,3,8);
    }
}

//if(!(i<=characters.size()-3 && characters.get(i + 1) == 'S' && characters.get(i + 2) == 'O') && !(i<=characters.size()-3 && characters.get(i + 1) == 'O' && characters.get(i + 2) == 'S') && !(i<=characters.size()-2 && characters.get(i+1) == 'S'))
/* !(i<=characters.size()-2 && characters.get(i+1) == 'S') &&
                            !(i<=characters.size()-3 && characters.get(i + 1) == 'O' && characters.get(i + 2) == 'S') &&
                            !(i<=characters.size()-3 && characters.get(i + 1) == 'S' && characters.get(i + 2) == 'O') &&
                            !(i<=characters.size()-2 && characters.get(i+1) == 'S' && !VSO && !VOS) &&
                            (i!=characters.size()-1 || i==0)*/