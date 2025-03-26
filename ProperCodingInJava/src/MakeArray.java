public class MakeArray {
    public static int [] intBuild (String [] args) {
        int [] arr = new int [args.length];
        for (int i = 0; i < args.length; i++) {
            arr [i] = Integer.parseInt(args [i]);
        }
        return arr;
    }

    public static double [] doubleBuild (String [] args) {
        double [] arr = new double [args.length];
        for (int i = 0; i < args.length; i++) {
            arr [i] = Double.parseDouble(args [i]);
        }
        return arr;
    }

    public static String [] stringBuildint (int [] args) {
        String [] arr = new String[args.length];
        for (int i = 0; i < args.length; i++) {
            arr [i] = Integer.toString (args [i]);
        }
        return arr;
    }

    public static String [] stringBuilddbl (double [] args) {
        String [] arr = new String[args.length];
        for (int i = 0; i < args.length; i++) {
            arr [i] = Double.toString (args [i]);
        }
        return arr;
    }
}
