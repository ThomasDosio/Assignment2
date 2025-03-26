import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class AirQualityTest {
    @Test
    public void testSampleData1() {
        double ozone = 10;
        double nitrogenDioxide = 10;
        double sulphurDioxide = 10;
        double pm25 = 10;
        double pm10 = 10;

        int expectedDAQI = 1;
        int outputDAQI = AirQuality.getDAQI(ozone, nitrogenDioxide, sulphurDioxide, pm25, pm10);
        assertEquals(expectedDAQI, outputDAQI);
    }

    @Test
    public void testSampleData2() {
        // Ozone = 200 should give DAQI level 8
        // the rest should all give DAQI level 1
        // The highest should be chosen, therefore expected output is 8
        int output = AirQuality.getDAQI(200, 10, 10, 10, 10);
        assertEquals(8, output);
    }

    @Test
    public void testSampleData3() {
        // O3    = 30  -> DAQI 1
        // NO2   = 70  -> DAQI 2
        // SO2   = 199 -> DAQI 3
        // PM2.5 = 40  -> DAQI 4
        // PM10  = 66  -> DAQI 5
        // expected DAQI = 5
        int output = AirQuality.getDAQI(30, 70, 199, 40, 66);
        int expected = 5;
        assertEquals(expected, output);
    }

    @Test
    public void testSampleData4() {
        // Test with data from Edinburgh St Leonards Street sensor at 11:00 on 11/11/2019
        assertEquals(2, AirQuality.getDAQI(50, 3, 9, 4, 6));
    }

    @Test
    public void testPartialSampleData1() {
        double ozone = 55; // DAQI = 2
        double nitrogenDioxide = AirQuality.NA;
        double sulphurDioxide = AirQuality.NA;
        double pm25 = 30; // DAQI = 3
        double pm10 = 15; // DAQI = 1
        // Overall DAQI is the highest from available data, overall DAQI = 3
        assertEquals(3, AirQuality.getDAQI(ozone, nitrogenDioxide, sulphurDioxide, pm25, pm10));
    }

    @Test
    public void testPartialSampleData2() {
        // Test with data from Edinburgh Nicolson Street sensor at 11:00 on 11/11/2019
        assertEquals(1, AirQuality.getDAQI(AirQuality.NA, 54, AirQuality.NA, AirQuality.NA, AirQuality.NA));
    }
}
