package com.db;

import java.util.*;

public class TextSimilarityUtil {

    public static double similarity(String s1, String s2) {

        if(s1 == null || s2 == null)
            return 0;

        s1 = cleanText(s1);
        s2 = cleanText(s2);

        Set<String> words1 =
                new HashSet<>(
                Arrays.asList(
                s1.split("\\s+")));

        Set<String> words2 =
                new HashSet<>(
                Arrays.asList(
                s2.split("\\s+")));

        int match = 0;

        for(String w : words1){
            if(words2.contains(w)){
                match++;
            }
        }

        int totalWords =
                Math.max(words1.size(),
                         words2.size());

        return (double) match / totalWords;
    }

    private static String cleanText(String text){

        text = text.toLowerCase();

        text = text.replaceAll(
                "[^a-z0-9 ]",
                " ");

        text = text.replaceAll(
                "\\s+",
                " ").trim();

        return text;
    }
}