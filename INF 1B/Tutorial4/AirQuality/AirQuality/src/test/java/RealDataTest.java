import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class RealDataTest {
    // This runs before any test to load data from the specified file
    @BeforeEach
    public void setup() {
        RealData.analyseData("src/test/resources/TestAirData1.csv");
    }

    @Test
    public void testExistingDate1() {
        int output = RealData.getDateDAQI(1, 11, 2019);
        assertEquals(2, output);
    }
}
