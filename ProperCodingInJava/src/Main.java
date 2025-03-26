public static void Change (String [] arr) {
    arr[0] = "Boo";
}//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public static void main(String[] args){
    String [] s = {"hello", "world"};
    Change(s);
    System.out.println(s[0]);
}
