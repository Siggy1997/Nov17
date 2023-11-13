<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Pay</title>

<script src="../js/jquery-3.7.0.min.js"></script> 
<script type="text/javascript">

$(function() {
			$("#payBtn").attr('disabled', true);
	
			$("#cardCheck").click(
			function() {
			$("#payBtn").attr('disabled', true);
				
			let firstNum = $("#firstNum").val();
			let secondNum = $("#secondNum").val();
			let thirdNum = $("#thirdNum").val();
			let lastNum = $("#lastNum").val();
			let svc = $("#svc").val();
			let cdcard = $("#cdcard").val();
			let cardNum = $("#firstNum").val() + $("#secondNum").val() + $("#thirdNum").val() + $("#lastNum").val();
			let notNum = /[^0-9]/g; //숫자아닌지 확인
			
			
		    if (firstNum == "" || secondNum=="" || thirdNum=="" || lastNum==""|| notNum.test(cardNum)) {
		        $("#cardInfo").text("카드번호를 모두 올바르게 입력해주세요.(특수문자x)");
		        $("#cardInfo").css("color", "red");
		        return false;
		     } else if(svc == "" || notNum.test(svc) || svc.length != 3) {
		         $("#cardInfo").text("svc를 올바르게 입력해주세요.(3자리)");
		         $("#cardInfo").css("color", "red");
		         return false;
		     } else if(cdcard == "카드사선택") {
		         $("#cardInfo").text("카드사를 선택해주세요.");
		         $("#cardInfo").css("color", "red");
		     } else {
				$("#cdbalance").val("");
				
				let cdnumber = $("#firstNum").val() + "-" + $("#secondNum").val() + "-" + $("#thirdNum").val() + "-" + $("#lastNum").val();
				let cdsvc = $("#svc").val();
				let cdcard = $("select[name='cdcard']").val();
				 $.ajax({
					 url : "/cardCheck/"+${sessionScope.mno}, //어디로 갈지
					type : "post", //타입
					data : {"cdnumber" : cdnumber, "cdsvc" : cdsvc, "cdcard": cdcard },
					dataType : "json", 
					success : function(data) {
						if (data.cardCheck.count == 1) {
							$("#cardInfo").text("카드 조회가 완료되었습니다.");
							$("#cardInfo").css("color", "green").css("font-weight", "bold").css("font-size","10pt")
							$("#cdbalance").val(data.cardCheck.cdbalance);
							$("#cdno").val(data.cardCheck.cdno);
							$('#payBtn').attr('disabled', false);
							
							let expectPay = parseFloat($("#expectPay").val()); 
							let myPoint = 0;
							let usePoint = parseFloat($("#usePoint").val());
							
							let totalPay = expectPay;
							let totalPoint = myPoint;
							
							let finalPay = expectPay - myPoint;
							
							$("#totalPay").val(totalPay.toString());
							$("#totalPoint").val(totalPoint.toString());
							$("#usePoint").val(myPoint.toString());
							$("#finalPay").val(finalPay.toString());
							
						} else {
							$("#cardInfo").text(
									"존재하지 않는 카드입니다. 다시 입력해주세요.");
							$("#cardInfo").css("color", "red").css(
									"font-weight", "bold").css("font-size",
									"10pt")
							$("#firstNum").focus();
							return false;
						}
					}, //success 끝 
					error : function(request, status, error) {
						$("#cardInfo").text("카드 조회 중 오류가 발생했습니다." + error);
						$("#cardInfo").css("color", "red").css("font-weight", "bold").css("font-size","10pt");
					}
				}); //ajax 끝 
			}
		}); //cardCheck 끝
	
	$("#usePoint").on("blur", function() {
		let expectPay = parseFloat($("#expectPay").val()); 
		let myPoint = parseFloat($("#myPoint").val());
		let usePoint = parseFloat($("#usePoint").val());
		
		if(usePoint > myPoint) {
			$("#pointInfo").text("보유포인트보다 초과포인트를 입력할 수 없습니다.");
			$("#pointInfo").css("color", "red").css("font-weight", "bold").css("font-size","10pt");
			$("#usePoint").val("");
			$("#totalPay").val("");
			$("#totalPoint").val("");
			$("#finalPay").val("");
			$("#usePoint").focus();
			return false
		} else {
			$("#pointInfo").text("");
			let totalPay = expectPay;
			let totalPoint = usePoint;
			
			let finalPay = totalPay - totalPoint
			
			  $("#totalPay").val(totalPay.toString());
			  $("#totalPoint").val(totalPoint.toString());
			  $("#finalPay").val(finalPay.toString());
		}
				  
		
		});
 
			
	$("#useAllPoint").click(function(){
		$("#pointInfo").text("");
		
		let expectPay = parseFloat($("#expectPay").val()); 
		let myPoint = parseFloat($("#myPoint").val());
		let usePoint = parseFloat($("#usePoint").val());
		
		let totalPay = expectPay;
		let totalPoint = myPoint;
		
		let finalPay = expectPay - myPoint;
		
		$("#totalPay").val(totalPay.toString());
		$("#totalPoint").val(totalPoint.toString());
		$("#usePoint").val(myPoint.toString());
		$("#finalPay").val(finalPay.toString());
		
	}); //useAllPoint 끝
	
	$("#payBtn").click(function(){
		event.preventDefault(); //폼 전송 막기
		
		let cdnumber = $("#firstNum").val() + "-" + $("#secondNum").val() + "-" + $("#thirdNum").val() + "-" + $("#lastNum").val();
		let cdsvc = $("#svc").val();
		let cdcard = $("select[name='cdcard']").val();
		 $.ajax({
			url : "/cardCheck/"+${sessionScope.mno}, //어디로 갈지
			type : "post", //타입
			data : {"cdnumber" : cdnumber, "cdsvc" : cdsvc, "cdcard": cdcard },
			dataType : "json", 
			success : function(data) {
				if (data.cardCheck.count == 1) {
					$("#cardInfo").text("카드 조회가 완료되었습니다.");
					$("#cardInfo").css("color", "green").css("font-weight", "bold").css("font-size","10pt")
					$("#cdbalance").val(data.cardCheck.cdbalance);
					$("#cdno").val(data.cardCheck.cdno);
					$('#payBtn').attr('disabled', false);
					
				} else {
					$("#cardInfo").text(
							"존재하지 않는 카드입니다. 다시 입력해주세요.");
					$("#cardInfo").css("color", "red").css(
							"font-weight", "bold").css("font-size",
							"10pt")
					$("#firstNum").focus();
					return false;
				}
				
				let cdbalance = parseFloat($("#cdbalance").val()); 
				let finalPay = parseFloat($("#finalPay").val()); 
				//alert(cdbalance);
				//alert(finalPay);
				
				if(finalPay > cdbalance) {
					$("#cardInfo").text("카드 결제 잔액이 부족합니다. 다른 카드를 선택해주세요.");
					$("#cardInfo").css("color", "red").css("font-weight", "bold").css("font-size","10pt");
					$("#totalPay").val("");
					$("#cdbalance").val("");
					$("#cdno").val("");
					$("#totalPoint").val("");
					$("#finalPay").val("");
					$("#payBtn").attr('disabled', true);
					return false
				} else {
					$("#completePay").submit();
				}
			}, //success 끝 
			error : function(request, status, error) {
				$("#cardInfo").text("카드 조회 중 오류가 발생했습니다." + error);
				$("#cardInfo").css("color", "red").css("font-weight", "bold").css("font-size","10pt");
			}
		}); //ajax 끝 
	});
	
}); //function끝



