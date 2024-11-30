document.getElementById("update-name-button").addEventListener("click", function () {
    // 새로운 장터명 입력 받기
    let newMarketName = prompt("새로운 장터명을 입력하세요:");

    if (newMarketName && newMarketName.trim() !== "") {
        // 8글자 제한: 8글자 이상이면 변경하지 않음
        if (newMarketName.length > 8) {
            alert("장터명은 8글자까지만 입력 가능합니다.");
        } else {
            // 장터명 텍스트만 변경 (버튼은 유지)
            document.getElementById("market-name-img").innerText = newMarketName;
            const marketNameTextElement = document.getElementById("market-name-text");
        
            // 기존 버튼 유지하며 텍스트만 업데이트
            marketNameTextElement.firstChild.nodeValue = newMarketName; 
        }
    } else {
        alert("유효한 장터명을 입력해주세요.");
    }
});



document.getElementById("edit-description-button").addEventListener("click", function () {
    const descriptionText = document.getElementById("market-description");
    const descriptionEditor = document.getElementById("description-editor");
    const editButton = document.getElementById("edit-description-button");

    if (descriptionText.style.display !== "none") {
        // "수정" 버튼을 눌렀을 때: 텍스트 -> 입력창
        descriptionEditor.value = descriptionText.textContent; // 현재 텍스트를 에디터로 복사
        descriptionText.style.display = "none"; // 텍스트 숨김
        descriptionEditor.style.display = "block"; // 에디터 표시
        editButton.textContent = "저장"; // 버튼 텍스트 변경
    } else {
        // "저장" 버튼을 눌렀을 때: 입력창 -> 텍스트
        descriptionText.textContent = descriptionEditor.value; // 에디터 내용을 텍스트로 복사
        descriptionEditor.style.display = "none"; // 에디터 숨김
        descriptionText.style.display = "block"; // 텍스트 표시
        editButton.textContent = "소개글 수정"; // 버튼 텍스트 변경
    }
});
