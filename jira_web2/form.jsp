

<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.servlet.ServletRequest" %>
<%@ page import="com.sun.jersey.core.util.*" %>
<%@ page import="org.json.*" %>
<%@ page import="com.sun.jersey.api.client.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.nio.charset.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
	<body>
		<% 
      String title = request.getParameter("title");
      String comment = request.getParameter("message");
      String from = request.getParameter("email");

      String domainName = "form1.atlassian.net";
      String url = "https://" + domainName + "/rest/api/latest/issue/";
      String username = "hamnamtk@gmail.com";
      String password = "rEDw1IsN51zV2fSKF6lJ2C75";
      String strPath = "./webapps/jira_web2/log.txt";
      
      /*String url = "https://maneims.atlassian.net/rest/api/latest/issue/";
      String username = "Rijas.Abdu@mannai.com.qa";
      String password = "v0KZsUi0mCfZia24mck52061";*/
      
      comment = comment + " (Reported by : " + from + ")";
      Client client = Client.create();
      WebResource webresource = client.resource(url);
      String data = "{\"fields\":{\"project\":{\"key\":\"ITSAMPLE\"},\"summary\":\"" + title + "\",\"issuetype\":{\"name\":\"Task\"},\"description\":\""+ comment + "\"}}";
      String auth = new String(Base64.encode(username + ":" + password));
      ClientResponse res = webresource.header("Authorization", "Basic " + auth).type("application/json").accept("application/json").post(ClientResponse.class,data);
      String output = res.getEntity(String.class);
      //System.out.println(output);
      
      int code = response.getStatus();
      
      //Logger log = Logger.getLogger("hamna");
      //log.info("hello");
      
      
      File strFile = new File(strPath);
      //boolean fileCreated = strFile.createNewFile();
      Date date = new Date();

      
      FileWriter fileWritter = new FileWriter(strFile,true);
      BufferedWriter bw = new BufferedWriter(fileWritter);
      bw.write(date.toString() + " | " + title + " | " + comment + "\n");
      bw.close();
      
      if(code==200){
    	 out.print("<dialog open>Ticket sent successfully.</dialog>");
      }
      else{
    	  out.print("<dialog open>Ticket not sent. Please try again.</dialog>");
      }
      
     
        %>    
        <%-- <% Runtime.getRuntime().exec("java -jar C:/Program Files/Apache Software Foundation/Tomcat 10.0/lib/commons-fileupload-1.4.jar");
        
         %> --%>
        <%-- <%
        Logger log = Logger.getLogger("hamna");
        log.debug("Hello this is a debug message");
        log.info("Hello this is an info message"); 
        out.println("Here");
        %> --%>
        <%-- <% Logger log = Logger.getLogger(abc.class);
           log.debug("Show DEBUG message");
           log.info("Show INFO message");
           log.warn("Show WARN message");
           log.error("Show ERROR message");
           log.fatal("Show FATAL message"); %> --%>

        <!-- <p><%=title%> <%=from%> <%=comment%> </p> -->
	</body>
</html>