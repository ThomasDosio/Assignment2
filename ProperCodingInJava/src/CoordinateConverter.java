public class CoordinateConverter {

    public static double convertXYtoR(double x, double y) {
        double R = Math.sqrt(Math.pow(x,2) + Math.pow(y,2));
        return R;
    }

    public static double convertXYtoT(double x, double y) {
        double T = Math.atan2(y,x);
        return T;
    }

    public static double convertRTtoX(double r, double theta) {
        double X = r*Math.cos(theta);
        return X;
    }

    public static double convertRTtoY(double r, double theta) {
        double Y = r*Math.sin(theta);
        return Y;
    }

    public static double convertDegToRad(double deg) {
        double rad = (deg/180)*Math.PI;
        return rad;
    }

    public static double convertRadToDeg(double rad) {
        double deg = (rad/Math.PI)*180;
        return deg;
    }

}
