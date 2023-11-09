<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyWriting</title>

<script src="../js/jquery-3.7.0.min.js"></script> 

<script type="text/javascript">

function choiceDetail(bno, btype) {
    if (btype === 0) {
      location.href = '../qnaDetail?bno=' + bno;
    } else {
      location.href = '../freeDetail?bno=' + bno;
    }
  }
</script>

<style type="text/css">
th, td {
  text-align: center;
}
</style>

</head>
<body>
	<a href="../main">&nbsp;&nbsp;←뒤로가기</a>
	<h3>${sessionScope.mname} 님이 찜한 글 입니다.</h3>
	
	<h3>${sessionScope.mname} 님이 작성하신 글입니다.</h3>
    <table class="table">
      <thead>
        <tr>
          <th style="width:60px; min-width: 60px; max-width: 60px;">번호</th>
          <th style="width:300px; min-width: 300px; max-width: 300px;">제목</th>
          <th style="width:150px; min-width: 150px; max-width: 150px;">글쓴이</th>
          <th style="width:150px; min-width: 150px; max-width: 150px;">날짜</th>
          <th style="width:60px; min-width: 60px; max-width: 60px;">조회수</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${myWriting}" var="row">
          <tr>
            <td style="width:60px; min-width: 60px; max-width: 60px;">${row.bno}</td>
            <td class="tdtitle" style="width:300px; min-width: 300px; max-width: 300px;" onclick="choiceDetail(${row.bno}, ${row.btype})">${row.btitle}</td>
            <td style="width:150px; min-width: 150px; max-width: 150px;">${row.mnickname}</td>
            <td style="width:150px; min-width: 150px; max-width: 150px;">${row.bdate}</td>
            <td style="width:60px; min-width: 60px; max-width: 60px;">${row.blike}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <h3>${sessionScope.mname} 님이 작성하신 댓글입니다.</h3>
        <table class="table">
      <thead>
        <tr>
          <th style="width:60px; min-width: 60px; max-width: 60px;">번호</th>
          <th style="width:300px; min-width: 300px; max-width: 300px;">댓글내용</th>
          <th style="width:150px; min-width: 150px; max-width: 150px;">글쓴이</th>
          <th style="width:150px; min-width: 150px; max-width: 150px;">날짜</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${myComment}" var="row">
          <tr>
            <td style="width:60px; min-width: 60px; max-width: 60px;">${row.cno}</td>
            <td class="tdtitle" style="width:300px; min-width: 300px; max-width: 300px;"  onclick="location.href='../commentDetail?cno=${row.cno}'">${row.ccontent}</td>
            <td style="width:150px; min-width: 150px; max-width: 150px;">${row.mnickname}</td>
            <td style="width:150px; min-width: 150px; max-width: 150px;">${row.cdate}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
</body>
</html>
