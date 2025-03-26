public class ErrorHandlingException {
    public static String lowerAndTrim(String str) {
        try{
        str = str.trim();
        str = str.toLowerCase();
        } catch (NullPointerException error) {
            System.err.println(error);
        }
        return str;
    }
}
