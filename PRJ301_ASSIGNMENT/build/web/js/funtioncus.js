var iconPass = document.getElementById('eye-icon-pass');
var passwordInput = document.getElementById('passwordInput');
var isPasswordVisible = false;

iconPass.addEventListener('click', function () {
    if (isPasswordVisible) {
        iconPass.className = 'fa-solid fa-eye';
        passwordInput.type = 'password';
        isPasswordVisible = false;
        console.log('Password hidden!');
    } else {
        iconPass.className = 'fa-regular fa-eye-slash';
        passwordInput.type = 'text';
        isPasswordVisible = true;
        console.log('Password visible!');
    }
});

var iconRePass = document.getElementById('eye-icon-repass');
var rePasswordInput = document.getElementById('rePasswordInput');
var isPasswordVisible = false;

iconRePass.addEventListener('click', function () {
    if (isPasswordVisible) {
        iconRePass.className = 'fa-solid fa-eye';
        rePasswordInput.type = 'password';
        isPasswordVisible = false;
        console.log('Password hidden!');
    } else {
        iconRePass.className = 'fa-regular fa-eye-slash';
        rePasswordInput.type = 'text';
        isPasswordVisible = true;
        console.log('Password visible!');
    }
});

// Lấy tham số URL
function getURLParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}

// Xác định tab được hiển thị dựa trên tham số URL
var tabParam = getURLParameter('tab');
if (tabParam === 'registered') {
    // Hiển thị tab "Already Registered"
    $('.nav-tabs a[href="#registered"]').tab('show');
} else if (tabParam === 'profile') {
    // Hiển thị tab "New member of Tien's Farm"
    $('.nav-tabs a[href="#profile"]').tab('show');
}
