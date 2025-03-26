public class ArrayOps {

    public static double findMax(double[] data) {
        data = BubbleSort.doubleOrder(data);
        return data[data.length -1];
    }

    public static double[] normalise(double data[]) {
        double sum = 0;
        for (int i = 0; i < data.length; i++) {
            sum += data[i];
        }

        double [] copy = DeepCopy.copy(data);

        for (int i = 0; i<copy.length; i++) {
            copy[i] = copy[i]/sum;
        }
        return copy;
    }

    public static void normaliseInPlace(double data[]) {
        double sum = 0;
        for (int i = 0; i < data.length; i++) {
            sum += data[i];
        }
        for (int i = 0; i<data.length; i++) {
            data[i] = data[i]/sum;
        }

    }

    public static double[] reverse(double[] data) {
        double[] copy = DeepCopy.copy(data);
        double[] secondcopy = DeepCopy.copy(copy);
        for (int i = 0; i < copy.length; i++) {
            copy [i] = secondcopy [secondcopy.length - 1 - i];
        }
        return copy;
    }

    public static void reverseInPlace(double[] data) {
        double[] copy = DeepCopy.copy(data);
        for (int i = 0; i < copy.length; i++) {
            data [i] = copy [copy.length - 1 - i];
        }
    }

    public static void swap(double[] data1, double[] data2) {
        double[] copy1 = DeepCopy.copy(data1);
        double[] copy2 = DeepCopy.copy(data2);
        for (int i = 0; i < data1.length; i++) {
            data1 [i] = copy2[i];
        }
        for (int i = 0; i < data2.length; i++) {
            data2 [i] = copy1[i];
        }
    }

    public static void main(String[] args) {
        double [] answer = normalise(MakeArray.doubleBuild(args));
        PrintArray.doublePrint(answer);

    }

}
