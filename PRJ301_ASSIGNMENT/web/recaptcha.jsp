<%-- 
    Document   : recaptcha
    Created on : Jul 5, 2023, 9:42:54 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
  <title>Alert Example</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <style>
    /* CSS tùy chỉnh */
    .alert-container {
      position: fixed;
      top: 20px;
      right: 20px;
      transition: all 0.5s ease;
      opacity: 0;
    }
    
    .alert-container.show {
      opacity: 1;
    }
    
    .alert-container.alert-animation {
      animation: slide-in-right 0.5s forwards;
    }
    
    @keyframes slide-in-right {
      0% {
        transform: translateX(100%);
      }
      100% {
        transform: translateX(0);
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Alert Example</h1>
    
    <button class="btn btn-primary" onclick="showAlert()">Click Me</button>
    
    <div id="alertContainer" class="alert-container"></div>
  </div>
  
  <script>
    function showAlert() {
      // Hiển thị cảnh báo
      var alertHtml = '<div class="alert alert-success alert-dismissible fade show" role="alert">';
      alertHtml += 'Action completed!';
      alertHtml += '<button type="button" class="close" data-dismiss="alert" aria-label="Close">';
      alertHtml += '<span aria-hidden="true">&times;</span>';
      alertHtml += '</button>';
      alertHtml += '</div>';
      
      var alertContainer = document.getElementById('alertContainer');
      alertContainer.innerHTML = alertHtml;
      
      // Thêm lớp CSS để hiển thị cảnh báo
      alertContainer.classList.add('show');
      alertContainer.classList.add('alert-animation');
      
      // Ẩn cảnh báo sau 3 giây (3000 milliseconds)
      setTimeout(function() {
        alertContainer.innerHTML = '';
        alertContainer.classList.remove('show');
        alertContainer.classList.remove('alert-animation');
      }, 3000);
    }
  </script>
  
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
