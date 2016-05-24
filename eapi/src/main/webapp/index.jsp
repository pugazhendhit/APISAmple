<!DOCTYPE html>

<!--[if lte IE 9]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 9]><!-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

 <%
	if (request.getParameter("uuid") != null) {
	 	 session.setAttribute("payment_landing",request.getParameter("uuid"));
	 }
	 
    String redirect_url = "http://119.160.221.121:3210/ecom/payments/"+(String)session.getAttribute("payment_token");
 
    String payment_status= (String)session.getAttribute("payment_status");
    if(payment_status == null){
    	payment_status = "";
	}
    
    String payment_landing = (String)session.getAttribute("payment_landing");
    if(payment_landing == null){
    	payment_landing = "";
	}else{
		payment_landing = "UUID - "+payment_landing;
	}
    
    String customer_response = (String)session.getAttribute("customer_json_response");
	if(customer_response == null){
		 customer_response = "";
	}

    String payment_response = (String)session.getAttribute("payment_json_response");
	if(payment_response == null){
		payment_response = "";
	}
	 
    String  customer_data = (String)session.getAttribute("customer_json");
	if (customer_data == null) {
	    String customer_json = "{\"secret_token\":\"abc123\",\"email\":\"ktb@gmail.com\",\"name\":\"ktb\"}";
	    session.setAttribute("customer_json",customer_json);
	    customer_data = (String)session.getAttribute("customer_json");
	}
	
	String  customer_id = (String)session.getAttribute("customer_id");
	String  payment_data = (String)session.getAttribute("payment_json");
	
	if (payment_data == null && customer_id == null ) {
		 String payment_json = "{\"secret_token\":\"abc123\",\"amount\":\"250.00\",\"currency\":\"THB\",\"collect_addresses\":\"0\",\"status_url\":\"http://10.144.97.193:3000/eapi/Status?uuid=1530b1c4-7e21-464b-8078-c41afd9d24d5\",\"landing_url\":\"http://119.160.221.121:3080/eapi/index.jsp?uuid=1530b1c4-7e21-464b-8078-c41afd9d24d5\"}";
		 session.setAttribute("payment_json",payment_json);
		 payment_data = (String)session.getAttribute("payment_json");
	}else if (customer_id != null){
		 String payment_json = "{\"secret_token\":\"abc123\",\"amount\":\"250.00\",\"currency\":\"THB\",\"customer_id\":\""+customer_id+"\",\"collect_addresses\":\"0\",\"status_url\":\"http://10.144.97.193:3000/eapi/Status?uuid=1530b1c4-7e21-464b-8078-c41afd9d24d5\",\"landing_url\":\"http://119.160.221.121:3080/eapi/index.jsp?uuid=1530b1c4-7e21-464b-8078-c41afd9d24d5\"}";
		 session.setAttribute("payment_json",payment_json);
		 payment_data = (String)session.getAttribute("payment_json");
	}
%>

<html class="no-js">
<meta charset="utf-8">
<title>API Sample</title>
<!--=================================
Meta tags
=================================-->
<meta name="description" content="">
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta name="viewport" content="minimum-scale=1.0, width=device-width, maximum-scale=1, user-scalable=no" />
<!--=================================
Style Sheets
=================================-->
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700,600' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="assets/css/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="assets/css/flags.css">
<link rel="stylesheet" href="assets/css/main.css">
<body>
<main id="pageContentArea">

 <div class="blog-main-slider color-white text-center" style="background-image:url('assets/img/b17.jpg'); no-repeat">
        <div class="overlay"></div>
        <div class="container">
            <h2>CloudAsset Ecommerce API</h2>
        </div>
    </div>
    
	  <div class="container">
	        <div class="row">
	            <h3 class="textbox">Step 1: Customer Create (URL -> "http://119.160.221.121:3210/ecom/customers/") </h3>
	            <div class="col-lg-6 col-md-6 col-sm-12">
	                <div class="textbox-form">
	                    <h4 class="textbox-title">Request</h4>
	                    <textarea class="form-control" rows="3" id="step1RequestField"> <%=customer_data%></textarea> 
	                    <button id = "step1Click" class="btn btn-send btn-pink pull-right" onclick="step1Click">SEND</button>    
	                </div>
	            </div>
	
	            <div class="col-lg-6 col-md-6 col-sm-12">
	                <div class="textbox-form">
	                    <h4 class="textbox-title">Response</h4>
	                    <textarea class="form-control" rows="3"><%=customer_response%></textarea>
	                    <button id ="clear1Click" class="btn btn-send btn-pink pull-right">CLEAR</button>
	                </div>
	            </div>
	        </div>
	        
	         <div class="row">
	            <h3 class="textbox">Step 2: Payment Create (URL -> "http://119.160.221.121:3210/ecom/invoices/")</h3>
	            <div class="col-lg-6 col-md-6 col-sm-12">
	                <div class="textbox-form">
	                    <h4 class="textbox-title">Request</h4>
	                    <textarea class="form-control" rows="3" id="step2RequestField"><%=payment_data%></textarea> 
	                    <button id ="step2Click" class="btn btn-send btn-pink pull-right">SEND</button>    
	                </div>
	            </div>
	
	            <div class="col-lg-6 col-md-6 col-sm-12">
	                <div class="textbox-form">
	                    <h4 class="textbox-title">Response</h4>
	                    <textarea class="form-control" rows="3"><%=payment_response%></textarea>
	                    <button id ="clear2Click" class="btn btn-send btn-pink pull-right">CLEAR</button>
	                </div>
	            </div>
	        </div>
	        
	        <div class="row">
	            <h3 class="textbox">Step 3: Redirect To Payment Gateway</h3>
	            <div class="col-lg-6 col-md-6 col-sm-12">
	                <div class="textbox-form">
	                    <h4 class="textbox-title">Request</h4>
	                    <textarea class="form-control" rows="3" id="step3RequestField" ><%=redirect_url%></textarea> 
	                    <button id ="step3Click" class="btn btn-send btn-pink pull-right">REDIRECT</button>    
	                </div>
	            </div>
	        </div>
	        
	        <div class="row">
	            <h3 class="textbox">Step 4: Payment Execute Status</h3>
	            <div class="col-lg-6 col-md-6 col-sm-12">
	                <div class="textbox-form">
	                    <h4 class="textbox-title">Response</h4>
	                    <textarea class="form-control" rows="3" id="step4RequestField"><%=payment_status%></textarea> 
	                </div>
	            </div>
	        </div>
	        
	        <div class="row">
	            <h3 class="textbox">Step 5: Redirect to Merchant</h3>
	            <div class="col-lg-6 col-md-6 col-sm-12">
	                <div class="textbox-form">
	                    <h4 class="textbox-title">Response</h4>
	                    <textarea class="form-control" rows="3" id="step5RequestField"><%=payment_landing%></textarea> 
	                </div>
	            </div>
	        </div>
	        
	    </div>
    </main>
    
    <!--=================================
