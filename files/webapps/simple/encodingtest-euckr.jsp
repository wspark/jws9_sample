<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%
        
    String first = null ;
    String word = null;
    
    if ( request.getParameter("data") != null )
    {
	    first = request.getParameter("data");
	    word = first;
	    
	    System.out.println("Default Encoding        : " + word);
	    
	     
	    System.out.println("utf-8 -> utf-8        : " + new String(word.getBytes("utf-8"), "utf-8"));
	    System.out.println("utf-8 -> euc-kr        : " + new String(word.getBytes("utf-8"), "euc-kr"));
	    System.out.println("utf-8 -> iso-8859-1    : " + new String(word.getBytes("utf-8"), "iso-8859-1"));
	    System.out.println("iso-8859-1 -> iso-8859-1        : " + new String(word.getBytes("iso-8859-1"), "iso-8859-1"));
	    System.out.println("iso-8859-1 -> euc-kr        : " + new String(word.getBytes("iso-8859-1"), "euc-kr"));
	    System.out.println("iso-8859-1 -> utf-8         : " + new String(word.getBytes("iso-8859-1"), "utf-8"));
	    System.out.println("euc-kr -> euc-kr         : " + new String(word.getBytes("euc-kr"), "euc-kr"));
	    System.out.println("euc-kr -> utf-8         : " + new String(word.getBytes("euc-kr"), "utf-8"));
	    System.out.println("euc-kr -> iso-8859-1    : " + new String(word.getBytes("euc-kr"), "iso-8859-1"));
	    
	    System.out.println("data:" + first); 
    } else first = "NULL";
    
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>encoding test result</title>
<script type="text/javascript">
	function send_by_post(){
		var frm=document.encoding;
		frm.method="post";
		frm.submit();
	}
	function send_by_get(){
		var frm=document.encoding;
		frm.method="get";
		frm.submit();
	}
</script>
</head>
<body>
<form name="encoding">
<table border="1" cellspacing="0" width="500">
  <tr>
    <th width="10%">구분</th><th width="25%">입력값</th>
  </tr>
  <tr>
      <td>Input Data</td>
      <td><input name="data"></td>
  </tr>
  <tr>
      <td colspan=2>
      		<input type="button" value="Send by Post" onclick="javascript:send_by_post()">
      		<input type="button" value="Send by Get" onclick="javascript:send_by_get()">
      </td>     
  </tr>
</table>
</form>
<br>
<br>
# Encoding Result
<br>
<%
    if ( first.equals("NULL"))
    {
	  out.println("입력값 : " + first);
    } else 
    {
        out.println("입력값 : " + first);
        out.println("<br><br>");
%>
    	<table border="1" cellspacing="0" width="800">
    	  <tr>
    	    <th width="10%">구분</th><th width="25%">결과값</th>
    	  </tr>
    	  <tr>
    	      <td>Default</td>
    	      <td>
    	      <%
    	        out.println(word);
    	      %>
    	      </td>
    	  </tr>
    	  <tr>
    	      <td>utf-8 -> utf-8</td>
    	      <td>
    	      <%
    	        out.println(new String(word.getBytes("utf-8"), "utf-8"));
    	      %>
    	      </td>
    	  </tr>
    	  <tr>
    	      <td>utf-8 -> euc-kr</td>
    	      <td>
    	      <%
    	        out.println(new String(word.getBytes("utf-8"), "euc-kr"));
    	      %>
    	      </td>
    	  </tr>
    	  <tr>
    	      <td>utf-8 -> iso-8859-1</td>
    	      <td>
    	      <%
    	      out.println(new String(word.getBytes("utf-8"), "iso-8859-1"));
    	      %>
    	      </td>
    	  </tr>
    	  <tr>
    	      <td>iso-8859-1 -> euc-kr</td>
    	      <td>
    	      <%
    	      out.println(new String(word.getBytes("iso-8859-1"), "euc-kr"));
    	      %>
    	      </td>
    	  </tr>
    	  <tr>
    	      <td>iso-8859-1 -> iso-8859-1</td>
    	      <td>
    	      <%
    	      out.println(new String(word.getBytes("iso-8859-1"), "iso-8859-1"));
    	      %>
    	      </td>
    	  </tr>

    	  <tr>
    	      <td>iso-8859-1 -> utf-8</td>
    	      <td>
    	      <%
    	      out.println(new String(word.getBytes("iso-8859-1"), "utf-8"));
    	      %>
    	      </td>
    	  </tr>
    	  <tr>
    	      <td>euc-kr -> euc-kr</td>
    	      <td>
    	      <%
    	      out.println(new String(word.getBytes("euc-kr"),"euc-kr"));
    	      %>
    	      </td>
    	  </tr>
    	  <tr>
    	      <td>euc-kr -> utf-8</td>
    	      <td>
    	      <%
    	      out.println(new String(word.getBytes("euc-kr"),"utf-8"));
    	      %>
    	      </td>
    	  </tr>

    	  <tr>
    	      <td>euc-kr -> iso-8859-1</td>
    	      <td>
    	      <%
    	      out.println(new String(word.getBytes("euc-kr"), "iso-8859-1"));
    	      %>
    	      </td>
    	  </tr>

    	</table>
<%
    }
%>
</form>
</body>
</html>