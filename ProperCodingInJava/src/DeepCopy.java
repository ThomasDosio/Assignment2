public class DeepCopy {
    public static double[] copy(double[] data) {
        double [] copy = new double[data.length];

        for (int i = 0; i<copy.length; i++) {
            copy[i] = ith(data, i);
        }
        return copy;
    }

    public static double ith (double [] arr, int i){
        double [] element = new double [1];
        element[0] = arr[i];
        return element[0];
    }
}
