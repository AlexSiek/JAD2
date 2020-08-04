package model;

public class purchaseHistory {
	private int id;
	private int categoryId;
	private String productName;
	private String vendor;
	private String pdtDesc;
	private int qty;
	private double buyPrice;
	private double MSPR;
	private String imgURL;
	private String createAt;
	private int orderStatus;
	private String username;
	private int pastPurchases;// Stores weekly purchase count
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getPdtDesc() {
		return pdtDesc;
	}
	public void setPdtDesc(String pdtDesc) {
		this.pdtDesc = pdtDesc;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public double getBuyPrice() {
		return buyPrice;
	}
	public void setBuyPrice(double buyPrice) {
		this.buyPrice = buyPrice;
	}
	public double getMSPR() {
		return MSPR;
	}
	public void setMSPR(double mSPR) {
		MSPR = mSPR;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	public String getCreateAt() {
		return createAt;
	}
	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}
	public int getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}
	public int getPastPurchases() {
		return pastPurchases;
	}
	public void setPastPurchases(int pastPurchases) {
		this.pastPurchases = pastPurchases;
	}
}
