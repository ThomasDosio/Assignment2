import java.util.Scanner;

public class NMax {
    public static int max (int a, int b, int c) {
        if(a>b && a>c) {
            return a;
        }
        else if(b>a && b>c) {
            return b;
        }
        else return c;
    }

    public static double max (double a, double b, double c) {
        if(a>b && a>c) {
            return a;
        }
        else if(b>a && b>c) {
            return b;
        }
        else return c;
    }

    public static void main(String[] args) {
        Scanner Scan = new Scanner (System.in);
        double d = Scan.nextDouble();
        double e = Scan.nextDouble();
        double f = Scan.nextDouble();

        System.out.println(max(d,e,f));
        Scan.close();
    }
}
