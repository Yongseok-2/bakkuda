document.addEventListener("DOMContentLoaded", () => {
    const photoInput = document.getElementById("photo-input");
    const photoPreview = document.getElementById("photo-preview");
    const customUploadBox = document.getElementById("custom-upload-box");

    // 사진 추가 버튼 클릭 시 파일 선택 창 열기
    customUploadBox.addEventListener("click", () => {
        photoInput.click();
    });

    // 파일 선택 시 미리보기 생성
    photoInput.addEventListener("change", (event) => {
        const files = event.target.files;

        for (const file of files) {
            const reader = new FileReader();

            reader.onload = function (e) {
                // 미리보기 이미지 컨테이너 생성
                const imgContainer = document.createElement("div");
                imgContainer.classList.add("img-preview");

                // 이미지 엘리먼트 생성
                const img = document.createElement("img");
                img.src = e.target.result;

                // 삭제 버튼 생성
                const deleteBtn = document.createElement("button");
                deleteBtn.textContent = "×";
                deleteBtn.classList.add("remove-btn");

                // 삭제 버튼 클릭 시 미리보기 삭제
                deleteBtn.addEventListener("click", () => {
                    photoPreview.removeChild(imgContainer);
                });

                // 미리보기 컨테이너에 이미지와 삭제 버튼 추가
                imgContainer.appendChild(img);
                imgContainer.appendChild(deleteBtn);

                // 미리보기 영역에 추가
                photoPreview.appendChild(imgContainer);
            };

            reader.readAsDataURL(file); // 파일을 Data URL로 읽기
        }

        // 파일 입력 초기화 (같은 파일 다시 추가 가능)
        photoInput.value = "";
    });
});
