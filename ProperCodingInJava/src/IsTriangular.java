import java.util.Scanner;

public class IsTriangular {
    public static boolean lessThanSumOthers(double a, double b, double c) {
        return a < (b + c);
    }
    public static boolean isTri(double a, double b, double c) {
        return lessThanSumOthers(a, b, c) && lessThanSumOthers(b, c, a) && lessThanSumOthers(c, a, b);
    }

    public static void main(String[] args) {
        Scanner StdIn = new Scanner(System.in);
        double a = StdIn.nextDouble();
        double b = StdIn.nextDouble();
        double c= StdIn.nextDouble();
        if(isTri(a,b,c)){
            System.out.printf("%s, %s and %s could be the lengths of a triangle", a, b, c);
        }
        else {
            System.out.println("Not a triangle.");
        }
        StdIn.close();
    }
}