</script>

</head>
<body>
	<a href="../main">&nbsp;&nbsp;←뒤로가기</a>
	<h1>Pay</h1>
	<h2>결제 예정금액 : </h2>
	<input id="expectPay" value="${payMoney.tprice}">원
	<h3>카드 조회하기</h3>
	<h4>카드번호</h4>
	<input type="text" id="firstNum" name="firstMrrn" maxlength="4" placeholder="1234"> -
	<input type="text" id="secondNum" name="secondNum" maxlength="4" placeholder="5678"> -
	<input type="password" id="thirdNum" name="thirdNum" maxlength="4" placeholder="1111"> -
	<input type="password" id="lastNum" name="lastNum" maxlength="4" placeholder="2222">
	<br>
	<h4>svc</h4>
	<input type="text" id="svc" name="svc" placeholder="ex)123" maxlength="3" >
	<br>
	<h4>카드사</h4>
	<select id="cdcard" name="cdcard">
	<option value="카드사선택">카드사선택</option>
	<option value="NH농협">NH농협</option>
	<option value="카카오">카카오</option>
	<option value="KB국민">KB국민</option>
	<option value="신한">신한</option>
	<option value="우리">우리</option>
	<option value="토스">토스</option>
	<option value="하나">하나</option>
	</select>
	<button id="cardCheck">카드확인</button>
	<br>
	<span id="cardInfo"></span>
	<div id="next"></div>
	<form action="/completePay/${sessionScope.mno}" method="post" id="completePay">
	<h4>포인트 사용하기</h4>
	보유포인트 : <input id="myPoint" value="${myPoint.mpoint}"> 포인트
	<br>
	<input id="usePoint" value="0">
	<button type="button" id="useAllPoint">전액 사용하기</button><br>
	<span id="pointInfo"></span>
	<br>
	카드잔액:<input id="cdbalance" name="cdbalance">
	카드고유번호:<input id="cdno" name="cdno">
	보유포인트 : <input id="myPoint" value="${myPoint.mpoint}" name="myPoint">
	<br>
	<h2>결제 총 금액 :</h2>
	<input id="totalPay" name="totalPay"> - <input id="totalPoint" name="totalPoint"> = <input id="finalPay" name="finalPay"> 원
	<br>
	<button id="payBtn" type="submit">결제하기</button>
	</form>
</body>
</html>