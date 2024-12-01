document.addEventListener("DOMContentLoaded", function () {
    const uploadBox = document.getElementById("custom-upload-box");
    const fileInput = document.getElementById("file-input");
    const uploadButton = document.getElementById("upload-button");

    // 클릭 이벤트로 파일 입력 열기
    uploadButton.addEventListener("click", () => {
        fileInput.click();
    });

    // 파일 선택 시 미리보기 업데이트
    fileInput.addEventListener("change", (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                // 업로드된 이미지를 upload-box의 백그라운드 이미지로 설정
                uploadBox.style.backgroundImage = `url(${e.target.result})`;
                uploadBox.classList.add("has-image");
            };
            reader.readAsDataURL(file);
        }
    });
});