Script Source
=================================-->

<script src="assets/js/jquery.js"></script>
<script src="assets/js/jquery.easing-1.3.pack.js"></script>
<script src="assets/js/jquery.countdown.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>
<script src="assets/js/main.js"></script>
<script src='http://cdnjs.cloudflare.com/ajax/libs/zepto/1.0/zepto.min.js'></script>
<script src="https://code.jquery.com/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	  console.log("loading");  

	  var uuid = GetURLParameter('uuid');

	  if (uuid != null){
		 $.ajax({
			  url: "GetStatus?uuid="+uuid,
			  type: "post",
			  data: "",
			  contentType: "application/json",
			  dataType: 'json',
			  success: function(json) {
				  location = location.pathname;
				},
			  error:function(){
			  }   
		}); 
		}
			
	
	  $( "#step1Click" ).click(function() {
		  console.log("Value"); 
		  var json_data = document.getElementById('step1RequestField');
		  console.log(json_data.value); 
		  $("body").css("cursor", "progress");
		  $.ajax({
			  url: "CustomerCreate",
			  type: "post",
			  contentType: "application/json; charset=utf-8",
		      dataType: "json",
			  data: json_data.value,
			  success: function(json) {
				  $("body").css("cursor", "default");
				  location.reload();
				  console.log('success'); 
			  },
			  error:function(){
				  $("body").css("cursor", "default");
				  console.log('failed'); 
			  }  
			}); 
		});


	  $( "#step2Click" ).click(function() {
		  console.log("Value"); 
		  var json_data = document.getElementById('step2RequestField');
		  console.log(json_data.value); 
		  $("body").css("cursor", "progress");
		  $.ajax({
			  url: "PaymentCreate",
			  type: "post",
			  contentType: "application/json; charset=utf-8",
		      dataType: "json",
			  data: json_data.value,
			  success: function(json) {
				  $("body").css("cursor", "default");
				  location.reload();
				  console.log('success'); 
			  },
			  error:function(){
				  $("body").css("cursor", "default");
				  console.log('failed'); 
			  }  
			}); 
		});

	  $( "#step3Click" ).click(function() {
		  console.log("Value"); 
		  var json_data = document.getElementById('step3RequestField');
		  window.open(json_data.value);
	  }); 


	  $( "#clear1Click" ).click(function() {
		  window.location = "Clear"; 
	  }); 

	  $( "#clear2Click" ).click(function() {
		  window.location = "Clear"; 
	  }); 
	  
		function GetURLParameter(sParam)
		{
		
		    var sPageURL = window.location.search.substring(1);
		    var sURLVariables = sPageURL.split('&');
		    for (var i = 0; i < sURLVariables.length; i++) 
		    {
		        var sParameterName = sURLVariables[i].split('=');
		        if (sParameterName[0] == sParam) 
		        {
		            return sParameterName[1];
		        }
		    }
	    }
	  
});

</script>

</body>
</html>
