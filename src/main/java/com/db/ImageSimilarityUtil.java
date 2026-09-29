package com.db;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class ImageSimilarityUtil {

    public static double compareImages(String img1, String img2) {

        try {

            String basePath =
                    System.getProperty("catalina.base")
                    + File.separator + "wtpwebapps"
                    + File.separator + "SmartLostAndFound"
                    + File.separator + "uploads"
                    + File.separator;

            BufferedImage image1 =
                    ImageIO.read(new File(basePath + img1));

            BufferedImage image2 =
                    ImageIO.read(new File(basePath + img2));

            if(image1 == null || image2 == null){
                return 0;
            }

            BufferedImage imgA = resize(image1,200,200);
            BufferedImage imgB = resize(image2,200,200);

            double grayScore =
                    grayscaleSimilarity(imgA,imgB);

            double colorScore =
                    colorSimilarity(imgA,imgB);

            double edgeScore =
                    sobelEdgeSimilarity(imgA,imgB);

            double histScore =
                    histogramSimilarity(imgA,imgB);

            double finalScore =
                    (grayScore * 0.25)
                  + (colorScore * 0.25)
                  + (edgeScore * 0.25)
                  + (histScore * 0.25);

            System.out.println(
            "Gray = "+grayScore+
            " Color = "+colorScore+
            " Edge = "+edgeScore+
            " Hist = "+histScore+
            " Final = "+finalScore);

            return finalScore;

        }
        catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    private static BufferedImage resize(
            BufferedImage img,
            int w,
            int h){

        Image tmp =
                img.getScaledInstance(
                        w,h,
                        Image.SCALE_SMOOTH);

        BufferedImage resized =
                new BufferedImage(
                        w,h,
                        BufferedImage.TYPE_INT_RGB);

        Graphics2D g2 =
                resized.createGraphics();

        g2.drawImage(tmp,0,0,null);
        g2.dispose();

        return resized;
    }

    /* grayscale comparison */
    private static double grayscaleSimilarity(
            BufferedImage a,
            BufferedImage b){

        long diff = 0;

        for(int y=0;y<a.getHeight();y++){
            for(int x=0;x<a.getWidth();x++){

                int rgb1 = a.getRGB(x,y);
                int rgb2 = b.getRGB(x,y);

                int gray1 =
                (
                ((rgb1>>16)&0xff)
                + ((rgb1>>8)&0xff)
                + (rgb1&0xff)
                )/3;

                int gray2 =
                (
                ((rgb2>>16)&0xff)
                + ((rgb2>>8)&0xff)
                + (rgb2&0xff)
                )/3;

                diff += Math.abs(gray1-gray2);
            }
        }

        double maxDiff =
                a.getWidth()*a.getHeight()*255;

        return 1.0 - diff/maxDiff;
    }

    /* color comparison */
    private static double colorSimilarity(
            BufferedImage a,
            BufferedImage b){

        long diff = 0;

        for(int y=0;y<a.getHeight();y++){
            for(int x=0;x<a.getWidth();x++){

                int rgb1 = a.getRGB(x,y);
                int rgb2 = b.getRGB(x,y);

                int r1=(rgb1>>16)&0xff;
                int g1=(rgb1>>8)&0xff;
                int b1=rgb1&0xff;

                int r2=(rgb2>>16)&0xff;
                int g2=(rgb2>>8)&0xff;
                int b2=rgb2&0xff;

                diff += Math.abs(r1-r2);
                diff += Math.abs(g1-g2);
                diff += Math.abs(b1-b2);
            }
        }

        double maxDiff =
                a.getWidth()*a.getHeight()*3*255;

        return 1.0 - diff/maxDiff;
    }

    /* histogram comparison */
    private static double histogramSimilarity(
            BufferedImage a,
            BufferedImage b){

        int[] histA = new int[256];
        int[] histB = new int[256];

        for(int y=0;y<a.getHeight();y++){
            for(int x=0;x<a.getWidth();x++){

                int rgb1 = a.getRGB(x,y);
                int rgb2 = b.getRGB(x,y);

                int gray1 =
                (
                ((rgb1>>16)&0xff)
                + ((rgb1>>8)&0xff)
                + (rgb1&0xff)
                )/3;

                int gray2 =
                (
                ((rgb2>>16)&0xff)
                + ((rgb2>>8)&0xff)
                + (rgb2&0xff)
                )/3;

                histA[gray1]++;
                histB[gray2]++;
            }
        }

        double diff = 0;

        for(int i=0;i<256;i++){
            diff += Math.abs(histA[i]-histB[i]);
        }

        double maxDiff =
                a.getWidth()*a.getHeight();

        return 1.0 - diff/maxDiff;
    }

    /* Sobel edge similarity */
    private static double sobelEdgeSimilarity(
            BufferedImage a,
            BufferedImage b){

        int[][] sobelX = {
                {-1,0,1},
                {-2,0,2},
                {-1,0,1}
        };

        int[][] sobelY = {
                {-1,-2,-1},
                {0,0,0},
                {1,2,1}
        };

        long diff = 0;

        for(int y=1;y<a.getHeight()-1;y++){
            for(int x=1;x<a.getWidth()-1;x++){

                int edgeA = sobelPixel(a,x,y,sobelX,sobelY);
                int edgeB = sobelPixel(b,x,y,sobelX,sobelY);

                diff += Math.abs(edgeA-edgeB);
            }
        }

        double maxDiff =
                a.getWidth()*a.getHeight()*255;

        return 1.0 - diff/maxDiff;
    }

    private static int sobelPixel(
            BufferedImage img,
            int x,
            int y,
            int[][] sx,
            int[][] sy){

        int gx=0;
        int gy=0;

        for(int j=-1;j<=1;j++){
            for(int i=-1;i<=1;i++){

                int rgb =
                img.getRGB(x+i,y+j);

                int gray =
                (
                ((rgb>>16)&0xff)
                + ((rgb>>8)&0xff)
                + (rgb&0xff)
                )/3;

                gx += gray * sx[j+1][i+1];
                gy += gray * sy[j+1][i+1];
            }
        }

        return (int)Math.sqrt(gx*gx + gy*gy);
    }
}