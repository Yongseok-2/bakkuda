const photoInput = document.getElementById("photo-input");
const customUploadBox = document.getElementById("custom-upload-box");
const photoPreview = document.getElementById("photo-preview");
const imageCountText = document.getElementById("image-count");

// 이미지 등록 버튼 클릭 시 파일 선택창 열기
customUploadBox.addEventListener("click", () => {
    photoInput.click();
});

// 파일 선택 시 처리
photoInput.addEventListener("change", () => {
    const files = Array.from(photoInput.files);
    photoPreview.innerHTML = ""; // 기존 사진 초기화

    if (files.length > 10) {
        alert("최대 10개의 사진만 업로드할 수 있습니다.");
        photoInput.value = ""; // 선택 초기화
        imageCountText.textContent = "물품 이미지(0/10)";
        return;
    }

    // 사진 미리보기 생성
    files.forEach((file) => {
        const reader = new FileReader();
        reader.onload = (e) => {
            const img = document.createElement("img");
            img.src = e.target.result;
            img.alt = "Uploaded photo";
            photoPreview.appendChild(img);
        };
        reader.readAsDataURL(file);
    });

    // 물품 이미지 개수 업데이트
    imageCountText.textContent = `물품 이미지(${files.length}/10)`;
});

// tradeCheckbox 클릭 시 입력 필드 보이기/숨기기
const tradeCheckbox = document.getElementById('trade-checkbox');
const tradeInput = document.getElementById('tradeInput');

tradeCheckbox.addEventListener('change', () => {
    if (tradeCheckbox.checked) {
        tradeInput.classList.remove('hidden');  // 체크되면 보이게
    } else {
        tradeInput.classList.add('hidden');  // 체크 해제되면 숨기기
    }
});

// 판매 체크박스 클릭 시 입력 필드 보이기/숨기기
const sellCheckbox = document.getElementById('sell-checkbox');
const sellInput = document.getElementById('sellInput');

sellCheckbox.addEventListener('change', () => {
    if (sellCheckbox.checked) {
        sellInput.classList.remove('hidden');  // 체크되면 보이게
    } else {
        sellInput.classList.add('hidden');  // 체크 해제되면 숨기기
    }
});
