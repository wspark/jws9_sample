<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.lang.management.*" %>
<%@ page import="java.util.*" %>




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>JVM Options</title>

</head>
<body>


    	<table border="1" cellspacing="0" width="800">
    	  <tr>
    	    <th width="10%">구분</th><th width="25%">결과값</th>
    	  </tr>
    	  <%
        
RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
List<String> jvmArgs = runtimeMXBean.getInputArguments();
for (String arg : jvmArgs) {
    System.out.println(arg);
  
%>
    	  <tr>
    	      <td></td>
    	      <td> <%=arg%></td>
    	  </tr>
    	  
<%

}
    
%>
    	  
    	</table>
</body>
</html>