// 체크박스와 입력 필드 DOM 요소를 가져옴
const barterCheckbox = document.getElementById('barterCheckbox');
const saleCheckbox = document.getElementById('saleCheckbox');
const barterInput = document.getElementById('barterInput');
const saleInput = document.getElementById('saleInput');

// 물물교환 체크박스 클릭 시 입력 필드 보이기/숨기기
barterCheckbox.addEventListener('change', () => {
    if (barterCheckbox.checked) {
        barterInput.classList.remove('hidden');
    } else {
        barterInput.classList.add('hidden');
    }
});

// 판매 체크박스 클릭 시 입력 필드 보이기/숨기기
saleCheckbox.addEventListener('change', () => {
    if (saleCheckbox.checked) {
        saleInput.classList.remove('hidden');
    } else {
        saleInput.classList.add('hidden');
    }
});