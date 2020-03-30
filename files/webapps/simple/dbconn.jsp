<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.NumberFormat"%>  
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.DriverManager"%> 
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.DataSource"%>  
<%!   
	private static String seconds(double l) {
		NumberFormat nf = new DecimalFormat("#.#####");
		return nf.format(l);
	}
%>
<%
double start = System.nanoTime();
//out.println("Start: " + start+" nano seconds"); 

String jndi_name=null;
String type=null;
String jdbc_class=null;
String jdbc_url=null;
String jdbc_user=null;
String jdbc_pw=null;
String sql_type=null;

ResultSet  rs   = null;
Connection conn = null;
Statement  stmt = null;
InitialContext ctx = null;
DataSource     ds=null; 

try{
	jndi_name=request.getParameter("jndi_name");
	type=request.getParameter("type");
	jdbc_class=request.getParameter("jdbc_class");
	jdbc_url=request.getParameter("jdbc_url");
	jdbc_user=request.getParameter("jdbc_user");
	jdbc_pw=request.getParameter("jdbc_pw");
	sql_type=request.getParameter("sql_type"); 


// 	System.out.println("===========" + type);
// 	System.out.println("===========" + jndi_name);
// 	System.out.println("===========" + jdbc_class);
// 	System.out.println("===========" + jdbc_url);
// 	System.out.println("===========" + jdbc_user);
// 	System.out.println("===========" + jdbc_pw);
// 	System.out.println("===========" + sql_type); 
	
}catch(Exception e){
	e.printStackTrace();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>database connection Test</title>
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
	</style>
</head>
<body topmargin="0"> 

<div id="container">
	<h1>Connection Pool Test Page</h1>

	<div id="body"> 
	<%
	String dsName ="";
	
	try{
		
		if(type.equals("jndi")){

		  //String dsName="java:/comp/env/"+jndi_name;
		  dsName=""+jndi_name;
			  
		  ctx    = new InitialContext(); 
		  ds     = (DataSource) ctx.lookup(dsName);
	  	  conn = ds.getConnection();

	   	  out.println("Connection Success =========== DS Name : " + dsName);  
	      out.println("<BR/>");
	   	  out.println("Connection Success =========== Connection : " + conn);
	   	  out.println("<BR/>");
			   
		} else if(type.equals("jdbc")){
	      Class.forName(jdbc_class);
	      conn = DriverManager.getConnection(jdbc_url,jdbc_user, jdbc_pw);

		  out.println("Connection Success =========== Driver : " + jdbc_class);
		  out.println("<BR/>");
		  out.println("Connection Success =========== Url : " + jdbc_url);
		  out.println("<BR/>");
		  out.println("Connection Success =========== User : " + jdbc_user);
		  out.println("<BR/>");
		  out.println("Connection Success =========== Password : " + jdbc_pw);
		  out.println("<BR/>");
		  out.println("Connection Success =========== Connection : " + conn);
		  out.println("<BR/>");
		}
		
       String sql = "";
		if(sql_type != null){ 
	       if ( sql_type == "mysql") {
	       	sql="select 1";
	       } else {
				sql="select 1 from dual";
	        }
			stmt = conn.createStatement();  
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int column_size=rsmd.getColumnCount();
	
			out.println("<div style='clear:both;'>- sql : "+sql+"</div>");
			
			out.println("<table style='background-color:#ccc;' cellpadding='5' cellspacing='1'>");
			out.println("<tr>");
			for(int i=1;i<=column_size;i++){ 
				out.println("<td style='height:25px;font-weight:bold;text-align:center;background-color:#fff'>");
				out.println(rsmd.getColumnName(i)); 
				out.println("</td>"); 
			}
			out.println("</tr>"); 
			
			int rs_size=0;
			while(rs.next()) {    
				out.println("<tr>");
				for(int i=1;i<=column_size;i++){ 
					out.println("<td style='background-color:#fff'>");
					out.println("<nobr>"+rs.getString(i)+"</nobr>"); 
					out.println("</td>"); 
				}
				out.println("</tr>");
				rs_size++;
			}
	 
			out.println("</table>");   
			out.println("<div style='clear:both;'> - "+rs_size+" rows is set</div>");
		}
		  
	}catch (NameNotFoundException e){
		//e.printStackTrace();
		out.println("<h1><font color=red>Can't Find JNDI Name - [ " + dsName + " ]</font></h1>");
		out.println("<h1><font color=red>JNDI Name을 확인하세요.</font></h1>");
		System.out.println("=======================================");
       System.out.println("Can't Find JNDI Name - [" + dsName + "]");
       System.out.println("=======================================");
	}catch (Exception e){
		e.printStackTrace();
       
	}finally{
	    try {
	    	if ( stmt != null){
	    		stmt.close();
	    	}
	    	if ( conn != null){
	    		conn.close();
	    	}
	       
	    } catch(Exception ex) {  
	       ex.printStackTrace();
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



