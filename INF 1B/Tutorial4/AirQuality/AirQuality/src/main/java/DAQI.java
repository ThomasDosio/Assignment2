/**
 * DAQI - a class with helper methods to compute the Daily Air Quality Index
 */
public class DAQI {
    /**
     * getOzoneDAQI
     * @param o3 running 8 hourly mean ozone in micrograms per cube metre
     * @return DAQI for the given O3 level (and -1 if O3 is N/A)
     */
    public static int getOzoneDAQI(double o3) {
        if (o3 < 0 || o3 == AirQuality.NA) {
            return -1;
        } else if (o3 <= 33) {
            return 1;
        } else if (o3 <= 66) {
            return 2;
        } else if (o3 <= 100) {
            return 3;
        } else if (o3 <= 120) {
            return 4;
        } else if (o3 <= 140) {
            return 5;
        } else if (o3 <= 160) {
            return 6;
        } else if (o3 <= 187) {
            return 7;
        } else if (o3 <= 213) {
            return 8;
        } else if (o3 <= 240) {
            return 9;
        } else {
            return 10;
        }
    }

    /**
     * getNitrogenDioxideDAQI
     * @param no2 hourly mean nitrogen dioxide in micrograms per cube metre
     * @return DAQI for given NO2 level (and -1 if NO2 is N/A)
     */
    public static int getNitrogenDioxideDAQI(double no2) {
        if (no2 < 0 || no2 == AirQuality.NA) {
            return -1;
        } else if (no2 <= 67) {
            return 1;
        } else if (no2 <= 134) {
            return 2;
        } else if (no2 <= 200) {
            return 3;
        } else if (no2 <= 267) {
            return 4;
        } else if (no2 <= 334) {
            return 5;
        } else if (no2 <= 400) {
            return 6;
        } else if (no2 <= 467) {
            return 7;
        } else if (no2 <= 534) {
            return 8;
        } else if (no2 <= 600) {
            return 9;
        } else {
            return 10;
        }
    }

    /**
     * getSulphurDioxideDAQI
     * @param so2 15 minute mean sulphur dioxide in micrograms per cube metre
     * @return DAQI for given SO2 level (and -1 if SO2 is N/A)
     */
    public static int getSulphurDioxideDAQI(double so2) {
        if (so2 < 0 || so2 == AirQuality.NA) {
            return -1;
        } else if (so2 <= 88) {
            return 1;
        } else if (so2 <= 177) {
            return 2;
        } else if (so2 <= 266) {
            return 3;
        } else if (so2 <= 354) {
            return 4;
        } else if (so2 <= 443) {
            return 5;
        } else if (so2 <= 532) {
            return 6;
        } else if (so2 <= 710) {
            return 7;
        } else if (so2 <= 887) {
            return 8;
        } else if (so2 <= 1064) {
            return 9;
        } else {
            return 10;
        }
    }

    /**
     * getPM25DAQI
     * @param pm25 24 hour mean PM2.5 particles in micrograms per cube metre
     * @return DAQI for given PM2.5 level (and -1 if PM2.5 is N/A)
     */
    public static int getPM25DAQI(double pm25) {
        if (pm25 < 0 || pm25 == AirQuality.NA) {
            return -1;
        } else if (pm25 <= 11) {
            return 1;
        } else if (pm25 <= 23) {
            return 2;
        } else if (pm25 <= 35) {
            return 3;
        } else if (pm25 <= 41) {
            return 4;
        } else if (pm25 <= 47) {
            return 5;
        } else if (pm25 <= 53) {
            return 6;
        } else if (pm25 <= 58) {
            return 7;
        } else if (pm25 <= 64) {
            return 8;
        } else if (pm25 <= 70) {
            return 9;
        } else {
            return 10;
        }
    }

    /**
     * getPM25DAQI
     * @param pm10 24 hour mean PM10 particles in micrograms per cube metre
     * @return DAQI for given PM10 level (and -1 if PM10 is not N/A)
     */
    public static int getPM10DAQI(double pm10) {
        if (pm10 < 0 || pm10 == AirQuality.NA) {
            return -1;
        } else if (pm10 <= 16) {
            return 1;
        } else if (pm10 <= 33) {
            return 2;
        } else if (pm10 <= 50) {
            return 3;
        } else if (pm10 <= 58) {
            return 4;
        } else if (pm10 <= 66) {
            return 5;
        } else if (pm10 <= 75) {
            return 6;
        } else if (pm10 <= 83) {
            return 7;
        } else if (pm10 <= 91) {
            return 8;
        } else if (pm10 <= 100) {
            return 9;
        } else {
            return 10;
        }
    }
}
