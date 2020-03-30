<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.NumberFormat"%>  
<%! 
  private int totalHits = 0;

  private static String seconds(double l) {
	NumberFormat nf = new DecimalFormat("#.#####");
	return nf.format(l);
  }
%> 
<%
double start = System.nanoTime();
//out.println("Start: " + start+" nano seconds"); 
session = request.getSession(true);
 
String SESSION_ID=null;
String SESSION_VALUE=null;
String type=null;
try{ 
	SESSION_ID=request.getParameter("session_id");
	SESSION_VALUE=request.getParameter("session_value");
	type=request.getParameter("type"); 

// 	System.out.println("=========== SESSION_ID : " + SESSION_ID);
// 	System.out.println("=========== SESSION_VALUE : " + SESSION_VALUE);
// 	System.out.println("=========== type : " + type);
}catch(Exception e){
	e.printStackTrace();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Session Test</title>
<style type="text/css">

	::selection{ background-color: #E13300; color: white; }
	::moz-selection{ background-color: #E13300; color: white; }
	::webkit-selection{ background-color: #E13300; color: white; }

	body {
		background-color: #fff;
		margin: 40px;
		font: 13px/20px normal Helvetica, Arial, sans-serif;
		color: #4F5155; 
	}

	a {
		color: #003399;
		background-color: transparent;
		font-weight: normal;
	}

	h1 {
		color: #444;
		background-color: transparent;
		border-bottom: 1px solid #D0D0D0;
		font-size: 19px;
		font-weight: normal;
		margin: 0 0 14px 0;
		padding: 14px 15px 10px 15px;
	}

	code {
		font-family: Consolas, Monaco, Courier New, Courier, monospace;
		font-size: 12px;
		background-color: #f9f9f9;
		border: 1px solid #D0D0D0;
		color: #002166;
		display: block;
		margin: 14px 0 14px 0;
		padding: 12px 10px 12px 10px;
	}

	#body{
		margin: 0 15px 0 15px;
	}
	
	p.footer{
		text-align: right;
		font-size: 11px;
		border-top: 1px solid #D0D0D0;
		line-height: 32px;
		padding: 0 10px 0 10px;
		margin: 20px 0 0 0;
	} 
	
	#container{
		margin: 10px;
		border: 1px solid #D0D0D0;
		-webkit-box-shadow: 0 0 8px #D0D0D0;
	}
	#colLine {
	 float:left;
	 border-top:1px solid #cccccc;
	 border-left:1px solid #cccccc; 
	}
	#colLine .ddiv
	{
	 clear:both;
	}
	#colLine .ddiv div {
	 float:left;
	 border-right:1px solid #cccccc;
	 border-bottom:1px solid #cccccc;
	 height:100px;
	 width:300px; 
	} 
	</style>
</head>
<body topmargin="0"> 

<div id="container">
	<h1>Session Test Page</h1>

	<div id="body"> 
	<%  
	session = request.getSession(true);
	
	try{ 
		if(type.equals("create")){ 
			session.setAttribute(SESSION_ID, SESSION_VALUE); 
			String path="./session.jsp?type=view&session_id="+SESSION_ID;
			//request.sendRedirect(path);
			out.println("<script>");
			out.println("location.href='"+path+"'");
			out.println("</script>");
		}else if(type.equals("view")){  
			out.println("Create Session Success =========== ");
			out.println("<BR>SESSION ID: " + SESSION_ID);
			out.println("<BR>SESSION VALUE: " + session.getAttribute(SESSION_ID)); 
			out.println("<BR>CREATION TIME: " + session.getCreationTime());
			out.println("<BR>TIMEOUT IN SEC: " + session.getMaxInactiveInterval());
			//out.println("<BR>IS New: " + session.isNew()); 
		} 
	}catch (Exception e){
		//e.printStackTrace();
        System.out.println("- Could not Control Session");
		out.println(e.toString());
	}finally{
	    try { 
	    } catch(Exception ex) {  
	        System.out.println("- Could not close the statement and connection");
	        System.out.println("- Exception: " + ex.toString()); 
	       //ex.printStackTrace();
	     }
	}
	%>
		
				
	</div>

<%  
double end = System.nanoTime();  
double elapsedTime = (end - start)/1000000000; 
//out.println("End  : " + end+" nano seconds");
//out.println("The process took approximately: " + elapsedTime + " nano seconds");
%>

<p class="footer">Page rendered in <strong><%=seconds(elapsedTime)%></strong> seconds</p>
</div>
  

</body>
</html>



