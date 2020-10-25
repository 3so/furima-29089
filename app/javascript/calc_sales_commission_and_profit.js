function calcSalesCommission() {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
  const calcSalesCommission = Math.floor(itemPrice.value * 0.1);
  const calcProfit = (itemPrice.value - calcSalesCommission);
  const salesCommission = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  salesCommission.innerHTML = `${calcSalesCommission}`;
  profit.innerHTML = `${calcProfit}`
  });
}

window.addEventListener("load", calcSalesCommission)