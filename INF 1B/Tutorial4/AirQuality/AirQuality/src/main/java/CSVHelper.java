import com.opencsv.ICSVParser;
import com.opencsv.bean.*;
import com.opencsv.bean.processor.PreAssignmentProcessor;
import com.opencsv.bean.processor.StringProcessor;
import com.opencsv.exceptions.CsvException;
import com.opencsv.exceptions.CsvRequiredFieldEmptyException;
import org.apache.commons.collections4.MultiValuedMap;

import java.io.FileReader;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;
import java.util.stream.Stream;

/**
 * CSVHelper contains functionality for reading data from CSV files
 * You can ignore the contents of this class for this tutorial
 * They are beyond the scope of what we have learned so far
 *
 * But if you are interested, take a look at http://opencsv.sourceforge.net/index.html ;)
 */
class CSVHelper {
    public static class NoDataHandler implements StringProcessor {
        String defaultValue;

        @Override
        public String processString(String value) {
            if (value == null) {
                return defaultValue;
            }

            String clean = value.trim();
            if (clean.isEmpty() || clean.equals("No data")) {
                return defaultValue;
            }

            return value;
        }

        @Override
        public void setParameterString(String value) {
            defaultValue = value;
        }
    }

    public static class DataRow {
        @CsvBindByName(column = "Date")
        @CsvDate("yyyy-MM-dd")
        public LocalDate date;

        @CsvBindByName(column = "Time")
        @CsvDate("HH:mm:ss")
        public LocalTime time;

        @PreAssignmentProcessor(processor = NoDataHandler.class, paramString = "-1")
        @CsvBindByName(column = "\"Ozone\"", locale = "en-UK")
        public Double ozone;

        @PreAssignmentProcessor(processor = NoDataHandler.class, paramString = "-1")
        @CsvBindByName(column = "\"Nitrogen dioxide\"", locale = "en-UK")
        public Double nitrogenDioxide;

        @PreAssignmentProcessor(processor = NoDataHandler.class, paramString = "-1")
        @CsvBindByName(column = "\"Sulphur dioxide\"", locale = "en-UK")
        public Double sulphurDioxide;

        @PreAssignmentProcessor(processor = NoDataHandler.class, paramString = "-1")
        @CsvBindByName(column = "\"PM2.5 particulate matter (Hourly measured)\"", locale = "en-UK")
        public Double pm25;

        @PreAssignmentProcessor(processor = NoDataHandler.class, paramString = "-1")
        @CsvBindByName(column = "\"PM10 particulate matter (Hourly measured)\"", locale = "en-UK")
        public Double pm10;

        @CsvBindAndJoinByName(column = ".*", elementType = String.class)
        public MultiValuedMap<String, String> otherData;

        @Override
        public String toString() {
            if (date != null && time != null) {
                return "[Data for " + date + " " + time + "]:"
                        + " O3 = " + ozone
                        + " NO2 = " + nitrogenDioxide
                        + " SO2 = " + sulphurDioxide
                        + " PM2.5 = " + pm25
                        + " PM10 = " + pm10;
            } else {
                return "[Corrupted data]";
            }
        }
    }

    private static class AirDataMapping<T> extends HeaderColumnNameMappingStrategy<T> {
        @Override
        public void verifyLineLength(int numberOfFields) throws CsvRequiredFieldEmptyException {
            if(!headerIndex.isEmpty()) {
                // if there are fewer fields than in the header, that's fine
                if (numberOfFields > headerIndex.getHeaderIndexLength()) {
                    throw new CsvRequiredFieldEmptyException(type, ResourceBundle
                            .getBundle(ICSVParser.DEFAULT_BUNDLE_NAME, errorLocale)
                            .getString("header.data.mismatch"));
                }
            }
        }
    }

    static DataRow[] readData(String filename) throws IOException {
        MappingStrategy<DataRow> strategy = new AirDataMapping<>();
        strategy.setType(DataRow.class);

        CsvToBean<DataRow> beans = new CsvToBeanBuilder<DataRow>(new FileReader(filename))
                .withSeparator(',')
                .withQuoteChar('\'')
                .withSkipLines(4)
                .withMappingStrategy(strategy)
                .build();
        beans.setThrowExceptions(false);

        Stream<DataRow> rows = beans.stream();

        List<CsvException> es = beans.getCapturedExceptions();
        for (CsvException e : es) {
            Throwable cause = e.getCause();
            System.err.println("Warning: exception while reading data: " + cause.getMessage() + "\n"
                    + "-> " + Arrays.toString(e.getLine()));
        }

        return rows.toArray(DataRow[]::new);
    }
}
