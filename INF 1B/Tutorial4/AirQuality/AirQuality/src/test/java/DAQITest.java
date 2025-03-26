import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class DAQITest {
    /* Ozone DAQI tests */
    @Test
    public void testOzoneDAQIPositive1() {
        double ozone = 25.0;
        int expectedDAQI = 1;
        assertEquals(expectedDAQI, DAQI.getOzoneDAQI(ozone));
    }

    @Test
    public void testOzoneDAQIPositive2() {
        double ozone = 200.0;
        int expectedDAQI = 8;
        assertEquals(expectedDAQI, DAQI.getOzoneDAQI(ozone));
    }

    @Test
    public void testOzoneDAQIZero() {
        assertEquals(1, DAQI.getOzoneDAQI(0));
    }

    @Test
    public void testOzoneDAQINA() {
        assertEquals(-1, DAQI.getOzoneDAQI(AirQuality.NA));
    }

    /* Nitrogen Dioxide DAQI tests */
    @Test
    public void testNitrogenDioxideDAQIPositive1() {
        assertEquals(2, DAQI.getNitrogenDioxideDAQI(130));
    }

    @Test
    public void testNitrogenDioxideDAQIPositive2() {
        assertEquals(5, DAQI.getNitrogenDioxideDAQI(300));
    }

    @Test
    public void testNitrogenDioxideDAQIZero() {
        assertEquals(1, DAQI.getNitrogenDioxideDAQI(0));
    }

    @Test
    public void testNitrogenDioxideDAQINegative() {
        assertEquals(-1, DAQI.getNitrogenDioxideDAQI(AirQuality.NA));
    }

    /* Sulphur Dioxide DAQI tests */
    @Test
    public void testSulphurDioxideDAQIPositive1() {
        assertEquals(1, DAQI.getSulphurDioxideDAQI(60));
    }

    @Test
    public void testSulphurDioxideDAQIPositive2() {
        assertEquals(6, DAQI.getSulphurDioxideDAQI(500));
    }

    @Test
    public void testSulphurDioxideDAQIZero() {
        assertEquals(1, DAQI.getSulphurDioxideDAQI(0));
    }

    @Test
    public void testSulphurDioxideDAQINegative() {
        assertEquals(-1, DAQI.getSulphurDioxideDAQI(AirQuality.NA));
    }

    /* PM2.5 DAQI tests */
    @Test
    public void testPM25DAQIPositive1() {
        assertEquals(2, DAQI.getPM25DAQI(25));
    }

    @Test
    public void testPM25DAQIPositive2() {
        assertEquals(5, DAQI.getPM25DAQI(47));
    }

    @Test
    public void testPM25DAQIZero() {
        assertEquals(7, DAQI.getPM25DAQI(0));
    }

    @Test
    public void testPM25DAQINegative() {
        assertEquals(22, DAQI.getPM25DAQI(AirQuality.NA));
    }

    /* PM10 DAQI tests */
    @Test
    public void testPM10DAQIPositive1() {
        assertEquals(2, DAQI.getPM10DAQI(30));
    }

    @Test
    public void testPM10DAQIPositive2() {
        assertEquals(3, DAQI.getPM25DAQI(50));
    }

    @Test
    public void testPM10DAQIZero() {
        assertEquals(1, DAQI.getPM10DAQI(0));
    }

    @Test
    public void testPM10DAQINegative() {
        assertEquals(-1, DAQI.getPM10DAQI(AirQuality.NA));
    }
}
