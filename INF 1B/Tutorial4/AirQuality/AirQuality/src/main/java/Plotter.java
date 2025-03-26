import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.XYPlot;
import org.jfree.data.time.Day;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import org.jfree.data.time.TimeSeriesDataItem;

import javax.swing.*;
import java.awt.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * Plotter - a class for plotting air quality data in a time-series chart
 * It uses the Java Swing library, which you do not need to know about for now.
 * However, to change what is plotted, the main method may need to change
 */
public class Plotter extends JFrame {
    public static class DataPoint {
        LocalDate date;
        int DAQI;
    }

    /**
     * The main entry point that is executed when you run the "Plot Data" configuration
     * @param args - not used
     */
    public static void main(String[] args) {
        // File to load data from
        RealData.analyseData("src/test/resources/TestAirData1.csv");
        // Start and end dates of the data points to plot
        LocalDate startDate = LocalDate.of(2019, 1, 1);
        LocalDate endDate = LocalDate.of(2019, 11, 11);
        int days = (int) startDate.until(endDate, ChronoUnit.DAYS);

        Plotter.DataPoint[] dataPoints = new Plotter.DataPoint[days + 1];

        for (int i = 0; i <= days; ++i) {
            Plotter.DataPoint point = new Plotter.DataPoint();
            point.date = startDate.plusDays(i);
            point.DAQI = RealData.getDateDAQI(point.date.getDayOfMonth(), point.date.getMonthValue(), point.date.getYear());
            dataPoints[i] = point;
        }

        // Create a graphical window and display the graph
        SwingUtilities.invokeLater(() -> {
            Plotter plotter = new Plotter();
            plotter.addData(dataPoints);
        });
    }

    private static final long serialVersionUID = 1L;
    private TimeSeriesCollection dataset;

    private Plotter() {
        // create a window
        super("Air Quality Data Plotter");
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setVisible(true);
        setLocationRelativeTo(null);
        setSize(800, 400);

        // create a new chart
        dataset = new TimeSeriesCollection();
        // Chart
        // X-Axis Label
        // Y-Axis Label
        JFreeChart chart = ChartFactory.createTimeSeriesChart(
                "Air Quality Data Plot", // Chart
                "Day", // X-Axis Label
                "DAQI", // Y-Axis Label
                dataset);

        // change the chart background color
        XYPlot plot = (XYPlot) chart.getPlot();
        plot.setBackgroundPaint(new Color(255,228,196));
        plot.getRangeAxis().setRange(0, 10);
        plot.getRangeAxis().setAutoTickUnitSelection(false);

        // display the chart in the window
        ChartPanel panel = new ChartPanel(chart);
        setContentPane(panel);
    }

    private void addData(DataPoint[] points) {
        TimeSeries timeSeries = new TimeSeries("Edinburgh air quality");

        for (DataPoint point : points) {
            Day day = new Day(point.date.getDayOfMonth(), point.date.getMonthValue(), point.date.getYear());
            TimeSeriesDataItem item = new TimeSeriesDataItem(day, point.DAQI);
            timeSeries.add(item);
        }

        dataset.addSeries(timeSeries);
    }
}
