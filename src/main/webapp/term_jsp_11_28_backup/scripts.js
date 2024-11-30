function clickme(){
    window.scrollTo(0,0);
}



// 최근 본 상품을 로컬 스토리지에 저장하고 UI에 반영
function addToRecentViewed(itemName) {
    const recentViewedList = document.getElementById("recentViewedList");

    let recentViewedItems = JSON.parse(localStorage.getItem('recentViewedItems')) || [];

    const index = recentViewedItems.indexOf(itemName);
    if (index !== -1) {
        recentViewedItems.splice(index, 1); 
    }

    recentViewedItems.unshift(itemName);

    if (recentViewedItems.length > 7) {
        recentViewedItems.pop();  
    }

    localStorage.setItem('recentViewedItems', JSON.stringify(recentViewedItems));
    updateRecentViewedList(recentViewedItems);
}

// 최근 본 상품 목록을 UI에 반영
function updateRecentViewedList(recentViewedItems) {
    const recentViewedList = document.getElementById("recentViewedList");
    recentViewedList.innerHTML = '';

    recentViewedItems.forEach(item => {
        const listItem = document.createElement("li");
        listItem.className = "recent-item";

        const itemText = document.createElement("span");
        itemText.textContent = item;

        const deleteButton = document.createElement("button");
        deleteButton.className = "delete-btn";
        deleteButton.textContent = "X";
        
        deleteButton.addEventListener('click', () => removeItem(item, recentViewedItems));

        listItem.appendChild(itemText);
        listItem.appendChild(deleteButton);
        recentViewedList.appendChild(listItem);
    });
}

// 항목 삭제 함수
function removeItem(itemName, recentViewedItems) {
    const index = recentViewedItems.indexOf(itemName);
    if (index !== -1) {
        recentViewedItems.splice(index, 1);
    }

    localStorage.setItem('recentViewedItems', JSON.stringify(recentViewedItems));
    updateRecentViewedList(recentViewedItems);
}

// 거래하기 버튼 클릭 시 "최근 본 상품"에 추가
document.querySelectorAll(".want-item .trade-button").forEach(button => {
    button.addEventListener("click", function(event) {
        event.preventDefault(); // 기본 클릭 동작 방지 (필요에 따라 삭제 가능)
        
        const itemName = this.closest(".want-item").querySelector(".product-name").textContent;
        addToRecentViewed(itemName);

        // 실제 페이지 이동을 위해 링크가 있는 경우 처리
        const itemLink = this.getAttribute('href');
        if (itemLink) {
            window.location.href = itemLink;
        }
    });
});

// 페이지 로드 시 최근 본 상품 목록 불러오기
window.addEventListener('load', function() {
    let recentViewedItems = JSON.parse(localStorage.getItem('recentViewedItems')) || [];
    updateRecentViewedList(recentViewedItems);
});

setTimeout(function() {
    var productContainers = document.querySelectorAll('.product-container');
    productContainers.forEach(function(container) {
        container.style.display = 'block';  // 동적으로 적용된 스타일을 수정
    });
}, 100);  // 100ms 후 스타일 적용



    window.onload = function() {
        if (!window.location.href.includes("refreshed")) {
            window.location.href = window.location.href + (window.location.href.includes("?") ? "&" : "?") + "refreshed=true";
        }
    };