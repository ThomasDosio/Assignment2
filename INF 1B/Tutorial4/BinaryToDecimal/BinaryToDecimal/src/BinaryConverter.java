// Credit to https://beginnersbook.com/2014/07/java-program-for-binary-to-decimal-conversion/
public class BinaryConverter {
    public static int binaryToDecimal(int binaryNumber){
        int decimal = 0;
        int p = 0;
        while(decimal == 0){
            int temp = binaryNumber%10;
            decimal += temp*Math.pow(2, p);
            binaryNumber = binaryNumber/10;
            p++;
        }
        return decimal;
    }

    public static void main(String[] args){
        System.out.println("110 --> " + binaryToDecimal(110));
    }
}
