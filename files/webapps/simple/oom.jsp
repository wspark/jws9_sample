<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap" %>
   <%
    
   HashMap<String,String> leakMap = new HashMap<String,String>();
   String STORE_DATA="TestDataTestDataTestDataTestDataTestDataTestData";
   StringBuffer sb = new StringBuffer();
    
    
    System.out.println("[[[[[ Making OutOfMemory...]]]]]");
    System.out.println("initial : " + Runtime.getRuntime().freeMemory() / (1024 * 1024) + " MB bytes free!");
    //int mapSize=leakMap.size();
     
     
    int maxCount=5000000;
    for(int loop=0;loop<maxCount;loop++){
        leakMap.put(STORE_DATA+loop, STORE_DATA+loop*5);
        sb.append(STORE_DATA);
        System.out.println("Free Memory : " + Runtime.getRuntime().freeMemory() / (1024 * 1024) + " MB bytes");
    }
     
 %>
