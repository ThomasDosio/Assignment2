import java.io.IOException;
import java.time.LocalDate;

/**
 * Class for working with UK AIR data
 */
public class RealData {
    private static CSVHelper.DataRow[] data;

    /**
     * analyseData reads a CSV file and stores the results in the data array
     * @param dataFilePath file to read
     */
    public static void analyseData(String dataFilePath) {
        try {
            data = CSVHelper.readData(dataFilePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * getDateDAQI returns the Daily Air Quality Index for a given date.
     * When multiple data points for the date are available, return the highest DAQI throughout the day.
     * @param day
     * @param month
     * @param year
     * @return DAQI for the given date
     */
    public static int getDateDAQI(int day, int month, int year) {
        if (data == null || data.length == 0) {
            throw new RuntimeException("Must populate data by calling analyseData() first!");
        }

        LocalDate date = LocalDate.of(year, month, day);

        // TODO: implement this

        for (CSVHelper.DataRow row : data) {
            // each row has these fields:
            // row.date
            // row.time;
            // row.ozone;
            // row.nitrogenDioxide
            // row.sulphurDioxide;
            // row.pm25;
            // row.pm10;
            System.out.println(row);
            // some rows are created from invalid data - these list warnings when the file is parsed
            // for invalid rows, row.date and row.time are null
        }

        return 1;
    }
}
