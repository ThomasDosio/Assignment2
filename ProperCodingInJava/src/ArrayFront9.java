public class ArrayFront9 {
    public static boolean arrayFront9(int[] arr) {
        boolean valid = false;
        for(int i = 0; i<Math.min(arr.length, 4); i++) {
            if (arr[i]==9) {
                valid = true;
            }
        }
        return valid;
    }

    public static void main(String[] args) {
        int [] nums= MakeArray.intBuild(args);
        System.out.println(arrayFront9(nums));

    }
}
