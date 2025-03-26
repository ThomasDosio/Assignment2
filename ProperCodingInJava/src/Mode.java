public class Mode {
    public static int last(int[] arr) {
        return arr[arr.length - 1];
    }

    public static void main(String[] args) {
        int[] arr = MakeArray.intBuild(args);

        int[] count = new int[10];
        for (int x : arr) {
            count[x] = count[x] + 1;
        }

        String[] countStr = MakeArray.stringBuildint(count);

        int[] sortedCountStr = BubbleSort.intOrder(countStr);

        for (int i = 0; i < count.length; i++) {
            if (count[i] == last(sortedCountStr)) {
                System.out.println("The mode is " + i);
            }
        }
    }
}