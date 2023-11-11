<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>[QnA 게시판 글쓰기]</h2>
	<form action='<c:url value='/postQna'/>' method="post" id="qnaForm" enctype="multipart/form-data">
		<div>
			제목<input type="text" name="btitle">
		</div>
		<div>
			내용
			<textarea rows="5" cols="13" name="bcontent"></textarea>
		</div>
		<select name = "selectDepartment">
		<option value = "department">진료과목</option>
          <option value = "소아과">소아과</option>
          <option value = "치과">치과</option>
          <option value = "내과">내과</option>
          <option value = "이비인후과">이비인후과</option>
          <option value = "피부과">피부과</option>
          <option value = "산부인과">산부인과</option>
          <option value = "안과">안과</option>
          <option value = "정형외과">정형외과</option>
          <option value = "한의학과">한의학과</option>
          <option value = "비뇨기과">비뇨기과</option>
          <option value = "신경과">신경과</option>
          <option value = "외과">외과</option>
          <option value = "정신의학과">정신의학과</option>
          <option value = "unknown">잘 모름</option>
       </select>	
		<input type="hidden" name="bdate" id="bdate">
		<!-- <input type="hidden" name="imageBase64" id="imageBase64"> -->
		<button type="submit">완료</button>
		<button type="button" onclick="location.href='qnaBoard'">목록</button>
	</form>

  <!-- <div>
      <button id="picker">M.media.picker</button>
  </div>
  <div id="box"></div>
  <div>
    <button id="upload">Upload Current Image</button>
  </div>
  <div id="progress"></div>
  <div id="upload-box"></div> -->

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="/js/mcore.min.js"></script>
  <script src="/js/jquery.plugin.js"></script>
  
	<script>
	
	// 폼이 제출될 때 현재 날짜와 시간을 입력란에 추가
	document.getElementById('qnaForm').addEventListener(
			'submit',
			function(event) {
				event.preventDefault(); // 기본 제출 동작을 막음

				// 현재 날짜와 시간을 가져오기
				const currentDatetime = new Date();
				const utcDatetime = new Date(currentDatetime.toISOString()
						.slice(0, 19)
						+ "Z"); // UTC 시간으로 변환
				const formattedDatetime = new Date(utcDatetime.getTime()
						+ 9 * 60 * 60 * 1000);

				document.getElementById('bdate').value = formattedDatetime
						.toISOString().slice(0, 19).replace("T", " ");

				const title = document
						.querySelector('input[name="btitle"]').value;
				const content = document
						.querySelector('textarea[name="bcontent"]').value;
				const selectDepartment = document.querySelector('select[name="selectDepartment"]').value;
				
				
				// 제목이나 내용 중 하나라도 비어있으면 경고창을 띄우고 전송을 막음
				if (title.trim() === '') {
					alert('제목을 입력해주세요.');
					event.preventDefault(); // 폼 전송 막기
					return false;
				}
				else if (content.trim() === '') {
					alert('내용을 입력해주세요.');
					event.preventDefault(); // 폼 전송 막기
					return false;
				}
				else if (selectDepartment === 'department') {
					alert('과목을 선택해주세요.');
					event.preventDefault(); // 폼 전송 막기
					return false;
				} else {
					
				const selectedDepartment = selectDepartment === 'unknown' ? null : selectDepartment;
				this.submit();
				}
			});
	
	/*
	
	 (function () {

		    $.imagePicker = function () {
		      return new Promise((resolve) => {
		        M.media.picker({
		          mode: "SINGLE",
		          media: "PHOTO",
		          // path: "/media", // 값을 넘기지않아야 기본 앨범 경로를 바라본다.
		          column: 3,
		          callback: (status, result) => {
		            resolve({ status, result })
		          }
		        });
		      })
		    }

		    $.convertBase64ByPath = function (imagePath) {
		      if (typeof imagePath !== 'string') throw new Error('imagePath must be string')
		      return new Promise((resolve) => {
		        M.file.read({
		          path: imagePath,
		          encoding: 'BASE64',
		          indicator: true,
		          callback: function (status, result) {
		            resolve({ status, result })
		          }
		        });
		      })
		    }

		    $.uploadImageByPath = function (targetImgPath, progress) {
		      return new Promise((resolve) => {
		        const _options = {
		          url: '/postQna',
		          header: {},
		          params: {},
		          body: [
		            // multipart/form-data 바디 데이터
		            { name: "file", content: targetImgPath, type: "FILE" },
		          ],
		          encoding: "UTF-8",
		          finish: (status, header, body, setting) => {
		            resolve({ status, header, body })
		          },
		          progress: function (total, current) {
		            progress(total, current);
		          }
		        }
		        M.net.http.upload(_options);
		      })
		    }

		  })();


		  $(function () {

		    let selectImagePath = '';
		    let $previewImg = null;
		    let $uploadImg = null;
		    const $box = $('#box');
		    const $uploadBox = $('#upload-box');
		    const $progress = $('#progress');
		    const $picker = $('#picker');
		    const $upload = $('#upload');



		    $picker.on('click', () => {
		      if ($previewImg !== null) {
		        $previewImg.remove();
		        $previewImg = null;
		      }
		      selectImagePath = '';
		      $.imagePicker()
		        .then(({ status, result }) => {
		          if (status === 'SUCCESS') {
		            selectImagePath = result.path;
		            return $.convertBase64ByPath(selectImagePath)
		          } else {
		            return Promise.reject('이미지 가져오기 실패')
		          }
		        })
		        .then(({ status, result }) => {
		          if (status === 'SUCCESS') {
		            $previewImg = $(document.createElement('img'))
		            $previewImg.attr('height', '200px')
		            $previewImg.attr('src', "data:image/png;base64," + result.data)
		            $box.append($previewImg);
		          } else {
		            return Promise.reject('BASE64 변환 실패')
		          }
		        })
		        .catch((err) => {
		          if (typeof err === 'string') alert(err)
		          console.error(err)
		        })
		    })

		    $upload.on('click', () => {
		      if (selectImagePath === '') return alert('이미지를 선택해주세요.')
		      if ($uploadImg) {
		        $uploadImg.remove();
		        $uploadImg = null;
		      }
		      $progress.text('')
		      $.uploadImageByPath(selectImagePath, (total, current) => {
		        console.log(`total: ${total} , current: ${current}`)
		        $progress.text(`${current}/${total}`)
		      })
		        .then(({
		          status, header, body
		        }) => {
		          // status code
		          if (status === '200') {
		            $progress.text('업로드 완료')
		            const bodyJson = JSON.parse(body)
		            $uploadImg = $(document.createElement('img'))
		            $uploadImg.attr('height', '200px')
		            $uploadImg.attr('src', bodyJson.fullpath)
		            $uploadBox.append($uploadImg)
		          } else {
		            return Promise.reject('업로드를 실패하였습니다.')
		          }
		        })
		        .catch((err) => {
		          if (typeof err === 'string') alert(err)
		          console.error(err)
		        })
		    })
		  });
		  */
	</script>

</body>
</html>