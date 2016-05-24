package com.cloudasset.api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Random;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet implementation class PaymentCreate
 */
public class PaymentCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PaymentCreate() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	  	//String url = "http://119.160.221.121:3210/ecom/invoices/";
		String url = "http://10.144.97.193:3000/ecom/invoices/";
		
		String responseJson = null;
		String json = null;
		 
	     try {
	    	 
			BufferedReader br = new BufferedReader(new  InputStreamReader(request.getInputStream()));
		    if(br != null){
		        json = br.readLine();
		    }
		    System.out.println(json);
			    
		    HttpClient httpClient = HttpClientBuilder.create().build();
			HttpPost postRequest = new HttpPost(url);
			postRequest.addHeader("Accept", "application/json");
			StringEntity input = new StringEntity(json);
			input.setContentType("application/json");
			postRequest.setEntity(input);
			HttpResponse response1 = httpClient.execute(postRequest);
			BufferedReader rd = new BufferedReader(new InputStreamReader(response1.getEntity().getContent()));
	        String line  = "";
            if(response1.getStatusLine().getStatusCode() == 201){
	            while ((line = rd.readLine()) != null) {
            	    JSONParser j = new JSONParser();
	                JSONObject o = (JSONObject)j.parse(line);
	            	HttpSession session = request.getSession();
					session.setAttribute("payment_json_response", line);
					session.setAttribute("payment_token", (String)o.get("payment_token"));
					session.setMaxInactiveInterval(30*60);
	            }
            }else{
            	String errorLine = "";
            	StringBuffer errorLineBu = new StringBuffer();
                while ((errorLine = rd.readLine()) != null) {
                	errorLineBu.append(errorLine);
                }
            	HttpSession session = request.getSession();
				session.setAttribute("payment_json_response", "Status Code : "+response1.getStatusLine().getStatusCode()+" Error MEssage : "+errorLineBu.toString());
				session.setMaxInactiveInterval(30*60);
            }
		}catch (Exception e) {
				e.printStackTrace();
				HttpSession session = request.getSession();
				session.setAttribute("payment_json_response", " Error Occured  : "+e.getMessage());
				session.setMaxInactiveInterval(30*60);
	    }finally{
	    	   responseJson ="{\"status\":\"success\"}";
	    }
		
	 	response.setContentType("application/json");
		response.getWriter().write(responseJson);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
