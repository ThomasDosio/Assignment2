public class BubbleSort {
    public static int[] intOrder(String[] args) {
        int[] arr = MakeArray.intBuild(args);

        boolean swap = true;

        while (swap) {
            swap = false;
            for (int j = 0; j < arr.length - 1; j++) {

                if (arr[j] > arr[j + 1]) {

                    int b = arr[j];
                    int c = arr[j + 1];

                    arr[j] = c;
                    arr[j + 1] = b;

                    swap = true;
                    }
            }
        }

        return arr;
        }
    public static double [] doubleOrder( double[] arr) {

        boolean swap = true;

        while (swap) {
            swap = false;
            for (int j = 0; j < arr.length - 1; j++) {

                if (arr[j] > arr[j + 1]) {

                    double b = arr[j];
                    double c = arr[j + 1];

                    arr[j] = c;
                    arr[j + 1] = b;

                    swap = true;
                }
            }
        }
        return arr;
    }
    }

