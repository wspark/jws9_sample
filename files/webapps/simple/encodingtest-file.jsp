<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*" %>

<!-- 
Encoding 확인방법
1. 실행옵션에 -Dfile.encoding=euc-kr 또는 utf-8 추가
2. FileOutputStream 생성시 인코딩 지정
2. jsp파일의 인코딩을 생성할 파일의 인코딩으로 맞춘다.
3. 생성된 파일 확인 시 쉘에서 LANG설정을 맞추어 변경한다. (LANG=ko_KR.euckr 또는 LANG=ko_KR.utf8)
4. 터미널 인코딩을 맞춘다.
 -->

<%
        
    String first = null ;
    String word = null;
    String filename = "/tmp/test.txt";
    
    if ( request.getParameter("data") != null )
    {
	    first = request.getParameter("data");
	    word = first;
	    
	    System.out.println("Default Encoding        : " + word);
	    
	    try {
				File fileDir = new File(filename);
					
				//Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileDir), "UTF8"));
				//Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileDir), "EUC_KR"));
				// 지정하지 않으면 -Dfile.encoding 값을 따름
				Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileDir)));
				
				writer.append("한글------------------------").append("\r\n");
				writer.append(word).append("\r\n");
				writer.append("iso-8859-1 => euc-kr : ").append(new String(word.getBytes("iso-8859-1"), "euc-kr")).append("\r\n");
				writer.append("iso-8859-1 => utf-8 : ").append(new String(word.getBytes("iso-8859-1"), "utf-8")).append("\r\n");
				writer.append("utf-8 => utf-8 : ").append(new String(word.getBytes("utf-8"), "utf-8")).append("\r\n");
				writer.append("euc-kr => euc-kr : ").append(new String(word.getBytes("euc-kr"), "euc-kr")).append("\r\n");
				
				writer.flush();
				writer.close();
		        
		    } 
		   catch (UnsupportedEncodingException e) 
		   {
			System.out.println(e.getMessage());
		   } 
		   catch (IOException e) 
		   {
			System.out.println(e.getMessage());
		    }
		   catch (Exception e)
		   {
			System.out.println(e.getMessage());
		   } 
	    
    } else first = "NULL";
    
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
    if ( first.equals("NULL")) {
	  	out.println("입력값 : " + first);
    } else {
        out.println("입력값 : " + first);
        out.println("<br><br>");
%>
    	<table border="1" cellspacing="0" width="800">
    	  <tr>
    	    <th width="10%">구분</th><th width="25%">결과값</th>
    	  </tr>
    	  <tr>
    	      <td>File</td>
    	      <td> <% out.println(filename); %></td>
    	  </tr>
 
    	  
    	</table>
<%
    }
%>

</body>
</html>