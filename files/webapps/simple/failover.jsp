<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%> 
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

Integer ival = (Integer)session.getAttribute("simplesession.counter");

if (ival == null) 
  ival = new Integer(1);
else 
  ival = new Integer(ival.intValue() + 1);

session.setAttribute("simplesession.counter", ival);
System.out.println("[SessionTest] count = " + ival ); 

Integer cnt = (Integer)application.getAttribute("simplesession.hitcount");

if (cnt == null)
  cnt = new Integer(1);
else
  cnt = new Integer(cnt.intValue() + 1);

application.setAttribute("simplesession.hitcount", cnt); 
//System.out.println("[SessionTest] count = " + ival );

try{ 
}catch(Exception e){
	e.printStackTrace();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>database Session Failover Test</title>
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
	<h1>Session Failover Test Page13</h1>

	<div id="body"> 
		<p>Session info : </p>
		<div> JSESSIONID<font color=red>.JvmRoute</font> : <%=session.getId()%></div>
		<div> CREATION TIME : <%=session.getCreationTime()%></div>
		<div> TIMEOUT IN SEC : <%=session.getMaxInactiveInterval()%></div> 
		<div> IS New : <%=session.isNew()%></div> 
 		
		<div style="clear:both;"></div>
 		<p>Failover Test : </p>
 		<div id="colLine">   
			<div class="ddiv">
				<div style="text-align:center">
					You have hit this page <BR/><BR/> 
					<font color=red size=15> <%= ival %></font> time<%= (ival.intValue() == 1) ? "" : "s" %>, <BR/> 
					before the session times out.
				</div>
				<div style="text-align:center">
					 You have hit this page a total of <BR/><BR/> 
					 <font color=green size=15> <%= cnt %></font> time<%= (cnt.intValue() == 1) ? "" : "s" %>!
				</div>
			</div>
		</div> 
		<div style="clear:both;"></div>
				
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



