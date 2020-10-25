function calcSalesCommission() {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
  const calcSalesCommission = Math.floor(itemPrice.value * 0.1);
  const salesCommission = document.getElementById("add-tax-price");
  salesCommission.innerHTML = `${calcSalesCommission}`;
  });
}

window.addEventListener("load", calcSalesCommission)