<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        #progress-container {
            width: 50%;
            margin: 50px auto;
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        #progress-bar {
            width: 0;
            height: 30px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            line-height: 30px;
        }
    </style>
</head>
<body>
    <div id="progress-container">
        <div id="progress-bar">0%</div>
    </div>

    <script>
        function updateProgressBar() {
            var progressBar = document.getElementById('progress-bar');
            var width = 0;
            var interval = setInterval(function() {
                if (width >= 100) {
                    clearInterval(interval);
                } else {
                    width++;
                    progressBar.style.width = width + '%';
                    progressBar.innerHTML = width + '%';
                }
            }, 20);
        }

        // 페이지 로드 시 프로그레스 바 업데이트
        window.onload = function() {
            updateProgressBar();
        };
    </script>
</body>
</html>