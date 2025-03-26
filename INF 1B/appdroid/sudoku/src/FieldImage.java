import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class FieldImage {
    private static BufferedImage cow, football, house, keanu, rain, rudolph, sun, superwoman, tree;

    static {
        try {
            String prefixPath = "res/";

            cow = ImageIO.read(new File(prefixPath + "cow.png"));
            football = ImageIO.read(new File(prefixPath + "football.png"));
            house = ImageIO.read(new File(prefixPath + "house.png"));
            keanu = ImageIO.read(new File(prefixPath + "keanu.png"));
            rain = ImageIO.read(new File(prefixPath + "rain.png"));
            rudolph = ImageIO.read(new File(prefixPath + "rudolph.png"));
            sun = ImageIO.read(new File(prefixPath + "sun.png"));
            superwoman = ImageIO.read(new File(prefixPath + "superwoman.png"));
            tree = ImageIO.read(new File(prefixPath + "tree.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    static ImageIcon[] icons = new ImageIcon[] {
        new StretchIcon(sun),
        new StretchIcon(cow),
        new StretchIcon(football),
        new StretchIcon(house),
        new StretchIcon(keanu),
        new StretchIcon(rain),
        new StretchIcon(rudolph),
        new StretchIcon(superwoman),
        new StretchIcon(tree)
    };
}
