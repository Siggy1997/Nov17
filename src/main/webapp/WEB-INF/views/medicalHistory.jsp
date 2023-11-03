<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MedicalHistory</title>

<script src="./js/jquery-3.7.0.min.js"></script> 

<script type="text/javascript">
</script>

<style type="text/css">
th, td {
  text-align: center;
}
</style>

</head>
<body>
	<a href="../main">&nbsp;&nbsp;←뒤로가기</a>
	<h1>MedicalHistory</h1>
	<h3>내 예약 진료내역 확인하기</h3>
        <table class="table">
      <thead>
        <tr>
          <th style="width:100px; min-width: 100px; max-width: 100px;">날짜</th>
          <th style="width:100px; min-width: 100px; max-width: 100px;">병원</th>
          <th style="width:100px; min-width: 100px; max-width: 100px;">진료과</th>
          <th style="width:100px; min-width: 100px; max-width: 100px;">담당의사</th>
          <th style="width:150px; min-width: 150px; max-width: 150px;">진단내용</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${appointmentHistory}" var="row">
          <tr>
            <td style="width:100px; min-width: 100px; max-width: 100px;">${row.adate}</td>
            <td style="width:100px; min-width: 100px; max-width: 100px;">${row.hname}</td>
            <td style="width:100px; min-width: 100px; max-width: 100px;">${row.dpkind}</td>
            <td style="width:100px; min-width: 100px; max-width: 100px;">${row.dname}</td>
            <td style="width:150px; min-width: 150px; max-width: 150px;">${row.asymptomInfo}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    	<h3>내 비대면 진료내역 확인하기</h3>
        <table class="table">
      <thead>
        <tr>
          <th style="width:100px; min-width: 100px; max-width: 100px;">날짜</th>
          <th style="width:100px; min-width: 100px; max-width: 100px;">병원</th>
          <th style="width:100px; min-width: 100px; max-width: 100px;">진료과</th>
          <th style="width:100px; min-width: 100px; max-width: 100px;">담당의사</th>
          <th style="width:150px; min-width: 150px; max-width: 150px;">진단내용</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${telehealthHistory}" var="row">
          <tr>
            <td style="width:100px; min-width: 100px; max-width: 100px;">${row.tdate}</td>
            <td style="width:100px; min-width: 100px; max-width: 100px;">${row.hname}</td>
            <td style="width:100px; min-width: 100px; max-width: 100px;">${row.dpkind}</td>
            <td style="width:100px; min-width: 100px; max-width: 100px;">${row.dname}</td>
            <td style="width:150px; min-width: 150px; max-width: 150px;">${row.tdiagnosisdetail}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
</body>
</html>