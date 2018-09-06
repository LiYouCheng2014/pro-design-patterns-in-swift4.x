var products = [
    Product(name: "Kayak", price: 275, stock: 10),
    Product(name: "Lifejacket", price: 48.95, stock: 14),
    Product(name: "Soccer Ball", price: 19.5, stock: 32)];

func calculateStockValue(productsArray:[Product]) -> Double {
    return productsArray.reduce(0, {(total, product) -> Double in
        return total + product.stockValue;
    });
}

print("Sales tax for Kayak: $\(products[0].calculateTax(rate: 0.2))");
print("Total value of stock: $\(calculateStockValue(productsArray: products))");
products[0].stock = -50;
print("Stock Level for Kayak: \(products[0].stock)");
